
`ifndef GUARD_SVT_APB_SYSTEM_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_APB_SYSTEM_SEQUENCE_LIBRARY_SV

// =============================================================================
/**
 * This sequence creates a reporter reference
 */
class svt_apb_system_base_sequence extends svt_sequence;

  `svt_xvm_object_utils(svt_apb_system_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_apb_system_sequencer)

  extern function new(string name="svt_apb_system_base_sequence");

  /** Initiating Slave index **/
  rand int unsigned active_participating_slave_index;
  /** Initiating Slave index **/
  rand int unsigned participating_slave_index;

  /** This bit silent is used typically to suppress is_supported message */
  bit silent;

  /** Represents the length of the sequence. */
  int unsigned sequence_length = 10;

  /** Status filed for capturing config DB get status for sequence_length */
  bit sequence_length_status;

  /** Status filed for capturing config DB get status for silent */  
  bit silent_status;

  /** This bit indicates whether the arrays related to various types of ports
   *  are populated or not. 
   *  This is used by the sequence for maitaining the infrastructure, and should
   *  not be programmed by user.
   */
  bit is_participating_slaves_array_setup = 0;

  /** Represents the slave port from which the sequence will be initiated. 
   *  This can be controlled through config DB. 
   */ 
  int unsigned slave_index_0;
  int unsigned slave_index_1;
  
  /** Status field for capturing config DB get status for slave_index */
  bit slave_index_status_0;
  bit slave_index_status_1;

  /** Array of slaves that are participating and active **/
  int active_participating_slaves[int];

  /** Array of slaves that are participating in the system so that the transactions from the master can be routed to the slaves in this array **/
  int participating_slaves_arr[int];

  /* Port configuration obtained from the sequencer */
  svt_apb_system_configuration sys_cfg;
  svt_configuration base_cfg;

  /* Port configuration for slave obtained through config_db */
  svt_apb_system_configuration slave_cfg;

  /** Randomize the initiatiating slave **/
  constraint active_participating_slaves_c {
    if (active_participating_slaves.size())
    {
     active_participating_slave_index inside {active_participating_slaves};
    }
  }

  /** Randomize the participating slave **/
  constraint participating_slaves_c {
    if (participating_slaves_arr.size())
    {
     participating_slave_index inside {participating_slaves_arr};
    }
  }


  /** Routes messages through the parent sequencer and raises an objection */
  virtual task pre_body();
    raise_phase_objection();
  endtask

  /** 
   * Routes messages through the parent sequencer and raises an objection and gets
   * the sequencer configuration. 
   */
  virtual task body();
    super.body();
    `svt_xvm_debug("body", {"Executing ", (is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"});
  endtask: body

  /** Drop objection */
  virtual task post_body();
    drop_phase_objection();
  endtask: post_body

  /** Setup participating masters and slaves */  
  function void setup_participating_slave_arrays();
    bit is_participating_slave_exists = 0;
    int index_slv =0;
    int index_participate_slv =0;

    `svt_xvm_debug("setup_participating_slave_arrays","Entered ...") 
    if(sys_cfg == null) begin
      p_sequencer.get_cfg(base_cfg);
      if (!$cast(sys_cfg, base_cfg)) begin
        `svt_xvm_fatal("setup_participating_master_slave_arrays", "Unable to $cast the configuration to a svt_apb_system_configuration class");
      end
    end

    if(svt_config_object_db#(svt_apb_system_configuration)::get(m_sequencer,get_full_name(),"slave_cfg",slave_cfg)) begin
      if (!is_participating_slaves_array_setup) begin

        foreach(slave_cfg.slave_cfg[slv])  begin
          if(slave_cfg.is_participating_slave(slv) == 1) begin
             is_participating_slave_exists = 1;
          end
        end

        if((slave_index_status_0) || (slave_index_status_1)) begin
          if(slave_index_status_0) begin
            if((slave_cfg.slave_cfg[slave_index_0].is_active == 1) && (slave_cfg.is_participating_slave(slave_index_0) == 1 ))  begin
              active_participating_slaves[index_slv++] = slave_index_0;  
              `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" programmed slave id that is active & participating is =%0d ",slave_index_0));
            end
            if(slave_cfg.is_participating_slave(slave_index_0) == 1) begin
              participating_slaves_arr[index_participate_slv++] = slave_index_0;
              `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" programmed slave id that is participating is =%0d ",slave_index_0));
            end
          end
          if(slave_index_status_1) begin
              if((slave_cfg.slave_cfg[slave_index_1].is_active == 1) && (slave_cfg.is_participating_slave(slave_index_1) == 1 ))  begin
                active_participating_slaves[index_slv++] = slave_index_1;  
                `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" programmed slave id that is active & participating is =%0d ",slave_index_1));
              end
              if(slave_cfg.is_participating_slave(slave_index_1) == 1) begin
                participating_slaves_arr[index_participate_slv++] = slave_index_1;
                `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" programmed slave id that is participating is =%0d ",slave_index_1));
              end
          end
        end
        else if (is_participating_slave_exists) begin
          foreach(slave_cfg.slave_cfg[slv])  begin
            if((slave_cfg.slave_cfg[slv].is_active == 1) && (slave_cfg.is_participating_slave(slv) == 1 ))  begin
              active_participating_slaves[index_slv++] = slv;  
              `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" slave id that is active & participating is =%0d ",slv));
            end
            if(slave_cfg.is_participating_slave(slv) == 1) begin
              participating_slaves_arr[index_participate_slv++] = slv;
              `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" slave id that is participating is =%0d ",slv));
            end
          end
        end
        else begin
          foreach(slave_cfg.slave_cfg[slv])  begin
            participating_slaves_arr[index_participate_slv++] = slv;
            if((slave_cfg.slave_cfg[slv].is_active == 1))  
              active_participating_slaves[index_slv++] = slv;  
            `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" slave id that is participating is =%0d ",slv));
          end
        end
        is_participating_slaves_array_setup=1;
      end // if (!is_participating_slaves_array_setup)
    end
    else begin
      if (!is_participating_slaves_array_setup) begin
        foreach(sys_cfg.slave_cfg[slv])  begin
          participating_slaves_arr[index_participate_slv++] = slv;
          `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" slave id that is participating is =%0d ",slv));
        end
        `svt_xvm_debug("setup_participating_slave_arrays",$sformatf(" active_participating_slaves.size()=%0d participating_slaves_arr.size=%0d ",active_participating_slaves.size(),participating_slaves_arr.size()));
        is_participating_slaves_array_setup=1;
      end // if (!is_participating_slaves_array_setup)
    end // if(uvm_config_db#(svt_apb_system_configuration)::get(m_sequencer,get_full_name(),"slave_cfg",slave_cfg))
    `svt_xvm_debug("setup_participating_slave_arrays","Exiting ...") 
  endfunction: setup_participating_slave_arrays

  /** Pre-Randomizing the participating masters and slaves */  
  function void pre_randomize();
    `svt_xvm_debug("svt_apb_test_suite_master_base_sequence::pre_randomize()","Entered ...");      
    super.pre_randomize();

`ifdef SVT_UVM_TECHNOLOGY
    slave_index_status_0  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "slave_index_0", slave_index_0);
    slave_index_status_1  = uvm_config_db#(int unsigned)::get(null, get_full_name(), "slave_index_1", slave_index_1);
`elsif SVT_OVM_TECHNOLOGY
    slave_index_status_0  = m_sequencer.get_config_int({get_full_name(), ".slave_index_0"}, slave_index_0);
    slave_index_status_1  = m_sequencer.get_config_int({get_full_name(), ".slave_index_1"}, slave_index_1);
`endif
    `svt_xvm_debug("body", $sformatf("programmed slave_index_0 is %0d as a result of %0s.",slave_index_0, slave_index_status_0 ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("programmed slave_index_1 is %0d as a result of %0s.",slave_index_1, slave_index_status_1 ? "config DB" : "default value"));
    setup_participating_slave_arrays();
    `svt_xvm_debug("svt_apb_test_suite_master_base_sequence::pre_randomize()","Exiting ...");  
  endfunction: pre_randomize

  /** Pre-start method for inintializing the master and slave array that are participating */
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
    `svt_xvm_debug("svt_apb_test_suite_master_base_sequence::pre_start()","Entered ...") 
    super.pre_start();
    setup_participating_slave_arrays();
    sequence_length_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    silent_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "silent", silent);
    `svt_xvm_note("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, sequence_length_status ? "config DB" : "default value"));
    `svt_xvm_note("body", $sformatf("silent is %0d as a result of %0s.", silent, silent_status ? "config DB" : "default value"));

    `svt_xvm_debug("svt_apb_test_suite_master_base_sequence::pre_start()","Exiting ...")    

  endtask // pre_start
`endif
  
endclass: svt_apb_system_base_sequence

/**
 * Abstract:
 * svt_apb_master_random_transfer_sequence defines a sequence in which random
 * APB transactions are issued and based on config_db flags and other values
 * performs the self checks and necessary operations.
 * Sequence is generated using `svt_xvm_do_on_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: System sequencer
 */
class svt_apb_master_random_transfer_sequence extends svt_apb_system_base_sequence;

  /** sequence_length */
  int unsigned sequence_length = 10;

  /** sequence of transactions to one slave. */
  int unsigned seq_num = 1;
  
  /** This bit provides a control to choose a single random slave is required
   *  or not by the sequence. Also this bit can be programmed using config_db
   */  
  bit single_slave = 0;

  /** bit to check non-zero wait cycles
   *  This bit can be programmed using config_db
   */
  bit wait_cycle_check = 0;

  /** bit to check zero wait cycles 
   *  This bit can be programmed using config_db
   */
  bit no_wait_cycle_check = 0;

  /** bit to allow only read transactions 
   *  This bit can be programmed using config_db
   */
  bit read_transaction;

  `svt_xvm_declare_p_sequencer(svt_apb_system_sequencer)

  `svt_xvm_object_utils_begin(svt_apb_master_random_transfer_sequence)
    `svt_xvm_field_int(sequence_length,     `SVT_ALL_ON)
    `svt_xvm_field_int(seq_num,             `SVT_ALL_ON)
    `svt_xvm_field_int(single_slave,        `SVT_ALL_ON)
    `svt_xvm_field_int(wait_cycle_check,    `SVT_ALL_ON)
    `svt_xvm_field_int(no_wait_cycle_check, `SVT_ALL_ON)
    `svt_xvm_field_int(read_transaction,    `SVT_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_apb_master_random_transfer_sequence");
    super.new(name);
  endfunction

  virtual task body();
    /** Status bits */
    bit status_sequence_length;
    bit status_seq_num;
    bit status_single_slave;
    bit status_wait_cycle_check;
    bit status_no_wait_cycle_check;
    bit status_read_transaction;

    /** slave_arr index queue */
    int unsigned slaves_arr[$];

    /** slave_index to put randomly selected slave */
    int unsigned slave_index;

    /** master transactions associative array */
    svt_apb_master_transaction master_xact[int];

    //super.body();

    /** Gets the configurations from test. */
`ifdef SVT_UVM_TECHNOLOGY
    status_sequence_length     = uvm_config_db #(int unsigned)::get(m_sequencer,get_type_name(),"sequence_length",sequence_length);
    status_seq_num             = uvm_config_db #(int unsigned)::get(m_sequencer,get_type_name(),"seq_num",seq_num);
    status_single_slave        = uvm_config_db #(bit)::get(m_sequencer,get_type_name(),"single_slave",single_slave);
    status_wait_cycle_check    = uvm_config_db #(bit)::get(m_sequencer,get_type_name(),"wait_cycle_check",wait_cycle_check);
    status_no_wait_cycle_check = uvm_config_db #(bit)::get(m_sequencer,get_type_name(),"no_wait_cycle_check",no_wait_cycle_check);
    status_read_transaction    = uvm_config_db #(bit)::get(m_sequencer,get_type_name(),"read_transaction",read_transaction);
`else
    status_sequence_length     = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
    status_seq_num             = m_sequencer.get_config_int({get_type_name(), ".seq_num"}, seq_num);
    status_single_slave        = m_sequencer.get_config_int({get_type_name(), ".single_slave"}, single_slave);
    status_wait_cycle_check    = m_sequencer.get_config_int({get_type_name(), ".wait_cycle_check"}, wait_cycle_check);
    status_no_wait_cycle_check = m_sequencer.get_config_int({get_type_name(), ".no_wait_cycle_check"}, no_wait_cycle_check);
    status_read_transaction    = m_sequencer.get_config_int({get_type_name(), ".read_transaction"}, read_transaction);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status_sequence_length ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("seq_num is %0d as a result of %0s.", seq_num, status_seq_num ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("Flag single_slave is %0b as a result of %0s.", single_slave, status_single_slave ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("Flag wait_cycle_check is %0b as a result of %0s.", wait_cycle_check, status_wait_cycle_check ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("Flag no_wait_cycle_check is %0d as a result of %0s.", no_wait_cycle_check, status_no_wait_cycle_check ? "config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("Flag read_transaction is %0d as a result of %0s.", read_transaction, status_read_transaction ? "config DB" : "default value"));

    if(active_participating_slaves.size()) begin
      slave_index = active_participating_slave_index;
      foreach(active_participating_slaves[i])
        slaves_arr.push_back(active_participating_slaves[i]);
    end
    else if(participating_slaves_arr.size()) begin
      slave_index = participating_slave_index;
      foreach(participating_slaves_arr[i])
        slaves_arr.push_back(participating_slaves_arr[i]);
    end
    else begin
      `svt_xvm_warning("body","Neither active_participating_slaves array nor participating_slaves_arr array has any slave index available");
    end

    for (int i=0; i < sequence_length; i++) begin
      foreach(slaves_arr[j]) begin
        int slave_idx = slaves_arr[j];
        for(int k = 0; k < seq_num; k++) begin
          int transfer_index = k;
          bit[`SVT_APB_MAX_ADDR_WIDTH-1:0] lo_addr;
          bit [`SVT_APB_MAX_ADDR_WIDTH-1:0] hi_addr;
          if (!sys_cfg.get_slave_addr_range(slave_idx, lo_addr, hi_addr))
            `svt_xvm_warning("body", $sformatf("Unable to obtain an address range for slave index %0d", slave_idx));
          if(single_slave && (slave_index != slave_idx))
            break;
          `svt_xvm_debug("body", $sformatf("Firing transaction to slave %0d",slave_idx));
          `svt_xvm_do_on_with(master_xact[transfer_index],p_sequencer.master_sequencer,{
            if(read_transaction)
              xact_type == svt_apb_transaction::READ;
            address inside {[lo_addr : hi_addr]};
          })

          fork
            automatic int tran_index = transfer_index;
            begin
              /** Self check for non-zero wait cycles */
              if(wait_cycle_check) begin
                wait(master_xact[tran_index].curr_state == svt_apb_transaction::ACCESS_STATE);
                `svt_xvm_debug("body", "Checking if wait cycles were put by the slave");
                if(master_xact[tran_index].num_wait_cycles < 1)
                  `svt_xvm_error("wait_cycle","pready was asserted with zero wait cycles");
              end
              /** Self check for zero wait cycles */
              if(no_wait_cycle_check) begin
                wait(master_xact[tran_index].curr_state == svt_apb_transaction::ACCESS_STATE);
                `svt_xvm_debug("body", "Checking if wait cycles were not put by the slave");
                if(master_xact[tran_index].num_wait_cycles != 0)
                  `svt_xvm_error("wait_cycle","pready was not asserted with zero wait cycles");
              end
            end
          join_none
          get_response(rsp);
        end
      end
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_apb_master_random_transfer_sequence

/**
 * Abstract:
 * svt_apb_random_slave_write_transfer_with_random_pstrb_sequence
 * defines a sequence in which a APB WRITE is followed by a APB READ
 * to the same address and data integrity check is performed.
 *
 * Execution phase: main_phase
 * Sequencer: System sequencer
 */
class svt_apb_random_slave_write_transfer_with_random_pstrb_sequence extends svt_apb_system_base_sequence;
  /** sequence_length */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(svt_apb_random_slave_write_transfer_with_random_pstrb_sequence)

  /** Class Constructor */
  function new(string name="svt_apb_random_slave_write_transfer_with_random_pstrb_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    /** Status bit */
    bit status;
    /** write data */
    bit[`SVT_APB_MAX_DATA_WIDTH -1:0] _write_data;
    /** read data */
    bit[`SVT_APB_MAX_DATA_WIDTH -1:0] _read_data;
    /** slave_idx to put randomly selected slave */
    int slave_idx ;
    /** Variable to randomly insert directed values */
    int rand_insertion;
    /** slave_arr index queue */
    int unsigned slaves_arr[$];
    /** Handles for read and write transactions */
    svt_apb_master_transaction write_xact, read_xact;

    `svt_xvm_note("body", "Entered ...")
    /** Get the sequence_length */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`endif
    `svt_xvm_note("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));

    `svt_xvm_debug("svt_apb_random_slave_write_transfer_with_random_pstrb_sequence", $sformatf("active_participating_slaves.size() = %0d participating_slaves_arr.size()=%0d. \n",active_participating_slaves.size(),participating_slaves_arr.size()));

    `svt_xvm_debug("svt_apb_random_slave_write_transfer_with_random_pstrb_sequence", $sformatf("active_participating_slave_index = %0d participating_slaves_arr=%0d. \n",active_participating_slave_index,participating_slaves_arr.size()));

    if(active_participating_slaves.size()) begin
      slave_idx = active_participating_slave_index;
      foreach(active_participating_slaves[i])
        slaves_arr.push_back(active_participating_slaves[i]);
    end
    else if(participating_slaves_arr.size()) begin
      slave_idx = participating_slave_index;
      foreach(participating_slaves_arr[i])
        slaves_arr.push_back(participating_slaves_arr[i]);
    end
    else begin
      `svt_xvm_warning("body","Neither active_participating_slaves array nor participating_slaves_arr array has any slave index available");
    end
  
    for(int i = 0; i < sequence_length; i++) begin
      foreach(slaves_arr[j]) begin
        int slv = slaves_arr[j];
        bit[`SVT_APB_MAX_ADDR_WIDTH-1:0] lo_addr;
        bit [`SVT_APB_MAX_ADDR_WIDTH-1:0] hi_addr;

        if (!sys_cfg.get_slave_addr_range(slv, lo_addr, hi_addr))
          `svt_xvm_warning("body", $sformatf("Unable to obtain an address range for slave index %0d", slv));

        rand_insertion = $urandom_range(sequence_length,0);

        `svt_xvm_debug("body", $sformatf("Sending APB write transfer to slave %0d",slv));
        /** Setup the write transaction */
        `svt_xvm_do_on_with(write_xact,p_sequencer.master_sequencer,{ 
          xact_type == svt_apb_transaction::WRITE;
          address inside {[lo_addr : hi_addr]};
          if(rand_insertion%10 == 0){
            data == '1;
          }
        })

        /** Wait for the write transaction to complete */
        get_response(rsp);
        `svt_xvm_debug("body", $sformatf("APB Write transfer completed. Now sending read transfer to slave %0d for address %0h",slv,write_xact.address));

        /** Setup the read transaction to above write transaction address */
        `svt_xvm_do_on_with (read_xact,p_sequencer.master_sequencer,{
                         xact_type == svt_apb_transaction::READ;
                         address == write_xact.address;
                         });
        /** Wait for the read transaction to complete */
        get_response(rsp);
        `svt_xvm_debug("body", "APB READ transfer completed");
  
        /** Filling _write data and _read data variables and compare */
        if(read_xact.cfg.apb4_enable) begin
          _write_data = write_xact.data;
          foreach(write_xact.pstrb[j]) begin
            if(!write_xact.pstrb[j]) begin
              _write_data[j*8+7-:8] = 0;
            end
          end
          _read_data = read_xact.data;
          foreach(write_xact.pstrb[j]) begin
            if(!write_xact.pstrb[j]) begin
              _read_data[j*8+7-:8] = 0;
            end
          end
          `svt_xvm_debug("body", $sformatf("comparing data for addr =%0x initial write xact data: %0x. write_data=%0x after  pstrb=%0x read_data=%0x read xact data: %0x transaction: %0d",write_xact.address, write_xact.data, _write_data, write_xact.pstrb, _read_data, read_xact.data,i));
          if(_read_data != _write_data) begin
            `svt_xvm_error("body", $sformatf("Mismatch in write and read data for addr =%0x initial write xact data: %0x. write_data=%0x after  pstrb=%0x read_data=%0x read xact data: %0x transaction: %0d",write_xact.address, write_xact.data, _write_data, write_xact.pstrb, _read_data, read_xact.data,i));
          end
        end
        else begin
          if(read_xact.data != write_xact.data) begin
            `svt_xvm_error("body", $sformatf("Mismatch in write and read data for addr =%0x write xact data: %0x. read xact data: %0x transaction: %0d",write_xact.address, write_xact.data,read_xact.data,i));
          end
        end
      end
    end

    `svt_xvm_note("body", "Exiting...")
  endtask: body

endclass: svt_apb_random_slave_write_transfer_with_random_pstrb_sequence

`protected
TeIE.R(?&B[GG+)S-RZHa>eBF?HJH&,G98Oba]1?W14VMK#]G7^\0)-H&BV:Ya,7
\,PNIX[B=UeZSQ.@gGe.F2464\0IB^#@LLML6@J539MKMc)WZ::Y24/?BeB?O:1.
W7c,ERH;f,7GJ>9)9CR0dBT7EQf4MN]4<@MSCB@7d1DB6KTES=fBUW<A2ZM>RGN+
Oc-VCD&PX_afbP(H7YOf;:D+RBV1-.0)]c)6FJLd2#?\65N(503?U<<AK$
`endprotected



`endif // GUARD_SVT_APB_SYSTEM_SEQUENCE_LIBRARY_SV
