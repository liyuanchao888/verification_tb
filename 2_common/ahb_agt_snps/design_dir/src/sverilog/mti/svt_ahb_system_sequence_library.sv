
`ifndef GUARD_SVT_AHB_SYSTEM_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_AHB_SYSTEM_SEQUENCE_LIBRARY_SV

// =============================================================================
/**
 * This sequence creates a reporter reference
 */
class svt_ahb_system_base_sequence extends svt_sequence;

  `svt_xvm_object_utils(svt_ahb_system_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_system_sequencer)

  /** Handles to get system configuration */
  svt_configuration base_cfg;
  svt_ahb_system_configuration sys_cfg;

  local semaphore sink_response_sema = new(1);

  extern function new(string name="svt_ahb_system_base_sequence");
  
  /** Active Participating Master index */
  rand int unsigned initiating_master_index_0;
  
  /** Active Participating Slave index */
  rand int unsigned active_participating_slave_index_0;

  /** Participating Slave index */
  rand int unsigned participating_slave_index_0;

  /** Array of masters that are participating and active */
  int active_participating_masters[int];

  /** Array of slaves that are participating and active */
  int active_participating_slaves[int];

  /** Array of slaves that are participating in the system so that the transactions from the master can be routed to the slaves in this array */
  int participating_slaves_arr[int];

  /** This bit silent is used typically to suppress is_supported message */
  bit silent;

  /** Represents the lock signal. */
  bit temp_lock_1,temp_lock_2;

  /** Represents the length of the sequence. */
  int unsigned sequence_length = 10;

  /** Status filed for capturing config DB get status for sequence_length */
  bit sequence_length_status;

  /** Status filed for capturing config DB get status for silent */  
  bit silent_status;

  /** 
   * This bit indicates whether the arrays related to various types of nodes
   * are populated or not. 
   * This is used by the sequence for maitaining the infrastructure, and should
   * not be programmed by user.
   */
  bit is_participating_master_slaves_array_setup = 0;

  /** 
   * Represents the master index from which the sequence will be initiated. 
   * This can be controlled through config DB. 
   */ 
  int unsigned master_index_0;
  
  int unsigned master_index_1;

  /** 
   * Represents the slave index from which the sequence will be initiated. 
   * This can be controlled through config DB. 
   */ 
  int unsigned slave_index_0;

  int unsigned slave_index_1;
  
  /** Status field for capturing config DB get status for master_index */
  bit master_index_status_0;

  bit master_index_status_1;
  
  /** Status field for capturing config DB get status for slave_index */
  bit slave_index_status_0;

  bit slave_index_status_1;
  
  /** Status field for capturing config DB get status for lock */
  bit temp_lock_status_1,temp_lock_status_2;

  /** Randomize the initiating_master_index_0 */
  constraint initiating_master_index_0_c {
    if (active_participating_masters.size())
    {
     initiating_master_index_0 inside {active_participating_masters};
    }
  }  

  /** Randomize the active_participating_slave_index_0 */
  constraint active_participating_slave_index_0_c {
    if (active_participating_slaves.size())
    {
     active_participating_slave_index_0 inside {active_participating_slaves};
    }
  }

  /** Randomize the participating_slave_index_0 */
  constraint participating_slave_index_0_c {
    if (participating_slaves_arr.size())
    {
     participating_slave_index_0 inside {participating_slaves_arr};
    }
  }
  
`ifdef SVT_UVM_TECHNOLOGY 
  /** pre_body() task which is called before task body() */
  extern virtual task pre_body();

  /** post_body() task which is called after task body() */
  extern virtual task post_body();
`endif

  /** Used to sink the responses collected in response queue */
  extern virtual task sink_responses();

  /** Function returns svt_ahb_system_configuration handle */
  extern virtual function svt_ahb_system_configuration get_sys_cfg();

  /** Setup participating masters and slaves */  
  function void setup_participating_master_slave_arrays();
    bit is_participating_slave_exists = 0;
    `svt_xvm_debug("setup_participating_master_slave_arrays","Entered ...") 
    if(sys_cfg == null) begin
      p_sequencer.get_cfg(base_cfg);
      if (!$cast(sys_cfg, base_cfg)) begin
        `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_ahb_system_configuration class");
      end
    end
    
    if (!is_participating_master_slaves_array_setup) begin
      int index_mstr=0;
      int index_slv =0;
      int index_participate_slv =0;

      if((!master_index_status_0) && (!master_index_status_1)) begin
        foreach(sys_cfg.master_cfg[mstr])  begin
          if((sys_cfg.master_cfg[mstr].is_active == 1) && (sys_cfg.is_participating(mstr) == 1)) begin
            if(sys_cfg.master_cfg[mstr].ahb_interface_type == svt_ahb_configuration::AHB) begin
              if(mstr != sys_cfg.default_master) begin
                active_participating_masters[index_mstr++] = mstr;  
                `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" master id that is active & participating is ='d%0d ",mstr));
              end
            end
            else begin
              active_participating_masters[index_mstr++] = mstr;  
              `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" master id that is active & participating is ='d%0d ",mstr));
            end
          end
        end
      end
      else begin
        if(master_index_status_0) begin
          if((sys_cfg.master_cfg[master_index_0].is_active == 1) && (sys_cfg.is_participating(master_index_0) == 1 ))  begin
            active_participating_masters[index_mstr++] = master_index_0;  
            `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" programmed master id that is active & participating is ='d%0d ",master_index_0));
          end
        end
        if(master_index_status_1) begin
            if((sys_cfg.master_cfg[master_index_1].is_active == 1) && (sys_cfg.is_participating(master_index_1) == 1 ))  begin
              active_participating_masters[index_mstr++] = master_index_1;  
              `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" programmed master id that is active & participating is ='d%0d ",master_index_1));
            end
        end
      end

      foreach(sys_cfg.slave_cfg[slv])  begin
        if(slv != sys_cfg.default_slave) begin
          if(sys_cfg.is_participating_slave(slv) == 1) begin
            is_participating_slave_exists = 1;
          end
        end
      end

      if((slave_index_status_0) || (slave_index_status_1)) begin
        if(slave_index_status_0) begin
          if((sys_cfg.slave_cfg[slave_index_0].is_active == 1) && (sys_cfg.is_participating_slave(slave_index_0) == 1 ))  begin
            active_participating_slaves[index_slv++] = slave_index_0;  
            `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" programmed slave id that is active & participating is ='d%0d ",slave_index_0));
          end
          if(sys_cfg.is_participating_slave(slave_index_0) == 1) begin
            participating_slaves_arr[index_participate_slv++] = slave_index_0;
            `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" programmed slave id that is participating is ='d%0d ",slave_index_0));
          end
        end
        if(slave_index_status_1) begin
            if((sys_cfg.slave_cfg[slave_index_1].is_active == 1) && (sys_cfg.is_participating_slave(slave_index_1) == 1 ))  begin
              active_participating_slaves[index_slv++] = slave_index_1;  
              `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" programmed slave id that is active & participating is ='d%0d ",slave_index_1));
            end
            if(sys_cfg.is_participating_slave(slave_index_1) == 1) begin
              participating_slaves_arr[index_participate_slv++] = slave_index_1;
              `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" programmed slave id that is participating is ='d%0d ",slave_index_1));
            end
        end
      end
      else if (is_participating_slave_exists) begin
        foreach(sys_cfg.slave_cfg[slv])  begin
          if(slv != sys_cfg.default_slave) begin
            if((sys_cfg.slave_cfg[slv].is_active == 1) && (sys_cfg.is_participating_slave(slv) == 1 ))  begin
              active_participating_slaves[index_slv++] = slv;  
              `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" slave id that is active & participating is ='d%0d ",slv));
            end
            if(sys_cfg.is_participating_slave(slv) == 1) begin
              participating_slaves_arr[index_participate_slv++] = slv;
              `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
            end
          end
        end
      end
      else begin
        foreach(sys_cfg.slave_cfg[slv])  begin
          if(slv != sys_cfg.default_slave) begin
            participating_slaves_arr[index_participate_slv++] = slv;
            if((sys_cfg.slave_cfg[slv].is_active == 1))  
              active_participating_slaves[index_slv++] = slv;  
            `svt_xvm_debug("svt_ahb_system_base_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
          end
        end
      end
      is_participating_master_slaves_array_setup=1;
    end // if (!is_participating_master_slaves_array_setup)
    `svt_xvm_debug("setup_participating_master_slave_arrays","Exiting ...") 

  endfunction: setup_participating_master_slave_arrays

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    `svt_xvm_debug("svt_ahb_system_base_sequence::pre_randomize()","Entered ...");      
    super.pre_randomize();
`ifdef SVT_UVM_TECHNOLOGY
    master_index_status_0 = uvm_config_db#(int unsigned)::get(null, get_full_name(), "master_index_0",master_index_0);
    master_index_status_1 = uvm_config_db#(int unsigned)::get(null, get_full_name(), "master_index_1",master_index_1);
    slave_index_status_0  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "slave_index_0", slave_index_0);
    slave_index_status_1  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "slave_index_1", slave_index_1);
`elsif SVT_OVM_TECHNOLOGY
    master_index_status_0 = m_sequencer.get_config_int({get_full_name(), ".master_index_0"}, master_index_0);
    master_index_status_1 = m_sequencer.get_config_int({get_full_name(), ".master_index_1"}, master_index_1);
    slave_index_status_0  = m_sequencer.get_config_int({get_full_name(), ".slave_index_0"}, slave_index_0);
    slave_index_status_1  = m_sequencer.get_config_int({get_full_name(), ".slave_index_1"}, slave_index_1);
`endif
    `svt_xvm_debug("body", $sformatf("programmed master_index_0 is 'd%0d as a result of %0s.",master_index_0, master_index_status_0 ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("programmed master_index_1 is 'd%0d as a result of %0s.",master_index_1, master_index_status_1 ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("programmed slave_index_0 is 'd%0d as a result of %0s.",slave_index_0, slave_index_status_0 ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("programmed slave_index_1 is 'd%0d as a result of %0s.",slave_index_1, slave_index_status_1 ? "config DB" : "default value"));
    setup_participating_master_slave_arrays();
    `svt_xvm_debug("svt_ahb_system_base_sequence::pre_randomize()","Exiting ...");  
  endfunction: pre_randomize

  /** Pre-start method for initializing the master and slave array that are participating */
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    `svt_xvm_debug("svt_ahb_system_base_sequence::pre_start()","Entered ...") 
    super.pre_start();
    setup_participating_master_slave_arrays();
    sequence_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    silent_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "silent", silent);
    temp_lock_status_1  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "temp_lock_1", temp_lock_1);
    temp_lock_status_2  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "temp_lock_2", temp_lock_2);
    `svt_xvm_note("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, sequence_length_status ? "config DB" : "default value"));
    `svt_xvm_note("body", $sformatf("silent is 'd%0d as a result of %0s.", silent, silent_status ? "config DB" : "default value"));
    `svt_xvm_note("body", $sformatf("temp_lock_1 is 'd%0d as a result of %0s.", temp_lock_1, temp_lock_status_1 ? "config DB" : "default value"));
    `svt_xvm_note("body", $sformatf("temp_lock_2 is 'd%0d as a result of %0s.", temp_lock_2, temp_lock_status_2 ? "config DB" : "default value"));

    `svt_xvm_debug("svt_ahb_system_base_sequence::pre_start()","Exiting ...")    

  endtask // pre_start
`endif
 
endclass: svt_ahb_system_base_sequence

// =============================================================================
/**
 * This sequence allows unconstrained random traffic for all ports
 */
class svt_ahb_system_random_sequence extends svt_ahb_system_base_sequence;

  `svt_xvm_object_utils(svt_ahb_system_random_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_system_sequencer)

  function new(string name="svt_ahb_system_random_sequence");
    super.new(name);
  endfunction

  virtual task body();
    // just extended so that UVM doesn't complain about a missing body implementation
  endtask: body
endclass

// =========================================================================================
/** 
 * #- Program a master VIP to drive write or read burst of fixed length on to the bus and <br> 
 *    routed to a slave. <br>
 * #- Check AHB bus should behave correctly for fixed length bursts when master <br> 
 *    de-assert hbusreq once it is granted the bus and burst should complete succesfully. <br> 
 * #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *    Slaves. <br>
 * .
 */ 

class svt_ahb_arb_fixed_length_hbusreq_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_arb_fixed_length_hbusreq_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_arb_fixed_length_hbusreq_virtual_sequence");
    /** Setting manage_objection to 'b1 causes the parent sequence to manage objections. */
    super.new(name);
    manage_objection = 1'b1;
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 0
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------

`ifdef SVT_UVM_TECHNOLOGY
 virtual task pre_start();
    bit status;
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq;
    
    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[int];
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Collection of slaves that are supporting in the system */
    if(active_participating_slaves.size()) begin
      foreach(active_participating_slaves[i]) begin
        supporting_slaves_arr[i] = active_participating_slaves[i];
        `svt_xvm_note("body",$sformatf("active_participating_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,active_participating_slaves[i],i,supporting_slaves_arr[i])); 
      end
    end
    else begin
      foreach(participating_slaves_arr[i]) begin
        supporting_slaves_arr[i] = participating_slaves_arr[i];
        `svt_xvm_note("body",$sformatf("participating_slaves_arr['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,participating_slaves_arr[i],i,supporting_slaves_arr[i])); 
      end
    end
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[master]) begin
        automatic int mstr = active_participating_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );

        /** Execute the transactions in each supporting Slave from selected Master. */
        foreach(supporting_slaves_arr[slave])  begin
          automatic int slv = supporting_slaves_arr[slave];
          
          `svt_xvm_do_on_with(master_seq, p_sequencer.master_sequencer[mstr], {
            sequence_length       == 1;
            seq_xact_type         inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            !(seq_burst_type      inside {svt_ahb_transaction::INCR});
            slv_num               == slv;
            seq_lock              == 0;
            seq_num_busy_cycles   == 0;
            seq_wait_for_xact_ended == 1;
          })
        end//foreach of slave
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus should behave correctly for fixed length bursts.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_arb_fixed_length_hbusreq_virtual_sequence


// =========================================================================================
/** 
 * #- Program the two master VIP to drive write or read burst with one always <br>
 *    driving locked transfers the other driving either locked or unlocked transfers <br>
 *    routed to same slave.<br>
 * #- Check AHB bus should behave correctly for mixtures of locked and normal bursts <br>
 *    when transfer driven by two masters to the slave.<br> 
 * .
 */ 
class svt_ahb_locked_diff_master_same_slave_rd_wr_virtual_sequence extends svt_ahb_system_base_sequence;

  //-----------------------------------------------------------------------------  
  // Member attributes
  //-----------------------------------------------------------------------------  
  /** Represents the Second Active Participating Master from which the sequence will be initiated. */ 
  rand int unsigned initiating_master_index_1;

  //-----------------------------------------------------------------------------  
  // Constraints
  //-----------------------------------------------------------------------------  
  /** Randomize the initiating_master_index_1 */
  constraint initiating_master_index_1_c {
    if(active_participating_masters.size() >= 2) {
      initiating_master_index_1 inside {active_participating_masters};
      initiating_master_index_1 != initiating_master_index_0;
    }
  }

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_locked_diff_master_same_slave_rd_wr_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_locked_diff_master_same_slave_rd_wr_virtual_sequence");
    /** Setting manage_objection to 'b1 causes the parent sequence to manage objections. */
    super.new(name);
    manage_objection = 1'b1;
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 0
   */
  //----------------------------------------------------------------------------- 
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;

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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    bit status;
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
    
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq1,master_seq2;
    
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    `svt_xvm_debug("body",$sformatf("Randomly selected two masters are 'd%0d 'd%0d",initiating_master_index_0,initiating_master_index_1)); 
    `svt_xvm_debug("body",$sformatf("Selected slave is 'd%0d",participating_slave_index_0)); 
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      fork
        begin:initiating_master_0_thread
          `svt_xvm_note("body",$sformatf("Start of seq from Master No.'d%0d",initiating_master_index_0));
          `svt_xvm_do_on_with(master_seq1, p_sequencer.master_sequencer[initiating_master_index_0], {
            sequence_length         == 3;
            seq_xact_type           inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            seq_num_busy_cycles     == 0;
            seq_lock                inside {0,1};
            slv_num                 == participating_slave_index_0;
            seq_wait_for_xact_ended == 1;
          })
        end
        begin:initiating_master_1_thread
          `svt_xvm_note("body",$sformatf("Start of seq from Master No.'d%0d",initiating_master_index_1));
          `svt_xvm_do_on_with(master_seq2, p_sequencer.master_sequencer[initiating_master_index_1], {
            sequence_length         == 3;
            seq_xact_type           inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            seq_num_busy_cycles     == 0;
            seq_lock                == 1;
            slv_num                 == participating_slave_index_0;
            seq_wait_for_xact_ended == 1;
          })
        end
      join
    end//forloop of sequence_length
    
    /** 
     * To check whether AHB bus arbiter grants access to a master based <br> 
     * on hlock request recieved as locked request has highest priority.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- arbiter_lock_last_grant<br>
     *  #- data_integrity_check<br>
     *  .  
     */
    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_locked_diff_master_same_slave_rd_wr_virtual_sequence

// =========================================================================================
/** 
 * #- Program the master VIP to drive write or read locked transaction of fixed length <br>
 *    routed to the slave.<br>
 * #- Check AHB bus should behave correctly for locked. <br>
 * #- Initiate the above stimulus from all Master VIPs sequentially towards all the <br>
 *    Slaves. <br>
 * .
 */

class svt_ahb_lock_fixed_length_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_lock_fixed_length_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_lock_fixed_length_virtual_sequence");
    /** Setting manage_objection to 'b1 causes the parent sequence to manage objections. */
    super.new(name);
    manage_objection = 1'b1;
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
   */
  //----------------------------------------------------------------------------- 
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
    num_supporting_slaves  = active_participating_slaves.size();
    /** Check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves )  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    bit status;
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq;
    
    `svt_xvm_debug("body", "Entering ...");
    
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
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[master]) begin
        automatic int mstr = active_participating_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );

        /** Execute the transactions in each supporting Slave from selected Master. */
        foreach(active_participating_slaves[slave])  begin
          automatic int slv = active_participating_slaves[slave];
          
          `svt_xvm_do_on_with(master_seq, p_sequencer.master_sequencer[mstr], {
            sequence_length       == 1;
            seq_xact_type         inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            !(seq_burst_type      inside {svt_ahb_transaction::INCR});
            slv_num               == slv;
            seq_lock              == 1;
            seq_num_busy_cycles   == 0;
            seq_wait_for_xact_ended == 0;
          })
        end//foreach of slave
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus behaves correctly when ERROR response is received by master<br> 
     * for a locked transfer and abort the remaining transfers in the locked<br> 
     * sequence.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- arbiter_lock_last_grant<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_lock_fixed_length_virtual_sequence

// =========================================================================================
/** 
 * #- Program the master VIP to drive write or read burst of undefined length on to the bus <br> 
 *     and routed to the slave.<br>
 * #- Check AHB bus should behave correctly for undefined length bursts, the master <br> 
 *    should continue to assert the request until it has started the last transfer.<br> 
 * #- Initiate the above stimulus from all Master VIPs sequentially towards all the <br>
 *    Slaves. <br>
 * .
 */ 

class svt_ahb_arb_undefined_length_hbusreq_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_arb_undefined_length_hbusreq_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_arb_undefined_length_hbusreq_virtual_sequence");
    /** Setting manage_objection to 'b1 causes the parent sequence to manage objections. */
    super.new(name);
    manage_objection = 1'b1;
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 0
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    bit status;
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq;
    
    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[int];
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Collection of slaves that are supporting in the system */
    if(active_participating_slaves.size()) begin
      foreach(active_participating_slaves[i]) begin
        supporting_slaves_arr[i] = active_participating_slaves[i];
        `svt_xvm_note("body",$sformatf("active_participating_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,active_participating_slaves[i],i,supporting_slaves_arr[i])); 
      end
    end
    else begin
      foreach(participating_slaves_arr[i]) begin
        supporting_slaves_arr[i] = participating_slaves_arr[i];
        `svt_xvm_note("body",$sformatf("participating_slaves_arr['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,participating_slaves_arr[i],i,supporting_slaves_arr[i])); 
      end
    end
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[master]) begin
        automatic int mstr = active_participating_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );

        /** Execute the transactions in each supporting Slave from selected Master. */
        foreach(supporting_slaves_arr[slave])  begin
          automatic int slv = supporting_slaves_arr[slave];
          
          `svt_xvm_do_on_with(master_seq, p_sequencer.master_sequencer[mstr], {
            sequence_length     == 1;
            seq_xact_type       inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            seq_burst_type      inside {svt_ahb_transaction::INCR};
            slv_num             == slv;
            seq_lock            == 0;
            seq_num_busy_cycles == 0;
            seq_wait_for_xact_ended == 1;
          })
        end//foreach of slave
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus should behave correctly for undefined length bursts.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif
endclass: svt_ahb_arb_undefined_length_hbusreq_virtual_sequence

// =========================================================================================
/** 
 * #- Program a master VIP to drive write or read burst with transfer type of BUSY to be <br>
 *    inserted in between the transfers. <br> 
 * #- Check AHB bus forwards OKAY response to BUSY transfers, when a master sends write <br>
 *    or read burst with BUSY transfer type. <br> 
 * #- Initiate the above stimulus from all Master VIPs sequentially towards all the <br>
 *    Slaves. <br>
 * .
 */ 

class svt_ahb_busy_transfer_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_busy_transfer_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_busy_transfer_virtual_sequence");
    /** Setting manage_objection to 'b1 causes the parent sequence to manage objections. */
    super.new(name);
    manage_objection = 1'b1;
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 0
   */
  //----------------------------------------------------------------------------- 
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
    if(num_supporting_masters >= required_num_supporting_masters) begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    bit status;
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq;
    
    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[int];
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Collection of slaves that are supporting in the system */
    if(active_participating_slaves.size()) begin
      foreach(active_participating_slaves[i]) begin
        supporting_slaves_arr[i] = active_participating_slaves[i];
        `svt_xvm_note("body",$sformatf("active_participating_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,active_participating_slaves[i],i,supporting_slaves_arr[i])); 
      end
    end
    else begin
      foreach(participating_slaves_arr[i]) begin
        supporting_slaves_arr[i] = participating_slaves_arr[i];
        `svt_xvm_note("body",$sformatf("participating_slaves_arr['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,participating_slaves_arr[i],i,supporting_slaves_arr[i])); 
      end
    end
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[master]) begin
        automatic int mstr = active_participating_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );

        /** Execute the transactions in each supporting Slave from selected Master. */
        foreach(supporting_slaves_arr[slave])  begin
          automatic int slv = supporting_slaves_arr[slave];
          
          `svt_xvm_do_on_with(master_seq, p_sequencer.master_sequencer[mstr], {
            sequence_length     == 1;
            seq_xact_type       inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            slv_num             == slv;
            seq_lock            == 0;
            seq_num_busy_cycles == 3;
            seq_wait_for_xact_ended == 1;
          })
        end//foreach of slave
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus forwards OKAY response to BUSY transfers, when a master sends <br>
     * write or read burst with BUSY transfer type. <br> 
     * Check done by System monitor(List of checkers)<br>
     *  #- zero_wait_cycle_okay<br> 
     *  #- seq_or_busy_before_nseq_during_xfer<br> 
     *  #- ctrl_or_addr_changed_during_busy<br> 
     *  #- data_integrity_check <br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_busy_transfer_virtual_sequence

// =======================================================================
/**
 *    #- Program a master VIP to drive write or read burst with 'n' number of transfers on to the bus. <br>
 *    #- Program a slave VIP to respond with ERROR response during any transfer. <br>
 *    #- Program the master VIP to abort remaining transfers when ERROR response is received <br>
 *       and shouldn't rebuild the transcation. <br>
 *    #- Check that AHB bus doesn't continues the remaining transfers in the burst. <br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *       Slaves connected to the BUS. <br>
 *    .
 */

class svt_ahb_arb_abort_on_error_resp_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_arb_abort_on_error_resp_virtual_sequence)
  
  bit seq_wait_for_xact_ended;
  
  /** Write or Read transaction request handles. */
  svt_ahb_master_transaction wr_rd_xact;
  
  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_arb_abort_on_error_resp_virtual_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
   */
  //----------------------------------------------------------------------------- 
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 1;
    int required_num_supporting_slaves  = 1;

    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    /** By default is_supported is 0 */
    is_supported = 0;

    num_supporting_masters = active_participating_masters.size();
    num_supporting_slaves  = active_participating_slaves.size();
    
    /** Check the required supporting Masters */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves )  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::active_participating_masters, \n\
                                                Number of Supporting Slave(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::active_participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::active_participating_masters, \n\
                                                Number of Supporting Slave(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::active_participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    bit status;
    bit seq_wait_for_xact_ended_status;
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    seq_wait_for_xact_ended_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "seq_wait_for_xact_ended", seq_wait_for_xact_ended);
    `svt_xvm_note("pre_start", $sformatf("seq_wait_for_xact_ended is 'd%0d as a result of %0s.", seq_wait_for_xact_ended, seq_wait_for_xact_ended_status ? "the config DB" : "Default Value"));
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
    
    `svt_xvm_note("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[initiating_master_index]) begin
        int mstr = active_participating_masters[initiating_master_index];
        `svt_xvm_note("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,initiating_master_index) );

        /** Execute the transactions in each participating Slave from selected Master. */
        foreach(active_participating_slaves[slave])  begin
          int slv = active_participating_slaves[slave];
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;
          `svt_xvm_note("body", $sformatf("Selected Slave is 'd%0d ",slv));

          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

          
          `svt_xvm_do_on_with(wr_rd_xact,p_sequencer.master_sequencer[mstr], {
           xact_type           inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
           lock                == 0;
           foreach(num_busy_cycles[i]) {
             num_busy_cycles[i] == 0;
           }
           if(i <= 4) {
             addr >= lo_addr;
             addr <= hi_addr;
             addr[9:0] dist{ [10'h3FC:10'h3FF]:= 50, [10'h000:10'h003]:=50};
           }
           else {      
             addr >= lo_addr;
             addr <= hi_addr;
           }
          })
          
          `svt_xvm_note("body", $sformatf("%0s Transaction sent is %0s...",wr_rd_xact.xact_type.name(),wr_rd_xact.sprint()));
          if (seq_wait_for_xact_ended) begin
            `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact), "Waiting for Transaction to end"} );
            /** Waiting for transaction to complete */
            `SVT_AHB_WAIT_FOR_XACT_ENDED(wr_rd_xact); 
            `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact), "Transaction is now ended"});
          end
        end//foreach of active_participating_slaves 
      end//foreach of active_participating_masters 
    end//forloop of sequence_length
    
    /** 
     * To check whether the AHB bus behaves correctly when ERROR response is<br> 
     * received by master for a write or read transfer.<br>
     * Check done by System monitor(List of checkers)<br>     
     *  #- htrans_not_changed_to_idle_during_error<br> 
     *  #- two_cycle_error_resp<br> 
     *  #- data_integrity_check<br> 
     *  .
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_arb_abort_on_error_resp_virtual_sequence


// =======================================================================
/**
 *    #- Program the Master VIP to drive write or read transaction.<br>
 *    #- Program the Slave VIP to assert HREADY signal low for few cycles<br>
 *       during transfers and then accordingly assert HREADY to 1.<br>
 *    #- Check the bus Master holds the data stable throughout the extended<br>
 *       cycles of transfer for which HREADY was de-asserted.<br>
 *    #- Check the bus forwards the appropriate OKAY response with wait state to the master.<br>
 *    .
 */

class svt_ahb_system_burst_transfer_virtual_sequence extends svt_ahb_system_base_sequence;

  
  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_system_burst_transfer_virtual_sequence)

  
  /** Write and Read transaction request handles. */
  svt_ahb_master_transaction wr_xact, rd_xact;
  
  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_system_burst_transfer_virtual_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
   */
  //----------------------------------------------------------------------------- 
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
    num_supporting_slaves  = participating_slaves_arr.size();
    
    /** Check the required supporting Masters and Slaves*/
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves )  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
    
    `svt_xvm_note("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[initiating_master_index]) begin
        int mstr = active_participating_masters[initiating_master_index];
        `svt_xvm_note("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,initiating_master_index) );

        /** Execute the transactions in each participating Slave from selected Master. */
        foreach(participating_slaves_arr[slave])  begin
          int slv = participating_slaves_arr[slave];
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;
          `svt_xvm_note("body", $sformatf("Selected Slave is 'd%0d ",slv));

          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
          
          `svt_xvm_do_on_with(wr_xact,p_sequencer.master_sequencer[mstr], {
           xact_type inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
           lock == 0;
           addr >= lo_addr;
           addr <= hi_addr;
          
           /** This is done to bypass data_integrity_check for READ */
           if(xact_type == svt_ahb_transaction::READ) {
             foreach(data[i])
               data[i] == 0;
           }
          
          })
          
          `svt_xvm_note("body", $sformatf("Write Transaction to be sent is %0s...",wr_xact.sprint()));
         
          `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_xact), "Waiting for Write transaction to end"} );
          /** Waiting for Write transaction to complete */
          `SVT_AHB_WAIT_FOR_XACT_ENDED(wr_xact); 
          `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_xact), "Write Transaction is now ended"});

        end//foreach of slave 
      end//foreach of active_participating_master 
    end//forloop of sequence_length
    
    /** 
     * To check whether AHB bus behaves correctly when master send write or read<br> 
     * burst with or without wait states are inserted by slave during transfers.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br> 
     *  #- hwdata_changed_during_wait_state<br> 
     *  #- non_okay_response_in_wait_state<br> 
     *  #- ctrl_or_addr_changed_during_wait_state<br> 
     *  #- htrans_changed_during_wait_state<br>
     *  .  
     */
    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_system_burst_transfer_virtual_sequence

// =======================================================================
/**
 *    #- Program the Master VIP to drive write or read transaction.<br>
 *    #- Program the bus for EBT during any transfer of the transaction.<br>
 *    #- Program the Master VIP to regains the access of bus.<br>
 *    #- Once it gains the bus, Program the Master to rebuild the transcation<br>
 *    #- with burst type as INCR or SINGLE.<br>
 *    #- Initiate the above stimulus from all Master VIPs sequentially towards all<br> 
 *       the Slaves connected to the Bus.<br>
 *    .
 */

class svt_ahb_system_ebt_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_system_ebt_virtual_sequence)
  
  /** Write or Read transaction request handles. */
  svt_ahb_master_transaction wr_rd_xact;
  
  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_system_ebt_virtual_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 0
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::active_participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::active_participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
    
    `svt_xvm_note("body", "Entering ...");
    
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
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[initiating_master_index]) begin
        int mstr = active_participating_masters[initiating_master_index];
        `svt_xvm_note("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,initiating_master_index) );

        /** Execute the transactions in each participating Slave from selected Master. */
        foreach(participating_slaves_arr[slave])  begin
          int slv = participating_slaves_arr[slave];
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;
          `svt_xvm_note("body", $sformatf("Selected Slave is 'd%0d ",slv));

          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
          
          `svt_xvm_do_on_with(wr_rd_xact,p_sequencer.master_sequencer[mstr], {
           xact_type inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
           lock == 0;
           addr >= lo_addr;
           addr <= hi_addr;
          
           /** This is done to bypass data_integrity_check for READ */
           if(xact_type == svt_ahb_transaction::READ) {
             foreach(data[i])
               data[i] == 0;
           }
          })
          
          `svt_xvm_note("body", $sformatf("%0s Transaction sent is %0s...",wr_rd_xact.xact_type.name(),wr_rd_xact.sprint()));
          `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact), "Waiting for Transaction to end"} );
          /** Waiting for transaction to complete */
          `SVT_AHB_WAIT_FOR_XACT_ENDED(wr_rd_xact); 
          `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact), "Transaction is now ended"});

        end//foreach of slave 
      end//foreach of active_participating_master 
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus behaves correctly when early burst termination occurred for<br> 
     * write or read burst and is rebuild with burst type as INCR or SINGLE.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_system_ebt_virtual_sequence

// =========================================================================================
/** 
 * #- Program the Master VIP to drive write or read burst with narrow transfers on the <br>
 *    bus. <br>
 * #- Check AHB bus arbiter forwards narrow transfers with appropriate byte lanes. <br> 
 * #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *    Slaves. <br>
 * .
 */ 

class svt_ahb_arb_narrow_transfer_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_arb_narrow_transfer_virtual_sequence)

  /** Write or Read transaction request handles. */
  svt_ahb_master_transaction wr_rd_xact;

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_arb_narrow_transfer_virtual_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
   */
  //----------------------------------------------------------------------------- 
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
    num_supporting_slaves  = participating_slaves_arr.size();

    /** check the required supporting Masters and Slaves  */
    if(num_supporting_masters >= required_num_supporting_masters && num_supporting_slaves >= required_num_supporting_slaves )  begin
      is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end    
  endfunction : is_supported 
  //-----------------------------------------------------------------------------

`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
    /** Local variable. */
    int log_base_2_data_width; 

    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[int];
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Collection of slaves that are supporting in the system */
    if(active_participating_slaves.size()) begin
      foreach(active_participating_slaves[i]) begin
        supporting_slaves_arr[i] = active_participating_slaves[i];
        `svt_xvm_note("body",$sformatf("active_participating_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,active_participating_slaves[i],i,supporting_slaves_arr[i])); 
      end
    end
    else begin
      foreach(participating_slaves_arr[i]) begin
        supporting_slaves_arr[i] = participating_slaves_arr[i];
        `svt_xvm_note("body",$sformatf("participating_slaves_arr['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,participating_slaves_arr[i],i,supporting_slaves_arr[i])); 
      end
    end
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[master]) begin
        automatic int mstr = active_participating_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );

        /** Execute the transactions in each supporting Slave from selected Master. */
        foreach(supporting_slaves_arr[slave])  begin
          automatic int slv = supporting_slaves_arr[slave];
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;
          `svt_xvm_note("body", $sformatf("Selected Slave is 'd%0d ",slv));

          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

          /** Calculate the log base of the data width of the bus of selected Master*/
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fnUQqYhfEnQ47mQ1N320pQee4tgiSXRzlf7IUyN6YS3sWsCfXQm1VbRY8OIZ88ud
/FCGGuElfm5Otgl68aLEbopUoiWcJT8eYinplB5B8prDKqwBEQgTC/2sx4YJgQqc
NNxx6lTsME552dCCrA3GdD6QR+LT75msIchjnNUwIRI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 192       )
crtuwwkOEbMqYgjFToaPP6pgW7GkxTV2iqGs0RZAlPR3Ya3+9u2WiuHCis1RW4iX
HzaDdSx3AzPWzGMQ/D5b2CrxdnWwomYnE1hosx7ryU/XmlEawdWqvIDhjJynR/DZ
lf2kp3iVISeVN+UdiguGqe4ek9VFnC+MDrhgwD83KoZ2i79YtkxHjVBbx/E51nyk
edpHXe1uIkg8KO3hRkVyf4B5egxBa5Z673nRVHPzEw/UVU+SvdhIug7lsh9Q66z/
dbOUBkWsNcLe5bCxTW7/cg==
`pragma protect end_protected
          
          `svt_xvm_debug("body", $sformatf("data_width is 'd%0d and log_base_2_data_width is 'd%0d",sys_cfg.master_cfg[mstr].data_width,log_base_2_data_width));
          
          `svt_xvm_do_on_with(wr_rd_xact, p_sequencer.master_sequencer[mstr], {
            xact_type     inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            lock          == 0;
            addr          >= lo_addr;
            addr          <= hi_addr;
            burst_size    == log_base_2_data_width - 4;
          })
          `svt_xvm_note("body", $sformatf("Write or Read Transaction to be sent is %0s...",wr_rd_xact.sprint()));
          `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact), "Waiting for Write or Read transaction to end"} );
          /** Waiting for Write or Read transaction to complete */
          `SVT_AHB_WAIT_FOR_XACT_ENDED(wr_rd_xact); 
          `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact), "Write or Read Transaction is now ended"});
        end//foreach of slave
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus forwards transactions having narrow transfer appropriately <br>
     * when a master sends write or read narrow transfers.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  #- hwdata_changed_during_wait_state<br>
     *  #- hsize_too_big_for_data_width<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_arb_narrow_transfer_virtual_sequence

// =========================================================================================
/** 
 * #- Program the Master VIP to drive write or read burst on the bus. <br>
 * #- AHB bus forwards this burst to a slave. <br> 
 * #- Check AHB bus should response properly when reset was inserted in the original <br>
 *    transaction in progress. <br> 
 * #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *    Slaves. <br>
 * .
 */ 

class svt_ahb_arb_reset_original_xact_in_progress_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_arb_reset_original_xact_in_progress_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_arb_reset_original_xact_in_progress_virtual_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 0
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------

`ifdef SVT_UVM_TECHNOLOGY
 virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq;
    
    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[int];
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Collection of slaves that are supporting in the system */
    if(active_participating_slaves.size()) begin
      foreach(active_participating_slaves[i]) begin
        supporting_slaves_arr[i] = active_participating_slaves[i];
        `svt_xvm_note("body",$sformatf("active_participating_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,active_participating_slaves[i],i,supporting_slaves_arr[i])); 
      end
    end
    else begin
      foreach(participating_slaves_arr[i]) begin
        supporting_slaves_arr[i] = participating_slaves_arr[i];
        `svt_xvm_note("body",$sformatf("participating_slaves_arr['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,participating_slaves_arr[i],i,supporting_slaves_arr[i])); 
      end
    end
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[master]) begin
        automatic int mstr = active_participating_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );

        /** Execute the transactions in each supporting Slave from selected Master. */
        foreach(supporting_slaves_arr[slave]) begin
          automatic int slv = supporting_slaves_arr[slave];
          fork
            begin
              `svt_xvm_do_on_with(master_seq, p_sequencer.master_sequencer[mstr], {
                sequence_length       == 1;
                seq_xact_type         inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
                slv_num               == slv;
                seq_lock              == 0;
                seq_wait_for_xact_ended == 1;
              })
            end
            begin
              repeat (2) begin 
                wait (sys_cfg.master_cfg[mstr].master_if.htrans == 3);
                @(posedge sys_cfg.ahb_if.hclk);
              end
              /** Assert reset */
              `svt_xvm_note("body", "asserting reset");
              sys_cfg.ahb_if.hresetn <= 1'b0;
              /** After few clocks, release reset */
              repeat (5) @(posedge sys_cfg.ahb_if.hclk);
              `svt_xvm_note("body", "deasserting reset");
              sys_cfg.ahb_if.hresetn <= 1'b1;
            end
          join_any
        end//foreach of slave
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus should response properly when reset was inserted in the original <br>
     * transaction in progress. <br>
     * Check done by System monitor(List of checkers)<br>
     *  #- data_integrity_check<br>
     *  #- htrans_idle_during_reset<br> 
     *  #- hready_out_from_slave_high_during_reset <br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_arb_reset_original_xact_in_progress_virtual_sequence

// =========================================================================================
/** 
 * #- Program the Master VIP to drive idle burst on the bus. <br>
 * #- AHB bus forwards this transfer to a slave. <br> 
 * #- Initiate the above stimulus from all Master VIPs sequentially towards all the<br>
 *    Slaves. <br>
 * .
 */ 

class svt_ahb_idle_transfer_virtual_sequence extends svt_ahb_system_base_sequence;

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_idle_transfer_virtual_sequence)

  /** IDLE transaction request handles. */
  svt_ahb_master_transaction idle_xact;

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_idle_transfer_virtual_sequence");
    super.new(name);
  endfunction : new

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 0
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                ", required_num_supporting_masters, num_supporting_masters))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------

`ifdef SVT_UVM_TECHNOLOGY
 virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[int];
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();

    /** Collection of slaves that are supporting in the system */
    if(active_participating_slaves.size()) begin
      foreach(active_participating_slaves[i]) begin
        supporting_slaves_arr[i] = active_participating_slaves[i];
        `svt_xvm_note("body",$sformatf("active_participating_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,active_participating_slaves[i],i,supporting_slaves_arr[i])); 
      end
    end
    else begin
      foreach(participating_slaves_arr[i]) begin
        supporting_slaves_arr[i] = participating_slaves_arr[i];
        `svt_xvm_note("body",$sformatf("participating_slaves_arr['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", i,participating_slaves_arr[i],i,supporting_slaves_arr[i])); 
      end
    end
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Execute the transactions from each selected active participating master */
      foreach(active_participating_masters[master]) begin
        automatic int mstr = active_participating_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );

        /** Execute the transactions in each supporting Slave from selected Master. */
        foreach(supporting_slaves_arr[slave])  begin
          automatic int slv = supporting_slaves_arr[slave];
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;
          `svt_xvm_note("body", $sformatf("Selected Slave is 'd%0d ",slv));

          /** Randomly select an Address range for selected slave */
          if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr))
            `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));
          
          `svt_xvm_do_on_with(idle_xact, p_sequencer.master_sequencer[mstr], {
             xact_type           inside {svt_ahb_transaction::IDLE_XACT};
             lock                == 0;
             addr >= lo_addr;
             addr <= hi_addr;
          })
        end//foreach of slave
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus forwards OKAY response from slave to master for IDLE transfer type.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- zero_wait_cycle_okay<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_idle_transfer_virtual_sequence

// =========================================================================================
/** 
 * #- Program a master VIP to drive write or read burst on the bus. <br>
 * #- AHB bus forwards this burst to a slave. <br> 
 * #- Check AHB bus should behave correctly when maximum number of rebuild attempts <br>
 *    on RETRY response was reached for a given transaction and master aborts the <br>
 *    transaction under such condition.<br>
 * .
 */ 

class svt_ahb_retry_resp_reached_max_virtual_sequence extends svt_ahb_system_base_sequence;
  //-----------------------------------------------------------------------------  
  // Member attributes
  //-----------------------------------------------------------------------------  
  int supporting_masters[int];
  int supporting_slaves[int];

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_retry_resp_reached_max_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_retry_resp_reached_max_virtual_sequence");
    super.new(name);
  endfunction : new
  
  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AHB */
      if (sys_cfg.master_cfg[active_participating_masters[mstr]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_ahb_retry_resp_reached_max_virtual_sequence",$sformatf(" master id that is participating is ='d%0d ",mstr));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if (sys_cfg.slave_cfg[active_participating_slaves[slv]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_ahb_retry_resp_reached_max_virtual_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
      end
    end
  endfunction

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters\n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end      
  endfunction : is_supported
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();

    /** Represents the Randomly selected Slave. */ 
    int unsigned selected_slv;

    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq;
    
    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[];
    
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    
    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);
    
    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses(); 

    /** Collection of slaves that are supporting in the system */
    if(supporting_slaves.size()) begin
      supporting_slaves_arr = new[supporting_slaves.size];
      foreach(supporting_slaves[j]) begin
        supporting_slaves_arr[j] = supporting_slaves[j];
        `svt_xvm_note("body",$sformatf("supporting_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", j,supporting_slaves[j],j,supporting_slaves_arr[j])); 
      end
    end

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin

      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[master]) begin
        automatic int mstr = supporting_masters[master];
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master) );
 
        /** Randomly selected slave */ 
        supporting_slaves_arr.shuffle;
        selected_slv = supporting_slaves_arr[0];
               
        `svt_xvm_note("body", $sformatf("Selected Slave is 'd%0d ",selected_slv));
        `svt_xvm_do_on_with(master_seq, p_sequencer.master_sequencer[mstr], {
          sequence_length     == 1;
          seq_xact_type       inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
          !(seq_burst_type    inside {svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16});
          slv_num             == selected_slv;
          seq_lock            == 0;
          seq_wait_for_xact_ended == 0;
        })
      end//foreach of active_participating_master
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus should behave correctly when maximum number of rebuild attempts <br>
     * on RETRY response was reached for a given transaction and master aborts the <br>
     * transaction under such condition.<br>
     * Check done by System monitor(List of checkers)<br>
     *  #- two_cycle_retry_resp<br>
     *  #- htrans_not_changed_to_idle_during_retry<br>
     *  #- data_integrity_check<br>
     *  .  
     */

    `svt_xvm_debug("body", "Exiting...");

  endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_retry_resp_reached_max_virtual_sequence

// =======================================================================================
/**
 * #- Program a master VIP to drive write or read burst on the bus. <br> 
 * #- AHB bus forwards this burst to a slave. <br> 
 * #- Simultaneously Program all other masters VIP to drive write or read burst on the<br>
 *    bus and forwards the burst to different slaves. <br> 
 * #- Program above selected slaves VIP such that it should response with SPLIT for any <br>
 *    transfer of the burst and assert HSPILT signal after certain clock cycles. <br>
 * #- Check the above masters are not continuing the transfers after receving SPLIT <br>
 *    response.<br>
 * #- Make sure all masters have received SPLIT transfer response.<br>
 * #- Check AHB bus arbiter will grant to the default master.<br>
 * #- After certain clock cycles, Check AHB bus arbiter will grant the particular master<br>
 *    based on HSPLITx signals,so it can re-attempt the transfer and finishes with OKAY <br>
 *    transfer response.<br>
 * .
 */

class svt_ahb_split_resp_all_master_diff_slave_virtual_sequence extends svt_ahb_system_base_sequence;
  //-----------------------------------------------------------------------------  
  // Member attributes
  //-----------------------------------------------------------------------------  
  //-----------------------------------------------------------------------------     
  int supporting_masters[int];
  int supporting_slaves[int];


  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_split_resp_all_master_diff_slave_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_split_resp_all_master_diff_slave_virtual_sequence");
    super.new(name);
  endfunction : new
  
  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AHB */
      if (sys_cfg.master_cfg[active_participating_masters[mstr]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_ahb_split_resp_all_master_diff_slave_virtual_sequence",$sformatf(" master id that is participating is ='d%0d ",mstr));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if (sys_cfg.slave_cfg[active_participating_slaves[slv]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_ahb_split_resp_all_master_diff_slave_virtual_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
      end
    end
  endfunction

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 2
   */
  //----------------------------------------------------------------------------- 
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;
    
    /** Supporting slaves required */
    int required_num_supporting_slaves  = 2;
    
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end    
  endfunction : is_supported 
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
    /** Write or Read transaction request handles. */
    svt_ahb_master_transaction wr_rd_xact[int];

    `svt_xvm_debug("body", "Entering ...");
    
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
    for(int i = 0; i < sequence_length; i++) begin

      /** Variable to the Queue */ 
      int supporting_slaves_queue[$];

      /** Local Variable */ 
      int num_xacts_ended_count = 0;

      /** Collection of slaves that are supporting in the system */
      if(supporting_slaves.size()) begin
        foreach(supporting_slaves[i]) begin
          supporting_slaves_queue.push_back(supporting_slaves[i]);
          `svt_xvm_note("body",$sformatf("supporting_slaves['d%0d] is 'd%0d and supporting_slaves_queue size is 'd%0d", i,supporting_slaves[i],supporting_slaves_queue.size())); 
        end
      end
      
      /** Check number of masters and slaves in environment*/
      if(supporting_masters.size() != supporting_slaves_queue.size())
        `svt_xvm_warning("body", $sformatf("Unable to drive transactions as number of masters = 'd%0d and number of slaves = 'd%0d are not equal", supporting_masters.size(),supporting_slaves_queue.size()));

      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[master]) begin
        automatic int mstr = supporting_masters[master];
        automatic int slv;
        bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;
        bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master));

        supporting_slaves_queue.shuffle;
        slv = supporting_slaves_queue.pop_front();
        `svt_xvm_note("body", $sformatf("Selected Slave is 'd%0d ",slv));
        
        /** Randomly select an Address range for selected slave */
        if (!sys_cfg.get_slave_addr_range(mstr,slv, lo_addr, hi_addr))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

        `svt_xvm_do_on_with(wr_rd_xact[mstr], p_sequencer.master_sequencer[mstr], {
          xact_type           inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
          lock                == 0;
          !(burst_type    inside {svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16});
          if(burst_type == svt_ahb_transaction::INCR) {
            num_incr_beats == 5;
          }
          foreach(num_busy_cycles[i]) {
            num_busy_cycles[i] == 0;
          }
          addr >= lo_addr;
          addr <= hi_addr;
        })
      end//foreach of active_participating_masters
      foreach(wr_rd_xact[i]) begin
        fork  
          automatic int master = i;
          begin 
            `svt_xvm_note("body", $sformatf("wr_rd_xact['d%0d] is %0s...",master,wr_rd_xact[master].sprint()));
            `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact[master]), "Waiting for Transaction to end"} );
            /** Waiting for transaction to complete */
            `SVT_AHB_WAIT_FOR_XACT_ENDED(wr_rd_xact[master]);
            num_xacts_ended_count++;
            `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact[master]), "Transaction is now ended"});
          end
        join_none
      end
      `svt_xvm_note("body", $sformatf("num_xacts_ended_count is 'd%0d and size of supporting_masters is 'd%0d",num_xacts_ended_count,supporting_masters.size()));
      /** Wait until all masters transaction to complete */
      wait(num_xacts_ended_count == supporting_masters.size());
    end//forloop of sequence_length
    
    /**
     * To check AHB bus arbiter should grant access to default master, when each master of 
     * write or read burst transfer has already received a SPLIT response from different
     * slaves.
     * Check done by System monitor(List of checkers) <br>
     *  #- mask_hgrant_until_hsplit_assert <br>
     *  #- two_cycle_split_resp <br>
     *  #- htrans_not_changed_to_idle_during_split <br>
     *  #- illegal_hgrant_on_split_resp <br>
     *  #- grant_to_default_master_during_allmaster_split <br>
     *  #- data_integrity_check <br> 
     *  .  
     */
     
    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_split_resp_all_master_diff_slave_virtual_sequence

// =======================================================================================
/**
 * #- Program a master VIP to drive write or read burst on the bus. <br>
 * #- AHB bus forwards this burst to a slave. <br> 
 * #- Simultaneously Program all other masters VIP to drive write or read burst on the<br>
 *    bus and forwards the burst to above selected slave. <br> 
 * #- Program above selected slave VIP such that it should response with SPLIT for any <br>
 *    transfer of each master burst and assert HSPILT signal after certain clock cycles.<br>
 * #- Check the above masters are not continuing the transfers after receving SPLIT <br>
 *    response.<br>
 * #- Make sure all masters have received SPLIT transfer response.<br>
 * #- Check AHB bus arbiter will grant to the default master.<br>
 * #- After certain clock cycles, Check AHB bus arbiter will grant the particular master <br>
 *    based on HSPLITx signals,so it can re-attempt the transfer and finishes with OKAY  <br>
 *    transfer response.<br>
 * .
 */

class svt_ahb_split_resp_all_master_same_slave_virtual_sequence extends svt_ahb_system_base_sequence;
 //-----------------------------------------------------------------------------  
  // Member attributes
  //-----------------------------------------------------------------------------   
  int supporting_masters[int];
  int supporting_slaves[int];

  //-----------------------------------------------------------------------------  
  // Constraints
  //----------------------------------------------------------------------------- 
  /** Randomize the active_participating_slave_index_0 */
  constraint active_participating_slave_index_0_c {
    if (supporting_slaves.size())
    {
     active_participating_slave_index_0 inside {supporting_slaves};
    }
  }

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_split_resp_all_master_same_slave_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_split_resp_all_master_same_slave_virtual_sequence");
    super.new(name);
  endfunction : new
  
  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AHB */
      if (sys_cfg.master_cfg[active_participating_masters[mstr]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_ahb_split_resp_all_master_same_slave_virtual_sequence",$sformatf(" master id that is participating is ='d%0d ",mstr));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if (sys_cfg.slave_cfg[active_participating_slaves[slv]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_ahb_split_resp_all_master_same_slave_virtual_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
      end
    end
  endfunction
  
  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 1
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end    
  endfunction : is_supported 
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Write or Read transaction request handles. */
    svt_ahb_master_transaction wr_rd_xact[int];

    /** Represents the Randomly selected Slave. */ 
    int unsigned selected_slv;

    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Randomly selected slave */
    if(supporting_slaves.size() >= 1) begin 
      selected_slv = active_participating_slave_index_0;
    end
    `svt_xvm_note("body",$sformatf("Randomly selected slave is 'd%0d",selected_slv)); 
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      /** Local Variable */ 
      int num_xacts_ended_count = 0;

      /** Execute the transactions from each selected active participating master */
      foreach(supporting_masters[master]) begin
        automatic int mstr = supporting_masters[master];
        bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;
        bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;
        `svt_xvm_debug("body", $sformatf("Master to initiate = 'd%0d initiating masters index = 'd%0d ",mstr,master));
        
        /** Randomly select an Address range for selected slave */
        if (!sys_cfg.get_slave_addr_range(mstr,selected_slv, lo_addr, hi_addr))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", selected_slv));

        `svt_xvm_do_on_with(wr_rd_xact[mstr], p_sequencer.master_sequencer[mstr], {
          xact_type           inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
          lock                == 0;
          !(burst_type    inside {svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16});
          if(burst_type == svt_ahb_transaction::INCR) {
            num_incr_beats == 5;
          }
          foreach(num_busy_cycles[i]) {
            num_busy_cycles[i] == 0;
          }
          addr >= lo_addr;
          addr <= hi_addr;
        })
      end//foreach of active_participating_masters
      foreach(wr_rd_xact[i]) begin
        fork  
          automatic int master = i;
          begin 
            `svt_xvm_note("body", $sformatf("wr_rd_xact['d%0d] is %0s...",master,wr_rd_xact[master].sprint()));
            `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact[master]), "Waiting for Transaction to end"} );
            /** Waiting for transaction to complete */
            `SVT_AHB_WAIT_FOR_XACT_ENDED(wr_rd_xact[master]); 
            num_xacts_ended_count++;
            `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(wr_rd_xact[master]), "Transaction is now ended"});
          end
        join_none
      end
      `svt_xvm_note("body", $sformatf("num_xacts_ended_count is 'd%0d and size of supporting_masters is 'd%0d",num_xacts_ended_count,supporting_masters.size()));
      /** Wait until all masters transaction to complete */
      wait(num_xacts_ended_count == supporting_masters.size());
    end//forloop of sequence_length
    
    /**
     * To check AHB bus arbiter should grant access to default master, when each master of 
     * write or read burst transfer has already received a SPLIT response from same
     * slave.
     * Check done by System monitor(List of checkers) <br>
     *  #- mask_hgrant_until_hsplit_assert <br>
     *  #- two_cycle_split_resp <br>
     *  #- htrans_not_changed_to_idle_during_split <br>
     *  #- illegal_hgrant_on_split_resp <br>
     *  #- grant_to_default_master_during_allmaster_split <br>
     *  #- data_integrity_check <br> 
     *  .  
     */
     
    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_split_resp_all_master_same_slave_virtual_sequence

// =========================================================================================
/** 
 * #- Program a master VIP to drive write or read burst on the bus.<br>
 * #- AHB bus forwards this burst to a slave. <br> 
 * #- Simultaneously Program another master VIP to drive write or read burst on the <br>
 *    bus and forwards the burst to another slave. <br> 
 * #- Program above two selected slaves VIP such that it should response with RETRY or <br>
 *    SPLIT for any transfer of the burst. <br>
 * #- Check AHB bus arbiter behaves properly when RETRY or SPLIT response was <br> 
 *    received from different slaves. <br>
 * #- Check AHB bus arbiter will grant to higher-priority master when received RETRY <br>
 *    response or another master when received SPLIT response from different slaves <br>
 *    and finishes with OKAY transfer response when re-attempt it. <br>
 * .
 */ 

class svt_ahb_split_retry_resp_diff_master_diff_slave_virtual_sequence extends svt_ahb_system_base_sequence;

  //-----------------------------------------------------------------------------  
  // Member attributes
  //-----------------------------------------------------------------------------  
  /** Represents the Second Active Participating Master from which the sequence will be initiated. */ 
  rand int unsigned initiating_master_index_1;
  
  /** Represents the Randomly selected Second Slave. */ 
  rand int unsigned selected_slv_1;

  int supporting_masters[int];
  int supporting_slaves[int];

  //-----------------------------------------------------------------------------  
  // Constraints
  //-----------------------------------------------------------------------------  
  /** Randomize the initiating_master_index_0 */
  constraint initiating_master_index_0_c {
    if (supporting_masters.size())
    {
     initiating_master_index_0 inside {supporting_masters};
    }
  }  

  /** Randomize the initiating_master_index_1 */
  constraint initiating_master_index_1_c {
    if(supporting_masters.size() >= 2) {
      initiating_master_index_1 inside {supporting_masters};
      initiating_master_index_1 != initiating_master_index_0;
    }
  }
  
  /** Randomize the active_participating_slave_index_0 */
  constraint active_participating_slave_index_0_c {
    if (supporting_slaves.size())
    {
     active_participating_slave_index_0 inside {supporting_slaves};
    }
  }
 
  /** Randomize the selected_slv_1 */
  constraint selected_slv_1_c {
    if(supporting_slaves.size() >= 2) {
      selected_slv_1 inside {supporting_slaves};
      selected_slv_1 != active_participating_slave_index_0;
    }
  }

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_split_retry_resp_diff_master_diff_slave_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_split_retry_resp_diff_master_diff_slave_virtual_sequence");
    super.new(name);
  endfunction : new
  
  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AHB */
      if (sys_cfg.master_cfg[active_participating_masters[mstr]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_ahb_split_retry_resp_diff_master_diff_slave_virtual_sequence",$sformatf(" master id that is participating is ='d%0d ",mstr));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if (sys_cfg.slave_cfg[active_participating_slaves[slv]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_ahb_split_retry_resp_diff_master_diff_slave_virtual_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
      end
    end
  endfunction

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 2
   *  #- minimum number supporting Slaves  = 2
   */
  //----------------------------------------------------------------------------- 
  
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    
    /** local variables */
    int num_supporting_masters;
    int num_supporting_slaves;

    /** Supporting masters required */
    int required_num_supporting_masters = 2;
    
    /** Supporting slaves required */
    int required_num_supporting_slaves  = 2;
    
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end    
  endfunction : is_supported 
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
    /** Represents the Randomly selected First Slave. */ 
    int unsigned selected_slv;
    
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq1,master_seq2;
    
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    `svt_xvm_note("body",$sformatf("Randomly selected two masters are 'd%0d 'd%0d",initiating_master_index_0,initiating_master_index_1)); 

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
    
    /** Randomly selected two different slaves */
    if(supporting_slaves.size() >= 2) begin 
      selected_slv = active_participating_slave_index_0;
    end
    `svt_xvm_note("body",$sformatf("Randomly selected two slaves are 'd%0d 'd%0d",selected_slv,selected_slv_1)); 
    
    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin
      
      fork
        begin:initiating_master_0_thread
        
          /** 
           * Randomly selected first master fires a transaction with address of randomly
           * selected slave.
           */
          `svt_note("body","start of seq from initiating_master_0");
          `svt_xvm_do_on_with(master_seq1, p_sequencer.master_sequencer[initiating_master_index_0], {
            sequence_length     == 1;
            seq_xact_type       inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            !(seq_burst_type    inside {svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16});
            slv_num             == selected_slv;
            seq_lock            == 0;
            seq_wait_for_xact_ended == 1;
          })
        end
        begin:initiating_master_1_thread

          /**
           * Randomly selected second master fires a transaction with address of randomly
           * selected another slave.
           */
          `svt_note("body","start of seq from initiating_master_1");
          `svt_xvm_do_on_with(master_seq2, p_sequencer.master_sequencer[initiating_master_index_1], {
            sequence_length     == 1;
            seq_xact_type       inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
            !(seq_burst_type    inside {svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16});
            slv_num             == selected_slv_1;
            seq_lock            == 0;
            seq_wait_for_xact_ended == 1;
          })
        end
      join
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus arbiter behaves properly when RETRY or SPLIT or ERROR response was <br> 
     * received from different slaves. <br>
     * Check done by System monitor(List of checkers) <br>
     *  #- two_cycle_retry_resp <br>
     *  #- htrans_not_changed_to_idle_during_retry<br> 
     *  #- mask_hgrant_until_hsplit_assert<br>
     *  #- two_cycle_split_resp<br>
     *  #- htrans_not_changed_to_idle_during_split<br>
     *  #- illegal_hgrant_on_split_resp<br>
     *  #- data_integrity_check<br>
     *  .  
     */
     
    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_split_retry_resp_diff_master_diff_slave_virtual_sequence

// =========================================================================================
/** 
 * #- Program a master VIP to drive locked or unlocked burst on to the bus <br> 
 *    and routed to a slave. <br>
 * #- Program above selected slave VIP such that it should response with RETRY or <br>
 *    SPLIT for any transfer of the burst. <br>
 * #- Check AHB bus arbiter behaves properly when RETRY or SPLIT response was <br> 
 *    received for locked or unlocked burst from same slave. <br>
 * #- For unlocked bursts, Check AHB bus arbiter will grant to higher-priority master <br>
 *    when received RETRY response or another master when received SPLIT response <br>
 *    from same slave and finishes with OKAY transfer response when re-attempt it. <br>
 * #- For locked bursts, Check AHB bus arbiter should give grant access to dummy master<br>
 *    when received SPLIT response or higher-priority master when received RETRY response. <br> 
 * .
 */ 

class svt_ahb_lock_split_retry_resp_same_master_same_slave_virtual_sequence extends svt_ahb_system_base_sequence;
  //-----------------------------------------------------------------------------  
  // Member attributes
  //-----------------------------------------------------------------------------  
  //-----------------------------------------------------------------------------  
  int supporting_masters[int];
  int supporting_slaves[int];

  //-----------------------------------------------------------------------------  
  // Constraints
  //-----------------------------------------------------------------------------  
  /** Randomize the initiating_master_index_0 */
  constraint initiating_master_index_0_c {
    if (supporting_masters.size())
    {
     initiating_master_index_0 inside {supporting_masters};
    }
  }  

  /** Randomize the active_participating_slave_index_0 */
  constraint active_participating_slave_index_0_c {
    if (supporting_slaves.size())
    {
     active_participating_slave_index_0 inside {supporting_slaves};
    }
  }

  /** UVM/OVM Object Utility macro */
  `svt_xvm_object_utils(svt_ahb_lock_split_retry_resp_same_master_same_slave_virtual_sequence)

  //-----------------------------------------------------------------------------  
  // Methods
  //-----------------------------------------------------------------------------
  /** Class Constructor */
  function new (string name = "svt_ahb_lock_split_retry_resp_same_master_same_slave_virtual_sequence");
    super.new(name);
  endfunction : new
  
  /** Pre-Randomizing the participating masters */  
  function void pre_randomize();
    int index_mstr = 0;
    int index_slv = 0;
    super.pre_randomize();
    /** Getting number of Supporting Masters */
    foreach(active_participating_masters[mstr])  begin
      /**  Check if the Master configuration is AHB */
      if (sys_cfg.master_cfg[active_participating_masters[mstr]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_masters[index_mstr++] = active_participating_masters[mstr];
        `svt_xvm_debug("svt_ahb_lock_split_retry_resp_same_master_same_slave_virtual_sequence",$sformatf(" master id that is participating is ='d%0d ",mstr));
      end
    end
    /** Getting number of Supporting Slaves */
    foreach(active_participating_slaves[slv])  begin
      if (sys_cfg.slave_cfg[active_participating_slaves[slv]].ahb_interface_type == svt_ahb_configuration::AHB) begin 
        supporting_slaves[index_slv++] = active_participating_slaves[slv];
        `svt_xvm_debug("svt_ahb_lock_split_retry_resp_same_master_same_slave_virtual_sequence",$sformatf(" slave id that is participating is ='d%0d ",slv));
      end
    end
  endfunction

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires following configurations
   *  #- minimum number supporting Masters = 1
   *  #- minimum number supporting Slaves  = 1
   */
  //----------------------------------------------------------------------------- 
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
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.\n\
                                                Number of Supporting Master(s) - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_masters,\n\
                                                svt_ahb_configuration::is_active,\n\
                                                svt_ahb_system_configuration::participating_masters, \n\
                                                Number of Supporting Slave(s)  - Minimum Required : 'd%0d Current : 'd%0d \n\
                                                Modify configurations through \n\
                                                svt_ahb_system_configuration::num_slaves,\n\
                                                svt_ahb_system_configuration::participating_slaves\
                                                ", required_num_supporting_masters, num_supporting_masters, required_num_supporting_slaves, num_supporting_slaves))
    end    
  endfunction : is_supported 
  
  //-----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_start();
    `svt_xvm_debug("pre_start",$sformatf("Entering ..."));
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_debug("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif

  //-----------------------------------------------------------------------------  
  virtual task body();
  
    /** Represents the Randomly selected Master. */ 
    int unsigned selected_mstr;

    /** Represents the Randomly selected Slave. */ 
    int unsigned selected_slv;
    
    /** Handle to Master sequence */
    ahb_transaction_random_write_or_read_sequence master_seq;
    
    /** Array of masters that are supporting in the system */ 
    int supporting_masters_arr[];
    
    /** Array of slaves that are supporting in the system */ 
    int supporting_slaves_arr[];
    
    `svt_xvm_debug("body", "Entering ...");
    
    /** check if current environment is supported or not */ 
    if(!is_supported(sys_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end

    /** Setting the response_queue_depth */ 
    set_response_queue_depth(-1);

    /** Fork off a thread to pull the responses out of response queue. */
    sink_responses();
 
    supporting_masters_arr = new[supporting_masters.size];
   
    /** Collection of masters that are supporting in the system */
    foreach(supporting_masters[i]) begin
      supporting_masters_arr[i] = supporting_masters[i];
      `svt_xvm_note("body",$sformatf("supporting__masters['d%0d] is 'd%0d and supporting_masters_arr['d%0d] is 'd%0d", i,supporting_masters[i],i,supporting_masters_arr[i])); 
    end

    /** Collection of slaves that are supporting in the system */
    if(supporting_slaves.size()) begin
      supporting_slaves_arr = new[supporting_slaves.size];
      foreach(supporting_slaves[j]) begin
        supporting_slaves_arr[j] = supporting_slaves[j];
        `svt_xvm_note("body",$sformatf("supporting_slaves['d%0d] is 'd%0d and supporting_slaves_arr['d%0d] is 'd%0d", j,supporting_slaves[j],j,supporting_slaves_arr[j])); 
      end
    end

    /**  Execute the sequence for 'sequence_length' number of times. */ 
    for(int i = 0; i < sequence_length; i++) begin

      /** Randomly selected master */ 
      supporting_masters_arr.shuffle;
      selected_mstr = supporting_masters_arr[0];

      /** Randomly selected slave */ 
      supporting_slaves_arr.shuffle;
      selected_slv = supporting_slaves_arr[0];
      
      `svt_xvm_note("body",$sformatf("Randomly selected master is 'd%0d and slave is 'd%0d ",selected_mstr,selected_slv)); 
      
      /** 
       * Randomly selected master fires a transaction with address of randomly
       * selected slave.
       */
      `svt_xvm_do_on_with(master_seq, p_sequencer.master_sequencer[selected_mstr], {
        sequence_length     == 1;
        seq_xact_type       inside {svt_ahb_transaction::WRITE, svt_ahb_transaction::READ};
        !(seq_burst_type    inside {svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16});
        slv_num             == selected_slv;
        seq_lock            == local::temp_lock_1;
        seq_wait_for_xact_ended == 1;
      })
    end//forloop of sequence_length
    
    /** 
     * To check AHB bus arbiter behaves properly when RETRY or SPLIT or ERROR response <br> 
     * was received for locked or unlocked burst from same slave. <br>
     * Check done by System monitor(List of checkers) <br>
     *  #- two_cycle_retry_resp <br>
     *  #- htrans_not_changed_to_idle_during_retry<br> 
     *  #- mask_hgrant_until_hsplit_assert<br>
     *  #- two_cycle_split_resp<br>
     *  #- htrans_not_changed_to_idle_during_split<br>
     *  #- illegal_hgrant_on_split_resp<br>
     *  #- arbiter_lock_last_grant <br>
     *  #- arbiter_changed_hmaster_during_lock <br>
     *  #- data_integrity_check<br>
     *  .  
     */
     
    `svt_xvm_debug("body", "Exiting...");

 endtask: body
 
  //-----------------------------------------------------------------------------  
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    super.post_start();
    drop_phase_objection();
  endtask
`endif

endclass: svt_ahb_lock_split_retry_resp_same_master_same_slave_virtual_sequence

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bYy2ll3A8/Czc+1YWt6nOTnAiNHAWaOsI1cT/i4LA6RpWZp1D2T9CYDxLH2xDmIi
SPSTNgZ6T2F5thmYKSnTbLejzjQToB1Iwd5lAepJ8gvdQrJyZE6gO1xZpeQbCLwC
ORpcBvvMDzX3XbZKBF9iAGWKMCiZ0iZk8dZ66hSCUrY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1968      )
XzMhvmR/LkTuu39P+M3eK6cV3b60IeMp48sEZ4Ze8o8mrS1wBGHqvYo6QByEAHUJ
CLcrYXhj6gUBQ/HjIKLp0JmgbO0D8Ufj9jLZdic9y4VTAWXxYhRy3i2uAgG2mJeI
F5Me0C0Xb8uWevSdSLdICiQQRrdhevo+12OG8GO2SBtbA2wtZ/rlgbCbcyx+oyxe
7P4cPBu3xKT+oa6eOHRxvbkcCyUdS6+95QXtgQgY/3z0CH0ymCnc3cisaISIQGpS
KKnsRU1U0eNYd7n2yp7mRXr4vSh94DEVUPx19UHZpWthUIziX3hn7viFMy7JjOLz
HKqkC6/xYU0MB/QaD1RhXe12rAcs9qsdq4krfdhNfZ2++rUWn3IeE8ewcVqwDKdR
I+HV4hRR6Whbk7QefB/1rYvzElpIyqYmkSO1B3XBbxI5gbLWGMPKanWECHtmUv5g
oxRrXyutxKntU0DIytEp/irNDMOkT89Zs/g1G7eqBPXsVKb9AFtKKOX49D8eSCLa
nkEMIXm0yqxVW5XsyboHS8Y9ZgvKIrN1msnsQcaQue30yVr3dBhbTjxOvryM5YaD
2uwFQmtAI+ZG9O8WIKeDkQytOsyGo/Apgls5Tsu+/Cq6od03ngq/LyiTL5/f3Nn7
IunyhkGBbQCJWo3I9XGS8WYAUAvnwtwX3rspuKrpGw+T/ZlTYQv4tbcMJIh3h2W0
jzxYjfGuC8WYem/TRKGpAsJ8ERkDgV98LeGfZyhuzcEOrrpnmf6DVd0IkSxBSMhU
mhV0AmjAcAvBTSczubnUKCmvmOFWGHO2dkoYvCtM3pTGfJFaeQIj9Pzjvuwjh7Hx
RXkHCaLe5PTLUYyxHgSsORsvnXEXmXlxsWhbKzrgXZ/LdfSq8QoDFrtNuvrbp20K
EekqTwo+AVSJguKqi/O5NWtGxCUywKLvkagttmi14uQ4pKpVOYzM+7JqD594tZnl
E2VVtK2V4E2vg6G8WVqoZhCDEbPtJqJpujIMt875LpA59xme4cIoj4VcmfiAZgz8
V3lrzknSxTFBs/I38GeVgWMa6k8mBnmG6ExZw95MmW9Z3VmVdS48GsmKyaifLtlf
1Ew+q33cEa4IZHS7vzxjc54oDL9pAAWthHg9woak369YoFmlVDBB2r0K5k/4h1+N
QY2EYVRtH0krktkz3aVQg6ZmaNK4dDEn1k3O5wbd8EfcRIMJ+82aJ80gOU+V1hSf
pDKT+xkw06pONbt+xPkjd9zPD9cRav50dNHThxl8wS177lumBv8swED7jJwrBddE
1a0cH2Xen4hh0YEc+yDsTcxcLL66bqVNMvUAyd1++BILHaP6uZIoKLQKxhr66xQd
ayfs7ats2nNeh2j7uXs1SCBVW7CVVxJ3hgC2HxSuV1YYUXFHwGImLeHq0fcpIShB
CfOb0LHW+Ov9HZ08MDJMTiVX8hXWmrwWDv+sWVcHU+PUOH5KAVoRQO91vEupldJ6
TCzmPLpsNvk9joqClxXnfjs5E2AFPl5adXypGRJm/Cm/aQDM67m/ye7Vng8P0TuG
PmW+W7GJULwB2W7Hxs15etXFYDCtyFpsu7LWJ4vvpcOwixbAf5uNpY0KsD04MqOo
/VkEraZP3ZC556Uto0EQbJnZimXYGE5aFZMbNzDm+Z5DluLjggHN0U1BVB+4Zf0w
c0ePKweuUteEHlVf1vX8TgxLqiDV5UrPxVXynZL0XQO28O3lTTzimXssblDkpK3l
i1M93DSndn481mOTMRdar0jkojNL4FogBTAunBuRtdQff9QbegkMWNPXw36Unkao
vNvFusV3x8kRdykcLo5K6Gwy0WOb54h7DXSgkhB7l3Q2mZDdhsWXcYily4hJKapa
NB/AOmQ3X8u9+fd9tT9s08h+e5c5B8TUlv9VWni6we/E79ZxEmx/cUjmmfVLULTd
ycvUJg4+mCb6SHYqPqS1peFDDzNkUVahgh/G1AhJsUyV+0a8/3ZAHHsbG0Clnvzj
uTvDPgTa29Du0O/gPg8Ok95B6Zl5hizLoYPltz5GUUe3gFn8dHYKF3XOH4Ne8bt6
M4i/jkm5lHV55qT03CBvibpYFEmXdFmGb96IPi/frhWnb0H60awpeRFEj3JJa1GU
y1rpylwopjkF8Kteo9Xzdesi+cLMZcFAP80uFTY7Fvkhhxuw6g1BRqQ7c2DiSJpL
ppbKbK5LqRGLrpGC9H1nBA2X5Q/rz4WUaOkYiVKpTw1sLmuevRsAiheyMNXAa2DT
s7IueKSWjUjFwyUE7cXn0n6aqydwG6C09NLjmRHbSLhcUXwymRP6fvmD0agClHzS
5ThjoUaKxnyNRUWKoMgCgBvKSNdVxfSV+bHhd3hwzwe22gIkxzjq5M77SgmdG9CE
Rg8ycOVew5W8stz9q8gyLg==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_SEQUENCE_LIBRARY_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DUICBPvPsJZb5DuFZGGYHBPKSxUK/rJQ44zG2izhmYPTJUoHn//zdmPMz+tEArrq
6vCq5hpwJ7tUlwVEPgGrHGASht5iaaDCSynsqWHceSW5heD+IdMX6Y5SkDnn6ReZ
4KwK798KYYAQC8jT9faZNC6pdUt0+9eK8TRdHwQZ2no=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2051      )
Z+QrMxjJdHo3L/acys1zxMn5qBRVK3Hr3qjwELRHShIz46Psh9tsFQtF+NVVjLWx
qbVP452QIEits+uHpdfdNKXk8xDrZntZigLHJcjXPn/CVHw+weUKOxXl8LaEkkYE
`pragma protect end_protected
