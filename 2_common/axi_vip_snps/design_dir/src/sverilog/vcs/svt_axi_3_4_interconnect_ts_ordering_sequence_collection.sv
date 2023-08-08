
`ifndef GUARD_SVT_AXI_3_4_INTERCONNECT_TS_ORDERING_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_AXI_3_4_INTERCONNECT_TS_ORDERING_SEQUENCE_COLLECTION_SV
//====================================================================================
/** 
 *    #- Program the Master VIP to drive write transaction with AWCACHE[1:0]=2'b00.<br>
 *    #- Check the transaction is not modified at the Interconnect Master Port.<br>
 *    #- Check Interconnect is not responding to the write transaction until Slave VIP<br>
 *       responds.<br>
 *    #- Wait for the transaction to complete successfully. <br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *       Slaves connected to the Interconnect DUT. <br>
 *    .
 */

class svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences. */
  rand int unsigned sequence_length;
  
  /** Write transaction request handle. */
  svt_axi_master_transaction xact;

  /** Local variable */
  int supporting_masters[int];
  int supporting_slaves[int];
  
  /** Constrain the sequence length to a reasonable value. */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro. */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence)
`endif
  
  /** Class Constructor. */
  function new (string name = "svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence");
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

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();    

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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0;
    int support_slv_index=0;  
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end
 
    foreach(participating_slaves_arr[slv])  begin
      if(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence",$sformatf("slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence", $sformatf("slave with id='d%0d has only AXI_READ_ONLY port",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** Sequence body task. */
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
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++)begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index]) begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,initiating_master_index) );

        /** Execute the transactions in each participating Slave from selected Master. */
        foreach(supporting_slaves[slave])  begin
          int slv = supporting_slaves[slave];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
          
          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
                   
          /** Selected Active participating Master fires non modifiable and non bufferable Write transaction to selected Slave. */ 
          `svt_xvm_do_on_with(xact,p_sequencer.master_sequencer[mstr], {
            addr                >=  lo_addr;
            addr                <=  hi_addr -(burst_length*(1<<burst_size));
            xact_type           == _write_xact_type[mstr];
            coherent_xact_type  == svt_axi_transaction::WRITENOSNOOP;
            atomic_type         == svt_axi_transaction::NORMAL;
            burst_type          inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
            cache_type[1:0]     == 2'b00;
          })
         
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(xact), "Waiting for Write transaction to end"});
          /** Waiting for Write transaction to complete */
          wait(`SVT_AXI_XACT_STATUS_ENDED(xact)); 
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(xact), "Write Transaction is now ended"});

        end//foreach of slave 
      end//foreach of supporting_master 
    end //for sequence length

    /**
     * To check the Write transactions are not modified and check Interconnect is not<br> 
     * responding to the write transaction until Slave VIP responds.<br>
     * Check performed by System Monitor :(List of checkers)<br>
     *  #- atomic_type_match_for_non_modifiable_xact_check <br>
     *  #- prot_type_match_for_non_modifiable_xact_check<br>
     *  #- region_match_for_non_modifiable_xact_check<br>
     *  #- burst_length_match_for_non_modifiable_xact_check<br>
     *  #- burst_size_match_for_non_modifiable_xact_check<br>
     *  #- cache_type_match_for_non_modifiable_xact_check<br>
     *  #- device_non_bufferable_response_match_check<br>
     *  .
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_device_non_bufferable_memory_ictest_sequence 

//====================================================================================
/** 
 *    #- Program the Master VIP to drive write transaction with AWCACHE[0]=1'b1.<br>
 *       Rest bits can be random.<br>
 *    #- After receiving write response, program the AXI Master VIP to drive read <br>
 *       transaction with same address as previous write with ARCACHE[3:0] as random.<br>
 *    #- Wait for the transaction to complete successfully. <br>
 *    #- Compare read data with write data.<br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all<br> 
 *       the Slaves connected to the Interconnect DUT.<br>
 *    .
 */

class svt_axi_ordering_write_read_bufferable_memory_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences. */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[int];
  
  /** Write and Read transaction request handles. */
  svt_axi_master_transaction wr_xact, rd_xact;
  
  /** Constrain the sequence length to a reasonable value. */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** UVM Object Utility macro. */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_read_bufferable_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_read_bufferable_memory_ictest_sequence)
`endif
  
  /** Class Constructor. */
  function new (string name = "svt_axi_ordering_write_read_bufferable_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 0
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
                                                svt_axi_port_configuration:: axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration:: axi_interface_category,\n\
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
        `svt_xvm_debug("svt_axi_ordering_write_read_bufferable_memory_ictest_sequence",$sformatf("master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin 
        `svt_xvm_debug("svt_axi_ordering_write_read_bufferable_memory_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
  endfunction: pre_randomize

  /** Sequence body task. */
  virtual task body();
   
    /** Local variables. */
    bit status;
    bit [7:0] packed_wr_data [], packed_rd_data [];
    bit packed_wstrb [] ;
    bit compare_data;

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
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for (int i=0; i< sequence_length; i++)begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index]) begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,initiating_master_index) );

        /** Execute the transactions in each participating Slave from selected Master. */
        foreach(participating_slaves_arr[slave])  begin
          int slv = participating_slaves_arr[slave];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;

          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
          
          /** Selected Master fires bufferable Write transaction to selected Slave. */ 
          `svt_xvm_do_on_with(wr_xact,p_sequencer.master_sequencer[mstr], {
            addr                >=  lo_addr;
            addr                <=  hi_addr-(burst_length*(1<<burst_size)) ;
            xact_type           == _write_xact_type[mstr];
            atomic_type         == svt_axi_transaction::NORMAL;
            coherent_xact_type  == svt_axi_transaction::WRITENOSNOOP;
            burst_type          inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
            cache_type[0]       == 1'b1;
          })
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact), "Waiting for Write transaction to end"} );
          /** Waiting for Write transaction to complete */
          wait(`SVT_AXI_XACT_STATUS_ENDED(wr_xact)); 
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact), "Write Transaction is now ended"});

          /**
           * Same Master fires Read transaction with same Write transaction
           * address, atomic_type, burst_type, burst_length, burst_size*/
          `svt_xvm_do_on_with(rd_xact,p_sequencer.master_sequencer[mstr],{
            addr               == local::wr_xact.addr; 
            xact_type          == _read_xact_type[mstr];
            coherent_xact_type == svt_axi_transaction::READNOSNOOP;
            atomic_type        == local::wr_xact.atomic_type;
            burst_type         == local::wr_xact.burst_type;
            burst_length       == local::wr_xact.burst_length; 
            burst_size         == local::wr_xact.burst_size;
            prot_type          == local::wr_xact.prot_type;
           })  
          
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact), "Waiting for Read transaction to end"});
          /** Waiting for Read transaction to complete */
          wait(`SVT_AXI_XACT_STATUS_ENDED(rd_xact)); 
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact), "Read Transaction is now ended"});
       
          /** Returns the data and strobe field as a byte stream based on the burst_type. */
          wr_xact.pack_data_to_byte_stream ( wr_xact.data, packed_wr_data );  
          wr_xact.pack_wstrb_to_byte_stream (wr_xact.wstrb, packed_wstrb ); 
          rd_xact.pack_data_to_byte_stream ( rd_xact.data, packed_rd_data ); 
          
          /** Compares the contents of two Write and read byte streams. */
          compare_data = rd_xact.compare_write_data( packed_wr_data, packed_wstrb, packed_rd_data );
          if(compare_data == 0) begin
            `svt_xvm_error("compare_write_data",$sformatf("Mismatch in Write Transaction data and Read Transaction data "));
          end       

        end//foreach of slave 
      end//foreach of supporting_master
    end //for sequence length
    /**
     * The Interconnect shall provide visibility to data of the bufferable write transaction.<br>
     * Check performed by Test<br>
     */
    
    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_read_bufferable_memory_ictest_sequence 

// =============================================================================
/**
 *    #- Program a Master VIP to drive two normal write transactions to same Slave VIP <br>
 *       and with same AWID.Program AWCACHE[1:0] to 2'b00, to indicate non-modifiable,<br> 
 *       non-bufferable. This ensures that both Write transactions reach the Slave VIP.<br>
 *    #- Program the Slave VIP to respond to first transaction with OKAY and second<br> 
 *       transaction with SLVERR. Program random delays in the slave responses.<br>
 *    #- Check the BRESP are in same order at Interconnect Master Port. This will be <br>
 *       checked in the master sequence itself. Check that the response of the first <br>
 *       completed transaction is OKAY. Check that the response of second transaction <br>
 *       is SLVERR.<br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all <br>
 *       the Slaves connected to the Interconnect DUT.<br>
 */

class svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence  extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** Local variable */
  int active_slaves[];
  int supporting_masters[int];
  int supporting_slaves[int];

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence )
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence )
`endif

  /** Write transaction request handles */
  svt_axi_master_transaction wr_xact_req[$];

  /** Class Constructor */
  function new (string name = "svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence ");
    super.new(name);
  endfunction : new
  
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
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

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves  = supporting_slaves.size();
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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0;
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end
    foreach(active_participating_slaves[slv])  begin
      if(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_slaves[support_slv_index++] = active_participating_slaves[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence",$sformatf("slave with id='d%0d has only AXI_READ_ONLY port",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** Sequence body task. */
  virtual task body();
    
    /** Local variables */
    bit status;
    int first_xact_resp_rcvd;
    bit [`SVT_AXI_MAX_ID_WIDTH-1:0] wr_id=0;
    int wr_length =2;

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
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length;i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index]) begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,initiating_master_index) );
        
        /** Execute the transactions in each active participating Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
         
          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
              
          /** Execute wr_length Write transactions with same ID and randomizing address */
          for (int wr=0; wr<wr_length; wr++) begin
            `svt_xvm_do_on_with(wr_xact_req[wr],p_sequencer.master_sequencer[mstr],{
              /** 
               * Randomizing addr,burst_length,burst_size,id for two Write transaction.
               */
              addr               >= lo_addr;
              addr               <= hi_addr-(burst_length*(1<<burst_size));
              if (wr==1) {
                id               == wr_id;
              }  
              xact_type          == _write_xact_type[mstr];
              coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
              atomic_type        == svt_axi_transaction::NORMAL; 
              /** The cache_type must be a Device Non-bufferable Memory  */
              cache_type[1:0]    == 2'b00;
              burst_type         inside {svt_axi_transaction::INCR, svt_axi_transaction::WRAP};
            })
            wr_id = wr_xact_req[0].id;  
          end

          /** check the BRESP of first transaction is recieved first */
          first_xact_resp_rcvd = 0;
          fork
            begin
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Waiting for first Write transaction to end"} );

              /** Waiting for first Write transaction to complete. */
              wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[0]));
              first_xact_resp_rcvd = 1;
            end
            begin
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Waiting for second Write transaction to end"} );

              /** Waiting for second Write transaction to complete. */
              wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[1]));
              if(!first_xact_resp_rcvd)begin 
                `svt_xvm_error("body", $sformatf("Expected to receive WRITE transaction response in transaction order i.e for transaction address = 'h%h but received for transaction address = 'h%h", wr_xact_req[0].addr, wr_xact_req[1].addr))
              end
            end
          join
      
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "First write Transaction is now ended"});
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Second write Transaction is now ended"});
          
          /** Check first transaction response os OKAY and second transaction response is SLVERR */
          if((wr_xact_req[0].bresp != svt_axi_transaction::OKAY) || (wr_xact_req[1].bresp != svt_axi_transaction::SLVERR))
            `svt_xvm_error("Response ordering",$sformatf("Expected response mismatch from injected response"));

        end//foreach slave
      end//foreach of supporting_master
    end //for sequence length 
    `svt_xvm_debug("body", "Exiting...");
    /**
     * To check the BRESP are in same order at Interconnect Master Port.<br>
     * To check that the response of the first completed transaction is OKAY.<br>
     * Check that the response of second transaction is SLVERR.<br>
     * Check performed by Test<br>
     */

  endtask: body
endclass:svt_axi_ordering_write_same_id_device_non_bufferable_memory_same_slave_response_ictest_sequence 

// =============================================================================
/**
 *    #- Program a Master VIP to drive two normal write transactions to two different<br>
 *       randomly selected Slave VIPs and with same AWID.Program AWCACHE[1:0] to 2'b00,<br>
 *       to indicate non-modifiable, non-bufferable. This ensures that both write<br> 
 *       transactions reach the Slave VIP.<br>
 *    #- Program the Slave VIP to respond to first transaction with OKAY and second <br>
 *       transaction with SLVERR. Program the delays such that response to second write<br>
 *       transaction is sent first, that is, before response for first write transaction.<br>
 *    #- Check the BRESP are in same order at Interconnect Master Port. This will be <br>
 *       checked in the master sequence itself. Check that the response of the first <br>
 *       completed transaction is OKAY. Check that the response of second transaction <br>
 *       is SLVERR.<br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *       Slaves connected to the Interconnect DUT.<br> 
 *    .
 */

class svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Variable to select random slaves */
  rand int unsigned active_participating_slave_index_2;
  
  /** Local variable */
  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** Constraint the second slave */
  constraint second_slave_c {
    if (supporting_slaves.size()>=2)
    {
     active_participating_slave_index_2 inside {supporting_slaves};
     active_participating_slave_index_2 != active_participating_slave_index;
    }
  }
  
   /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence)
`endif

  /** Write transaction request handles */
  svt_axi_master_transaction wr_xact_req[$];

  /** Class Constructor */
  function new (string name = "svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence");
    super.new(name);
  endfunction : new

    /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 2
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;
   
    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 2;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();
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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0;
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end
    foreach(active_participating_slaves[slv])  begin
      if(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_slaves[support_slv_index++] = active_participating_slaves[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence",$sformatf("slave with id=%0d has only AXI_READ_ONLY port",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** Sequence body task. */
  virtual task body();
    bit status;
    int first_xact_resp_rcvd;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr1;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr1;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr2;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr2;
    int active_slaves[];  
    int index;
    int selected_slv_index; 
    bit [`SVT_AXI_MAX_ID_WIDTH-1:0] wr_id;
    int wr_length =2;
    int selected_slv[];

    /** Temporary vars */
    int supporting_slv_q[$];

    /** Handle to system environment */
    svt_axi_system_env system_env;
    
    /** Handle to uvm_component */
`SVT_XVM(component) my_parent;

    /** Slave sequence */
    svt_axi_slave_ordering_programmed_response_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];

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
   
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Getting svt_axi_system_env object handle */ 
    my_parent = p_sequencer.get_parent();
    if(!($cast(system_env,my_parent)))begin
      `svt_xvm_fatal("body","Internal Error - Expected parent to be of type svt_axi_system_env, but it is not");
    end
    
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);
  
    index = 0;
    /** Triggering slave sequences */
    foreach(active_slaves[index])  begin
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end
   
    /** Wait for the triggering of all the active participating slaves. */
    foreach(supporting_slaves[index])  begin
      wait(slv_seq[supporting_slaves[index]] != null);
    end
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length;i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[initiating_master_index]) begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,initiating_master_index) );
       
        /** Initializing active participating slaves array */
        selected_slv=new[supporting_slaves.size()];

        /** Execute the transactions in random different Slave from selected Master */
        selected_slv[0]= active_participating_slave_index;
        selected_slv[1]= active_participating_slave_index_2;
        
        /** Randomly select Address range for selected slave */
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv[0], lo_addr1, hi_addr1,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv[0]));
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv[1], lo_addr2, hi_addr2,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv[1]));
      
   
        /** Program bvalid_delay  */ 
        slv_seq[selected_slv[0]].bvalid_delay = `SVT_AXI_MAX_WRITE_RESP_DELAY;
        slv_seq[selected_slv[1]].bvalid_delay =   0;
        
        /** Program the selected slave Okay and Slverr response weights */ 
        slv_seq[selected_slv[0]].OKAY_wt = 100;
        slv_seq[selected_slv[0]].SLVERR_wt = 0;
        slv_seq[selected_slv[1]].OKAY_wt = 0;
        slv_seq[selected_slv[1]].SLVERR_wt = 100;
     
        /** Execute wr_length Write transactions with same ID */
        for (int wr=0; wr<wr_length; wr++) begin
          wr_xact_req[wr] = null;
          `svt_xvm_do_on_with(wr_xact_req[wr],p_sequencer.master_sequencer[mstr],{
            if(local::wr==0)
              {
                addr >= lo_addr1;
                addr <= hi_addr1-(burst_length*(1<<burst_size));
              }
            else
              {
                addr >= lo_addr2;
                addr <= hi_addr2-(burst_length*(1<<burst_size));
                id   == wr_id;
              }
            xact_type          == _write_xact_type[mstr];
            coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
            atomic_type        == svt_axi_transaction::NORMAL; 
            /** The cache_type must be a Device Non-Bufferable memory */
            cache_type[1:0]    == 2'b00;
            burst_type         inside {svt_axi_transaction::INCR, svt_axi_transaction::WRAP};
          })
          wr_id = wr_xact_req[0].id;
        end

        /** Wait until Second transaction response reaches at the Interconnect's Master Port */
        `svt_xvm_debug("body","Waiting until Second transaction response reaches at the Interconnect's Master Port");
        `protected
UbP8ML=-b9I/Q70I=5MPQP&dTdB7JB]74IPBVgO/-46&-V731HD75)+2(O8WJ7_Y
TE^4?/^W9:6KC;V]BET7g=gP_Ie>1JPdYLAIU80#bK?SX)C4H=D;M-8M68(:Wdgc
+VcB;]6U2[S3^FN5Z\X>F(Y&c64,9T#a.L_;H^48da&J=17-S]UN=Ob64/CKfN7B
($
`endprotected

        `svt_xvm_debug("body","EVENT_TX_XACT_ENDED triggered");
        wait (slv_seq[selected_slv[0]].suspended_req != null );
        if (slv_seq[selected_slv[0]].suspended_req.suspend_response == 0)
        wait((slv_seq[selected_slv[0]].suspended_req.suspend_response == 1));
        if(slv_seq[selected_slv[0]].suspended_req.addr_status != svt_axi_transaction::ACCEPT) 
        wait((slv_seq[selected_slv[0]].suspended_req.addr_status == svt_axi_transaction::ACCEPT));
        /** Triggering the event present in the slave sequence,to resume the suspended response of a transaction */
        `svt_xvm_debug("body",$sformatf("Triggering the event resume_write_response to resume the previously suspended response of a transaction "));
        ->slv_seq[selected_slv[0]].resume_write_resp;
        `svt_xvm_debug("body",$sformatf("Triggered the event resume_write_response succecfully "));

        /** check the BRESP of first transaction is recieved first */
        first_xact_resp_rcvd = 0;
        fork
          begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "Waiting for first Write transaction to end"} );
            
            /** Waiting for first Write transaction to complete. */
            wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[0]));
            first_xact_resp_rcvd = 1;
          end
          begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Waiting for second Write transaction to end"} );
            
            /** Waiting for second Write transaction to complete. */
            wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[1]));
            if(!first_xact_resp_rcvd)begin 
              `svt_xvm_error("body", $sformatf("Expected to receive WRITE transaction response in transaction order i.e for transaction address = 'h%h but received for transaction address = 'h%h", wr_xact_req[0].addr, wr_xact_req[1].addr))
            end
          end
        join
       
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[0]), "First write Transaction is now ended"});
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[1]), "Second write Transaction is now ended"});
 
        /** Check first transaction response os OKAY and second transaction response is SLVERR */
        if((wr_xact_req[0].bresp != svt_axi_transaction::OKAY) ||  (wr_xact_req[1].bresp != svt_axi_transaction::SLVERR)) begin
          `svt_xvm_error("Response ordering",$sformatf("Expected response mismatch from injected response"));
        end

      end //foreach of supporting_master
    end //for sequence length 
    `svt_xvm_debug("body", "Exiting...");
    /**
     * To check the BRESP are in same order at Interconnect Master Port.<br>
     * To check that the response of the first completed transaction is OKAY.<br>
     * Check that the response of second transaction is SLVERR.<br>
     * Check performed by Test<br>
     */
     
  endtask: body
endclass:svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_slave_response_ictest_sequence

// =============================================================================
/**
 *    #- Program the AXI Master VIP to drive multiple (4) write transactions<br> 
 *       for same Slave VIP with same ID, different AWADDR to Device memory.<br> 
 *    #- Make sure addresses in the transactions are non-overlapping. This will<br> 
 *       help to validate that ordering is preserved even for non-overlapping addresses<br>
 *       for Device Memory.<br>
 *    #- Check the write transactions are in same order at the Interconnect Master Port<br> 
 *       and Interconnect Slave Port. Also check the IDs of all transactions at the<br> 
 *       Interconnect Master port are same.<br>
 *    #- Wait for the transaction to complete successfully.<br> 
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *       Slaves connected to the Interconnect DUT.<br>
 *    . 
 */
class svt_axi_ordering_write_same_id_device_memory_ictest_sequence extends svt_axi_system_base_sequence;

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
  `uvm_object_utils(svt_axi_ordering_write_same_id_device_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_same_id_device_memory_ictest_sequence)
`endif
  
  /** Class Constructor */
  function new (string name = "svt_axi_ordering_write_same_id_device_memory_ictest_sequence");
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

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();   

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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0;
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_memory_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
         supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
         `svt_xvm_debug("svt_axi_ordering_write_same_id_device_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_memory_ictest_sequence",$sformatf("slave with id='d%0d has only AXI_READ_ONLY port",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int wr_xact_num = 32;
    int mstr;

    /** Master Write Sequence request handle */
    svt_axi_write_same_slave_sequence wr_seq;

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
 
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0;i<sequence_length;i++) begin

      /** Execute the transactions from each selected active participating master */
      foreach (supporting_masters[initiating_master_index]) begin
        mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d initiating master index='d%0d ",mstr,initiating_master_index) );
           
        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
          `svt_xvm_debug("body", $sformatf("Slave to participate is  'd%0d index='d%0d ",slv,index) );
   
          /** 
           * Drive Master write sequence with same ID and non overlapping address
           * for (4) write transactions to same slave
           */
          `svt_xvm_do_on_with(wr_seq,p_sequencer.master_sequencer[mstr], {
            slv_num             == slv;
            num_of_wr_xact      == wr_xact_num;
            address             == NON_OVERLAP_ADDR;  
            memory_type         == DEVICE;
            id                  == SAME;
          })
          for (int wr=0;wr<wr_xact_num;wr++) begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Waiting for Write transaction to end"});
            /** Waiting for above sequence of Write transactions to complete. */
            wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[wr]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Write Transaction is now ended"});
          end
        end //foreach Slave
      end // foreach supporting_master
    end //for sequence_length
    /** 
     * To check the Write transactions are forwarded in order.<br>
     * Check done by System monitor :(List of checkers)<br>
     *  #- non_modifiable_xact_check<br>
     *  .   
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_same_id_device_memory_ictest_sequence

// =============================================================================
/*
*    #- Program the AXI Master VIP to drive multiple write transactions for same Slave<br> 
*       VIP with same ID to Device memory. Make sure address of the write transactions<br>  
*       are non-overlapping.<br>
*    #- Program the same Master VIP to drive multiple read transactions for same Slave<br> 
*       VIP with same ID and ARADDR same as previous AWADDR to device memory.<br>
*    #- Wait for the transaction to reach the Slave.<br>
*    #- Check the read data is same as write data and in same order at the Interconnect<br> 
*       Master Port and Interconnect Slave Port.<br>
*    #- Wait for the transaction to complete successfully.<br> 
*    #- Initiate the above stimulus from all Master VIPs sequentially towards the same<br> 
*       Slaves connected to the Interconnect DUT.<br>
*    .  
*/
class svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence extends svt_axi_system_base_sequence;

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
  `uvm_object_utils(svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence)
`endif
  
  /** Read transaction request handles */
  svt_axi_master_transaction rd_xact_req[int];
   
  /** Class Constructor */
  function new (string name = "svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence");
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

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();   

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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence",$sformatf("Master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin 
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence",$sformatf("slave with id='d%0d does not have an AXI_READ_WRITE port",participating_slaves_arr[slv]));

      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int xact_num = 32;
    int mstr;
 
    /** Master Write sequence request handle */
    svt_axi_write_same_slave_sequence wr_seq;

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
      /** Execute the sequence for 'sequence_length' number of times */
      for (int i=0; i < sequence_length;i++) begin
        
        /** Execute the transactions from each selected active participating master */
        foreach (supporting_masters[initiating_master_index]) begin
          mstr = supporting_masters[initiating_master_index];
          `svt_xvm_debug("body", $sformatf("master to initiate is  'd%0d initiating master index='d%0d ",mstr,initiating_master_index) );

          /** Execute the transactions in each Slave from selected Master */
          foreach(supporting_slaves[index])  begin
            int slv = supporting_slaves[index];
            `svt_xvm_debug("body", $sformatf("Slave to participate is  'd%0d index='d%0d ",slv,index) );

            /** 
             * Drive Master Write sequence with same ID and non overlap address for 2 write
             * transactions to same slave
             */
            `svt_xvm_do_on_with(wr_seq,p_sequencer.master_sequencer[mstr], {
              slv_num             == slv;
              num_of_wr_xact      == xact_num;
              address             == NON_OVERLAP_ADDR;  
              memory_type         == DEVICE;
              id                  == WR_RD_SAME_ID;
            })
            
            for (int wr=0;wr<xact_num;wr++) begin
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Waiting for Write transaction to end"});
              /** Waiting for above sequence of Write transactions to complete */
              wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[wr]));
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Write Transaction is now ended"});
            end
     
            /** 
             * Execute 2 Read transaction with 1st Write transaction accessing Address and 
             * 2nd Write transaction accessing Address with same id to make sure the Read transaction's  
             * data in order. 
             */
            for (int rd=0;rd<xact_num;rd++) begin
              `svt_xvm_do_on_with(rd_xact_req[rd],p_sequencer.master_sequencer[mstr],{ 
                addr               == local::wr_seq.wr_xact_req[rd].addr;
                id                 == local::wr_seq.wr_xact_req[rd].id;
                xact_type          == _read_xact_type[mstr];
                coherent_xact_type == svt_axi_transaction::READNOSNOOP;
                burst_type         == local::wr_seq.wr_xact_req[rd].burst_type;
                burst_size         == local::wr_seq.wr_xact_req[rd].burst_size;
                burst_length       == local::wr_seq.wr_xact_req[rd].burst_length;
                cache_type         inside {0,1};
                reference_event_for_addr_valid_delay ==  svt_axi_transaction ::PREV_ADDR_HANDSHAKE;
                addr_valid_delay   == 0;
                data_before_addr   == 0;
              })
            end

            for (int rd=0;rd<xact_num;rd++) begin
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd]), "Waiting for Read transaction to end"});
              /** Waiting for above Read transactions to complete */
              wait (`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req[rd]));
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd]), "Read Transaction is now ended"});
            end 
          end //foreach
        end//foreach
      end //for sequence_length
      /** 
       * To check the Read transactions are forwarded in order.<br>
       * Check done by System monitor :(List of checkers)<br>
       *  #- non_modifiable_xact_check<br>
       *  .   
       */

    `svt_xvm_debug("body", "Exiting...");

  endtask: body
endclass:svt_axi_ordering_write_read_same_id_device_memory_ictest_sequence

// =============================================================================
/** 
 *    #- Program a randomly selected AXI4 Master VIP to drive two write transactions to<br> 
 *       same Slave VIP with same ID and overlapping address (not same address).<br> 
 *       Select the address of first write transaction randomly. Calculate the address<br> 
 *       for second write transaction such that it is overlapping with address of first<br> 
 *       write transaction. AWCACHE[1] should be set to 1, to indicate modifiable<br> 
 *       transactions.<br> 
 *    #- Wait for both the write transactions to end.<br>
 *    #- Program the AXI4 Master VIP to drive a read transaction to the same address as<br> 
 *       the second write transaction.<br>
 *    #- Compare the read data with data of second write transaction, which is the<br> 
 *       expected data.<br>
 *    #- Disable the data_integrity check as this check can falsely fire in case of<br> 
 *       outstanding  transactions to same or overlapping address.<br>
 */
class svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Supporting Master index **/
  rand int unsigned supporting_master_index;

  /** Local variable */
  int active_slaves[int];
  int supporting_masters[int];
  int supporting_slaves[int];
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** Randomize the supporting master **/
  constraint supporting_masters_c {
    if (supporting_masters.size())
    {
     supporting_master_index inside {supporting_masters};
    }
  }  

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence)
`endif
  
  /** Read transaction request handle */
  svt_axi_master_transaction rd_xact_req;
  
  /** Class Constructor */
  function new (string name = "svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AXI4 */
      if ((!((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) || (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM ))) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE))  begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if ((!(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM)) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE))  begin 
        supporting_slaves[index_slv++] = participating_slaves_arr[slv];
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end
    end
  endfunction

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting AXI4 Masters = 1
   *  #- Minimum supporting AXI4 Slaves = 1
   *  #- Master configuration of axi_interface_type should be AXI4
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    /** Supporting masters required */
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();
    /** check the required supporting Masters  */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves) begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_type,\n\
                                                Number of AXI4 Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::axi_interface_category,\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_type,\n\
                                                Number of AXI4 Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::axi_interface_category,\
                                                svt_axi_port_configuration::axi_interface_type\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported


  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int mstr;
    bit [7:0] packed_wr_data [], packed_rd_data [];
    bit packed_wstrb [] ;
    bit compare_data; 
    int xact_num =2;

    /** Master Write sequence request handle */
    svt_axi_write_same_slave_sequence wr_seq;

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

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Randomly active and participating Master */
    mstr = supporting_master_index;
    `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d initiating master index='d%0d ",mstr,supporting_master_index) );
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin

      /** Execute the transactions in each Slave from selected Master */
      foreach(supporting_slaves[slave])  begin
        int slv = supporting_slaves[slave];
        
        /** 
         * Drive Master Write sequence with same ID and overlapping address
         * for 2 Write transactions to same slave 
         */
        `svt_xvm_do_on_with(wr_seq,p_sequencer.master_sequencer[mstr], {
          slv_num             == slv;
          num_of_wr_xact      == xact_num;
          address             == OVERLAP_ADDR;  
          memory_type         == NORMAL;
          id                  == SAME;
        })
                  
        for (int wr=0;wr<xact_num;wr++) begin
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Waiting for Write transaction to end"});
          /** Waiting for above sequence of Write transactions to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[wr]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Write Transaction is now ended"});
        end
          
        /** 
         * Execute Read transactions with 2nd Write transaction accessing Address,
         * to make sure the transaction's data is written into the memory in order.
         */
        `svt_xvm_do_on_with(rd_xact_req,p_sequencer.master_sequencer[mstr],{ 
          addr               == local::wr_seq.wr_xact_req[1].addr; 
          xact_type          == _read_xact_type[mstr];
          coherent_xact_type == svt_axi_transaction::READNOSNOOP;
          burst_type         == local::wr_seq.wr_xact_req[1].burst_type;
          burst_size         == local::wr_seq.wr_xact_req[1].burst_size;
          burst_length       == local::wr_seq.wr_xact_req[1].burst_length;
          cache_type         == local::wr_seq.wr_xact_req[1].cache_type;
          prot_type          == local::wr_seq.wr_xact_req[1].prot_type;
          atomic_type        == local::wr_seq.wr_xact_req[1].atomic_type;
        })
                  
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req), "Waiting for Read transaction to end"});
        /** Waiting for above Read transaction to complete */
        wait (`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req));
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req), "Read Transaction is now ended"});

        /** Returns the data and strobe field as a byte stream based on the burst_type. */
        wr_seq.wr_xact_req[1].pack_data_to_byte_stream ( wr_seq.wr_xact_req[1].data, packed_wr_data );
        wr_seq.wr_xact_req[1].pack_wstrb_to_byte_stream (wr_seq.wr_xact_req[1].wstrb, packed_wstrb );
        rd_xact_req.pack_data_to_byte_stream ( rd_xact_req.data, packed_rd_data );

        /** Compares the contents of two byte streams. */
        compare_data = rd_xact_req.compare_write_data( packed_wr_data, packed_wstrb, packed_rd_data );
        if(compare_data == 0) begin
          `svt_xvm_error("compare_write_data",$sformatf("Mismatch in Write Transaction data and Read Transaction data "));
        end         
      end //foreach
    end //for sequence_length
    /** 
     * To check the Write transactions are forwarded in order.<br>
     * Check done by Test<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi4_ordering_write_overlap_addr_same_id_normal_memory_ictest_sequence

// =============================================================================
/**
 *    #- Program the Master VIP to drive two write transactions to the same slave,<br> 
 *       with non-repetitive data (incremental, random)<br>
 *    #- Program the Master VIP to drive two read transactions for same Slave with<br>
 *       same ARID. Use the same address for read transactions as used by write<br>
 *       transactions.<br>
 *    #- Check the RDATA are in same order at Interconnect Slave Port. This will be<br>
 *       checked by data_integrity check in AXI System Monitor.<br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br> 
 *       Slaves connected to the Interconnect DUT<br>
 *    .
 */

class svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence extends svt_axi_system_base_sequence;

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
  `uvm_object_utils(svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence)
`endif
  
  /** Class Constructor */
  function new (string name = "svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence");
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

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();   

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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence",$sformatf("slave with id='d%0d does not have an AXI_READ_WRITE port",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int xact_num = 2;
    int mstr;
    
    /** Master Write_Read sequence request handle  */
    svt_axi_read_same_slave_sequence wr_rd_seq;
           
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
 
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length;i++) begin

      /** Execute the transactions from each selected active participating master */
      foreach (supporting_masters[initiating_master_index]) begin
        mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("master to initiate is  'd%0d initiating master index='d%0d ",mstr,initiating_master_index) );
        
        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
         
          /** 
           * Drive Master Write_Read sequence for 2 Write transactions followed by Read 
           * transactions to same slave from selected Master
           */
          `svt_xvm_do_on_with(wr_rd_seq,p_sequencer.master_sequencer[mstr], {
            slv_num              == slv;
            xact_length          == xact_num;
            id                   == SAME;  
            memory_type          == DEVICE;   
            do_write_before_read == 1;
          })
         
        end //foreach
      end//foreach
    end //for sequence_length
    /** 
     * To check the RDATA are in same order.<br>
     * Check done by System monitor :(List of checkers)<br>
     *  #- data_integrity_check<br>  
     *  . 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_read_same_id_device_memory_same_slave_response_ictest_sequence

// =============================================================================
/**
 *    #- Program the Master VIP to drive two write transactions to two randomly selected<br> 
 *       slave, with non-repetitive data (incremental, random)<br>
 *    #- Program the Master VIP to drive two read transactions to same randomly selected<br> 
 *       Slave VIPs, with same ARID. Use the same address for read transactions as used<br> 
 *       by write transactions.<br>
 *    #- Check the RDATA are in same order at Interconnect Slave Port. This will be<br> 
 *       checked by data_integrity check in AXI System Monitor.<br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br> 
 *       Slaves connected to the Interconnect DUT<br>
 *    .
 */

class svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_masters[int];
  int supporting_slaves[int];

  /** Variable to select random slaves */
  rand int unsigned participating_slave_index_2;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** Constraint the second slave */
  constraint second_slave_c {
    if (supporting_slaves.size()>=2)
    {
     participating_slave_index_2 inside {supporting_slaves};
     participating_slave_index_2 != participating_slave_index;
    }
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence)
`endif
  
  /** Read transaction request handles */
  svt_axi_master_transaction rd_xact_req[int];

  /** Class Constructor */
  function new (string name = "svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting Masters = 1
   *  #- Minimum required Slaves = 2
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    /** Supporting masters required */
    int required_num_supporting_slaves = 2;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves  = supporting_slaves.size();

    /** Check the required supporting Masters and Slaves  */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves ) begin
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
                                                svt_axi_system_configuration::participating_masters,\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

/** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence",$sformatf("master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence",$sformatf("slave with id='d%0d does not have an AXI_READ_WRITE port",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int xact_num =2;
    int mstr;
    int selected_slv[];

    /** Master Write sequence request handles */
    svt_axi_write_same_slave_sequence wr_seq[int];

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
 
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Initializing participating slaves array */
      selected_slv=new[supporting_slaves.size()];

    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length;i++) begin

      /** Execute the transactions from each selected active participating master */
      foreach (supporting_masters[initiating_master_index]) begin
        mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("master to initiate is  'd%0d initiating master index='d%0d ",mstr,initiating_master_index) );
         
        /** Execute the transactions in random different Slave from selected Master */
        selected_slv[0]= participating_slave_index;
        selected_slv[1]= participating_slave_index_2;
               
        /** 
         * Drive Master Write sequence to random different slave from
         * selected Master
         */
        for (int wr=0;wr<xact_num;wr++) begin 
          `svt_xvm_do_on_with(wr_seq[wr],p_sequencer.master_sequencer[mstr], {
             slv_num             == selected_slv[wr];
             num_of_wr_xact      == 1;
             address             == NON_OVERLAP_ADDR;  
             memory_type         == DEVICE;
             id                  == RD_WR_CHAN_MIN_ID;
          })
        end
        for (int wr=0;wr<xact_num;wr++) begin
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[wr].wr_xact_req[0]), "Waiting for Write transaction to end"});
          /** Waiting for above sequences of a Write transaction to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq[wr].wr_xact_req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[wr].wr_xact_req[0]), "Write Transaction is now ended"});
        end

        /** 
         * Execute Read transactions with 1st and 2nd Write transaction accessing Address
         * with same id to make sure the transaction's data is written into the memory in order.
         */
        for (int rd=0;rd<xact_num;rd++) begin
          `svt_xvm_do_on_with(rd_xact_req[rd],p_sequencer.master_sequencer[mstr],{ 
            addr               == local::wr_seq[rd].wr_xact_req[0].addr; 
            xact_type          == _read_xact_type[mstr];
            coherent_xact_type == svt_axi_transaction::READNOSNOOP;
            id                 == local::wr_seq[rd].wr_xact_req[0].id;
            burst_type         == local::wr_seq[rd].wr_xact_req[0].burst_type;
            burst_size         == local::wr_seq[rd].wr_xact_req[0].burst_size;
            burst_length       == local::wr_seq[rd].wr_xact_req[0].burst_length;
            cache_type         == local::wr_seq[rd].wr_xact_req[0].cache_type;
          })
        end
        for (int rd=0;rd<xact_num;rd++) begin
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd]), "Waiting for Read transaction to end"});
          /** Waiting for above Read transactions to complete */
          wait (`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req[rd]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd]), "Read Transaction is now ended"});
        end    
      end//foreach
    end //for sequence_length
    /** 
     * To check the RDATA are in same order.<br>
     * Check done by System monitor :(List of checkers)<br>
     *  #- data_integrity_check <br>
     *  .   
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_read_same_id_device_memory_diff_slave_response_ictest_sequence

// =============================================================================
/**
 *    #- Program the AXI Master VIP to drive multiple (4) write transactions for same<br> 
 *       Slave VIP with same ID, different (but overlapping) AWADDR to Device memory.<br> 
 *    #- Make sure addresses in the transactions are overlapping. This will help to <br> 
 *       validate that ordering is preserved  for overlapping addresses for Device Memory.<br>
 *    #- Check the write transactions are in same order at the Interconnect Master Port<br> 
 *       and Interconnect Slave Port. Also check the IDs of all transactions at the<br> 
 *       Interconnect Master port are same.<br>
 *    #- Wait for the transaction to complete successfully.<br> 
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br> 
 *       Slaves connected to the Interconnect DUT.<br> 
 *    .
 */

class svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence extends svt_axi_system_base_sequence;

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
  `uvm_object_utils(svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence)
`endif
  
  /** Class Constructor */
  function new (string name = "svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence");
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

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();    

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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0;
    int support_slv_index=0;  
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end
    foreach(participating_slaves_arr[slv])  begin
      if(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_slaves[support_slv_index++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf("slave with id='d%0d has only AXI_READ_ONLY port",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize


  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int wr_xact_num = 4;
    int mstr;

    /** Master Write sequence request handle */
    svt_axi_write_same_slave_sequence wr_seq;
   
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

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin

      /** Execute the transactions from each selected active participating master */
      foreach (supporting_masters[initiating_master_index]) begin
        mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body", $sformatf("master to initiate is  'd%0d initiating master index='d%0d ",mstr,initiating_master_index) );
 
        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];

           /** 
           * Drive Master Write sequence with overlap_addr and same id for 4 multiple Write transactions 
           * to same slave from selected Master
           */
          `svt_xvm_do_on_with(wr_seq,p_sequencer.master_sequencer[mstr], {
              slv_num             == slv;
              num_of_wr_xact      == wr_xact_num;
              address             == OVERLAP_ADDR;
              memory_type         == DEVICE;
              id                  == SAME; 
          })
          for (int wr=0;wr<wr_xact_num;wr++) begin
           `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Waiting for Write transaction to end"});
           /** Waiting for above sequence of Write transactions to complete */
           wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[wr]));
           `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Write Transaction is now ended"});
          end
        end //foreach slave
      end //foreach master
    end //for sequence_length
    /** 
     * To check the Write transactions are forwarded in order.<br>
     * Check done by AXI SVT System Monitor.(List of checkers)<br>
     *  #- non_modifiable_xact_check <br>
     *  .
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_overlap_addr_same_id_device_memory_ictest_sequence

// =============================================================================
/**
 *    #- Program the AXI Master VIP to drive multiple (4) write transactions for<br> 
 *       same Slave VIP with different ID, different (but overlapping) AWADDR to<br>
 *       Device memory.<br> 
 *    #- Make sure addresses in the transactions are overlapping.This will help to<br>  
 *       validate that ordering is preserved  for overlapping addresses for Device<br>
 *       Memory.<br>
 *    #- Check the write transactions are in same order at the Interconnect Master Port<br>
 *       and Interconnect Slave Port.<br>
 *    #- Wait for the transaction to complete successfully.<br> 
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br> 
 *       Slaves connected to the Interconnect DUT<br>
 *    .
 */

class svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence extends svt_axi_system_base_sequence;

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
  `uvm_object_utils(svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AXI4 */
      if ((!((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) || (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM ))) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if ((!(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM)) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY))  begin 
        supporting_slaves[index_slv++] = participating_slaves_arr[slv];
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting AXI4 Masters = 1
   *  #- Minimum supporting AXI4 Slaves = 1
   *  #- Master configuration of axi_interface_type should be AXI4
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    /** Supporting masters required */
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();
    /** check the required supporting Masters  */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves) begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_type,\n\
                                                Number of AXI4 Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::axi_interface_category,\
                                                svt_axi_port_configuration::axi_interface_type\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_type,\n\
                                                Number of AXI4 Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::axi_interface_category,\
                                                svt_axi_port_configuration::axi_interface_type\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int wr_xact_num = 4;
    int mstr;
    
    /** Master Write sequence request handle  */
    svt_axi_write_same_slave_sequence wr_seq;

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

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin

      /** Execute the transactions from each selected active participating master */
      foreach (supporting_masters[master_index]) begin
        mstr = supporting_masters[master_index];
        `svt_xvm_debug("body", $sformatf("master to initiate is  'd%0d initiating master index='d%0d ",mstr,master_index) );

        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[slave])  begin
          int slv = supporting_slaves[slave];
         
          /** 
           * Drive Master Write sequence with overlap_addr and diff id for 4 multiple Write transactions 
           * to same slave from selected Master
           */
          `svt_xvm_do_on_with(wr_seq,p_sequencer.master_sequencer[mstr], {
            slv_num             == slv;
            num_of_wr_xact      == wr_xact_num;
            address             == OVERLAP_ADDR;
            memory_type         == DEVICE;
            id                  == DIFF; 
          })
          for (int wr=0;wr<wr_xact_num;wr++) begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Waiting for Write transaction to end"});
            /** Waiting for above sequence of Write transactions to complete */
            wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[wr]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Write Transaction is now ended"});
          end
        end //foreach slave
      end //foreach master
    end //for sequence_length
    /** 
     * To check the Write transactions are forwarded in order.<br>
     * Check done by AXI SVT System Monitor.<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi4_ordering_write_overlap_addr_diff_id_device_memory_ictest_sequence

// =============================================================================
/**
 *    #- Program the AXI Master VIP to drive multiple (4) write transactions for<br> 
 *       same Slave VIP with different ID, different (but overlapping) AWADDR to<br> 
 *       Normal memory.<br> 
 *    #- Make sure addresses in the transactions are overlapping. This will help to<br>
 *       validate that ordering is preserved  for overlapping addresses for Normal Memory.<br>
 *    #- Check the write transactions are in same order at the Interconnect Master Port<br> 
 *       and Interconnect Slave Port.<br>
 *    #- Wait for the transaction to complete successfully.<br> 
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>  
 *       Slaves_connected to the Interconnect DUT.<br>
 *    .
 */

class svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence extends svt_axi_system_base_sequence;

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
  `uvm_object_utils(svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence)
`endif
  
  /** Class Constructor */
  function new (string name = "svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AXI4 */
      if ((!((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) || (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM ))) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
       `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if ((!(sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM)) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY))  begin 
        supporting_slaves[index_slv++] = participating_slaves_arr[slv];
        `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else  begin
       `svt_xvm_debug("svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting AXI4 Masters = 1
   *  #- Minimum supporting AXI4 Slaves = 1
   *  #- Master configuration of axi_interface_type should be AXI4
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;

    /** Supporting masters required */
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();
    /** check the required supporting Masters  */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves) begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of AXI4 Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::axi_interface_category,\
                                                svt_axi_port_configuration::axi_interface_type\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of AXI4 Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::axi_interface_category,\
                                                svt_axi_port_configuration::axi_interface_type\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves,num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int wr_xact_num = 4;
    int mstr;

    /** Master Write sequence request handle */
    svt_axi_write_same_slave_sequence wr_seq;
        
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

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin

      /** Execute the transactions from each selected active participating master */
      foreach (supporting_masters[master_index]) begin
        mstr = supporting_masters[master_index];
        `svt_xvm_debug("body", $sformatf("master to initiate is  'd%0d initiating master index='d%0d ",mstr,master_index) );
        
        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[slave])  begin
          int slv = supporting_slaves[slave];

          /** 
           * Drive Master Write sequence with overlap_addr and diff id for 4 multiple Write transactions 
           * to same slave from selected Master
           */
          `svt_xvm_do_on_with(wr_seq,p_sequencer.master_sequencer[mstr], {
            slv_num             == slv;
            num_of_wr_xact      == wr_xact_num;
            address             == OVERLAP_ADDR;
            memory_type         == NORMAL;
            id                  == DIFF; 
          })
          
          for (int wr=0;wr<wr_xact_num;wr++) begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Waiting for Write transaction to end"});
            /** Waiting for above sequence of Write transactions to complete */
            wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[wr]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Write Transaction is now ended"});
          end
        end //foreach slave
      end //foreach master
    end //for sequence_length
    /** 
     * To check the Write transactions are forwarded in order.<br>
     * Check done by AXI SVT System Monitor.<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi4_ordering_write_overlap_addr_diff_id_normal_memory_ictest_sequence

// =============================================================================
/**
 *    #- Program a randomly selected AXI4 Master VIP to drive two Read transactions to<br> 
 *       same Slave VIP with same ID and overlapping address (not same address).<br> 
 *       Select the address of first Read transaction randomly. Calculate the address<br> 
 *       for second Read transaction such that it is overlapping with address of first<br> 
 *       Read transaction. ARCACHE[1] should be set to 1, to indicate modifiable transactions<br>
 *    #- Within the sequence, wait for xact_request_received_event event issued by Slave VIP Port monitor.<br> 
 *       Check if the address of the transaction which triggered this event is same as<br> 
 *       address of the first read transaction. This validates that the read addresses<br> 
 *       arrived at the Slave VIP in the same order in which they were issued by the Master VIP.<br> 
 *    .
 */

class svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Supporting Master index **/
  rand int unsigned supporting_master_index;
  
  int supporting_masters[int];
  int supporting_slaves[int];
  int active_slaves[];

  /** Randomize the supporting master **/
  constraint supporting_masters_c {
    if (supporting_masters.size())
    {
     supporting_master_index inside {supporting_masters}; 
    }
  }  

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence)
`endif
  
  /** Class Constructor */
  function new (string name = "svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AXI4 */
      if ((!((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) || (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM ))) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if ((!(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM)) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY))  begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting AXI4 Masters = 1
   *  #- Minimum supporting Slaves = 1
   *  #- Master configuration of axi_interface_type should be AXI4
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Getting number of supporting Slaves and supporting Masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters and Slaves  */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int mstr;
    int num_read_xacts;
    int num_read_xacts_status;
    int index;

    /** Slave sequence */
    svt_axi_slave_get_xact_request_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];

    /** Temporary vars */
    int supporting_slv_q[$];

    /** Master Read sequence request handle */
    svt_axi_read_same_slave_sequence rd_seq;

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_read_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_read_xacts", num_read_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_read_xacts"},  num_read_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    
    `svt_xvm_debug("body", $sformatf("num_read_xacts is 'd%0d as a result of %0s.", num_read_xacts,
                                     num_read_xacts_status ? "config DB" : "randomization"));
 
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
   
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);

    /** Triggering slave sequences */
    foreach(active_slaves[index])  begin
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** Execute the transactions from randomly active and participating Master */
    mstr = supporting_master_index;
    `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d initiating master index='d%0d ",mstr,supporting_master_index) );

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];

          /** 
           * Drive Master Read sequence with overlap_addr and same id for 2 multiple Read transactions 
           * to same slave from selected Master
           */
          `svt_xvm_do_on_with(rd_seq,p_sequencer.master_sequencer[mstr], {
            slv_num              == slv;
            xact_length          == num_read_xacts;
            address              == OVERLAP_ADDR;
            memory_type          == NORMAL;
            id                   == SAME;
            do_write_before_read == 0;
          })
         
          /** Waiting for xact_request_received_event to get triggred */
          @(slv_seq[slv].xact_request_received_event); 
          if(slv_seq[slv].slave_req.addr == rd_seq.rd_xact_req[0].addr)   
            `svt_xvm_debug("body", "Address are matched"); 
          
          for (int rd=0; rd<num_read_xacts; rd++) begin
            /** Waiting for above sequence of Read transactions to complete */
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Waiting for Read transaction to end"});
            wait (`SVT_AXI_XACT_STATUS_ENDED(rd_seq.rd_xact_req[rd]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Read Transaction is now ended"});
          end

      end //foreach
    end //sequence_length
    /** 
     * To check the Read transactions are forwarded in order.<br>
     * Check done by Test<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi4_ordering_read_overlap_addr_same_id_normal_memory_ictest_sequence

// =============================================================================
/**
 *    #- Program a randomly selected AXI4 Master VIP to drive two Read transactions to<br> 
 *       same Slave VIP with different ID and overlapping address (not same address).<br> 
 *       Select the address of first Read transaction randomly. Calculate the address<br> 
 *       for second Read transaction such that it is overlapping with address of first<br> 
 *       Read transaction. ARCACHE[1] should be set to 1, to indicate modifiable transactions<br>
 *    #- Within the sequence, wait for xact_request_received_event event issued by Slave VIP Port monitor.<br> 
 *       Check if the address of the transaction which triggered this event is same as<br> 
 *       address of the first read transaction. This validates that the read addresses<br> 
 *       arrived at the Slave VIP in the same order in which they were issued by the Master VIP.<br> 
 *    .  
 */

class svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Supporting Master index **/
  rand int unsigned supporting_master_index;
  
  int supporting_masters[int];
  int supporting_slaves[int];
  int active_slaves[];

  /** Randomize the supporting master **/
  constraint supporting_masters_c {
    if (supporting_masters.size())
    {
     supporting_master_index inside {supporting_masters};
    }
  }  
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name = "svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AXI4 */
      if ((!((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) || (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM ))) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if ((!(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM)) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY))  begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting AXI4 Masters = 1
   *  #- Minimum supporting Slaves = 1
   *  #- Master configuration of axi_interface_type should be AXI4
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Getting number of supporting Slaves and supporting Masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters and Slaves  */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int mstr;
    int num_read_xacts;
    int num_read_xacts_status;
    int index;
    
    /** Master Read sequence request handle  */
    svt_axi_read_same_slave_sequence rd_seq;

    /** Temporary vars */
    int supporting_slv_q[$];

    /** Slave sequence */
    svt_axi_slave_get_xact_request_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_read_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_read_xacts", num_read_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_read_xacts"},  num_read_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    
    `svt_xvm_debug("body", $sformatf("num_read_xacts is 'd%0d as a result of %0s.", num_read_xacts,
                                     num_read_xacts_status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
 
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);

    /** Triggering slave sequences */
    foreach(active_slaves[index])  begin
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** Execute the transactions from randomly active and participating Master */
    mstr = supporting_master_index;
    `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d supporting_master_index='d%0d ",mstr,supporting_master_index) );

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
   
          /** 
           * Drive Master Read sequence with overlap_addr and diff id for 2 multiple Read transactions 
           * to same slave from selected Master
           */
          `svt_xvm_do_on_with(rd_seq,p_sequencer.master_sequencer[mstr], {
            slv_num              == slv;
            xact_length          == num_read_xacts;
            address              == OVERLAP_ADDR;
            memory_type          == NORMAL;
            id                   == DIFF;
            do_write_before_read == 0;
          })
          
          /** Waiting for xact_request_received_event to get triggred */
          @(slv_seq[slv].xact_request_received_event); 
          if(slv_seq[slv].slave_req.addr == rd_seq.rd_xact_req[0].addr)   
            `svt_xvm_debug("body", "Address are matched"); 
          
          for (int rd=0; rd<num_read_xacts; rd++) begin
            /** Waiting for above sequence of Read transactions to complete */
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Waiting for Read transaction to end"});
            wait (`SVT_AXI_XACT_STATUS_ENDED(rd_seq.rd_xact_req[rd]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Read Transaction is now ended"});
          end

      end //foreach
    end //sequence_length
    /** 
     * To check the Read transactions are forwarded in order.<br>
     * Check done by Test<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi4_ordering_read_overlap_addr_diff_id_normal_memory_ictest_sequence

// =============================================================================
/**
 *    #- Program a randomly selected AXI4 Master VIP to drive two Read transactions to<br> 
 *       same Slave VIP with different ID and overlapping address (not same address).<br>  
 *       Select the address of first Read transaction randomly. Calculate the address<br>  
 *       for second Read transaction such that it is overlapping with address of first<br>  
 *       Read transaction. ARCACHE[1] should be set to 0, to indicate non-modifiable<br>  
 *       transactions(to device memory).<br> 
 *    #- Within the sequence, wait for xact_request_received_event event issued by Slave VIP Port monitor.<br>  
 *       Check if the address of the transaction which triggered this event is same as<br>  
 *       address of the first read transaction. This validates that the read addresses<br>  
 *       arrived at the Slave VIP in the same order in which they were issuesd by the<br>  
 *       Master VIP.<br> 
 *    . 
 */

class svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Supporting Master index **/
  rand int unsigned supporting_master_index;
  
  int supporting_slaves[int];
  int supporting_masters[int];
  int active_slaves[];

  /** Randomize the supporting master **/
  constraint supporting_masters_c {
    if (supporting_masters.size())
    {  
     supporting_master_index inside {supporting_masters};
    }
  }  

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence)
`endif
  
  /** Class Constructor */
  function new (string name = "svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AXI4 */
      if ((!((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) || (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM ))) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end 
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if ((!(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM)) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY))  begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting AXI4 Masters = 1
   *  #- Minimum supporting Slaves = 1
   *  #- Master configuration of axi_interface_type should be AXI4
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Getting number of supporting Slaves and supporting Masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters and Slaves  */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int mstr;
    int num_read_xacts;
    int num_read_xacts_status;
    int index;
    int supporting_slv_q[$];

    /** Master Read sequence request handle */
    svt_axi_read_same_slave_sequence rd_seq;  
    /** Slave sequence */
    svt_axi_slave_get_xact_request_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_read_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_read_xacts", num_read_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_read_xacts"},  num_read_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    
    `svt_xvm_debug("body", $sformatf("num_read_xacts is 'd%0d as a result of %0s.", num_read_xacts,
                                     num_read_xacts_status ? "config DB" : "randomization"));
 
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);

    /** Triggering slave sequences */
    foreach(active_slaves[index])  begin
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** Execute the transactions from randomly active and participating Master */
    mstr = supporting_master_index;
    `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d supporting_master_index='d%0d ",mstr,supporting_master_index) );

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
   
          /** 
           * Drive Master Read sequence with overlap_addr and diff id for 2 multiple Read transactions 
           * to same slave from selected Master
           */
          `svt_xvm_do_on_with(rd_seq,p_sequencer.master_sequencer[mstr], {
            slv_num              == slv;
            xact_length          == num_read_xacts;
            address              == OVERLAP_ADDR;
            memory_type          == DEVICE;
            id                   == DIFF;
            do_write_before_read == 0;
          })
           
          /** Waiting for xact_request_received_event to get triggred */
          @(slv_seq[slv].xact_request_received_event); 
          if(slv_seq[slv].slave_req.addr == rd_seq.rd_xact_req[0].addr)   
            `svt_xvm_debug("body", "Address are matched"); 
          
          for (int rd=0; rd<num_read_xacts; rd++) begin
            /** Waiting for above sequence of Read transactions to complete */
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Waiting for Read transaction to end"});
            wait (`SVT_AXI_XACT_STATUS_ENDED(rd_seq.rd_xact_req[rd]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Read Transaction is now ended"});
          end

      end //foreach slave
    end //sequence_length
    /** 
     * To check the Read transactions are forwarded in order.<br>
     * Check done by Test<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi4_ordering_read_overlap_addr_diff_id_device_memory_ictest_sequence

// =============================================================================
/**
 *    #- Program a randomly selected AXI4 Master VIP to drive two Read transactions to<br> 
 *       same Slave VIP with same ID and overlapping address (not same address).<br> 
 *       Select the address of first Read transaction randomly. Calculate the address<br> 
 *       for second Read transaction such that it is overlapping with address of first<br> 
 *       Read transaction. ARCACHE[1] should be set to 0, to indicate non-modifiable<br> 
 *       transactions(to device memory).<br>
 *    #- Within the sequence, wait for xact_request_received_event event issued by Slave VIP Port monitor.<br> 
 *       Check if the address of the transaction which triggered this event is same as<br> 
 *       address of the first read transaction. This validates that the read addresses<br> 
 *       arrived at the Slave VIP in the same order in which they were issuesd by the<br> 
 *       Master VIP.<br> 
 *    .
 */

class svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Supporting Master index **/
  rand int unsigned supporting_master_index;
  
  int supporting_slaves[int];
  int supporting_masters[int];
  int active_slaves[];

  /** Randomize the supporting master **/
  constraint supporting_masters_c {
    if (supporting_masters.size())
    {
     supporting_master_index inside {supporting_masters};
    }
  }  

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence)
`endif
  
  /** Class Constructor */
  function new (string name = "svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AXI4 */
      if ((!((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) || (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM ))) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY))  begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if ((!(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_type == svt_axi_port_configuration::AXI4_STREAM)) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY))  begin 
       supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else  begin
        `svt_xvm_debug("svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- Minimum supporting AXI4 Masters = 1
   *  #- Minimum supporting Slaves = 1
   *  #- Master configuration of axi_interface_type should be AXI4
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;
    int required_num_supporting_slaves = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Getting number of supporting Slaves and supporting Masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();
    
    /** check the required supporting Masters and Slaves  */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI4 Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::axi_interface_type\n\
                                                ", required_num_supporting_masters, num_supporting_masters,required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** UVM sequence body task */
  virtual task body();
    
    /** Local variable */
    bit status;
    int mstr;
    int num_read_xacts;
    int num_read_xacts_status;
    int index;
    int supporting_slv_q[$];

    /** Slave sequence */
    svt_axi_slave_get_xact_request_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];

    /** Master Read sequence request handle */
    svt_axi_read_same_slave_sequence rd_seq;

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_read_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_read_xacts", num_read_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_read_xacts"},  num_read_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    
    `svt_xvm_debug("body", $sformatf("num_read_xacts is 'd%0d as a result of %0s.", num_read_xacts,
                                     num_read_xacts_status ? "config DB" : "randomization"));
 
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);

    /** Triggering slave sequences */
    foreach(active_slaves[index])  begin
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** Execute the transactions from randomly active and participating Master */
    mstr = supporting_master_index;
    `svt_xvm_debug("body", $sformatf("Master to initiate is  'd%0d supporting_master_index='d%0d ",mstr,supporting_master_index) );

    /** Execute the sequence for 'sequence_length' number of times */
    for (int i=0; i < sequence_length; i++) begin
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
           
          /** 
           * Drive Master Read sequence with overlap_addr and same id for 2 multiple Read transactions 
           * to same slave from selected Master
           */
          `svt_xvm_do_on_with(rd_seq,p_sequencer.master_sequencer[mstr], {
              slv_num              == slv;
              xact_length          == num_read_xacts;
              address              == OVERLAP_ADDR;
              memory_type          == DEVICE;
              id                   == SAME;
              do_write_before_read == 0;
            })
                    
          /** Waiting for xact_request_received_event to get triggred */
          @(slv_seq[slv].xact_request_received_event); 
          if(slv_seq[slv].slave_req.addr == rd_seq.rd_xact_req[0].addr)   
            `svt_xvm_debug("body", "Address are matched"); 
          
          for (int rd=0; rd<num_read_xacts; rd++) begin
            /** Waiting for above sequence of Read transactions to complete */
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Waiting for Read transaction to end"});
            wait (`SVT_AXI_XACT_STATUS_ENDED(rd_seq.rd_xact_req[rd]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[rd]), "Read Transaction is now ended"});
          end

      end //foreach
    end //sequence_length
    /** 
     * To check the Read transactions are forwarded in order.<br>
     * Check done by Test<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi4_ordering_read_overlap_addr_same_id_device_memory_ictest_sequence

// =============================================================================
/**
 *    #- Drive a sequence of Write transactions with a set of different AWID's to the<br>
 *       same Slave VIP(e.g sequence of IDs 1,2,3,4,5 from each Master) from all<br> 
 *       masters simultaneously.<br> 
 *       Note that the set of AWIDs used must remain same for all Masters.<br>
 *    #- Wait for all Write transactions to complete.<br>
 *    #- Drive a sequence of Read transactions with a set of different ARID's to the<br>
 *       same Slave VIP(e.g sequence of IDs 1,2,3,4,5 from each Master) from all<br> 
 *       masters simultaneously.<br>
 *       Note that the set of ARIDs used must remain same for all Masters.<br>
 *    #- Program the Slave VIP to interleave read data.<br>
 *    #- Check that the Interconnect is forwarding the correct read data with respect to<br> 
 *       address issued,to the appropriate Master.<br>
 *    .
 */

class svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_slaves[int];
  int supporting_masters[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence)
`endif

  /** Master Write sequence request handles */
  svt_axi_write_same_slave_sequence wr_seq[int];

  /** Read transaction request handles */
  //svt_axi_master_transaction rd_xact_req[$];
  svt_axi_master_transaction rd_xact_req[int];
  
  /** Class Constructor */
  function new(string name = "svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 1
   *  #- minimum read_data_reordering_depth of supporting Slave  > 1
   *  #- minimum read_data_interleave_size of supporting Slave  > 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Total number of supporting_slaves and active_participating_masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();

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
                                                  svt_axi_port_configuration:: axi_interface_category,\n\
                                                  svt_axi_system_configuration::participating_masters\n\
                                                  Number of required Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                  Modify configurations through \n\
                                                  svt_axi_system_configuration::num_slaves,\n\
                                                  svt_axi_port_configuration::read_data_reordering_depth\n\
                                                  svt_axi_port_configuration::read_data_interleave_size\
                                                  ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
        else
          `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                  Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                  Modify configurations through \n\
                                                  svt_axi_system_configuration::num_masters,\n\
                                                  svt_axi_port_configuration::is_active,\n\
                                                  svt_axi_port_configuration:: axi_interface_category,\n\
                                                  svt_axi_system_configuration::participating_masters\n\
                                                  Number of required Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                  Modify configurations through \n\
                                                  svt_axi_system_configuration::num_slaves,\n\
                                                  svt_axi_port_configuration::read_data_reordering_depth\n\
                                                  svt_axi_port_configuration::read_data_interleave_size\
                                                  ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))  
      end
    endfunction : is_supported

  /** Pre-Randomizing the participating masters.*/  
  function void pre_randomize();
    int index_mstr=0;
    int index_slv=0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence", $sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_note("svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].read_data_interleave_size > 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].read_data_reordering_depth > 1)&& (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE))  begin
        supporting_slaves[index_slv++] = participating_slaves_arr[slv];
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence",$sformatf(" slave with id ='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end 
    end
    `svt_xvm_debug("svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence",$sformatf(" number of supporting_slaves is ='d%0d ",supporting_slaves.size()));
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    /** Local variable */
    bit status;
    int num_write_xacts;
    bit num_write_xacts_status;
    int num_read_xacts;
    bit num_read_xacts_status;
    int active_masters[];
    int min_wr_id_width;
    int min_rd_id_width;
    int index;
    int rd_id_q[$]; 

    `svt_xvm_debug("body", "Entering...");
    
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_write_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_write_xacts", num_write_xacts);
    num_read_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_read_xacts", num_read_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_write_xacts"},  num_write_xacts));
    void'(m_sequencer.get_config_int({get_type_name(), "num_read_xacts"},  num_read_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_write_xacts is 'd%0d as a result of %0s.", num_write_xacts,
                                     num_write_xacts_status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_read_xacts is 'd%0d as a result of %0s.", num_read_xacts,
                                     num_read_xacts_status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end 

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    active_masters=new[supporting_masters.size];
    foreach(supporting_masters[i])begin
      active_masters[i]=supporting_masters[i];
    end
    
    /** Getting minimum write channel id width across all active masters */
    min_wr_id_width = get_min_wr_chan_id_width(active_masters, sys_cfg);
    `svt_xvm_debug("body", $sformatf("min_wr_id_width = 'd%0d", min_wr_id_width));

    /** Getting minimum read channel id width across all active masters */
    min_rd_id_width = get_min_rd_chan_id_width(active_masters, sys_cfg);

    /** Collecting read channel id */
    for(int i=0; i < (1<<min_rd_id_width) ; i++)  begin
      rd_id_q.push_back(i);
    end

    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      /** Execute the sequence of Write and Read transactions from all the Masters simultaneously to each Slave */
      foreach(supporting_slaves[slave])  begin
        int slv = supporting_slaves[slave];
        
        /** Execute the sequence of Write transactions from all the Masters simultaneously to a selected Slave */
        foreach(supporting_masters[master])begin
          int mstr = supporting_masters[master];

          /** Drive a Write sequence of multiple write transactions with different ID's from selected Master to the selected Slave*/
          `svt_xvm_do_on_with(wr_seq[mstr], p_sequencer.master_sequencer[mstr],{
            slv_num                == slv;
            num_of_wr_xact         == num_write_xacts;
            address                == RANDOM_ADDR;
            id                     == SET_OF_SEQ_ID;
            min_id                 == local:: min_wr_id_width;   
          })
        end                        

        /** Waiting for Write sequences of multiple write transactions from all the Master's to complete on a selected Slave. */
        foreach(supporting_masters[master])begin
          int mstr_l = supporting_masters[master];

          /** Waiting for the sequence of multiple Write transactions from selected Master to complete on a selected Slave. */
          for(int wr_l=0;wr_l<num_write_xacts;wr_l++)begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[mstr_l].wr_xact_req[wr_l]), "Waiting for Write transaction to end"});
            wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq[mstr_l].wr_xact_req[wr_l]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[mstr_l].wr_xact_req[wr_l]), "Write Transaction is now ended"});
          end                
        end                       

        /** Shuffling all collected read channel id */
        rd_id_q.shuffle;

        /** Execute the sequence of Read transactions from all the Masters simultaneously to a selected Slave */
        foreach(supporting_masters[master])begin
          int mstr = supporting_masters[master];
          automatic int rd_xact_no;
          /** Drive sequence of Read transactions with different ID's from selected Master to the selected Slave*/
          for(int rd=0;rd<num_read_xacts;rd++)begin
            rd_xact_no = (mstr*num_read_xacts)+rd;
            `svt_xvm_do_on_with(rd_xact_req[rd_xact_no],p_sequencer.master_sequencer[mstr],{
              addr               == wr_seq[mstr].wr_xact_req[rd].addr; 
              xact_type          == _read_xact_type[mstr]; 
              coherent_xact_type == svt_axi_transaction::READNOSNOOP;
              atomic_type        == svt_axi_transaction::NORMAL;  
              id                 == (rd_id_q[rd % (1<<min_rd_id_width)]);
              addr_valid_delay   == 0;
            // Not supported in INCA and does not affect functionally since
            // it is being set to 0 and that is the default behaviour
`ifndef INCA
              check_addr_overlap == 0;
`endif             
              burst_type         == wr_seq[mstr].wr_xact_req[rd].burst_type; 
              burst_size         == wr_seq[mstr].wr_xact_req[rd].burst_size; 
              burst_length       == wr_seq[mstr].wr_xact_req[rd].burst_length; 
              reference_event_for_addr_valid_delay ==  svt_axi_transaction ::PREV_ADDR_HANDSHAKE;
            }) 
          end              
        end                         
        /** Waiting for the sequence of Read transactions from all the Master's to complete on a selected Slave. */
        foreach(supporting_masters[master])begin
          int mstr_l = supporting_masters[master];
          automatic int rd_xact_num;
          /** Waiting for the sequence of Read transactions from selected Master to complete on a selected Slave. */
          for(int rd_l=0;rd_l<num_read_xacts;rd_l++)begin
            rd_xact_num = (mstr_l*num_read_xacts)+rd_l;
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd_xact_num]), "Waiting for Read transaction to end"});
            wait(`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req[rd_xact_num]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd_xact_num]), "Read Transaction is now ended"});
          end                   
        end//foreach
      end//foreach slave                        
    end//for sequence length                              

    rd_id_q.delete();  

    /** 
     * To check the Write and Read transactions are forwarded in order.<br>
     * Check done by System monitor.(List of checkers)<br> 
     *  #- data_integrity_check<br>
     *  .
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_read_same_id_sequence_diff_masters_ictest_sequence 

// =============================================================================
/**
 *    #- Drive a sequence of Write transactions with same AWID to the same Slave VIP<br> 
 *       from all masters simultaneously.<br> 
 *    #- Wait for all Write transactions to complete.<br>
 *    #- Drive a sequence of Read transactions with same ARID  to the same Slave VIP<br>
 *       from all masters simultaneously.<br> 
 *    #- Program the Slave VIP to interleave read data.<br>
 *    #- Check that the Interconnect is forwarding the correct read data with respect to<br>
 *       address issued,to the appropriate Master.<br>
 *    .
 */

class svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int supporting_slaves[int];
  int supporting_masters[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence)
`endif
  
  /** Master Write sequence request handles */
  svt_axi_write_same_slave_sequence wr_seq[int];

  /** Read transaction request handles */
  svt_axi_master_transaction rd_xact_req[int];
  
  /** Class Constructor */
  function new(string name = "svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 1
   *  #- minimum read_data_reordering_depth of supporting Slave  > 1
   *  #- minimum read_data_interleave_size of supporting Slave  > 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Total number of supporting_slaves and active_participating_masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();

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
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of required Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::read_data_reordering_depth\n\
                                                svt_axi_port_configuration::read_data_interleave_size\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of required Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::read_data_reordering_depth\n\
                                                svt_axi_port_configuration::read_data_interleave_size\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end
  endfunction : is_supported

  /** Pre-Randomizing the participating masters.*/  
  function void pre_randomize();
    int index_mstr=0;
    int index_slv=0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence",$sformatf("master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].read_data_interleave_size > 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].read_data_reordering_depth > 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE))  begin
        supporting_slaves[index_slv++]=participating_slaves_arr[slv];
        `svt_xvm_debug("svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence",$sformatf(" slave with id ='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end 
    end
    `svt_xvm_debug("svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence",$sformatf(" number of supporting_slaves is ='d%0d ",supporting_slaves.size()));
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    /** Local variable */
    bit status;
    int num_write_xacts;
    bit num_write_xacts_status;
    int num_read_xacts;
    bit num_read_xacts_status;
    int active_masters[];
    int min_wr_id_width;
    int min_rd_id_width;
    int index;
    bit [`SVT_AXI_MAX_ID_WIDTH-1:0] temp_rd_id; 
    int rd_id_arr[$];  

    `svt_xvm_debug("body", "Entering...");
    
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_write_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_write_xacts", num_write_xacts);
    num_read_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_read_xacts", num_read_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_write_xacts"},  num_write_xacts));
    void'(m_sequencer.get_config_int({get_type_name(), "num_read_xacts"},  num_read_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_write_xacts is 'd%0d as a result of %0s.", num_write_xacts,
                                     num_write_xacts_status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_read_xacts is 'd%0d as a result of %0s.", num_read_xacts,
                                     num_read_xacts_status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end 
 
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
  
    active_masters=new[supporting_masters.size];
    foreach(supporting_masters[i])begin
      active_masters[i]=supporting_masters[i];
    end
    
    /** Getting minimum write channel id width across all active masters */
    min_wr_id_width = get_min_wr_chan_id_width(active_masters, sys_cfg);
    `svt_xvm_debug("body", $sformatf("min_wr_id_width = 'd%0d", min_wr_id_width));

    /** Getting minimum read channel id width across all active masters */
    min_rd_id_width = get_min_rd_chan_id_width(active_masters, sys_cfg);

    `svt_xvm_debug("svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence",$sformatf(" supporting_slaves is ='d%0d ",supporting_slaves.size()));

    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      /** Execute the sequence of Write and Read transactions from all the Masters simultaneously to each Slave */
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
        
        /** Collecting read channel id */
        for(int i=0; i < (1<<min_rd_id_width) ; i++)  begin
          rd_id_arr.push_back(i);
        end
        /** Shuffling all collected read channel id */
        rd_id_arr.shuffle;
        temp_rd_id = rd_id_arr.pop_front();   
        
        /** Execute the sequence of Write transactions from all the Masters simultaneously to a selected Slave */
        foreach(supporting_masters[master])begin
          int mstr = supporting_masters[master];
          /** Drive a Write sequence of multiple write transactions with same ID's from selected Master to the selected Slave*/
          `svt_xvm_do_on_with(wr_seq[mstr], p_sequencer.master_sequencer[mstr],{
            slv_num                == slv;
            num_of_wr_xact         == num_write_xacts;
            address                == RANDOM_ADDR;
            id                     == SET_OF_SAME_ID;
            min_id                 == local:: min_wr_id_width;   
          })
        end                        

        /** Waiting for Write sequences of multiple write transactions from all the Master's to complete on a selected Slave. */
        foreach(supporting_masters[master])begin
          int mstr_l = supporting_masters[master];

          /** Waiting for the sequence of multiple Write transactions from selected Master to complete on a selected Slave. */
          for(int wr_l=0;wr_l<num_write_xacts;wr_l++)begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[mstr_l].wr_xact_req[wr_l]), "Waiting for Write transaction to end"});
            wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq[mstr_l].wr_xact_req[wr_l]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[mstr_l].wr_xact_req[wr_l]), "Write Transaction is now ended"});
          end                
        end                      

        /** Execute the sequence of Read transactions from all the Masters simultaneously to a selected Slave */
        foreach(supporting_masters[master])begin
          int mstr = supporting_masters[master];
          automatic int rd_xact_no;
          /** Drive sequence of Read transactions with same ID's from selected Master to the selected Slave*/
          for(int rd=0;rd<num_read_xacts;rd++)begin
            rd_xact_no = (mstr*num_read_xacts)+rd;
            `svt_xvm_do_on_with(rd_xact_req[rd_xact_no],p_sequencer.master_sequencer[mstr],{
              addr               == local::wr_seq[mstr].wr_xact_req[rd].addr; 
              xact_type          == _read_xact_type[mstr];
              coherent_xact_type == svt_axi_transaction::READNOSNOOP;
              id                 == temp_rd_id;
              atomic_type        == svt_axi_transaction::NORMAL;
              addr_valid_delay   == 0;
              // Not supported in INCA and does not affect functionally since
              // it is being set to 0 and that is the default behaviour
`ifndef INCA
              check_addr_overlap                     == 0;
`endif
              burst_type         == local::wr_seq[mstr].wr_xact_req[rd].burst_type; 
              burst_length       == local::wr_seq[mstr].wr_xact_req[rd].burst_length; 
              burst_size         == local::wr_seq[mstr].wr_xact_req[rd].burst_size; 
              reference_event_for_addr_valid_delay ==  svt_axi_transaction ::PREV_ADDR_HANDSHAKE;
            }) 
          end              
        end                         

        /** Waiting for the sequence of Read transactions from all the Master's to complete on a selected Slave. */
        foreach(supporting_masters[master])begin
          int mstr_l = supporting_masters[master];
          automatic int rd_xact_num;
          /** Waiting for the sequence of Read transactions from selected Master to complete on a selected Slave. */
          for(int rd_l=0;rd_l<num_read_xacts;rd_l++)begin
            rd_xact_num = (mstr_l*num_read_xacts)+rd_l;
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd_xact_num]), "Waiting for Read transaction to end"});
            wait(`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req[rd_xact_num]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd_xact_num]), "Read Transaction is now ended"});
          end                   
        end//foreach
      end//foreach slave                         
   end//for sequence length                               
   /** 
    * To check Interconnect shall forward the correct write data to appropriate slave<br> 
    * VIPs and correct read data to appropriate Master VIPs.<br> 
    * Check done by System monitor<br> 
    *  #- data_integrity_check<br>
    *  .
    */

   `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_same_id_xact_from_diff_masters_ictest_sequence  

// =============================================================================
/**
 *    #- Program the Master VIP to drive write transaction to Slave VIP.<br>
 *    #- Program the Slave VIP to delay the response of previous write transaction<br> 
 *       until further intimation.<br>
 *    #- Program the Master VIP to drive read transaction to the same Slave VIP before<br>
 *       getting response to above write transaction.<br>
 *    #- Check that the Interconnect is forwarding the read transaction before receiving<br>
 *       response from Slave VIP.This will get tested through system configuration<br>
 *       bus_inactivity_timeout.<br>
 *    #- Program the Slave VIP to respond to both read and write transactions.<br>
 *    .
 */

class svt_axi_ordering_write_read_without_wait_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int active_slaves[];
  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_read_without_wait_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_read_without_wait_ictest_sequence)
`endif
   
  /** Class Constructor */
  function new(string name = "svt_axi_ordering_write_read_without_wait_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
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

    /** 
     * Total number of active_participating_slaves and active_participating_masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();

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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_read_without_wait_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_without_wait_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end

    foreach(active_participating_slaves[slv])  begin
      if(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_slaves[support_slv_index++] = active_participating_slaves[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_read_without_wait_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_without_wait_ictest_sequence",$sformatf("slave with id='d%0d does not have an AXI_READ_WRITE port",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    int index;
    int wr_xact_num = 1; 
    int num_read_xacts = 1; 
    int supporting_slv_q[$];

    /** Master Write sequence request handle */
    svt_axi_write_same_slave_sequence wr_seq;

    /** Master Read sequence request handle */
    svt_axi_read_same_slave_sequence rd_seq;
    
    /** Slave sequence */
    svt_axi_slave_ordering_memory_suspend_response_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];

    /** Handle to system environment */
    svt_axi_system_env system_env;
    
    /** Handle to uvm_component */
`SVT_XVM(component) my_parent;

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.",
                                     sequence_length, status ? "config DB" : "randomization"));
   
     /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Getting svt_axi_system_env object handle */ 
    my_parent = p_sequencer.get_parent();
    if(!($cast(system_env,my_parent)))begin
      `svt_xvm_fatal("body","Internal Error - Expected parent to be of type svt_axi_system_env, but it is not");
    end
     
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);

    /** Triggering slave sequences */
    foreach(active_slaves[index]) begin  
       fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      foreach(supporting_masters[initiating_master_index]) begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body",$sformatf("Master to initiate is 'd%0d initiating_master_index is 'd%0d",mstr,i));

        /** Execute the transactions on each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
          /** Drive a Write sequence with random addr to same Slave*/
          `svt_xvm_do_on_with(wr_seq, p_sequencer.master_sequencer[mstr],{
            slv_num             == slv;
            num_of_wr_xact      == wr_xact_num;
            address             == RANDOM_ADDR;
            id                  == RANDOM;
          })

          /** Wait until Write Address reached Slave */
          @(slv_seq[slv].wr_addr_reached);

          /** Drive a Read sequence with random addr to same Slave*/
          `svt_xvm_do_on_with(rd_seq, p_sequencer.master_sequencer[mstr],{
            slv_num              == slv;
            xact_length          == num_read_xacts;
            address              == RANDOM_ADDR;
            id                   == RANDOM;
            do_write_before_read == 0;
          })

          /** Wait until ARVALID is asserted at Interconnect's Master Port */
          `protected
f6dcTe2&JaPP>)S7G0^T2Z]&^/]]12c#\;I04&Wf/[R[[ed;N[GB-)c;U]+1/I\e
R\K:1QEX(=/&&DCM_Aba#WNU]7PU5K6OJ<<]E8ZgHM^S<cRA_<cEHaEEF]PaM2M/
aM0Z1S61.Q_]+UKZ9Iac]KJV;fe:Tda\B:9#T=\O2G3>_Z</fUM9(&6&9aBS]YWKW$
`endprotected

          `svt_xvm_debug("body","EVENT_TX_READ_XACT_STARTED triggered");

          /** Wait until Read Address reached Slave */
          ->slv_seq[slv].rd_addr_reached;
          `svt_xvm_debug("body","Triggered the event rd_addr_reached to resume suspended response of previous write transaction");

          fork 
            begin
              /** Waiting for sequence of a Write transactions to complete */
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[0]), "Waiting for Write transaction to end"});
              wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[0]));
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[0]), "Write Transaction is now ended"});
            end
            begin
              /** Waiting for sequence of a Read transactions to complete */
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[0]), "Waiting for Read transaction to end"});
              wait(`SVT_AXI_XACT_STATUS_ENDED(rd_seq.rd_xact_req[0]));
              `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[0]), "Read Transaction is now ended"});
            end
          join

        end//foreach slave
      end//foreach master
    end //for sequence_length
    /** To check the Write and Read transactions are completed successfully.<br>
     *  Check done by Test Sequence.<br> 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_ordering_write_read_without_wait_ictest_sequence

// =============================================================================
/**
 *    #- Program the  Master VIP to drive read transaction.<br>
 *    #- After few clock cycles, program the Master VIP to drive write transaction<br> 
 *       to Slave VIP  with  AWID same as ARID.<br>
 *    #- Program the Slave VIP to delay the response of previous read transaction.<br>
 *    #- Check interconnect forwards the response of write transaction and then response<br>
 *       of read transaction.<br>
 *    . 
 */

class svt_axi_ordering_read_write_same_id_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int active_slaves[];

  /** Supporting masters */
  int supporting_masters[int];

  /** Supporting slaves */
  int supporting_slaves[int];  

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_read_write_same_id_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_read_write_same_id_ictest_sequence)
`endif
   
  /** Class Constructor */
  function new(string name = "svt_axi_ordering_read_write_same_id_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
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

    /** 
     * Total number of active_participating_slaves and active_participating_masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();

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
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active\
                                                svt_axi_port_configuration::num_outsanding_xact\
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
                                                svt_axi_port_configuration::num_outsanding_xact\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_slv=0; 
    int index_mstr=0; 
    super.pre_randomize();
    /** Getting number of Supporting Slaves */
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_read_write_same_id_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_read_write_same_id_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    /**  Check if the Slave configuration is has num_outstanding > 1 */
    foreach(active_participating_slaves[slv])  begin
      if ((((sys_cfg.slave_cfg[active_participating_slaves[slv]].num_outstanding_xact == -1 ) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].num_write_outstanding_xact > 1 || sys_cfg.slave_cfg[active_participating_slaves[slv]].num_read_outstanding_xact > 1 )) || ((sys_cfg.slave_cfg[active_participating_slaves[slv]].num_outstanding_xact != -1 )&& (sys_cfg.slave_cfg[active_participating_slaves[slv]].num_outstanding_xact > 1)))&& (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
        supporting_slaves[index_slv++] = active_participating_slaves[slv];  
        `svt_xvm_debug("svt_axi_ordering_read_write_same_id_ictest_sequence",$sformatf(" slave id that is active participating is ='d%0d ",active_participating_slaves[slv]));
        `svt_xvm_debug("svt_axi_ordering_read_write_same_id_ictest_sequence",$sformatf(" slave that is active and participating has num_write_outstanding_xact ='d%0d and num_read_outstanding_xact ='d%0d",sys_cfg.slave_cfg[active_participating_slaves[slv]].num_write_outstanding_xact,sys_cfg.slave_cfg[active_participating_slaves[slv]].num_read_outstanding_xact));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_read_write_same_id_ictest_sequence",$sformatf("slave with id='d%0d does not meet requirements",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    int num_read_xacts = 1;
    int supporting_slv_q[$];
     
    /** Master Read sequence request handle */
    svt_axi_read_same_slave_sequence rd_seq;
    
    /** Write transaction request handle */
    svt_axi_master_transaction wr_xact;

    /** Slave sequence */
    svt_axi_slave_suspend_read_response_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[$];

    /** Handle to system environment */
    svt_axi_system_env system_env;
    
    /** Handle to uvm_component */
`SVT_XVM(component) my_parent;

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

    /** Getting svt_axi_system_env object handle */ 
    my_parent = p_sequencer.get_parent();
    if(!($cast(system_env,my_parent)))begin
      `svt_xvm_fatal("body","Internal Error - Expected parent to be of type svt_axi_system_env, but it is not");
    end

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);

    /** Triggering slave sequences */
    foreach(active_slaves[index]) begin  
       fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
`protected
@E:-/+CJ>a[69>BfM;4#X+149g/.[NT),aH,Q&)#^g,@U?1)e0=?()EO1RXZ-I[c
W@)CM?U6OfdIH<6/PKJO^8()f#J393TPB,bd#OEZX,1BTT\b^C=)Ja?OJ8<b/GOe
5+94GEI)FE5ZffHRXB;)1>FOUR@#YMVO^H76Jc4LDSSa[IEfYR]H&/?OP$
`endprotected

            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
`protected
\(^YBMe@\0:4(]:5&U9UXF&NC=GT<K42T1\aXc>T]^_Pge_NH+Z90)??4b+PbOIQ
AP&-6f9O(=@40$
`endprotected

    end

    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      foreach(supporting_masters[initiating_master_index]) begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body",$sformatf("Master to initiate is 'd%0d initiating_master_index is 'd%0d",mstr,i));

        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

          /** Drive a Read sequence to same Slave*/
          `svt_xvm_do_on_with(rd_seq, p_sequencer.master_sequencer[mstr],{
            slv_num              == slv;
            xact_length          == num_read_xacts;
            address              == RANDOM_ADDR;
            id                   == RD_WR_CHAN_MIN_ID;
            do_write_before_read == 0;
          })
          
          /** Wait until ARVALID is asserted at Interconnect's Master Port */
          `protected
N++/R)Pc6Pb06dEE_O;E.-26g#SXbfB//><2QdcT\LZ[#LXFYLd77)g#gLN3\)R=
\\I0XN/d&5.\_\=_gDU/NdFBe&S=R9:P3XTWI0OMQ8C<1:8dOLPIF\e^RKA#Qb6K
eZBZD[E>bH-.Ya69MFg^RE,4<=)fW&20UdQFc[\Q;/M^ZcMAFW_dfWRg&SgLMG]#W$
`endprotected

          `svt_xvm_debug("body","EVENT_TX_READ_XACT_STARTED triggered");

          /** Execute a Write transaction to the same Slave*/
          `svt_xvm_do_on_with(wr_xact, p_sequencer.master_sequencer[mstr],{
            addr               >= lo_addr;
            addr               <= hi_addr-(burst_length*(1<<burst_size));
            xact_type          == _write_xact_type[mstr];
            coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
            atomic_type        == svt_axi_transaction::NORMAL;
            id                 == local::rd_seq.rd_xact_req[0].id;
            burst_type         inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
          })

          /** Waiting for Write transaction to complete */
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact), "Waiting for Write transaction to end"});
          wait(`SVT_AXI_XACT_STATUS_ENDED(wr_xact));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact), "Write Transaction is now ended"});

          /** Triggering the event present in the slave sequence,to resume the suspended response of a transaction */
          `svt_xvm_debug("body",$sformatf("Triggering the event resume_read_resp to resume the previously suspended response of a transaction "));
          ->slv_seq[slv].resume_read_resp;
          `svt_xvm_debug("body",$sformatf("Triggered the event resume_read_resp succecfully "));

          /** Waiting for sequence of a Read transaction to complete */
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[0]), "Waiting for Read transaction to end"});
          wait(`SVT_AXI_XACT_STATUS_ENDED(rd_seq.rd_xact_req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq.rd_xact_req[0]), "Read Transaction is now ended"});
        end//foreach                  
      end//foreach                     
    end//for sequence length                          
    /** To check the Read and write transactions are completed successfully.<br>
     *  Check done by Test Sequence.<br> 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_ordering_read_write_same_id_ictest_sequence 

// =============================================================================
/**
 *    #- Program the  Master VIP to drive write transaction.<br>
 *    #- After few clock cycles, program the Master VIP to drive read transaction to<br> 
 *       Slave VIP  with  ARID same as AWID.<br>
 *    #- Program the Slave VIP to delay the response of previous write transaction.<br>
 *    #- Check interconnect forwards the response of read transaction and then response<br> 
 *       of write transaction.This will get tested through system configuration<br>
 *       bus_inactivity_timeout.<br>
 *    . 
 */

class svt_axi_ordering_write_read_same_id_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int active_slaves[];
  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_read_same_id_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_read_same_id_ictest_sequence)
`endif
   
  /** Class Constructor */
  function new(string name = "svt_axi_ordering_write_read_same_id_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
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

    /** 
     * Total number of active_participating_slaves and active_participating_masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();


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

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int support_mstr_index=0; 
    int support_slv_index=0; 
    super.pre_randomize();
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_masters[support_mstr_index++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_ictest_sequence",$sformatf("master with id='d%0d does not have an AXI_READ_WRITE port",active_participating_masters[mstr]));
      end
    end
    foreach(active_participating_slaves[slv])  begin
      if(sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        supporting_slaves[support_slv_index++] = active_participating_slaves[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_read_same_id_ictest_sequence",$sformatf("slave with id='d%0d does not have an AXI_READ_WRITE port",active_participating_slaves[slv]));
      end
    end
  endfunction: pre_randomize


  /** UVM sequence body task */ 
  virtual task body();

    /** local variables */
    bit status;
    int index; 
    int wr_xact_num = 1;
    int supporting_slv_q[$];
    
    /** Master Write sequence request handle */
    svt_axi_write_same_slave_sequence wr_seq;

    /** Read transaction request handle */
    svt_axi_master_transaction rd_xact;

    /** Handle to system environment */
    svt_axi_system_env system_env;
    
    /** Handle to uvm_component */
`SVT_XVM(component) my_parent;

    /** Slave sequence */
    svt_axi_slave_suspend_write_response_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];

    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.",
                                     sequence_length, status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end 
 
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Getting svt_axi_system_env object handle */ 
    my_parent = p_sequencer.get_parent();
    if(!($cast(system_env,my_parent)))begin
      `svt_xvm_fatal("body","Internal Error - Expected parent to be of type svt_axi_system_env, but it is not");
    end
    
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);
 
    /** Triggering slave sequences */
    foreach(active_slaves[index]) begin  
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      foreach(supporting_masters[initiating_master_index]) begin
        int mstr = supporting_masters[initiating_master_index];
        `svt_xvm_debug("body",$sformatf("Master to initiate is 'd%0d initiating_master_index is 'd%0d",mstr,i));

        /** Execute the transactions on each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
    
          /** Drive a Write sequence with random addr to same Slave*/
          `svt_xvm_do_on_with(wr_seq, p_sequencer.master_sequencer[mstr],{
            slv_num             == slv;
            num_of_wr_xact      == wr_xact_num;
            address             == RANDOM_ADDR;
            id                  == RD_WR_CHAN_MIN_ID;
          })

          /** Wait until AWVALID is asserted at Interconnect's Master Port */
          `protected
g+fE/Wg/A4aVR8YQcd>XFF+Y)?+\7[2[QSVAG^V&P3S2I+gBG[2b.);T7d6&RTS-
^7FXAE@R.aCORU=M^bfeAZc4(0)P@M:MK/@ROY._6/G(,PA+<[GUbfX/U)(=HOWd
ILLf>LQ51aEX=+a0X_B5bc/dZV9=b^I9gA(H]S&3\4L)HS?58M:A+WQ-7()&:<?E
($
`endprotected

          `svt_xvm_debug("body","EVENT_TX_WRITE_XACT_STARTED triggered");

          /** Execute a Read transaction with Write transaction accessing id to same Slave*/
          `svt_xvm_do_on_with(rd_xact, p_sequencer.master_sequencer[mstr],{
            addr                >= lo_addr;
            addr                <= hi_addr-(burst_length*(1<<burst_size));
            xact_type           == _read_xact_type[mstr];
            coherent_xact_type  == svt_axi_transaction::READNOSNOOP;
            atomic_type         == svt_axi_transaction::NORMAL; 
            id                  == wr_seq.wr_xact_req[0].id;
            addr_valid_delay    == 0;
            burst_type          inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
            reference_event_for_addr_valid_delay ==  svt_axi_transaction ::PREV_ADDR_HANDSHAKE;
          })

          /** Waiting for Read transaction to complete */
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact), "Waiting for Read transaction to end"});
          wait(`SVT_AXI_XACT_STATUS_ENDED(rd_xact));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact), "Read Transaction is now ended"});

          /** Triggering the event present in the slave sequence,to resume the suspended response of a transaction */
          `svt_xvm_debug("body",$sformatf("Triggering the event resume_write_response to resume the previously suspended response of a transaction "));
          ->slv_seq[slv].resume_write_resp;
          `svt_xvm_debug("body",$sformatf("Triggered the event resume_write_response succecfully "));

          /** Waiting for sequence of a Write transaction to complete */
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[0]), "Waiting for Write transaction to end"});
          wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[0]));
          `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[0]), "Write Transaction is now ended"});
        end//foreach
      end//foreach
    end //for sequence_length
    /** To check the Write and Read transactions are completed successfully.<br>
     *  Check done by Test Sequence.<br> 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_ordering_write_read_same_id_ictest_sequence 

// =============================================================================
/**
 *    #- Program a randomly selected Master M0 VIP to drive a read transaction<br> 
 *       to the Slave VIP .<br>
 *    #- Program the Slave VIP to suspend the response of read transaction from Master<br>
 *       M0 VIP.Use svt_axi_transaction::suspend_response member to suspend the response.<br>
 *       Use it in slave response sequence.<br>
 *    #- Program another randomly selected Master M1 VIP to drive a read transaction to<br> 
 *       the same Slave VIP.Wait for transaction from M1 to end.<br>
 *    #- Release the suspended response from Slave VIP for read transaction from Master<br> 
 *       M0 VIP.<br>
 *    .  
 */

class svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;
  
  /** Variables to select random Masters */
  rand int selected_mstr[2];

  /** Variables to select random Masters */
  rand int unsigned initiating_master_index_2;

  /** Local variable */
  int active_slaves[];
  int supporting_slaves[int];
  int supporting_masters[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** Randomize the initiatiating second master */
  constraint initiating_second_master_c {
    if (supporting_masters.size()>=2)
    {
     initiating_master_index_2 inside {supporting_masters}; 
     initiating_master_index_2 != initiating_master_index;
    }
  }

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence)
`endif
  
  /** Master Read sequence request handles */
  svt_axi_read_same_slave_sequence rd_seq[$];

  /** Slave sequence */
  svt_axi_slave_suspend_read_response_on_address_sequence slv_seq[int];
  svt_axi_slave_memory_sequence slv_mem_seq[int];
  
  /** Class Constructor */
  function new(string name = "svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 1
   *  #- minimum read_data_reordering_depth of supporting Slave  >= 2
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Total number of supporting_slaves and active_participating_masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();


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
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active\n\
                                                svt_axi_port_configuration::read_data_reordering_depth\
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
                                                svt_axi_port_configuration::is_active\n\
                                                svt_axi_port_configuration::read_data_reordering_depth\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end
  endfunction : is_supported

  /** Pre-Randomizing the participating masters and slaves.*/  
  function void pre_randomize();
    int index_mstr=0;
    int index_slv=0;
    super.pre_randomize();
    /** Getting number of supporting_masters */
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY) begin
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence",$sformatf("master with id='d%0d has only AXI_WRITE_ONLY port",active_participating_masters[mstr]));
      end
    end
    /** Getting number of supporting_slaves */
    foreach(active_participating_slaves[slv])  begin
      if((sys_cfg.slave_cfg[active_participating_slaves[slv]].read_data_reordering_depth >1) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_WRITE_ONLY))  begin
        supporting_slaves[index_slv++]=active_participating_slaves[slv];
        `svt_xvm_debug("svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence",$sformatf(" slave with id ='d%0d does not meet requirements ",active_participating_slaves[slv]));
      end 
    end
    `svt_xvm_debug("svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence",$sformatf(" number of supporting_slaves is ='d%0d ",supporting_slaves.size()));
  endfunction: pre_randomize
    
  /** UVM sequence body task */
  virtual task body();
    /** Local variable */
    bit status;
    int active_masters[];
    int min_rd_id_width;
    int num_read_xacts=1;
    automatic int slave;
    int supporting_slv_q[$];

    /** Handle to system environment */
    svt_axi_system_env system_env;

    /** Handle to uvm_component */
`SVT_XVM(component) my_parent;

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

    /** Getting svt_axi_system_env object handle */
    my_parent = p_sequencer.get_parent();
    if(!($cast(system_env,my_parent)))begin
      `svt_xvm_fatal("body","Internal Error - Expected parent to be of type svt_axi_system_env, but it is not");
    end

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    active_masters=new[supporting_masters.size];
    foreach(supporting_masters[i])begin
      active_masters[i]=supporting_masters[i];
    end

    /** Getting minimum id width among active masters */
    min_rd_id_width = get_min_rd_chan_id_width(active_masters, sys_cfg);

    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);
 
    `svt_xvm_debug("body",$sformatf("active_slaves ='d%0d ",active_slaves.size()));

    /** Triggering slave sequences */
    foreach(active_slaves[index]) begin  
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** Re-arranging the selected_mstr */
    if (sys_cfg.master_cfg[initiating_master_index].id_width < sys_cfg.master_cfg[initiating_master_index_2].id_width) begin
      selected_mstr[0]=initiating_master_index;
      selected_mstr[1]=initiating_master_index_2;
    end
    else begin
      selected_mstr[0]=initiating_master_index_2;
      selected_mstr[1]=initiating_master_index;
    end

    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      /** Execute the sequence of Read transactions from random Masters to each Slave */
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];

        /** Execute the transactions in randomly selected two Masters to selected Slave */
        foreach(selected_mstr[i])begin
          `svt_xvm_debug("body",$sformatf("MASTER selected_mstr['d%0d] is 'd%0d slv= 'd%0d",i,selected_mstr[i],slv));
        end

        /** Drive Master Read sequence of Read transactions from random Master to the selected Slave*/
        `svt_xvm_do_on_with(rd_seq[0],p_sequencer.master_sequencer[selected_mstr[0]],{
            slv_num              == slv;
            xact_length          == num_read_xacts;
            address              == RANDOM_ADDR;
            id                   == SET_OF_SAME_ID;
            min_id               == local:: min_rd_id_width;   
            do_write_before_read == 0;
        })

        /** Passing the address to slave sequence,for suspending the response of a transaction */
        slv_seq[slv].address_to_suspend = rd_seq[0].rd_xact_req[0].addr;
        `svt_xvm_debug("body",$sformatf("Transaction fired by master 'd%0d with address is 'h%h ",selected_mstr[0],rd_seq[0].rd_xact_req[0].addr));
        `svt_xvm_debug("body",$sformatf("Transaction address to which response is suspended is 'h%h",slv_seq[slv].address_to_suspend ));

        /** Wait until ARVALID is asserted at Interconnect's Master Port */
        `protected
2VQGC[fI/Kag3E<V:FGS&+RP-07R.&Id&UE2\W1][[WYM6I;:A#5.)=D&b[cYM]L
>E/AN_4I7?X8;_UI+;T&.GI8=A5_aa1I:HJALQ(^Wb^_Ua8),9MO=+Q+1)2@BMHL
6DD;._gP[a_)&fV5S8KeMP(=@eNAJ36-X4:4:C9]8U)__W7V^eT1:X=Z_>OC7D@aS$
`endprotected

        `svt_xvm_debug("body","EVENT_TX_READ_XACT_STARTED triggered");

        /** Drive Master Read sequence of Read transactions from random Master to the selected Slave*/
        `svt_xvm_do_on_with(rd_seq[1],p_sequencer.master_sequencer[selected_mstr[1]],{
            slv_num              == slv;
            xact_length          == num_read_xacts;
            address              == RANDOM_ADDR;
            id                   == SET_OF_SAME_ID;
            min_id               == local:: min_rd_id_width;   
            do_write_before_read == 0;
        })

        `svt_xvm_debug("body",$sformatf("Transaction fired by master 'd%0d with address is 'h%h ",selected_mstr[1],rd_seq[1].rd_xact_req[0].addr));

        /** Waiting for second read sequence of a Read transaction to complete */
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq[1].rd_xact_req[0]), "Waiting for Read transaction to end"});
         wait(`SVT_AXI_XACT_STATUS_ENDED(rd_seq[1].rd_xact_req[0]));
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq[1].rd_xact_req[0]), "Read Transaction is now ended"});

        /** Triggering the event present in the slave sequence,to resume the suspended response of a transaction */
        `svt_xvm_debug("body",$sformatf("Triggering the event resume_read_resp to resume_response of transaction fired by master 'd%0d with address is 'h%h ",selected_mstr[0],rd_seq[0].rd_xact_req[0].addr));
        ->slv_seq[slv].resume_read_resp;
        `svt_xvm_debug("body",$sformatf("Triggered the event resume_read_resp successfully,to resume the response of a transaction from master 'd%0d with address is 'h%h to end ",selected_mstr[0],rd_seq[0].rd_xact_req[0].addr));

        /** Waiting for first read sequence of a Read transaction to complete */
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq[0].rd_xact_req[0]), "Waiting for Read transaction to end"});
        wait(`SVT_AXI_XACT_STATUS_ENDED(rd_seq[0].rd_xact_req[0]));
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_seq[0].rd_xact_req[0]), "Read Transaction is now ended"});

      end//foreach                     
    end//for sequence length                          
                             
    /** 
     * To check that the Interconnect shall forward the transaction from randomly <br> 
     * selected second Master VIP to the Slave VIP before receiving response for <br>
     * transaction from first Master and forward response to second Master VIP <br> 
     * without waiting for response for transaction from first Master VIP.<br>
     * Check done by System monitor<br> 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_read_same_id_from_diff_masters_ictest_sequence  

// =============================================================================
/**
 *    #- Program a randomly selected Master M0 VIP to drive a write transaction to<br> 
 *       the Slave VIP .<br>
 *    #- Program the Slave VIP to suspend the response of write transaction from<br> 
 *       Master M0 VIP.<br>
 *       Use svt_axi_transaction::suspend_response member to suspend the response.<br>
 *       Use it in slave response sequence.<br>
 *    #- Program another randomly selected Master M1 VIP to drive a write transaction<br>
 *       to the same Slave VIP.Wait for transaction from M1 to end.<br>
 *    #- Release the suspended response from Slave VIP for write transaction from Master<br>
 *       M0 VIP.<br>
 *    . 
 */

class svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Variables to select random Masters */
  rand int selected_mstr[2]; 

 /** Variables to select random Masters */
  rand int unsigned initiating_master_index_2;

  /** Local variable */
  int active_slaves[];
  int supporting_slaves[int];
  int supporting_masters[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** Randomize the initiatiating second master */
  constraint initiating_second_master_c {
    if (supporting_masters.size()>=2)
    {
      initiating_master_index_2 inside {supporting_masters}; 
      initiating_master_index_2 != initiating_master_index;
    }
  }  

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence)
`endif
  
  /** Master Write sequence request handles */
  svt_axi_write_same_slave_sequence wr_seq[int];

  /** Handle to system environment */
  svt_axi_system_env system_env;
    
  /** Handle to uvm_component */
//  uvm_component my_parent;
`SVT_XVM(component) my_parent;

  /** Slave sequence */
  svt_axi_slave_suspend_write_response_on_address_sequence slv_seq[int];
  svt_axi_slave_memory_sequence slv_mem_seq[int];
  
  /** Class Constructor */
  function new(string name = "svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence");
    super.new(name);
  endfunction : new

 /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 1
   *  #- minimum write_resp_reordering_depth of supporting Slave  > 1
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** 
     * Total number of supporting_slaves and active_participating_masters 
     */
    num_supporting_slaves = supporting_slaves.size();
    num_supporting_masters = supporting_masters.size();


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
                                                svt_axi_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_slaves,\n\
                                                svt_axi_port_configuration::is_active\n\
                                                svt_axi_port_configuration::write_resp_reordering_depth\
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
                                                svt_axi_port_configuration::is_active\n\
                                                svt_axi_port_configuration::write_resp_reordering_depth\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end
  endfunction : is_supported

  /** Pre-Randomizing the participating masters.*/  
  function void pre_randomize();
    int index_mstr=0;
    int index_slv=0;
    super.pre_randomize();
     /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if((sys_cfg.slave_cfg[active_participating_slaves[slv]].write_resp_reordering_depth >1) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY))  begin
        supporting_slaves[index_slv++]=active_participating_slaves[slv];
        `svt_xvm_debug("svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence",$sformatf(" slave id that is participating is='d%0d ",active_participating_slaves[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence",$sformatf(" slave with id ='d%0d does not meet requirements ",active_participating_slaves[slv]));
      end 
    end
    `svt_xvm_debug("svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence",$sformatf(" number of supporting_slaves is ='d%0d ",supporting_slaves.size()));
  endfunction: pre_randomize
   
  /** UVM sequence body task */
  virtual task body();
    /** Local variable */
    bit status;
    automatic int slave;
    int active_masters[];
    int index; 
    int wr_id;
    int min_wr_id_width;
    int num_write_xacts=1;
    int supporting_slv_q[$];

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

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    active_masters=new[supporting_masters.size];
    foreach(supporting_masters[i])begin
      active_masters[i]=supporting_masters[i];
    end

    /** Getting minimum id width among active masters */
    min_wr_id_width = get_min_wr_chan_id_width(active_masters, sys_cfg);
    `svt_xvm_debug("body", $sformatf("min_wr_id_width = 'd%0d", min_wr_id_width));

    /** Getting svt_axi_system_env object handle */ 
    my_parent = p_sequencer.get_parent();
    if(!($cast(system_env,my_parent)))begin
      `svt_xvm_fatal("body","Internal Error - Expected parent to be of type svt_axi_system_env, but it is not");
    end
    
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);
 
    `svt_xvm_debug("body",$sformatf("active_slaves ='d%0d ",active_slaves.size()));

    /** Triggering slave sequences */
    foreach(active_slaves[index]) begin  
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

    /** To randomly select the master */
    selected_mstr[0]=initiating_master_index;
    selected_mstr[1]=initiating_master_index_2;

    `svt_xvm_debug("body",$sformatf("supporting_slaves ='d%0d ",supporting_slaves.size()));

    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      /** Execute the sequence of Write transactions from random Masters to each Slave */
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
        foreach(selected_mstr[i])begin
          `svt_xvm_debug("body",$sformatf("selected_mstr['d%0d] is 'd%0d",i,selected_mstr[i]));
        end
        
        /** Drive Write sequence of a Write Transaction from random Master to the selected Slave*/
        `svt_xvm_do_on_with(wr_seq[0], p_sequencer.master_sequencer[selected_mstr[0]],{
          slv_num                == slv;
          num_of_wr_xact         == num_write_xacts;
          address                == RANDOM_ADDR;
          id                     == SET_OF_SAME_ID;
          min_id                 == local:: min_wr_id_width;   
        })

        /** Passing the address to slave sequence,for suspending the response of a transaction */
        slv_seq[slv].address_to_suspend = wr_seq[0].wr_xact_req[0].addr;
        `svt_xvm_debug("body",$sformatf("Transaction fired by master 'd%0d with address is 'h%h ",selected_mstr[0],wr_seq[0].wr_xact_req[0].addr));
        `svt_xvm_debug("body",$sformatf("Transaction address to which response is suspended is 'h%h",slv_seq[slv].address_to_suspend ));

        /** Wait until AWVALID is asserted at Interconnect's Master Port */
        `protected
b>bX4W>]bf\XOd@#>X4E>O.;C893F@DH[\>:6Wb.L;Z[VdMRRc./6)RgL(C3/F)7
(2X[T^a.I[SL,=Z=aTb[Cd:d(L\/1O@I,]6G&H1HB=D-PLfH]+(gPY#W^]4GbYCH
:N/1EW60M^P1@&^6R(0^GC@()TFeNAM_VTNAV>[f9B5P&V<dC87[I74g>d\W(D<4T$
`endprotected

        `svt_xvm_debug("body","EVENT_TX_WRITE_XACT_STARTED triggered");

        /** Drive Write sequence of a Write Transaction from random Master to the selected Slave*/
        `svt_xvm_do_on_with(wr_seq[1], p_sequencer.master_sequencer[selected_mstr[1]],{
           slv_num                == slv;
           num_of_wr_xact         == num_write_xacts;
           address                == RANDOM_ADDR;
           id                     == SET_OF_SAME_ID;
           min_id                 == local:: min_wr_id_width;   
         })

        `svt_xvm_debug("body",$sformatf("Transaction fired by master 'd%0d with address is 'h%h ",selected_mstr[1],wr_seq[1].wr_xact_req[0].addr));

         /** Waiting for second write sequence of a Write transaction to complete */
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[1].wr_xact_req[0]), "Waiting for Write transaction to end"});
        wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq[1].wr_xact_req[0]));
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[1].wr_xact_req[0]), "Write Transaction is now ended"});

        /** Triggering the event present in the slave sequence,to resume the suspended response of a transaction */
        `svt_xvm_debug("body",$sformatf("Triggering the event resume_write_resp to resume_response of transaction fired by master 'd%0d with address is 'h%h ",selected_mstr[0],wr_seq[0].wr_xact_req[0].addr));
        ->slv_seq[slv].resume_write_resp;
        `svt_xvm_debug("body",$sformatf("Triggered the event resume_write_resp successfully,to resume the response of a transaction from master 'd%0d with address is 'h%h to end ",selected_mstr[0],wr_seq[0].wr_xact_req[0].addr));

        /** Waiting for first write sequence of a Write transaction to complete */
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[0].wr_xact_req[0]), "Waiting for Write transaction to end"});
        wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq[0].wr_xact_req[0]));
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[0].wr_xact_req[0]), "Write Transaction is now ended"});
      end//foreach                     
    end//for sequence length                               
    /** 
     * To check that the Interconnect shall forward the transaction from randomly<br> 
     * selected second Master VIP to the Slave VIP before receiving response to<br> 
     * the transaction from first Master VIP  and forward response<br>
     * to second Master VIP without waiting for response to first Master VIP transaction.<br>
     * Check done by System monitor<br> 
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi_ordering_write_same_id_from_diff_masters_ictest_sequence 
 
// =============================================================================
/**
 *    #- Program all AXI3 Master VIPs to simultaneously drive a sequence of write<br> 
 *       transactions with interleaved write data(with write interleaving depth >1 )<br>
 *       with random AWID's. <br>
 *       Transaction address will be randomly selected based on system address map.<br>
 *    #- Configure the AXI3 Slave VIP interleaving depth >1.<br>
 *    #- Check that the Interconnect is forwarding the correct write data with respect<br>
 *       to address issued<br>
 *    .
 */

class svt_axi3_ordering_write_diff_id_interleave_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi3_ordering_write_diff_id_interleave_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi3_ordering_write_diff_id_interleave_ictest_sequence)
`endif
  
  /** Master Write sequence request handles */
  svt_axi_write_same_slave_sequence wr_seq_q[int];

  /** Class Constructor */
  function new(string name = "svt_axi3_ordering_write_diff_id_interleave_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- Master configuration of axi_interface_type should be AXI3
   *  #- Master should support interleaving(write_data_interleave_depth > 1) 
   *  #- Slave should support interleaving(write_data_interleave_depth > 1) 
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;
    
    /** Supporting slaves required */
    int required_num_supporting_slaves = 1; 

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();

    /** Check the required supporting Masters and Slaves */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI3 Supporting Master(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                Number of Supporting Slave(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI3 Supporting Master(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                Number of Supporting Slave(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr=0; 
    int index_slv=0; 
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr]) begin
      /**  Check if the Master configuration is AXI3 and interleaving is allowed */
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) && (sys_cfg.master_cfg[active_participating_masters[mstr]].write_data_interleave_depth > 1) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].write_data_interleave_depth > 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin
        supporting_slaves[index_slv++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_ictest_sequence",$sformatf(" slave write_data_interleave_depth that is participating is ='d%0d ",sys_cfg.slave_cfg[participating_slaves_arr[slv]].write_data_interleave_depth));
      end
      else  begin
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    /** Local variable */
    bit status;
    int num_write_xacts;
    bit num_write_xacts_status;
    int index; 
       
    `svt_xvm_debug("body", "Entering...");
    
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_write_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_write_xacts", num_write_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_write_xacts"},  num_write_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_write_xacts is 'd%0d as a result of %0s.", num_write_xacts,
                                     num_write_xacts_status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      /** Execute the sequence of Write transactions from all the Masters simultaneously to each Slave */
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
                
        /** Execute the sequence of Write transactions simultaneously from all active participating Master to a selected Slave */
        foreach(supporting_masters[master_index]) begin
          int mstr = supporting_masters[master_index];
          if(!num_write_xacts_status || num_write_xacts == 0)
            num_write_xacts =  sys_cfg.master_cfg[mstr].write_data_interleave_depth;
          `svt_xvm_debug("body", $sformatf("Master to initiate is 'd%0d initiating masters index='d%0d ",mstr,initiating_master_index));
          
          /** Drive a Write sequence of multiple write transactions from selected Master to the selected Slave*/
          `svt_xvm_do_on_with(wr_seq_q[mstr], p_sequencer.master_sequencer[mstr],{
            slv_num             == slv;
            num_of_wr_xact      == num_write_xacts;
            address             == RANDOM_ADDR;
            id                  == RANDOM;
            interleave          == RANDOM_INTERLEAVE;
          })
        end
     
        /** Waiting for Write sequences of multiple write transactions from all the Master's to complete on a selected Slave. */
        foreach(supporting_masters[i])begin
         int m = supporting_masters[i];
          /** Waiting for the sequence of multiple Write transactions from selected Master to complete on a selected Slave. */
          for(int wr_l=0;wr_l<num_write_xacts;wr_l++)begin
            `svt_xvm_debug("body ", {`SVT_AXI_PRINT_PREFIX1(wr_seq_q[m].wr_xact_req[wr_l]), "Waiting for Write transaction to end"});
            wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq_q[m].wr_xact_req[wr_l]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq_q[m].wr_xact_req[wr_l]), "Write Transaction is now ended"});
          end
        end
      end//foreach slave                        
    end//for sequence length                               
    /** 
     * To check Interconnect is forwarding the correct write data with respect to address
     * issued.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi3_ordering_write_diff_id_interleave_ictest_sequence 

// =============================================================================
/**
 *    #- Program all AXI3 Master VIPs to simultaneously drive a sequence of write<br> 
 *       transactions with repeating AWID's (1,2,1,2,1). In case of master being<br> 
 *       configured as AXI3 write data with interleaving (with write interleaving<br> 
 *       depth >1).Transaction address will be randomly selected based on system<br> 
 *       address map.<br>
 *    #- Configure the AXI3 Slave VIP interleaving depth >1.<br>
 *    #- Check that the Interconnect is forwarding the correct write data with<br> 
 *       respect to address issued.<br>
 *    .
 */

class svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence)
`endif
  
  /** Master Write sequence request handles */
  svt_axi_write_same_slave_sequence wr_seq[int];

  /** Class Constructor */
  function new(string name = "svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- Master configuration of axi_interface_type should be AXI3
   *  #- Master should support interleaving(write_data_interleave_depth > 1) 
   *  #- Slave should support interleaving(write_data_interleave_depth > 1) 
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;
    
    /** Supporting slaves required */
    int required_num_supporting_slaves = 1; 

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();

    /** Check the required supporting Masters and Slaves */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI3 Supporting Master(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                Number of Supporting Slave(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI3 Supporting Master(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                Number of Supporting Slave(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr=0; 
    int index_slv=0; 
    super.pre_randomize(); 
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr]) begin
      /**  Check if the Master configuration is AXI3 and interleaving is allowed */
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) && (sys_cfg.master_cfg[active_participating_masters[mstr]].write_data_interleave_depth > 1) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].write_data_interleave_depth > 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin
        supporting_slaves[index_slv++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence",$sformatf(" slave write_data_interleave_depth that is participating is ='d%0d ",sys_cfg.slave_cfg[participating_slaves_arr[slv]].write_data_interleave_depth));
      end
      else  begin
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */
  virtual task body();
    /** Local variable */
    bit status;
    int num_write_xacts;
    bit num_write_xacts_status;
    int active_masters[];
    int index;
    int min_wr_id_width;

    `svt_xvm_debug("body", "Entering...");
    
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_write_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_write_xacts", num_write_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_write_xacts"},  num_write_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_write_xacts is 'd%0d as a result of %0s.", num_write_xacts,
                                     num_write_xacts_status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    active_masters=new[supporting_masters.size];
    foreach(supporting_masters[i])begin
      active_masters[i]=supporting_masters[i];
    end

    /** Getting minimum id width among active masters */
    min_wr_id_width = get_min_wr_chan_id_width(active_masters, sys_cfg);
    `svt_xvm_debug("body", $sformatf("min_wr_id_width = 'd%0d", min_wr_id_width));
 
    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      /** Execute the sequence of Write transactions from all the Masters simultaneously to each Slave */
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
        
        /** Execute the sequence of Write transactions simultaneously from all active participating Master to a selected Slave */
        foreach(supporting_masters[master_index]) begin
          int mstr = supporting_masters[master_index];
          if(!num_write_xacts_status || num_write_xacts == 0)
            num_write_xacts =  sys_cfg.master_cfg[mstr].write_data_interleave_depth;
          `svt_xvm_debug("body", $sformatf("Master to initiate is 'd%0d initiating masters index='d%0d ",mstr,master_index));
           
          /** Drive a Write sequence of multiple write transactions with same ID's from selected Master to the selected Slave*/
          `svt_xvm_do_on_with(wr_seq[mstr], p_sequencer.master_sequencer[mstr],{
            slv_num                == slv;
            num_of_wr_xact         == num_write_xacts;
            address                == RANDOM_ADDR;
            id                     == SET_OF_REPT_ID;
            interleave             == RANDOM_INTERLEAVE; 
            min_id                 == local:: min_wr_id_width;   
          })
        end                        

        /** Waiting for Write sequences of multiple write transactions from all the Master's to complete on a selected Slave. */
        foreach(supporting_masters[i]) begin
          int m = supporting_masters[i];
          /** Waiting for the sequence of multiple Write transactions from selected Master to complete on a selected Slave. */
          for(int wr_l=0;wr_l<num_write_xacts;wr_l++)begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[m].wr_xact_req[wr_l]), "Waiting for Write transaction to end"});
            wait(`SVT_AXI_XACT_STATUS_ENDED(wr_seq[m].wr_xact_req[wr_l]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq[m].wr_xact_req[wr_l]), "Write Transaction is now ended"});
          end                
        end     

      end//foreach slave                        
    end//for sequence length                               
    /** 
     * To check Interconnect is forwarding the correct write data with respect to address
     * issued.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi3_ordering_write_diff_id_interleave_with_repeating_id_ictest_sequence 

// =============================================================================
/**
 *    #- Configure Master VIP to interleaving depth >1.<br>
 *    #- Program AXI3 Master VIP to drive a sequence of write transactions with write<br> 
 *       data interleaving.<br>
 *    #- Configure the AXI3 Slave VIP to interleaving depth of 1<br>
 *    #- Check that the Interconnect is forwarding the transactions to the  AXI3 Slave<br> 
 *       VIP without write data interleaving<br>
 *    .
 */

class svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length is used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
  
  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence)
`endif
  
  /** Master Write sequence request handle */
  svt_axi_write_same_slave_sequence wr_seq;

  /** Class Constructor */
  function new(string name = "svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- Master configuration of axi_interface_type should be AXI3
   *  #- Master should support interleaving(write_data_interleave_depth > 1) 
   *  #- Slave should not support interleaving(write_data_interleave_depth = 1) 
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;
    
    /** Supporting slaves required */
    int required_num_supporting_slaves = 1; 

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();

    /** Check the required supporting Masters and Slaves */
    if((num_supporting_masters >= required_num_supporting_masters) && (num_supporting_slaves >= required_num_supporting_slaves))  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI3 Supporting Master(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                Number of Supporting Slave(s) not supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of AXI3 Supporting Master(s) supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_system_configuration::num_masters,\n\
                                                svt_axi_port_configuration::is_active,\n\
                                                svt_axi_system_configuration::participating_masters\n\
                                                svt_axi_port_configuration::axi_interface_category,\n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                Number of Supporting Slave(s) not supporting interleaving - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_axi_port_configuration::write_data_interleave_depth,\n\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported

  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr=0; 
    int index_slv=0; 
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr]) begin
      /**  Check if the Master configuration is AXI3 and interleaving is allowed */
      if((sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_type == svt_axi_port_configuration::AXI3) && (sys_cfg.master_cfg[active_participating_masters[mstr]].write_data_interleave_depth > 1) && (sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else  begin
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence",$sformatf(" master with id='d%0d does not meet requirements ",active_participating_masters[mstr]));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(participating_slaves_arr[slv])  begin
      if((sys_cfg.slave_cfg[participating_slaves_arr[slv]].write_data_interleave_depth == 1) && (sys_cfg.slave_cfg[participating_slaves_arr[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin
        supporting_slaves[index_slv++] = participating_slaves_arr[slv];  
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",participating_slaves_arr[slv]));
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence",$sformatf(" slave write_data_interleave_depth that is participating is ='d%0d ",sys_cfg.slave_cfg[participating_slaves_arr[slv]].write_data_interleave_depth));
      end
      else  begin
        `svt_xvm_debug("svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence",$sformatf(" slave with id='d%0d does not meet requirements ",participating_slaves_arr[slv]));
      end
    end
  endfunction: pre_randomize

  /** UVM sequence body task */
 virtual task body();
    /** Local variable */
    bit status;
    int num_write_xacts;
    bit num_write_xacts_status;
    int index; 
       
    `svt_xvm_debug("body", "Entering...");
    
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_write_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_write_xacts", num_write_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_write_xacts"},  num_write_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_write_xacts is 'd%0d as a result of %0s.", num_write_xacts,
                                     num_write_xacts_status ? "config DB" : "randomization"));
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Execute the sequence for 'sequence_length' number of times */
    for(int i=0; i < sequence_length;i++)begin
      /** Execute the transactions from each selected Master. */
      foreach(supporting_masters[master_index]) begin
        int mstr = supporting_masters[master_index];
        if(!num_write_xacts_status || num_write_xacts == 0)
          num_write_xacts =  sys_cfg.master_cfg[mstr].write_data_interleave_depth;
        `svt_xvm_debug("body", $sformatf("Master to initiate is 'd%0d initiating masters index='d%0d ",mstr,master_index));
        
        /** Execute the transactions in each Slave from selected Master */
        foreach(supporting_slaves[index])  begin
          int slv = supporting_slaves[index];
          /** Drive a Write sequence of multiple write transactions with different ID's from selected Master to the selected Slave*/
          `svt_xvm_do_on_with(wr_seq, p_sequencer.master_sequencer[mstr],{
            slv_num             == slv;
            num_of_wr_xact      == num_write_xacts;
            address             == RANDOM_ADDR;
            id                  == DIFF; 
            interleave          == RANDOM_INTERLEAVE;
          })
  
          /** Waiting for above sequence of Write transaction to complete. */
          for(int wr=0;wr<num_write_xacts;wr++)begin
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Waiting for Write transaction to end"});
            wait (`SVT_AXI_XACT_STATUS_ENDED(wr_seq.wr_xact_req[wr]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_seq.wr_xact_req[wr]), "Write Transaction is now ended"});
          end
        end//foreach slave                        
      end//foreach master                        
    end//for sequence length                               
    /** 
     * To check Interconnect is forwarding the correct write data with respect to address<br>
     * issued.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass:svt_axi3_ordering_write_diff_id_no_interleave_at_slave_ictest_sequence 

//======================================================================================
/** 
 *    #- Program the Master M0 VIP to drive multiple write transactions with same ID.<br>
 *    #- Simultaneously program the Master M1 VIP to drive multiple write transactions<br>
 *       with same ID and it should be equal to ID used by M0.<br>
 *    #- Program the Slave VIP to respond out-of-order.<br>
 *    #- Program the Slave VIP to respond with OKAY for transactions addressed by M0 and<br>
 *       SLVERR for transactions addressed by M1. The transactions coming from M0 and M1<br>
 *       can be differentiated based on address.<br>
 *    #- Check the BRESP forwarded by interconnect to M0 are OKAY and for M1 are SLVERR.<br>
 *       This check will be performed within the virtual sequence running on AXI System<br>
 *       Sequencer.<br>
 *    .
 */

class svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Local variable */
  int active_slaves[];
  int supporting_masters[int];
  int supporting_slaves[int];

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }

  /** Initiating second Master index */
  rand int unsigned initiating_master_index_2;

  /** Randomize the initiatiating second master */
  constraint initiating_second_master_c {
    if (supporting_masters.size()>=2)
    {
     initiating_master_index_2 inside {supporting_masters}; 
     initiating_master_index_2 != initiating_master_index;
    }
  }  

  /** Write transaction request handles */
  svt_axi_master_transaction wr_xact_req[$];

  /** Variables to select random Masters */
  int selected_mstr[2];

  /** UVM Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence)
`endif

  /** Class Constructor */
  function new (string name =  "svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence");
    super.new(name);
  endfunction : new

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Slaves */
    foreach(active_participating_masters[mstr])  begin
      if(sys_cfg.master_cfg[active_participating_masters[mstr]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin
        supporting_masters[index_mstr++] = active_participating_masters[mstr];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence",$sformatf(" master id that is participating is ='d%0d ",active_participating_masters[mstr]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence",$sformatf("master with id='d%0d has only AXI_READ_ONLY port",active_participating_masters[mstr]));
      end
    end

    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if((sys_cfg.slave_cfg[active_participating_slaves[slv]].reordering_algorithm == svt_axi_port_configuration::RANDOM) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].write_resp_reordering_depth >= 2) && (sys_cfg.slave_cfg[active_participating_slaves[slv]].axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY)) begin
        supporting_slaves[index_slv++] = active_participating_slaves[slv];  
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence",$sformatf(" slave id that is participating is ='d%0d ",active_participating_slaves[slv]));
      end
      else begin
        `svt_xvm_debug("svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence",$sformatf("slave with id='d%0d does not meet requirements",active_participating_slaves[slv]));
      end
    end//foreach of slave
  endfunction: pre_randomize

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 1
   *  #- minimum write_resp_reordering_depth of each active Slave should be greater than or equal to 2
   *  #- Configuration of each active slave reordering_algorithm should be RANDOM
   */
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;
    svt_axi_system_configuration  axi_sys_cfg;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;

    /** Supporting slaves required */
    int required_num_supporting_slaves  = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    /** getting test suite system configuration */
    if (!$cast(axi_sys_cfg,cfg)) begin
      `svt_xvm_fatal("body", "unable to $cast the configuration to a svt_axi_system_configuration class");
    end

    num_supporting_masters = supporting_masters.size();
    num_supporting_slaves = supporting_slaves.size();

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

  /** UVM sequence body task */
  virtual task body();
   
    /** Local variables */
    bit status;
    int active_masters[];
    int index;
    int num_write_xacts;
    bit num_write_xacts_status;
    int min_wr_id_width; 
    int wr_id; 
    int supporting_slv_q[$];
    int wr_id_min_val_arr[$];

    /** Slave sequence */
    svt_axi_slave_diff_write_resp_for_diff_masters_sequence slv_seq[int];
    svt_axi_slave_memory_sequence slv_mem_seq[int];
    `svt_xvm_debug("body", "Entering...");

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    num_write_xacts_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "num_write_xacts", num_write_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), "sequence_length"},  sequence_length));
    void'(m_sequencer.get_config_int({get_type_name(), "num_write_xacts"},  num_write_xacts));
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length,
                                     status ? "config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("num_write_xacts is 'd%0d from a master as a result of %0s.", num_write_xacts,
                                     num_write_xacts_status ? "config DB" : "randomization"));

    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue */
    sink_responses();
    
    /** Initializing active masters array */
    active_masters=new[supporting_masters.size];
    
    /** Mapping contents of active_participating_masters into active masters array */ 
    foreach(supporting_masters[i])begin
      active_masters[i]=supporting_masters[i];
    end
   
    /** Getting number of active slaves */
    get_active_slaves(active_slaves, sys_cfg);

    /** Triggering slave sequences */
    foreach(active_slaves[index])  begin
      fork  begin
        automatic int slv = active_slaves[index];
        fork
          begin
            `svt_xvm_debug("body",$sformatf("Process created for slave = 'd%0d",slv));
            supporting_slv_q = supporting_slaves.find_index with(item == slv);
            if(supporting_slv_q.size())  begin
              `svt_xvm_debug("body",$sformatf("supporting_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            else begin
              `svt_xvm_debug("body",$sformatf("active_slaves with slv = 'd%0d", slv))
              `svt_xvm_do_on(slv_mem_seq[slv], p_sequencer.slave_sequencer[slv])
            end
            `svt_xvm_debug("body",$sformatf("After Process created for slave = 'd%0d",slv))
          end
        join_none
      end
      join
    end

        /** Re-arranging the selected_mstr */
    if (sys_cfg.master_cfg[initiating_master_index].id_width < sys_cfg.master_cfg[initiating_master_index_2].id_width) begin
      selected_mstr[0]=initiating_master_index;
      selected_mstr[1]=initiating_master_index_2;
    end
    else begin
      selected_mstr[0]=initiating_master_index_2;
      selected_mstr[1]=initiating_master_index;
    end
    
    `svt_xvm_debug("body",$sformatf("Randomly selected two masters are 'd%0d 'd%0d",initiating_master_index,initiating_master_index_2));

    /** Execute the sequence for 'sequence_length' number of times */ 
    for (int i=0; i< sequence_length; i++)begin
      /** Execute the transactions in each Slave from selected active participating Master */
      foreach(supporting_slaves[index])  begin
        int slv = supporting_slaves[index];
        bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
        bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;

        /** Execute the transactions from each selected active participating Master */
        foreach(selected_mstr[master])   begin
          int mstr = selected_mstr[master];
          automatic int wr_xact_no;
          `svt_xvm_debug("body",$sformatf("Selected_mstr['d%0d] is randomly picking a master of 'd%0d from active_participating_masters",master, selected_mstr[master]));
        /** Randomly select an Address range for selected active slave */
        if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

          /** Execute Multiple Write transactions with same ID */
          for (int wr=0;wr<num_write_xacts;wr++) begin 
            wr_xact_no = master * num_write_xacts + wr; 
            `svt_xvm_do_on_with(wr_xact_req[wr_xact_no],p_sequencer.master_sequencer[mstr], {
              addr                    >= lo_addr;
              addr                    <= hi_addr-(burst_length*(1<<burst_size));
              /** Second master id should be same of the first master for all the num_write_xacts */
              if (master==1 || wr > 0) {
                id                    == wr_id;
              }
              xact_type               == _write_xact_type[mstr];
              coherent_xact_type      == svt_axi_transaction::WRITENOSNOOP;
              atomic_type             == svt_axi_transaction::NORMAL;
              burst_type              inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP,svt_axi_transaction::FIXED};
              cache_type              == 4'b0000;
              data_before_addr        == 0;
              reference_event_for_addr_valid_delay ==  svt_axi_transaction::PREV_ADDR_HANDSHAKE;
              addr_valid_delay        == 0;
            })

            /** Capture first id and use it for other xacts */
            if (master==0 && wr==0) begin
              wr_id = wr_xact_req[wr_xact_no].id;
            end

            if(master==0) begin
              /** Collection of Write transaction addresses of Master M0 */
              slv_seq[slv].num_addr_m0[wr] = wr_xact_req[wr_xact_no].addr;
              /** Collection of Write transaction data transfers of Master M0 */
              foreach(wr_xact_req[wr_xact_no].data[i]) begin
                slv_seq[slv].num_data_transfer_m0.push_back({wr_xact_req[wr_xact_no].addr,wr_xact_req[wr_xact_no].data[i]});
              end
            end
            else begin
              /** Collection of Write transaction addresses of Master M1 */
              slv_seq[slv].num_addr_m1[wr] = wr_xact_req[wr_xact_no].addr;
              /** Collection of Write transaction data transfers of Master M1 */
              foreach(wr_xact_req[wr_xact_no].data[i]) begin
                slv_seq[slv].num_data_transfer_m1.push_back({wr_xact_req[wr_xact_no].addr,wr_xact_req[wr_xact_no].data[i]});
              end
            end
          end  
        end//foreach of selected_mstr[]
        
        /** Waiting for the sequence of Write transactions from all the Master's to complete on a selected Slave */
        foreach(selected_mstr[master])   begin
          int mstr = selected_mstr[master];
          automatic int wr_xact_no;
          for (int wr=0;wr<num_write_xacts;wr++) begin
            wr_xact_no = master * num_write_xacts + wr;

            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[wr_xact_no]), "Waiting for Write transaction to end"});
            /** Waiting for above Write transaction to complete */
            wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[wr_xact_no]));
            `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[wr_xact_no]), "Write Transaction is now ended"});

            if (master==0) begin
              if(wr_xact_req[wr_xact_no].bresp != svt_axi_transaction::OKAY)
                `svt_xvm_error("body", $sformatf("Expected to receive WRITE transaction response as OKAY for master M0 for address 'h%0h",wr_xact_req[wr_xact_no].addr)); 
            end
            if (master==1) begin
              if(wr_xact_req[wr_xact_no].bresp != svt_axi_transaction::SLVERR) 
                `svt_xvm_error("body", $sformatf("Expected to receive WRITE transaction response as SLVERR for master M1 for address 'h%0h",wr_xact_req[wr_xact_no].addr));  
            end
          end 
        end
        /** To delete the content of write data transfers of Master M0 and M1 */ 
        slv_seq[slv].num_data_transfer_m0.delete();
        slv_seq[slv].num_data_transfer_m1.delete();
      end//foreach of slave
    end //forloop of sequence_length
    /**
     * To check Interconnect shall forward the BRESP to Master VIPs appropriately.<br>
     * Check done by Test<br>
     */

    `svt_xvm_debug("body", "Exiting...");
  endtask: body
endclass: svt_axi_ordering_write_same_id_device_non_bufferable_memory_diff_masters_response_ictest_sequence

`endif // GUARD_SVT_AXI_3_4_INTERCONNECT_TS_ORDERING_SEQUENCE_COLLECTION_SV

