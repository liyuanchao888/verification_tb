`ifndef GUARD_SVT_AXI_MASTER_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_AXI_MASTER_SEQUENCE_COLLECTION_SV
`ifdef SVT_UVM_TECHNOLOGY
`define SVT_AXI_MASTER_TRANSACTION_EVENT_WAIT_TRIGGER_DECL \
        uvm_event_pool xact_event_pool; \
        uvm_event xact_ev; 
`elsif SVT_OVM_TECHNOLOGY
`define SVT_AXI_MASTER_TRANSACTION_EVENT_WAIT_TRIGGER_DECL \
        ovm_event_pool xact_event_pool; \
        ovm_event xact_ev; 
`endif

`define SVT_AXI_MASTER_TRANSACTION_EVENT_WAIT_TRIGGER(xact,event_name) \
        xact_event_pool = xact.get_event_pool(); \
        xact_ev = xact_event_pool.get(event_name); \
        xact_ev.wait_trigger(); 

typedef class svt_axi_master_agent;
`ifndef SVT_EXCLUDE_VCAP
typedef class svt_axi_traffic_profile_transaction;
typedef class svt_axi_master_traffic_profile_sequencer;
typedef class svt_axi_traffic_profile_callback;
`endif

// =============================================================================
/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not. All other master sequences
 * in the collection extend from this base sequence.
 */
class svt_axi_master_base_sequence extends svt_sequence #(`SVT_AXI_MASTER_TRANSACTION_TYPE);
  
  /**
   * Following are the possible transaction types:
   * - WRITE    : Represent a WRITE transaction. 
   * - READ     : Represents a READ transaction.
   * - COHERENT : Represents a COHERENT transaction.
   * .
   *
   * Please note that WRITE and READ transaction type is valid for
   * #svt_axi_port_configuration::axi_interface_type is AXI3/AXI4/AXI4_LITE and
   * COHERENT transaction type is valid for
   * #svt_axi_port_configuration::axi_interface_type is AXI_ACE.
   */
  rand svt_axi_transaction::xact_type_enum _read_xact_type,_write_xact_type;

  /* Port configuration obtained from the sequencer */
  svt_axi_port_configuration cfg;

  /* Port id of a master to be used for address reterival */
  int mstr_num;

  /* This bit indicates whether the cfg is received from the sequencer or not.
   *  This is used by the sequence for maitaining the infrastructure, and should
   *  not be programmed by user.
  */
  protected string sequence_setup_done_method="";

  svt_axi_transaction actv_txn_q[$];
  semaphore sema_actv_txn_q = new(1);

  `svt_xvm_object_utils(svt_axi_master_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  extern function new(string name="svt_axi_master_base_sequence");

  /** 
   * Routes messages through the parent sequencer and raises an objection and gets
   * the sequencer configuration. 
   */
  virtual function void get_sequence_initial_setup(string initiator="");
`protected
HHP/3&PMXBTcCc&GU^eCV=cH=]R\JT:gT0S]OX&d#HN/fPV?Z/PU6)J/2f@,Q@Ug
/d>Od-e.T[efHK>RG[,;a:YPUcXR\_MR,T-,7]a2VR:K>MBQA_T/LbDCeDXGH\64
+G=UB;Y5<&(116fFWH0^PEPEE&d[g[cF/CP,UH_GbTd+U3F4Z]fL;>+?V4e:4?,,
aQJ4dCPFFW-97@dd(IK;BcU:JMfZ:gB7P3352./QF<gf;A#SJRa_bO&50gQB9<M<
;=D#M1#L>78L@Ra8CIJN0B]7b?908D2\K@&]5_GaaI;>Re;R+):PP6;3Aa_a4I+0
^0KFdUE4^4/_\SU5eKZ;PW&5WgF^\]39O?GZXWKg>+18.:.J-K?T5USBaS@K,)AB
QW6IX8I?I)80T;.bFKS)-M^g?1@a9.3]5>O_B-@68.AFY9MMK_cAL)>#a]DaV\Y_
Z5IWB)_c1^NeD9S4:;2A.5+MV#R;=J=K4I0(e(R984ZO4.:d86?OFU9=/ZBQ:a@F
JP_E6@W\Xb>;5K:WI?CO<6U3Uc53BT1HJT)D+ZeMGHbAH<C[5S1Rc.EMC:4B1VD+
C-51[S;Xe1U1-:e[5L:15HWF_S-cW5]g-a1#4g[,I>]I<\ME:^(gJL,DRCU1eZ;(
UFY5<Xe;-RJ+8]>-DG)74:&9QGI,H5MfJ=K3>8bJ6QE<W0[dc=X/S#3+E7)_)f5T
Ye=@A?4\gF:@3CQ^)YbB?Hd3)Mb07#aJW]0@)Q=(cKGF&]HKK+L?],GYcCg/d^_c
a>TQ-[=-CC\@/$
`endprotected

 endfunction:get_sequence_initial_setup

  /** Calls a method to route messages through the parent sequencer and raise an objection and get cfg */
  virtual task pre_body();
   `svt_xvm_debug("svt_axi_master_base_sequence::pre_body()","Entered ...")   
    get_sequence_initial_setup("pre_body");
   `svt_xvm_debug("svt_axi_master_base_sequence::pre_body()","Exiting ...")   
  endtask

  /** Calls a method to route messages through the parent sequencer and raise an objection and get cfg */
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task pre_start();
   `svt_xvm_debug("svt_axi_master_base_sequence::pre_start()","Entered ...")   
    get_sequence_initial_setup("pre_start");
    
    if ((cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) || (cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) begin
      _read_xact_type  = svt_axi_transaction::COHERENT;
      _write_xact_type = svt_axi_transaction::COHERENT;
    end
    else begin
      _read_xact_type  = svt_axi_transaction::READ;
      _write_xact_type = svt_axi_transaction::WRITE;
    end
   `svt_xvm_debug("svt_axi_master_base_sequence::pre_start()","Exiting ...")   
  endtask
`endif

  virtual task body();
  endtask: body

  virtual task manage_active_txn_q(svt_axi_transaction req);
    int _index[$];

    sema_actv_txn_q.get();
    actv_txn_q.push_back(req);
    sema_actv_txn_q.put();

    fork begin
      if(req.xact_type == svt_axi_transaction::READ)
         wait(req.data_status == svt_axi_transaction::ACCEPT ||
              req.data_status == svt_axi_transaction::ABORTED );
      else if(req.xact_type == svt_axi_transaction::WRITE)
         wait(req.write_resp_status == svt_axi_transaction::ACCEPT ||
              req.write_resp_status == svt_axi_transaction::ABORTED );

      sema_actv_txn_q.get();
      _index = actv_txn_q.find_index() with (item == req);
      if(_index.size() > 0)
         actv_txn_q.delete(_index[0]);
      sema_actv_txn_q.put();
    end
    join_none
  endtask: manage_active_txn_q

  /** Drop objection */
  virtual task post_body();
    if (sequence_setup_done_method == "pre_body") begin
       drop_phase_objection();
       `svt_amba_debug("post_start", {sequence_setup_done_method, " dropping objection..."});
    end
  endtask: post_body

  /** dropped objection at post_start because if post_body is not called for sub-sequence from virtual sequence
    * objection raised from pre_start will get dropped by post_start
    */
`ifdef SVT_UVM_TECHNOLOGY 
  virtual task post_start();
    if (sequence_setup_done_method == "pre_start") begin
       drop_phase_objection();
       `svt_amba_debug("post_start", {sequence_setup_done_method, " dropping objection..."});
    end
  endtask
`endif

  /* adjusts delay constraint weightage based on delay value */
  virtual function void set_delay_wt(ref int dly, `SVT_AXI_MASTER_TRANSACTION_TYPE txn);

    if(dly > `SVT_AXI_MAX_WREADY_DELAY) 
       dly = `SVT_AXI_MAX_WREADY_DELAY;

    if(dly == 0) begin
       if(txn.ZERO_DELAY_wt == 0) txn.ZERO_DELAY_wt = 1;
       txn.SHORT_DELAY_wt = 0;
         txn.LONG_DELAY_wt = 0;
    end
    else if(dly inside {[1:(`SVT_AXI_MAX_WREADY_DELAY >> 2)]}) begin
       if(txn.SHORT_DELAY_wt == 0) txn.SHORT_DELAY_wt = 1;
       txn.ZERO_DELAY_wt = 0;
       txn.LONG_DELAY_wt = 0;
    end
    else begin
       if(txn.LONG_DELAY_wt == 0) txn.LONG_DELAY_wt = 1;
       txn.SHORT_DELAY_wt = 0;
       txn.ZERO_DELAY_wt = 0;
    end
  endfunction
  
  /** Function returns queue of addr which are non overlapping */ 
  function void get_nonoverlap_addr(ref `SVT_AXI_MASTER_TRANSACTION_TYPE addr_collection_q[$],int num_of_addr,svt_axi_system_configuration sys_cfg,int slv,int mstr);
 
  /** Handle of master transaction */
  `SVT_AXI_MASTER_TRANSACTION_TYPE xact_temp;
  /** local variable */
  bit randomize_again;
  int randomize;

    /** Randomizing the address for non overlapping address*/
    for(int i=0;i<(num_of_addr * 20);i++) begin
      bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
      bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
      /** Randomly select an Address range for selected slave */
      if (!sys_cfg.get_slave_addr_range(mstr_num,slv, lo_addr, hi_addr,null))
        `svt_xvm_warning("get_nonoverlap_addr", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv));

      /** Set up the write transaction  */
      `svt_xvm_create(xact_temp)

      if(xact_temp.randomize()with 
      {
        addr >= lo_addr;
        addr <= hi_addr-((1<<burst_size)*burst_length);
        burst_type inside {svt_axi_transaction::INCR, svt_axi_transaction::WRAP};
      })  
      randomize_again=0;
      foreach(addr_collection_q[j]) begin 
        randomize_again = addr_collection_q[j].is_address_overlap(xact_temp.get_tagged_addr(),xact_temp.get_max_byte_address(xact_temp.addr));
        if (randomize_again)
          break;
        end    
        if(!randomize_again) begin
          addr_collection_q.push_back(xact_temp);
        if(addr_collection_q.size()== num_of_addr)
          break; 
        end
    end //for randomizing address
    if(addr_collection_q.size() != num_of_addr)  begin
      `svt_xvm_error("get_nonoverlap_addr function",$sformatf("Unable to get the required number of non overlap addresses")); 
    end
  endfunction:get_nonoverlap_addr

  /** Function returns id width for write channel */
  function int get_wr_chan_id_width(svt_axi_port_configuration port_cfg);
    if(port_cfg.use_separate_rd_wr_chan_id_width == 0) begin
      return port_cfg.id_width;
    end
    else begin
      return port_cfg.write_chan_id_width ;
    end
  endfunction : get_wr_chan_id_width

  function int get_rd_chan_id_width(svt_axi_port_configuration port_cfg);
    if(port_cfg.use_separate_rd_wr_chan_id_width == 0 ) begin
      return port_cfg.id_width;
    end
    else 
      return port_cfg.read_chan_id_width;
  endfunction : get_rd_chan_id_width

endclass: svt_axi_master_base_sequence

// =============================================================================
/** 
 *  This sequence generates a single random write transaction.
 */
class svt_axi_master_write_xact_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)
  `svt_xvm_object_utils(svt_axi_master_write_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Address to be written */
  rand bit [`SVT_AXI_MAX_DATA_WIDTH-1 : 0] data;

  svt_axi_transaction::atomic_type_enum atomic_type = svt_axi_transaction::NORMAL;

  function new(string name="svt_axi_master_write_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    super.body();

    `svt_xvm_do_with(req, {
      xact_type == svt_axi_transaction::WRITE;
      addr == local::addr;
`ifndef INCA
      data.size() == 1;
`else
      req.data.size() == 1;
`endif
      data[0] == local::data;
      atomic_type == local::atomic_type;
      burst_length == 1;
    })

    get_response(rsp);
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_axi_master_write_xact_sequence

// =============================================================================
/** 
 *  This sequence generates a single random read transaction.
 */
class svt_axi_master_read_xact_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)
  `svt_xvm_object_utils(svt_axi_master_read_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Expected data. This is used to check the return value. */
  bit [`SVT_AXI_MAX_DATA_WIDTH-1 : 0] exp_data;

  /** Enable the check of the expected data. */
  bit check_enable = 1;

  svt_axi_transaction::atomic_type_enum atomic_type = svt_axi_transaction::NORMAL;

  function new(string name="svt_axi_master_read_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    super.body();

    `svt_xvm_do_with(req, {
      xact_type == svt_axi_transaction::READ;
      addr == local::addr;
      atomic_type == local::atomic_type;
      burst_length == 1;
    })

    get_response(rsp);

    // Check the read data
    if (check_enable) begin
      if (rsp.data.size() != 1) begin
        `svt_xvm_error("body", $sformatf("Unexpected number of data for read to addr=%x.  Expected 1, recreived %0d", addr, rsp.data.size()));
      end
      else if (rsp.data[0] != exp_data) begin
        `svt_xvm_error("body", $sformatf("Data mismatch for read to addr=%x.  Expected %x, received %x", addr, exp_data, rsp.data[0]));
      end
    end

  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_axi_master_read_xact_sequence

// =============================================================================
/** 
 *  This sequence generates a single random ACE write transaction.
 */
class svt_axi_ace_master_write_xact_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)
  `svt_xvm_object_utils(svt_axi_ace_master_write_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Data to be written */
  rand bit [`SVT_AXI_MAX_DATA_WIDTH-1 : 0] data;

  svt_axi_transaction::atomic_type_enum atomic_type = svt_axi_transaction::NORMAL;

  function new(string name="svt_axi_ace_master_write_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    super.body();

    `svt_xvm_do_with(req, {
      xact_type == svt_axi_transaction::COHERENT;
      coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
      addr == local::addr;
`ifndef INCA
      data.size() == 1;
`else
      req.data.size() == 1;
`endif
      data[0] == local::data;
      atomic_type == local::atomic_type;
      burst_length == 1;
    })

    get_response(rsp);
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_axi_ace_master_write_xact_sequence

// =============================================================================
/** 
 *  This sequence generates a single random ACE read transaction.
 */
class svt_axi_ace_master_read_xact_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)
  `svt_xvm_object_utils(svt_axi_ace_master_read_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Expected data. This is used to check the return value. */
  bit [`SVT_AXI_MAX_DATA_WIDTH-1 : 0] exp_data;

  /** Enable the check of the expected data. */
  bit check_enable = 1;

  svt_axi_transaction::atomic_type_enum atomic_type = svt_axi_transaction::NORMAL;

  function new(string name="svt_axi_ace_master_read_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    super.body();

    `svt_xvm_do_with(req, {
      xact_type == svt_axi_transaction::COHERENT;
      coherent_xact_type == svt_axi_transaction::READNOSNOOP;
      addr == local::addr;
      atomic_type == local::atomic_type;
      burst_length == 1;
    })

    get_response(rsp);

    // Check the read data
    if (check_enable) begin
      // Check the read data
      if (rsp.data.size() != 1) begin
        `svt_xvm_error("body", $sformatf("Unexpected number of data for read to addr=%x.  Expected 1, recreived %0d", addr, rsp.data.size()));
      end
      else if (rsp.data[0] != exp_data) begin
        `svt_xvm_error("body", $sformatf("Data mismatch for read to addr=%x.  Expected %x, received %x", addr, exp_data, rsp.data[0]));
      end
    end

  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_axi_ace_master_read_xact_sequence

// =============================================================================
/** 
 *  This sequence generates random master transactions.
 */
class svt_axi_master_random_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_random_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_random_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    for (int i=0; i < sequence_length; i++) begin
       `svt_xvm_do_with(req,
          { 
            req.atomic_type == svt_axi_transaction::NORMAL;
            `ifdef SVT_AXI_QVN_ENABLE
            foreach(actv_txn_q[ix])
              if(actv_txn_q[ix].qvn_vnet_id != req.qvn_vnet_id)
                 actv_txn_q[ix].id != req.id;
            `endif
          })
       manage_active_txn_q(req);
    end

  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_axi_master_random_sequence

// =============================================================================
/**
 * This sequence generates a random sequences of write transaction or 
 * of read transaction. All other transaction fields are randomized.
 */
class svt_axi_random_sequence extends svt_axi_master_base_sequence;
 
`ifdef SVT_MULTI_SIM_ENUM_SCOPE
  // Property needed because MTI 10.0a can't seem to find enums defined in a class
  // scope unless that class is declared somewhere in that file or an included file.
  svt_axi_transaction base_xact;
`endif
 
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Customize the sequence for performance measurements */
  int unsigned enable_perf_mode = 0;
 
  /** Enable outstanding transactions */
  int unsigned enable_outstanding_xacts = 0;

  /** FIXED burst type weight. */
  int unsigned FIXED_burst_type_wt = 0;

  /** INCR burst type weight. */
  int unsigned INCR_burst_type_wt = 10;

  /** WRAP burst type weight. */
  int unsigned WRAP_burst_type_wt = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }
 
  /* Local variables. */
  bit wr_rd;
  rand int slv_num;
  rand int xact_length;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
  `ifndef __SVDOC__
  rand enum {WRITE, READ, RANDOM } xact_type;
  `endif
  
  /** Constrain the transaction length to a reasonable value */
  constraint reasonable_xact_length {
    xact_length  inside{0,10};
  }
  
  /** Class Constructor */
  function new(string name="svt_axi_random_sequence");
    super.new(name);
  endfunction
  
  `svt_xvm_object_utils_begin(svt_axi_random_sequence)
    `svt_xvm_field_int(FIXED_burst_type_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(INCR_burst_type_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(WRAP_burst_type_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  /** UVM sequence body task */ 
  virtual task body();
    bit status_perf_mode, status_enable_outstanding_xacts;
    bit status_FIXED_burst_type_wt;
    bit status_INCR_burst_type_wt;
    bit status_WRAP_burst_type_wt;
    /** Handles for configurations. */
    svt_configuration get_cfg;
    svt_axi_port_configuration port_cfg;
    svt_axi_transaction::burst_size_enum _burst_size;
    svt_axi_transaction::xact_type_enum _xact_type;    
   
    super.body();
   
`ifdef SVT_UVM_TECHNOLOGY
    void'(uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length));
    status_FIXED_burst_type_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "FIXED_burst_type_wt", FIXED_burst_type_wt);
    status_INCR_burst_type_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "INCR_burst_type_wt", INCR_burst_type_wt);
    status_WRAP_burst_type_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "WRAP_burst_type_wt", WRAP_burst_type_wt);
    status_perf_mode = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "enable_perf_mode", enable_perf_mode);
    status_enable_outstanding_xacts = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "enable_outstanding_xacts", enable_outstanding_xacts);
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), ".sequence_length"},  sequence_length));
    status_perf_mode = m_sequencer.get_config_int({get_type_name(), ".enable_perf_mode"},  enable_perf_mode);
    status_enable_outstanding_xacts = m_sequencer.get_config_int({get_type_name(), ".enable_outstanding_xacts"},  enable_outstanding_xacts);
    status_FIXED_burst_type_wt = m_sequencer.get_config_int({get_type_name(), ".FIXED_burst_type_wt"},  FIXED_burst_type_wt);
    status_INCR_burst_type_wt = m_sequencer.get_config_int({get_type_name(), ".INCR_burst_type_wt"},  INCR_burst_type_wt);
    status_WRAP_burst_type_wt = m_sequencer.get_config_int({get_type_name(), ".WRAP_burst_type_wt"},  WRAP_burst_type_wt);
`endif

    `svt_xvm_debug("body", $sformatf("sequence_length='d%0d", sequence_length));
    `svt_xvm_debug("body", $sformatf("enable_perf_mode is 'd%0d as a result of %0s.", enable_perf_mode, status_perf_mode ? "the config DB" : "the default value"));    
    `svt_xvm_debug("body", $sformatf("enable_outstanding_xacts is 'd%0d as a result of %0s.", enable_outstanding_xacts, status_enable_outstanding_xacts ? "the config DB" : "the default value"));    
    `svt_xvm_debug("body", $sformatf("FIXED_burst_type_wt is 'd%0d as a result of %0s.", FIXED_burst_type_wt, status_FIXED_burst_type_wt ? "the config DB" : "the default value"));    
    `svt_xvm_debug("body", $sformatf("INCR_burst_type_wt is 'd%0d as a result of %0s.", INCR_burst_type_wt, status_INCR_burst_type_wt ? "the config DB" : "the default value"));    
    `svt_xvm_debug("body", $sformatf("WRAP_burst_type_wt is 'd%0d as a result of %0s.", WRAP_burst_type_wt, status_WRAP_burst_type_wt ? "the config DB" : "the default value"));    
   
    /** Getting svt_axi_port_configuration object handle. */ 
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(port_cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
    end

    if (!cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num, lo_addr,hi_addr,null))
      `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));
 
    /** Execute the transactions in selected Slave from selected Master. */
    for (int i=0; i < xact_length; i++) begin
      if (enable_perf_mode) begin
         `protected
2aD\DP6Z1g<N(H.OTCM_f(Rg0D6P,IU3PPSKWT+7/T<I0VCHIA+^0)W@OB2e983O
RGS]UJ/=e9:I<&ZG3NR-V/FQHZ\1)T,]LZD_K59Q;f-A8S2#J>_S)23U3JbOK,4#
]NJFJWST/PMfJ4LRFTYKL,79ZPBEXXC>bQF+C9Pb)9c8KC_([-_KbA?4cS#UYcDL
A^)?G_/=(+[<J.+OM;4EBfU8S?L/R)P^B=1O1fg#[KD7c78Wd0gaBS?4P$
`endprotected

         if ((cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) || (cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) begin
           _xact_type = svt_axi_transaction::COHERENT;
         end
         else begin
           if (i%2 == 0 ) 
             _xact_type = svt_axi_transaction::WRITE;
           else 
             _xact_type = svt_axi_transaction::READ;
         end
      end else begin
        case(xact_type) 
         WRITE:  wr_rd = 0;
         READ:   wr_rd = 1;
         RANDOM: wr_rd = $urandom_range(0,1);
        endcase 
      end
      `svt_xvm_do_with(req,{
          if (!enable_perf_mode){
            if(local::wr_rd == 0)
              {xact_type           == _write_xact_type;
               coherent_xact_type  == svt_axi_transaction::WRITENOSNOOP;
               if(data_before_addr == 1){ 
                 reference_event_for_addr_valid_delay inside {svt_axi_transaction::FIRST_WVALID_DATA_BEFORE_ADDR ,svt_axi_transaction::FIRST_DATA_HANDSHAKE_DATA_BEFORE_ADDR};
                 addr_valid_delay  >  0;}
              }
            else  
              {xact_type           == _read_xact_type;
               coherent_xact_type  == svt_axi_transaction::READNOSNOOP;
              }
            atomic_type         == svt_axi_transaction::NORMAL;
            addr >  lo_addr;
            addr <= hi_addr-((1<<burst_size)*burst_length);
            if(atomic_type  == svt_axi_transaction::EXCLUSIVE)
              cache_type == 2;
        } else {
          burst_length == 16;
          atomic_type == svt_axi_transaction::NORMAL;
          burst_size == _burst_size;
          burst_type dist {svt_axi_transaction::INCR:=INCR_burst_type_wt,
                           svt_axi_transaction::FIXED:=FIXED_burst_type_wt,
                           svt_axi_transaction::WRAP:=WRAP_burst_type_wt};          
          xact_type == _xact_type;          
          addr_valid_delay == 0;
          foreach(wvalid_delay[idx])    
            wvalid_delay[idx]  == 0;
          bready_delay  == 0;
          foreach(rready_delay[idx])
            rready_delay[idx] == 0;
        }
      })

      // Wait for transaction to end based on 
      // enable_outstanding_xacts value
      if (!enable_outstanding_xacts)
        wait (`SVT_AXI_XACT_STATUS_ENDED(req));
    end
  endtask: body
endclass: svt_axi_random_sequence

// =============================================================================
/**
 * This sequence generates a Write transactions with overlapping addr/non overlapping
 * addr/random addr to the same slave. Remaining fields
 * are randomized.
 */
class svt_axi_write_same_slave_sequence extends svt_axi_master_base_sequence;

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_write_same_slave_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_write_same_slave_sequence)
`endif
`ifdef SVT_MULTI_SIM_ENUM_SCOPE
  // Property needed because MTI 10.0a can't seem to find enums defined in a class
  // scope unless that class is declared somewhere in that file or an included file.
  svt_axi_transaction base_xact;
`endif
 
  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;
     
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
  /** Local variable */
  bit status;
  /** Number of Write transaction in used to constrain it in sub-sequences  */
  rand int num_of_wr_xact ;
  rand enum { SAME,DIFF,RANDOM,SET_OF_SEQ_ID,SET_OF_REPT_ID,SET_OF_SAME_ID,WR_RD_SAME_ID,RD_WR_CHAN_MIN_ID } id;
  /** Write ID width  */
  int wr_id_width;
  int id_q[$];
  int id_q_size;
  int min_id_width;
  rand int min_id;
  rand bit [`SVT_AXI_MAX_ID_WIDTH-1:0] wr_id;
  /** Slave number used to constrain it */
  rand int slv_num; 
  /** Enum for Non overlapping addr,Overlapping addr,Random addr used to constrain */
  rand enum { NON_OVERLAP_ADDR,OVERLAP_ADDR,RANDOM_ADDR } address; 
  /** Memory type used to constrain for Device memory and Normal memory*/
  rand enum { DEVICE,NORMAL } memory_type;
  rand enum {RANDOM_INTERLEAVE,EQUAL_INTERLEAVE} interleave;
  /** Number of address for non overlapping address */
  int num_of_addr;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
  `SVT_AXI_MASTER_TRANSACTION_TYPE addr_collection_q[$],nonoverlap_addr;
  
  /** Write transaction request handles */
  `SVT_AXI_MASTER_TRANSACTION_TYPE wr_xact_req[];

  /** Class Constructor */
  function new(string name="svt_axi_write_same_slave_sequence");
    super.new(name);
  endfunction

  /** Handles for configurations. */
  svt_configuration get_cfg;
  svt_axi_port_configuration port_cfg;
  
  /** UVM sequence body task */ 
  virtual task body();
    
    super.body();
    /** Creating object for write transaction request handles */
    wr_xact_req = new[num_of_wr_xact];
    /** Get the number of address*/
    num_of_addr = num_of_wr_xact;

`ifdef SVT_UVM_TECHNOLOGY
    void'(uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length));
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), ".sequence_length"},  sequence_length));
`endif

    `svt_xvm_debug("body", $sformatf("sequence_length='d%0d", sequence_length));

    /** Getting svt_axi_port_configuration object handle. */ 
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(port_cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
    end
 
    /** Getting non-overlap address through the function inside Master base sequence */     
    get_nonoverlap_addr(addr_collection_q,num_of_addr,cfg.sys_cfg,slv_num,mstr_num);

    /** Generating random id within the range of id_width */
    if(id == SAME ) begin
      wr_id_width  = get_wr_chan_id_width(cfg);
      wr_id        = wr_id & ((1 <<wr_id_width)-1);
    end
    else if (id == DIFF) begin
      /** Generating different id within the range of id_width */
      for(int i= 0;i <= (1<<get_wr_chan_id_width(cfg)-1); i++)  begin
        id_q.push_back(i);
      end
      id_q.shuffle; 
    end
    else if(id == SET_OF_SEQ_ID)begin
      for(int i= 0;i <= (1<<min_id-1); i++) begin
      id_q.push_back(i);
      end
    end
    else if(id == SET_OF_REPT_ID)begin
      for(int i= 0;i <= (1<<min_id-1); i++) begin
        if(i%2 == 0)
          id_q.push_back(min_id);
        else
          id_q.push_back(min_id>>1);
      end
    end
    else if(id == SET_OF_SAME_ID)begin
      id_q.push_back(min_id);
    end
    else if (id == WR_RD_SAME_ID) begin
      if (port_cfg.use_separate_rd_wr_chan_id_width == 1)  begin
        if (port_cfg.write_chan_id_width < port_cfg.read_chan_id_width) begin
          min_id_width = port_cfg.write_chan_id_width;
        end 
        else begin
          min_id_width = port_cfg.read_chan_id_width;
        end
        wr_id = wr_id & ((1 <<min_id_width)-1);
      end
      else begin  
        wr_id_width  = get_wr_chan_id_width(cfg);
        wr_id        = wr_id & ((1 <<wr_id_width)-1);
      end
    end
    else if (id == RD_WR_CHAN_MIN_ID) begin
      if (port_cfg.use_separate_rd_wr_chan_id_width == 1)  begin
        if (port_cfg.write_chan_id_width < port_cfg.read_chan_id_width) begin
          min_id_width = port_cfg.write_chan_id_width;
        end 
        else begin
          min_id_width = port_cfg.read_chan_id_width;
        end
        /** Generating different id within the range of id_width */
        for(int i= 0;i <= (1<<min_id_width-1); i++)  begin
          id_q.push_back(i);
        end
        id_q.shuffle;
      end  
      else begin
        for(int i= 0;i <= (1<<get_wr_chan_id_width(cfg)-1); i++)  begin
          id_q.push_back(i);
        end
        id_q.shuffle;
      end
    end  

    id_q_size=id_q.size(); 
    if (!cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num,lo_addr,hi_addr,null))
      `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));

    /** Execute Write transactions with different address/overlapping address/non overlapping address */
    for (int wr=0;wr<num_of_wr_xact;wr++) begin
      nonoverlap_addr = addr_collection_q.pop_front();
      `svt_xvm_do_with(wr_xact_req[wr],{
        /** 
         * Randomizing addr for Write transaction.
         * Randomizing Burst_length,burst_size for
         * Write transaction.
         */
        if (local::address == NON_OVERLAP_ADDR)  
          {
            addr         == local::nonoverlap_addr.addr;
            burst_length == local::nonoverlap_addr.burst_length;
            burst_size   == local::nonoverlap_addr.burst_size;
            burst_type   == local::nonoverlap_addr.burst_type;
          }  
        else if (((local::address == OVERLAP_ADDR)  && (local::wr == 0)) || (local::address == RANDOM_ADDR)) 
          { 
            addr   >= lo_addr;
            addr   <= hi_addr-(burst_length*(1<<burst_size));
          }
        else if (local::address == OVERLAP_ADDR) 
          {
            addr   >= local::wr_xact_req[wr-1].addr;
            addr   <= (local::wr_xact_req[wr-1].addr)+(wr_xact_req[wr-1].burst_length*(1<<wr_xact_req[wr-1].burst_size));
            addr   <= hi_addr-(burst_length*(1<<burst_size));
          }
        xact_type          == _write_xact_type;
        coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
        atomic_type        == svt_axi_transaction::NORMAL;   
        if (local::id == SAME || local::id == WR_RD_SAME_ID)
          {
            id == wr_id;
          } 
        else if (local::id == DIFF)
          {
            id == id_q[wr%id_q_size];  
          }
        else if (local::id == SET_OF_SEQ_ID)
          {
            id == id_q[wr%id_q_size];  
          }
        else if (local::id == SET_OF_REPT_ID)
          {
            id == id_q[wr%id_q_size];  
          }
        else if(local::id == SET_OF_SAME_ID) 
          {
            id == id_q[0];  
          }
        else if (local::id == RD_WR_CHAN_MIN_ID) 
          {  
            id == id_q[wr];
          }  
        burst_type         inside {svt_axi_transaction::INCR, svt_axi_transaction::WRAP};
        reference_event_for_addr_valid_delay ==  svt_axi_transaction::PREV_ADDR_HANDSHAKE;
        if (local::interleave == RANDOM_INTERLEAVE )
          {
            interleave_pattern == RANDOM_BLOCK;
          }
        addr_valid_delay   == 0;
        data_before_addr   == 0;
`ifndef SVT_AXI_MULTI_SIM_OVERLAP_ADDR_ISSUE 
        check_addr_overlap == 0;
`endif
        if (local::memory_type == DEVICE)
          {  
            /** The cache_type must be a Device Memory (Bufferable or Non-Bufferable) */
            cache_type         inside {0,1};
          }
        else 
          {
            /** The cache_type must be a Normal Memory  */
            cache_type         inside {4'b0010,4'b0011,4'b0110,4'b1110,4'b1010,4'b0111,4'b1111,4'b1011};
          }
      })
      `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[wr]), "Sending Write transaction"});
      `svt_xvm_debug("body",$sformatf("wr_xact_req has  \n\
                                                Number of wr : 'd%0d \n\
                                                ID value : 'd%0d \n\
                                                Size of id_q : 'd%0d \n\
                                                Total number of write transactions : 'd%0d \n\ " ,wr,(id_q_size==0)? 0:id_q[wr%id_q_size],id_q_size,num_of_wr_xact )); 
    end
    id_q.delete();
  endtask
endclass: svt_axi_write_same_slave_sequence

// =============================================================================
/**
 * This sequence generates a Read transactions with overlapping addr/non overlapping
 * addr/random addr to the same slave. Remaining fields are randomized.
 * It generates the write followed by read transaction and waiting for write transaction
 * to complete,then execute the read transaction with same write transaction accessing address.
 */
class svt_axi_read_same_slave_sequence extends svt_axi_master_base_sequence;

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(svt_axi_read_same_slave_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(svt_axi_read_same_slave_sequence)
`endif
`ifdef SVT_MULTI_SIM_ENUM_SCOPE
  // Property needed because MTI 10.0a can't seem to find enums defined in a class
  // scope unless that class is declared somewhere in that file or an included file.
  svt_axi_transaction base_xact;
`endif
 
  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;
     
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 50;
  }
 
  /** Local variable */
  bit status;
  /** Number of transaction used to constrain in sub-sequences */
  rand int xact_length;
  /** Id used to constrain */
  rand enum { SAME,DIFF,RANDOM,SET_OF_SAME_ID,RD_WR_CHAN_MIN_ID } id;
  /** Read Id width */
  rand int min_id;
  int min_id_width;
  int rd_id_width;
  int id_arr[$];
  rand bit [`SVT_AXI_MAX_ID_WIDTH-1:0] rd_id;
  /** Slave number used to constrain */
  rand int slv_num;
  /** Address used to constrain */
  rand enum { NON_OVERLAP_ADDR,OVERLAP_ADDR,RANDOM_ADDR } address; 
  /** Memory type used to constrain for Device memory and Normal memory*/
  rand enum { DEVICE,NORMAL } memory_type;
  /** Write before read used to constrain */
  rand bit do_write_before_read;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;

  /** Write transaction request handles */
  `SVT_AXI_MASTER_TRANSACTION_TYPE wr_xact_req[];
  /** Read transaction request handles */
  `SVT_AXI_MASTER_TRANSACTION_TYPE rd_xact_req[];
  
  /** Class Constructor */
  function new(string name="svt_axi_read_same_slave_sequence");
    super.new(name);
  endfunction
  
  /** UVM sequence body task */ 
  virtual task body();
    
    /** Handles for configurations. */
    svt_configuration get_cfg;
    svt_axi_port_configuration port_cfg;
   
    super.body();
    /** Creating object for Write and Read transaction request handle */
    rd_xact_req = new[xact_length];
    wr_xact_req = new[xact_length];

`ifdef SVT_UVM_TECHNOLOGY
    void'(uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length));
`elsif SVT_OVM_TECHNOLOGY
    void'(m_sequencer.get_config_int({get_type_name(), ".sequence_length"},  sequence_length));
`endif

    `svt_xvm_debug("body", $sformatf("sequence_length='d%0d", sequence_length));
   
    /** Getting svt_axi_port_configuration object handle. */ 
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(port_cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
    end

    /** Generating random id within the range of id_width */
    if(id == SAME ) begin
      rd_id_width  = get_rd_chan_id_width(cfg);
      rd_id        = rd_id & ((1 << rd_id_width)-1);
    end
    else if (id == DIFF) begin
      /** Generating different id within the range of id_width */
      for(int i= 0;i <= (1<<get_rd_chan_id_width(cfg)-1); i++)  begin
        id_arr.push_back(i);
      end
      id_arr.shuffle;
    end
    else if (id == SET_OF_SAME_ID) begin
      id_arr.push_back(min_id);
    end
    else if (id == RD_WR_CHAN_MIN_ID) begin
      if (port_cfg.use_separate_rd_wr_chan_id_width == 1)  begin
        if (port_cfg.write_chan_id_width < port_cfg.read_chan_id_width) begin
          min_id_width = port_cfg.write_chan_id_width;
        end 
        else begin
          min_id_width = port_cfg.read_chan_id_width;
        end
        /** Generating different id within the range of id_width */
        for(int i= 0;i <= (1<<min_id_width-1); i++)  begin
          id_arr.push_back(i);
        end
        id_arr.shuffle;
      end  
      else begin
        for(int i= 0;i <= (1<<get_rd_chan_id_width(cfg)-1); i++)  begin
          id_arr.push_back(i);
        end
        id_arr.shuffle;
      end
    end  

    if (!cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num, lo_addr,hi_addr,null))
      `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));

    /** 
     * Execute the write transaction followed by read transaction to same slave and 
     * waiting for write transaction to complete.Execute Read transaction
     * with Write transation accessing address,burst_type,burst_length and burst_size. 
     */
    if (do_write_before_read == 1) begin
      for (int wr=0;wr<xact_length;wr++) begin
        `svt_xvm_do_with(wr_xact_req[wr],{
          /** 
           * Randomizing addr,burst_length,burst_size,data and id fields for 
           * Write transaction.
           */
          addr               >= lo_addr;
          addr               <= hi_addr-(burst_length*(1<<burst_size));
          xact_type          == _write_xact_type;
          coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
          atomic_type        == svt_axi_transaction::NORMAL; 
          burst_type         inside {svt_axi_transaction::INCR, svt_axi_transaction::WRAP};
          reference_event_for_addr_valid_delay ==  svt_axi_transaction ::PREV_ADDR_HANDSHAKE;
          addr_valid_delay   == 0;
          data_before_addr   == 0;
          if (local::memory_type == DEVICE)
            {  
              /** The cache_type must be a Device Memory (Bufferable or Non-Bufferable) */
              cache_type         inside {0,1};
            }
          else 
            {
              /** The cache_type must be a Normal Memory  */
              cache_type         inside {4'b0010,4'b0011,4'b0110,4'b1110,4'b1010,4'b0111,4'b1111,4'b1011};
            }
        })
      end
      for (int wr=0;wr<xact_length;wr++) begin
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[wr]), "Waiting for transaction to end"});
        /** Waiting for above Write transaction to complete */
        wait (`SVT_AXI_XACT_STATUS_ENDED(wr_xact_req[wr]));
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(wr_xact_req[wr]), "Transaction is now ended"});
      end 
      /** 
       * Execute the Read transaction with 1st Write transaction accessing Address and 
       * 2nd Write transaction accessing Address with same id to make sure the Read transaction's  
       * data in order. 
       */
      for (int rd=0;rd<xact_length;rd++) begin
        `svt_xvm_do_with(rd_xact_req[rd],{ 
          addr               == local::wr_xact_req[rd].addr;
          xact_type          == _read_xact_type;
          coherent_xact_type == svt_axi_transaction::READNOSNOOP;
          if (local::id == SAME)
            {
              id == rd_id;
            } 
          else if (local::id == DIFF)
            {
              id == id_arr[rd];  
            }
          burst_type         == local::wr_xact_req[rd].burst_type;
          burst_size         == local::wr_xact_req[rd].burst_size;
          burst_length       == local::wr_xact_req[rd].burst_length;
          reference_event_for_addr_valid_delay ==  svt_axi_transaction ::PREV_ADDR_HANDSHAKE;
          addr_valid_delay   == 0;
          data_before_addr   == 0;
          if (local::memory_type == DEVICE)
            {  
              /** The cache_type must be a Device Memory (Bufferable or Non-Bufferable) */
              cache_type         inside {0,1};
            }
          else 
            {
              /** The cache_type must be a Normal Memory  */
              cache_type         inside {4'b0010,4'b0011,4'b0110,4'b1110,4'b1010,4'b0111,4'b1111,4'b1011};
            }
        })
      end 
      for (int rd=0;rd<xact_length;rd++) begin
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd]), "Waiting for transaction to end"});
        /** Waiting for above Read transaction to complete */
        wait (`SVT_AXI_XACT_STATUS_ENDED(rd_xact_req[rd]));
        `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(rd_xact_req[rd]), "Transaction is now ended"});
      end
    end //begin  
    else  begin
      /** 
       * Execute  Read transaction with overlap/non overlap address/random address  
       * and Remaining fields are randomized.
       */
      for (int rd=0;rd<xact_length;rd++) begin
        `svt_xvm_do_with(rd_xact_req[rd],{
          /** 
           * Randomizing overlapping addr/non overlapping addr for Read transaction.
           * Randomizing Burst_length,burst_size and id fields only for 
           * Read transaction.
           */
          if(((local::rd == 0) && (local::address == OVERLAP_ADDR)) || (local::address == RANDOM_ADDR))
            { 
              addr   >= lo_addr;
              addr   <= hi_addr-(burst_length*(1<<burst_size));
            }
          else if (local::address == OVERLAP_ADDR)
            {
              addr   >= local::rd_xact_req[rd-1].addr;
              addr   <= (local::rd_xact_req[rd-1].addr)+(rd_xact_req[rd-1].burst_length*(1<<rd_xact_req[rd-1].burst_size));
              addr   <= hi_addr-(burst_length*(1<<burst_size));
            }
          xact_type          == _read_xact_type;
          coherent_xact_type == svt_axi_transaction::READNOSNOOP;
          atomic_type        == svt_axi_transaction::NORMAL; 
          if (local::id == SAME)
            {
               id == rd_id;
            } 
          else if (local::id == DIFF)
            {
               id == id_arr[rd]; 
            }
          else if (local::id == SET_OF_SAME_ID)
            {
              id == id_arr[0];
            }
          else if (local::id == RD_WR_CHAN_MIN_ID) 
            {  
              id == id_arr[rd];
            }  
          burst_type         inside {svt_axi_transaction::INCR, svt_axi_transaction::WRAP};
          reference_event_for_addr_valid_delay ==  svt_axi_transaction::PREV_ADDR_HANDSHAKE;
          addr_valid_delay   == 0;
`ifndef SVT_AXI_MULTI_SIM_OVERLAP_ADDR_ISSUE 
          check_addr_overlap == 0;
`endif          
          if (local::memory_type == DEVICE)
            {  
              /** The cache_type must be a Device Memory (Bufferable or Non-Bufferable) */
              cache_type         inside {0,1};
            }
          else 
            {
              /** The cache_type must be a Normal Memory  */
              cache_type         inside {4'b0010,4'b0011,4'b0110,4'b1110,4'b1010,4'b0111,4'b1111,4'b1011};
            }
        })
      end //for
    end // begin
    id_arr.delete();
  endtask
endclass: svt_axi_read_same_slave_sequence

// =============================================================================
/**
 * This sequence generates a sequence of write transactions, followed by a
 * sequence of read transactions. All other transaction fields are randomized.
 * The sequence waits for each transaction to complete, before sending the next
 * transaction. This sequence is valid only when
 * #svt_axi_port_configuration::axi_interface_category = AXI_READ_WRITE.
 */
class svt_axi_master_blocking_write_read_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  /** Handles for configurations. */
  svt_configuration get_cfg;
  svt_axi_port_configuration cfg;

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_blocking_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_blocking_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;

    super.body();

    /** Getting svt_axi_port_configuration object handle. */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_port_configuration class");
    end

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    if (cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin

      for (int i=0; i < sequence_length/2; i++) begin
        `svt_xvm_do_with(req,
          { 
            req.xact_type == svt_axi_transaction::WRITE;
            req.data_before_addr == 0;
            req.atomic_type == svt_axi_transaction::NORMAL;
          })

        // Wait for transaction to complete.
        get_response(rsp);
      end

      for (int i=0; i < sequence_length/2; i++) begin
        `svt_xvm_do_with(req, { req.xact_type == svt_axi_transaction::READ;
            req.atomic_type == svt_axi_transaction::NORMAL;})

         // Wait for transaction to complete
        get_response(rsp);
      end
    end

  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) 
      return 1;
    return 0;  
  endfunction : is_applicable

endclass: svt_axi_master_blocking_write_read_sequence

// =============================================================================
/**
 * This sequence generates a sequence of coherent writenosnoop transactions,
 * followed by coherent readnosnoop transactions. All other transaction fields
 * are randomized. The sequence does not wait for transactions to complete
 * before sending next transaction. This is required in order to generate 
 * outstanding transactions. This sequence is targetted to hit the following
 * covergroups.
 * svt_axi_port_monitor_def_cov_callback::trans_axi_num_outstanding_xacts_with_same_arid
 * svt_axi_port_monitor_def_cov_callback::trans_axi_num_outstanding_xacts_with_diff_arid
 * svt_axi_port_monitor_def_cov_callback::trans_axi_num_outstanding_xacts_with_same_awid
 * svt_axi_port_monitor_def_cov_callback::trans_axi_num_outstanding_xacts_with_diff_awid
 * svt_axi_port_monitor_def_cov_callback::trans_axi_num_outstanding_xacts_with_multiple_same_arid
 * svt_axi_port_monitor_def_cov_callback::trans_axi_num_outstanding_xacts_with_multiple_same_awid
 * This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE
 * and svt_axi_port_configuration::axi_interface_type is either ACE or ACE-Lite.
 */
class svt_axi_master_outstanding_xact_id_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;
  
  /** If set, then the sequence will initiate WRITENOSNOOP and READNOSNOOP
    * transactions with multiple same ids */
  rand bit multi_same_id_select = 0;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_outstanding_xact_id_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_outstanding_xact_id_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    int id_temp=0;

    super.body();

    /** Gets the user provided sequence_length and multi_same_id_select. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
    status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "multi_same_id_select", multi_same_id_select);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    // This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE
    // and svt_axi_port_configuration::axi_interface_type is either ACE or ACE-Lite.
    if ((cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) ||
       (cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) begin
      if (cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        
        if(multi_same_id_select)
          id_temp = 5;

        for (int i=0; i < sequence_length; i++) begin
          `svt_xvm_do_with(req,
            { 
              id == id_temp;
              xact_type == svt_axi_transaction::COHERENT;
              data_before_addr == 0;
              coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
              burst_type   == svt_axi_transaction::INCR;
              burst_size   == svt_axi_transaction::BURST_SIZE_32BIT;
              burst_length == 16;
              foreach(req.wstrb[index])
                wstrb[index]==(1<<(1<<(burst_size)))-1;            
              atomic_type == svt_axi_transaction::NORMAL;
            })
          
          if (i < (sequence_length/2 - 1)) begin
            if(multi_same_id_select)
              id_temp = 5;
            else begin
              id_temp = id_temp+1;
              if(cfg.use_separate_rd_wr_chan_id_width == 0)
                id_temp = id_temp % (1 << cfg.id_width);
              else 
                id_temp = id_temp % (1 << cfg.read_chan_id_width);
            end  
          end
          else begin
            if(multi_same_id_select)
              id_temp = 6;
            else  
              id_temp = 1;
          end    

          if(i == sequence_length -1)
            wait(req.write_resp_status == svt_axi_transaction::ACCEPT ||
              req.write_resp_status == svt_axi_transaction::ABORTED );
        end
        
        if(multi_same_id_select)
          id_temp = 5;
        else
          id_temp = 0;

        for (int i=0; i < sequence_length; i++) begin
          `svt_xvm_do_with(req, 
            {
              id == id_temp;
              data_before_addr == 0;
              xact_type == svt_axi_transaction::COHERENT;
              coherent_xact_type == svt_axi_transaction::READNOSNOOP;
              burst_type   == svt_axi_transaction::INCR;
              burst_size   == svt_axi_transaction::BURST_SIZE_32BIT;
              burst_length == 16;
            })

          if (i < (sequence_length/2 - 1)) begin
            if(multi_same_id_select)
              id_temp = 5;
            else begin 
              id_temp = id_temp+1;
              if(cfg.use_separate_rd_wr_chan_id_width == 0)
                id_temp = id_temp % (1 << cfg.id_width);
              else 
                id_temp = id_temp % (1 << cfg.write_chan_id_width);
            end  
          end
          else begin
            if(multi_same_id_select)
              id_temp = 6;
            else  
              id_temp = 1;
          end
        end
      end
    end
  endtask: body

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE
   * and svt_axi_port_configuration::axi_interface_type is either ACE or ACE-Lite.
   */  
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    svt_axi_port_configuration master_cfg;
    /** By default is_supported is 0 */
    is_supported = 0;  
    
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_supported", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if (((master_cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) ||
       (master_cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) && 
       (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
       is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type set to either ACE or ACE-Lite. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type set to either ACE or ACE-Lite. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
    end
  endfunction : is_supported

endclass: svt_axi_master_outstanding_xact_id_sequence

// =============================================================================
/**
 * This sequence generates a sequence of DVM TLB Invalidate transactions.
 * All other transaction fields are randomized. The sequence does not wait for transactions
 * to complete before sending next transaction. This is required in order to generate 
 * outstanding DVM TLBI transactions. This sequence is targetted to hit the following
 * covergroups.
 * svt_axi_port_monitor_def_cov_callback::trans_ace_num_outstanding_dvm_tlb_invalidate_xacts_with_same_arid
 * svt_axi_port_monitor_def_cov_callback::trans_ace_num_outstanding_dvm_tlb_invalidate_xacts_with_diff_arid
 * This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE
 * and svt_axi_port_configuration::axi_interface_type is either ACE or ACE-Lite.
 */
class svt_axi_master_outstanding_dvm_tlb_invalidate_xacts_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_outstanding_dvm_tlb_invalidate_xacts_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_outstanding_dvm_tlb_invalidate_xacts_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    int id_temp=0;

    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    // This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE
    // and svt_axi_port_configuration::axi_interface_type is either ACE or ACE-Lite.
    if ((cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) ||
       (cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) begin
      if (cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
        for (int i=0; i < sequence_length; i++) begin
          `svt_xvm_do_with(req,
            {
              addr[14:12] == 3'b000;
              id == id_temp;
              xact_type == svt_axi_transaction::COHERENT;
              coherent_xact_type == svt_axi_transaction::DVMMESSAGE;
            })
          if (i < (sequence_length/2 - 1))
            id_temp = id_temp+1;
          else
            id_temp = 1;
        end
      end
    end
  endtask: body

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE
   * and svt_axi_port_configuration::axi_interface_type is either ACE or ACE-Lite.
   */  
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    svt_axi_port_configuration master_cfg;
    /** By default is_supported is 0 */
    is_supported = 0;  
    
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_supported", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if (((master_cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) ||
       (master_cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) && 
       (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
       is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type set to either ACE or ACE-Lite. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type set to either ACE or ACE-Lite. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
    end
  endfunction : is_supported

endclass: svt_axi_master_outstanding_dvm_tlb_invalidate_xacts_sequence

// =============================================================================
/**
 * This sequence generates a sequence of coherent READONCE transactions.
 * All other transaction fields are randomized. The sequence does not wait for transactions
 * to complete before sending next transaction. This is required in order to generate 
 * outstanding snoop transactions. This sequence is targetted to hit the following
 * covergroups.
 * svt_axi_port_monitor_def_cov_callback::trans_ace_num_outstanding_snoop_xacts
 * This sequence requires svt_axi_port_configuration::axi_interface_category is set to 
 * svt_axi_port_configuration::AXI_READ_WRITE or svt_axi_port_configuration::AXI_READ_ONLY
 * and svt_axi_port_configuration::axi_interface_type is set to AXI_ACE or ACE_LITE.
 */
class svt_axi_master_outstanding_snoop_xacts_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_outstanding_snoop_xacts_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_outstanding_snoop_xacts_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    // This sequence requires svt_axi_port_configuration::axi_interface_category is set to 
    // svt_axi_port_configuration::AXI_READ_WRITE or svt_axi_port_configuration::AXI_READ_ONLY
    // and svt_axi_port_configuration::axi_interface_type is set to AXI_ACE or ACE_LITE.    
    if (((cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) ||
        (cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) && 
        ((cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) ||
        (cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY))) begin
      for (int i=0; i < sequence_length; i++) begin
        `svt_xvm_do_with(req,
          {
            data_before_addr == 0;
            xact_type == svt_axi_transaction::COHERENT;
            coherent_xact_type == svt_axi_transaction::READONCE; 
          })
      end
    end
  endtask: body

  /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires svt_axi_port_configuration::axi_interface_category is set to 
   * svt_axi_port_configuration::AXI_READ_WRITE or svt_axi_port_configuration::AXI_READ_ONLY
   * and svt_axi_port_configuration::axi_interface_type is set to AXI_ACE.
   */  
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    svt_axi_port_configuration master_cfg;
    /** By default is_supported is 0 */
    is_supported = 0;  
    
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_supported", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if ((master_cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) && 
        ((master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) ||
         (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_ONLY))) begin
       is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category is set to svt_axi_port_configuration::AXI_READ_WRITE or svt_axi_port_configuration::AXI_READ_ONLY and svt_axi_port_configuration::axi_interface_type set to either ACE or ACE-Lite. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type is set to AXI_ACE. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
    end
  endfunction : is_supported

endclass: svt_axi_master_outstanding_snoop_xacts_sequence

// =============================================================================
/**
 * This sequence generates alternate write and read transaction. All other
 * transaction fields are randomized.  The sequence waits for each transaction
 * to complete, before sending the next transaction.  This sequence is valid
 * only when #svt_axi_port_configuration::axi_interface_category =
 * AXI_READ_WRITE.
 */
class svt_axi_master_blocking_alternate_write_read_sequence extends svt_axi_master_base_sequence;

  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;

  /** Handles for configurations. */
  svt_configuration get_cfg;
  svt_axi_port_configuration port_cfg;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_blocking_alternate_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_blocking_alternate_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;

    super.body();

    /** Getting svt_axi_port_configuration object handle. */ 
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(port_cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
    end 

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    if (port_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin

      for (int i=0; i < sequence_length/2; i++) begin

        /** Generate write tranactions.*/
        `svt_xvm_do_with(req,
          { 
            req.xact_type == svt_axi_transaction :: WRITE;
            req.data_before_addr == 0;
            req.atomic_type == svt_axi_transaction::NORMAL;})

        // Wait for transaction to complete.
        get_response(rsp);

        /** Generate read transactions.*/
        `svt_xvm_do_with(req,
          { 
            req.xact_type == svt_axi_transaction :: READ;
            req.atomic_type == svt_axi_transaction::NORMAL;})

        // Wait for transaction to complete
        get_response(rsp);
      end
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) 
      return 1;
    return 0;  
  endfunction : is_applicable

endclass: svt_axi_master_blocking_alternate_write_read_sequence

// =============================================================================
/** 
 * This sequence generates write interleaved data with interleave size of each
 * block equal to one by default. User can modify the interleave block size by
 * setting #interleave_block_size. This is valid when
 * #svt_axi_port_configuration::axi_interface_type = AXI3.
 */
class svt_axi_master_write_data_fixed_interleave_block_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;

  /** 
   * Interleave block size, the block size must be less then or equal to
   * #svt_axi_transaction::burst_length. 
   */
  int unsigned interleave_block_size = 1;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_write_data_fixed_interleave_block_sequence)
    `svt_xvm_field_int(interleave_block_size, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
 
  function new(string name="svt_axi_master_write_data_fixed_interleave_block_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;

    super.body();

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));


`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "interleave_block_size", interleave_block_size);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".interleave_block_size"}, interleave_block_size);
`endif
    `svt_xvm_debug("body", $sformatf("interleave_block_size is 'd%0d as a result of %0s.", interleave_block_size, status ? "the config DB" : "the default value"));

    if (cfg.axi_interface_type == svt_axi_port_configuration::AXI3) begin

      for (int i=0; i < sequence_length; i++) begin
        `svt_xvm_do_with(req,
          { 
            req.xact_type == svt_axi_transaction :: WRITE;
            req.atomic_type == svt_axi_transaction::NORMAL;
            req.interleave_pattern == svt_axi_transaction ::RANDOM_BLOCK;
            req.burst_length >= interleave_block_size;
            // Equal blocks of interleave_block_size 
            foreach(req.random_interleave_array[i])
              req.random_interleave_array[i] == interleave_block_size;             
          })
      end
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(master_cfg.axi_interface_type == svt_axi_port_configuration::AXI3) 
      return 1;
    return 0;  
  endfunction : is_applicable

endclass: svt_axi_master_write_data_fixed_interleave_block_sequence

// =============================================================================
/** 
 * This sequence generates write data before address. This is valid when
 * #svt_axi_port_configuration::axi_interface_category = AXI_READ_WRITE or
 * AXI_WRITE_ONLY.
 */
class svt_axi_master_write_data_before_addr_sequence extends svt_axi_master_base_sequence;

  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_write_data_before_addr_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_write_data_before_addr_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;

    super.body();

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    if (cfg.axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) begin

      for (int i=0; i < sequence_length; i++) begin
        `svt_xvm_do_with(req,
          { 
            req.xact_type == svt_axi_transaction :: WRITE;
            req.atomic_type == svt_axi_transaction::NORMAL;
            req.data_before_addr == 1;
            req.reference_event_for_addr_valid_delay ==  svt_axi_transaction ::FIRST_WVALID_DATA_BEFORE_ADDR;
            req.addr_valid_delay > 0;
          })
      end
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(master_cfg.axi_interface_category != svt_axi_port_configuration::AXI_READ_ONLY) 
      return 1;
    return 0;  
  endfunction : is_applicable

endclass: svt_axi_master_write_data_before_addr_sequence

/** 
 * This sequence generates the transactions whose address is always aligned with
 * respect to burst size.
 */
class svt_axi_master_aligned_addr_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_aligned_addr_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_aligned_addr_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;

    super.body();

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    for (int i=0; i < sequence_length; i++) begin
      `svt_xvm_do_with(req,
        { addr == (addr & ({`SVT_AXI_MAX_ADDR_WIDTH{1'b1}} << burst_size)); 
          req.atomic_type == svt_axi_transaction::NORMAL;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;  
  endfunction : is_applicable

endclass: svt_axi_master_aligned_addr_sequence

// =============================================================================
/**
 *   This sequence performs Exclusive read transaction followed by Exclusive
 *   write transaction with same control fields as previous Exclusive read.
 *   Exclusive write commences only after response for Exclusive read is
 *   received by the master.
 **/
class svt_axi_master_exclusive_test_sequence extends svt_axi_master_base_sequence;
   
  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;
  
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  /** Handles for configurations. */
  svt_configuration get_cfg;
  svt_axi_port_configuration port_cfg;

  /** Indicates the slave number to be targetted */
  rand int slv_num = 0;

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)
  
  `svt_xvm_object_utils_begin(svt_axi_master_exclusive_test_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(slv_num, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_exclusive_test_sequence");
    super.new(name);
  endfunction

  /** Raise an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_body();
    uvm_phase starting_phase_for_curr_seq ;
    `svt_xvm_note("pre_body", "Entered ...")
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.raise_objection(this);
  end
  endtask: pre_body
`endif
  /** Drop an objection if this is the parent sequence */
`ifdef SVT_UVM_TECHNOLOGY
  virtual task post_body();
    uvm_phase starting_phase_for_curr_seq;
    `svt_xvm_note("post_body", "Entered ...")
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.drop_objection(this);
  end
  endtask: post_body
`endif

  virtual task body();
    /** Flag to determine whether to use the slave number in transactions or not */
    bit use_slv_num = 1'b0;
  
    /** Local variables */
    bit status;
    bit use_slv_num_status;
    bit slv_num_status;
    int ex_wr_id;
    int min_id_width;
    int id_q[$];
    int id_val; 
    bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] ex_wr_addr; 
    int burst_size_int;
    int burst_type_int;
    int prot_type_int ;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;

    super.body();

    /** Getting svt_axi_port_configuration object handle. */ 
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(port_cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_system_configuration class");
    end  

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    slv_num_status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "slv_num", slv_num);
    use_slv_num_status = uvm_config_db#(bit)::get(null, get_full_name(), "use_slv_num", use_slv_num);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
    slv_num_status = m_sequencer.get_config_int({get_type_name(), ".slv_num"}, slv_num);
    use_slv_num_status = m_sequencer.get_config_int({get_full_name(), ".use_slv_num"}, use_slv_num);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("use_slv_num is 'd%0d as a result of %0s.", use_slv_num, use_slv_num_status ? "the config DB" : "default value"));
    `svt_xvm_debug("body", $sformatf("slv_num is 'd%0d as a result of %0s.", slv_num, slv_num_status ? "the config DB" : "default value"));
    if(port_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
    
      /** Randomly select an Address range for the selected slave if we can use slv_num */
      if(use_slv_num)
        if (!port_cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num,lo_addr,hi_addr,null))
          `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));

      for (int k=0; k < sequence_length; k++) begin 
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
        for (int i = 0; i < 1; i++) begin
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
        for (int i = 0; i < 2; i++) begin
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_3
        for (int i = 0; i < 3; i++) begin
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_4
        for (int i = 0; i < 4; i++) begin
`else
        for (int i = 0; i < 5; i++) begin
`endif 
          //int burst_size_int = svt_axi_transaction::burst_size_enum'(i);
          //int burst_type_int = svt_axi_transaction::burst_type_enum'(i % 3);
          //int prot_type_int = svt_axi_transaction::prot_type_enum'(i);

          if (port_cfg.use_separate_rd_wr_chan_id_width == 1)  begin
            if (port_cfg.write_chan_id_width < port_cfg.read_chan_id_width) begin
              min_id_width = port_cfg.write_chan_id_width;
            end 
            else begin
              min_id_width = port_cfg.read_chan_id_width;
            end
            /** Generating different id within the range of id_width */
            for(int k= 0;k <= (1<<min_id_width-1); k++)  begin
              id_q.push_back(k);
            end
            id_q.shuffle;
            id_val = id_q.pop_front();
          end

          if ((port_cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE) || (port_cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) begin
            _read_xact_type  = svt_axi_transaction::COHERENT;
            _write_xact_type = svt_axi_transaction::COHERENT;
          end
          else begin
            _read_xact_type  = svt_axi_transaction::READ;
            _write_xact_type = svt_axi_transaction::WRITE;
          end

  
          for(int j = 0; j < 2; j++) begin
            int xact_type_int = (j%2==0) ? _read_xact_type:
                                           _write_xact_type;

            `svt_xvm_do_with(req,
            {
              xact_type == xact_type_int;
              atomic_type == svt_axi_transaction::EXCLUSIVE;
              cache_type == 0;
              if(i < 4)
                burst_length == 2**i;
              else
                burst_length == 8;
              if(!j && use_slv_num) {
                addr >= lo_addr;
                addr <= hi_addr-(burst_length*(1<<burst_size));
                coherent_xact_type == svt_axi_transaction::READNOSNOOP;
                if (port_cfg.use_separate_rd_wr_chan_id_width == 1) 
                id == id_val; 
              }
              else if(j == 1 && use_slv_num)
                coherent_xact_type == svt_axi_transaction::WRITENOSNOOP;
              if (j == 1) {
                addr == ex_wr_addr;
                burst_size == burst_size_int;
                burst_type == burst_type_int;
                prot_type == prot_type_int;
                id == ex_wr_id;
              }
            })   
  
            ex_wr_addr = req.addr;
            burst_size_int = req.burst_size;
            burst_type_int = req.burst_type;
            prot_type_int  = req.prot_type;
            ex_wr_id = req.id;
            
            if( j== 0) begin
              bit exclusive_read_success = 1;
              //wait for transaction to complete
              wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
                    (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));
              foreach (req.rresp[i]) begin
                if (req.rresp[i] != svt_axi_transaction::EXOKAY) begin
                  exclusive_read_success = 0;
                  break;
                end
              end
              if (!exclusive_read_success) begin
                `svt_xvm_note("body", "Exclusive READ transaction completed but did not got an EXOKAY response ...")
              end
              else begin
                `svt_xvm_note("body", "Exclusive READ transaction completed successfully with an EXOKAY response ...")
              end
            end
            else begin
              //wait for transaction to complete
              wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
                    (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED) &&
                    (req.write_resp_status == svt_axi_transaction::ACCEPT || req.write_resp_status == svt_axi_transaction::ABORTED));
              if (req.write_resp_status == svt_axi_transaction::ACCEPT) begin
                if (req.bresp != svt_axi_transaction::EXOKAY) begin
                  `svt_xvm_note("body", "Exclusive WRITE transaction completed but did not got an EXOKAY response ...")
                end
                else begin
                  `svt_xvm_note("body", "Exclusive WRITE transaction completed successfully with an EXOKAY response ...")
                end
              end
            end
          
          end     
        
        end
     
      end
    
    end
    `svt_xvm_note("body", "Exiting...")
  endtask: body
  
  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(
        (master_cfg.exclusive_access_enable == 1) &&
        (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) 
      )
      return 1;
    return 0;  
  endfunction : is_applicable

endclass : svt_axi_master_exclusive_test_sequence

/**
 *   This sequence performs the following 
 *   1) Normal read and write transactions 
 *   2) Exclusive read and write transactions  
 *   3) Normal read and write transactions 
 *   4) Exclusive read and write transactions  
 **/
class svt_axi_master_exclusive_random_test_sequence extends svt_axi_master_base_sequence;
  
  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;
  
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_master_exclusive_random_test_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  svt_axi_master_exclusive_test_sequence excl_rd_wr;  
  svt_axi_master_blocking_alternate_write_read_sequence norml_rd_wr;

  function new(string name="svt_axi_master_exclusive_random_test_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;

    super.body();

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    if(cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin

      for (int i=0; i < sequence_length; i++) begin

        `svt_xvm_do(norml_rd_wr);
        `svt_xvm_do(excl_rd_wr);
        `svt_xvm_do(norml_rd_wr);
        `svt_xvm_do(excl_rd_wr);

      end

    end
 
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(
        (master_cfg.exclusive_access_enable == 1) &&
        (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) 
      )
      return 1;
    return 0;  
  endfunction : is_applicable

endclass : svt_axi_master_exclusive_random_test_sequence

/**
 *   This sequence performs the following 
 *   1) Exclusive read transaction
 *   2) Normal write transaction with same ID, ADDR and other control fields as
 *   previous Exclusive read
 *   3) Exclusive write transaction with same ID, ADDR and other control fields as
 *   previous Exclusive read
 **/
class svt_axi_master_exclusive_memory_test_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_object_utils(svt_axi_master_exclusive_memory_test_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  function new(string name="svt_axi_master_exclusive_memory_test_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    
    bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] ex_wr_addr;     
    int burst_size_int;
    int burst_type_int;
    int prot_type_int ;

    super.body();
    
     
    if(cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
        for (int i = 0; i < 1; i++) begin
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
        for (int i = 0; i < 2; i++) begin
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_3
        for (int i = 0; i < 3; i++) begin
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_4
        for (int i = 0; i < 4; i++) begin
`else
        for (int i = 0; i < 5; i++) begin
`endif  
        //int burst_size_int = svt_axi_transaction::burst_size_enum'(i);
        //int burst_type_int = svt_axi_transaction::burst_type_enum'(i % 2);
        //int prot_type_int = svt_axi_transaction::prot_type_enum'(i);
 
        `svt_xvm_do_with(req,
            {
              xact_type == svt_axi_transaction::READ;
              atomic_type == svt_axi_transaction::EXCLUSIVE;
              data_before_addr == 0;
              id == (i % (1<<cfg.id_width));
              //burst_size == burst_size_int;
              //burst_type == burst_type_int;
              //prot_type == prot_type_int; 
              cache_type inside {[0:3]};  // applicable for both AXI3 and AXI4
              if(i < 4)
                burst_length == 2**i;
              else
                burst_length == 8;
            })

        ex_wr_addr = req.addr;
        burst_size_int = req.burst_size;
        burst_type_int = req.burst_type;
        prot_type_int  = req.prot_type;

        //wait for transaction to complete
        wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
              (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));
 
        `svt_xvm_do_with(req,
           {
             xact_type == svt_axi_transaction::WRITE;
             atomic_type == svt_axi_transaction::NORMAL;
             data_before_addr == 0;
             id == ((i+1) % (1<<cfg.id_width));
             burst_size == burst_size_int;
             burst_type == burst_type_int;
             prot_type == prot_type_int; 
             cache_type == 0; 
             if(i < 4)
               burst_length == 2**i;
             else
               burst_length == 8;
             addr == ex_wr_addr;
           })
        //wait for transaction to complete
        wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
              (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED) &&
              (req.write_resp_status == svt_axi_transaction::ACCEPT || req.write_resp_status == svt_axi_transaction::ABORTED));

        `svt_xvm_do_with(req,
            {
              xact_type == svt_axi_transaction::WRITE;
              atomic_type == svt_axi_transaction::EXCLUSIVE;
              data_before_addr == 0;
              id == (i % (1<<cfg.id_width));
              burst_size == burst_size_int;
              burst_type == burst_type_int;
              prot_type == prot_type_int;
              cache_type == 0; 
              if(i < 4)
                burst_length == 2**i;
              else
                burst_length == 8;
              addr == ex_wr_addr; 
            })
        //wait for transaction to complete
        wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
              (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED) &&
              (req.write_resp_status == svt_axi_transaction::ACCEPT || req.write_resp_status == svt_axi_transaction::ABORTED));
        
      end

    end
  
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(
        (master_cfg.exclusive_access_enable == 1) &&
        (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) 
      )
      return 1;
    return 0;  
  endfunction : is_applicable

endclass : svt_axi_master_exclusive_memory_test_sequence

/**
  *   This sequence performs the following
  *   1) Series of Exclusive read transactions  
  *   2) Series of Exclusive write transactions 
  **/
class svt_axi_master_exclusive_read_after_read_test_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_object_utils(svt_axi_master_exclusive_read_after_read_test_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  function new(string name="svt_axi_master_exclusive_read_after_read_test_sequence");
    super.new(name);
  endfunction
  
  virtual task body();

    bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] ex_wr_addr[$]; 
    int burst_size_int[$] ;
    int burst_type_int[$] ;
    int prot_type_int[$] ;
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
    int num_txn = 1;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
    int num_txn = 2;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_3
    int num_txn = 3;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_4
    int num_txn = 4;
`else
    int num_txn = 5;
`endif    

    super.body();
    
    if(cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
      
        for (int i = 0; i < num_txn; i++) begin

          `svt_xvm_do_with(req,
          {
            xact_type == svt_axi_transaction::READ;
            atomic_type == svt_axi_transaction::EXCLUSIVE;
            data_before_addr == 0;
            id == (i % (1<<cfg.id_width));
            cache_type == 0;
            if(i < 4)
              burst_length == 2**i;
            else
              burst_length == 8;
          })   

          ex_wr_addr.push_back(req.addr);
          burst_size_int.push_back(req.burst_size);
          burst_type_int.push_back(req.burst_type);
          prot_type_int.push_back(req.prot_type);
        
        //wait for transaction to complete
        wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
              (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));
        
        end
         
        for (int i = 0; i < num_txn; i++) begin

          `svt_xvm_do_with(req,
          {
            xact_type == svt_axi_transaction::WRITE;
            atomic_type == svt_axi_transaction::EXCLUSIVE;
            data_before_addr == 0;
            id == (i % (1<<cfg.id_width));
            burst_size == burst_size_int[i];
            burst_type == burst_type_int[i];
            prot_type == prot_type_int[i];
            cache_type == 0;
            if(i < 4)
              burst_length == 2**i;
            else
              burst_length == 8;
            addr == ex_wr_addr[i];
          })   
        
        end
        ex_wr_addr = {};
       
    end
  
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(
        (master_cfg.exclusive_access_enable == 1) &&
        (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) 
      )
      return 1;
    return 0;  
  endfunction : is_applicable

endclass : svt_axi_master_exclusive_read_after_read_test_sequence

/**
  *   This sequence performs the following
  *   1) Exclusive read transaction with WRAP burst type 
  *   2) Normal write transaction with different ID and address overlapping to the
  *   address of previous exclusive read
  *   3) Exclusive write transaction matching to the previous Exclusive read
  **/
class svt_axi_master_exclusive_normal_wrap_test_sequence extends svt_axi_master_base_sequence;

  `svt_xvm_object_utils(svt_axi_master_exclusive_normal_wrap_test_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  function new(string name="svt_axi_master_exclusive_normal_wrap_test_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
        
    super.body();
    
    if(cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
       
      for (int k=0 ; k < 3 ; k++) begin
      
        `svt_xvm_do_with(req,
            {
              xact_type == svt_axi_transaction::READ;
              atomic_type == svt_axi_transaction::EXCLUSIVE;
              data_before_addr == 0;
              id == (k % (1<<cfg.id_width));
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
              //burst_length == 2; wrap burst type not supported with this burst_length_width
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
              burst_length == 2;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_3
              burst_length == 4;
`else       
              burst_length == 8;
`endif
              burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
              burst_type == svt_axi_transaction::WRAP;
              addr == 'h80;    
              prot_type == svt_axi_transaction::DATA_SECURE_NORMAL; 
              cache_type == 0; 
            })
        
        //wait for transaction to complete
        wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
              (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));
         
        `svt_xvm_do_with(req,
            {
              xact_type == svt_axi_transaction::WRITE;
              atomic_type == svt_axi_transaction::NORMAL;
              data_before_addr == 0;
              id == ((k+1) % (1<<cfg.id_width));
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
              burst_length == 1; 
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
              burst_length == 2;
`else
              burst_length == 4;
`endif        
              burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
              burst_type == svt_axi_transaction::INCR;
              addr == ('h80 - ('d16 * k));    
              prot_type == svt_axi_transaction::DATA_SECURE_NORMAL; 
              cache_type == 0; 
            })
        //wait for transaction to complete
        wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
              (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED) &&
              (req.write_resp_status == svt_axi_transaction::ACCEPT || req.write_resp_status == svt_axi_transaction::ABORTED));
        
        `svt_xvm_do_with(req,
            {
              xact_type == svt_axi_transaction::WRITE;
              atomic_type == svt_axi_transaction::EXCLUSIVE;
              data_before_addr == 0;
              id == (k % (1<<cfg.id_width));
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
              //burst_length == 2; wrap burst type not supported with this burst_length_width
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
              burst_length == 2;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_3
              burst_length == 4;
`else
              burst_length == 8;
`endif        
              burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
              burst_type == svt_axi_transaction::WRAP;
              addr == 'h80; 
              prot_type ==  svt_axi_transaction::DATA_SECURE_NORMAL;
              cache_type == 0; 
            })
        //wait for transaction to complete
        wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
              (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED) &&
              (req.write_resp_status == svt_axi_transaction::ACCEPT || req.write_resp_status == svt_axi_transaction::ABORTED));
        
      end
      
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(
        (master_cfg.exclusive_access_enable == 1) &&
        (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) 
      )
      return 1;
    return 0;  
  endfunction : is_applicable

endclass : svt_axi_master_exclusive_normal_wrap_test_sequence

/**
 *   This sequence performs locked accesses 
 *   Each loop does the following:
 *   Send a normal transaction
 *   Send a locked access transaction that starts the locked sequeunce
 *   Send more locked access transactions
 *   Send a normal transactions that ends the locked sequence
 *   An intermediate loop sends only NORMAL transactions (represented by k == 5)
 **/
class svt_axi_master_locked_test_sequence extends svt_axi_master_base_sequence;
   
  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;
  
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)
  
  `svt_xvm_object_utils_begin(svt_axi_master_locked_test_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_axi_master_locked_test_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    int var1 = $urandom_range(7,2);
    bit[7:0]  locked_xact_id = 0, locked_xact_count = 0;
    super.body();

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

      //As per AXI_ACE spec Section "A7.3 Locked accesses",all the locked transaction in the locked sequence should have same id.
      //There cannot be more than one outstanding locked sequence,therefore making sure that this sequence generates all the 
      //locked transactions and the unlocking transaction within the locked sequence have the same ID.
      for (int k=0; k < sequence_length; k++) begin 
        `svt_xvm_do_with(req,
          {
            if ((k == 0) || (k % var1))
            {
              atomic_type inside {svt_axi_transaction::NORMAL,svt_axi_transaction::LOCKED};
              if(locked_xact_count != 0)
              {
                id == locked_xact_id;
              }
            }
           else
           {   
             atomic_type == svt_axi_transaction::LOCKED;
             if(locked_xact_count != 0)
             { 
              id == locked_xact_id;
             }
           }
           data_before_addr == 0;
           cache_type == 0;
         })
        if(req.atomic_type == svt_axi_transaction::LOCKED) begin
          locked_xact_id = req.id;
          locked_xact_count++;
        end   
        if(req.atomic_type == svt_axi_transaction::NORMAL) begin
          locked_xact_count = 0;
        end   
      end   
endtask: body
  
  virtual function bit is_applicable(svt_configuration cfg);
    svt_axi_port_configuration master_cfg;
    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_applicable", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if(master_cfg.locked_access_enable == 1) 
      return 1;
    return 0;  
  endfunction : is_applicable

endclass : svt_axi_master_locked_test_sequence

/**
  *   This sequence performs the following
  *   send back to back four transactions
  *   The atomic type is randomized to exclusive or normal for each transaction
  **/
class svt_axi_master_normal_exclusive_random_sequence extends svt_axi_master_base_sequence;
  /** Number of Transactions in this sequence. */
  rand int unsigned sequence_length = 10;
  
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  rand int slv_num = 0;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
  bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;


  `svt_xvm_object_utils_begin(svt_axi_master_normal_exclusive_random_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(slv_num, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  function new(string name="svt_axi_master_normal_exclusive_random_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;
    bit [7:0]id_normal;
    bit [7:0]id_exclusive;

    super.body();
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));
   
    if (!cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num, lo_addr,hi_addr,null))
       `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));

    if(cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
      for (int i=0 ; i< sequence_length ; i++) begin
        for (int k=0 ; k < 4 ; k++) begin
          id_normal= (k+1) % (1<<cfg.id_width);
          id_exclusive= k % (1<<cfg.id_width);
          `svt_xvm_do_with(req,
            {
              if(cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE || cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE) {
                xact_type == svt_axi_transaction::COHERENT;
                coherent_xact_type == svt_axi_transaction::READNOSNOOP;
              }
              else {
                xact_type == svt_axi_transaction::READ;
              }
              atomic_type inside { svt_axi_transaction::EXCLUSIVE,svt_axi_transaction::NORMAL}; 
              data_before_addr == 0;
              if (req.atomic_type ==   svt_axi_transaction::NORMAL) {
                id == id_normal;
              } else {
                id == id_exclusive ;
              } 
              addr >= lo_addr;
              addr <= hi_addr-((1<<burst_size)*burst_length);
              prot_type == svt_axi_transaction::DATA_SECURE_NORMAL; 
              cache_type == 0; 
            })
        
            //wait for transaction to complete
            wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
                 (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));
         
          end
        end
      end 
  endtask: body

   /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires svt_axi_port_configuration::axi_interface_category is set to 
   * svt_axi_port_configuration::AXI_READ_WRITE for exclusive acess
   */  
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    svt_axi_port_configuration master_cfg;
    /** By default is_supported is 0 */
    is_supported = 0;  
    
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_supported", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if ((master_cfg.exclusive_access_enable == 1) && (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) begin
       is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category is set to svt_axi_port_configuration::AXI_READ_WRITE. Currently svt_axi_port_configuration::axi_interface_category is set to %0s",master_cfg.axi_interface_category.name()))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE. Currently svt_axi_port_configuration::axi_interface_category is set to %0s ",master_cfg.axi_interface_category.name()))
    end
  endfunction : is_supported

 endclass : svt_axi_master_normal_exclusive_random_sequence

/**
 *   This sequence performs locked followed by exclusive accesses 
 *   Each loop does the following:
 *   Send a locked access read transaction followed by a excluisve read transaction
 *   Send the exclusive read transactions with same id as of locked read transaction
 *   Each transcation waits for the previous transaction to be ended
 **/
class svt_axi_master_locked_read_followed_by_excl_sequence extends svt_axi_master_base_sequence;

  rand int slv_num;

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(svt_axi_master_locked_read_followed_by_excl_sequence)

  /** Class Constructor */
  function new(string name="svt_axi_master_locked_read_followed_by_excl_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] ex_wr_addr;     
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
    int burst_size_int;
    int burst_type_int;
    int burst_length_int;
    int prot_type_int ;
    svt_configuration get_cfg;
    bit status;
    `svt_xvm_debug("body", "Entering...");

    super.body();
   
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_port_configuration class");
    end
    if (!cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num, lo_addr,hi_addr,null))
      `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));
      if(cfg.axi_interface_type == svt_axi_port_configuration::AXI3) begin
        `svt_xvm_do_with(req,
          {
            xact_type ==   svt_axi_transaction::READ;
            atomic_type == svt_axi_transaction::LOCKED;
            data_before_addr == 0;
            id == 0;
            cache_type == 0;
            addr >= lo_addr;
            addr <= hi_addr-((1<<burst_size)*burst_length);
          })
        ex_wr_addr = req.addr;
          wait(`SVT_AXI_XACT_STATUS_ENDED(req));
        end
            if(cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
              `svt_xvm_do_with(req,
              {
                xact_type == svt_axi_transaction::READ;
                atomic_type == svt_axi_transaction::NORMAL;
                data_before_addr == 0;
                id == 0;
                cache_type == 0;
                addr == ex_wr_addr;
                })   
        
              //wait for transaction to complete
              wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
                   (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));

              `svt_xvm_do_with(req,
              {
                xact_type == svt_axi_transaction::READ;
                atomic_type == svt_axi_transaction::EXCLUSIVE;
                data_before_addr == 0;
                id == 0;
                cache_type == 0;
                addr == ex_wr_addr;
                })   
               burst_size_int = req.burst_size;
               burst_length_int = req.burst_length;
               prot_type_int = req.prot_type;
               burst_type_int = req.burst_type;
              //wait for transaction to complete
              wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
                   (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));

                `svt_xvm_do_with(req,
              {
                xact_type == svt_axi_transaction::WRITE;
                atomic_type == svt_axi_transaction::EXCLUSIVE;
                data_before_addr == 0;
                id == 0;
                cache_type == 0;
                addr == ex_wr_addr;
                burst_length == burst_length_int;
                burst_size == burst_size_int;
                prot_type == prot_type_int;
                burst_type == burst_type_int;
                }) 
             wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
                   (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));
            end

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

   /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires svt_axi_port_configuration::axi_interface_category is set to 
   * svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type is set to AXI3 for exclusive acess and locked acess respectvively
   */  
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    svt_axi_port_configuration master_cfg;
    /** By default is_supported is 0 */
    is_supported = 0;  
    
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_supported", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if (((master_cfg.exclusive_access_enable == 1) && (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) || ((master_cfg.locked_access_enable == 1) && (master_cfg.axi_interface_type == svt_axi_port_configuration::AXI3))) begin
       is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category is set to svt_axi_port_configuration::AXI_READ_WRITE or svt_axi_port_configuration::AXI_READ_ONLY and svt_axi_port_configuration::axi_interface_type set to either AXI3. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type is set to AXI3. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
     end
  endfunction : is_supported


endclass: svt_axi_master_locked_read_followed_by_excl_sequence

// =============================================================================
/**
Utility methods definition of svt_axi_master_sequence_collection class
*/

/**
 * AXI ACE base master snoop response reactive sequence
 */
class svt_axi_master_snoop_base_sequence extends svt_sequence #(svt_axi_master_snoop_transaction);
  /** Port Configuration handle set by pre_body. */
   svt_axi_port_configuration cfg;

  `svt_xvm_object_utils(svt_axi_master_snoop_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_master_snoop_sequencer)

  /** Constructor of base sequence */
  extern function new(string name="svt_axi_master_snoop_base_sequence");

  /** Do not raise a phase objection and initialize the cfg parameter */
  extern virtual task pre_body();
  extern virtual task post_body();

  /** Wait for a snoop transaction request */
  extern task wait_for_snoop_request(output svt_axi_master_snoop_transaction req);

endclass: svt_axi_master_snoop_base_sequence

/**
  * Reactive response sequence that services snoop requests
  * using the cache located in the parent svt_axi_master_snoop_sequencer.
  * Automatically configured as the run_phase default sequence for every instance of
  * the svt_axi_master_snoop_sequencer.
  *
  * If data is available in the cache, that data is populated into the
  * snoop transaction.
  */  
class svt_axi_ace_master_snoop_response_sequence extends svt_axi_master_snoop_base_sequence;
  bit is_unique, is_clean, read_status;

  bit [7:0] data[];
  bit poison[];
  string poison_str;
  longint index,age;
  int log_base_2_cache_line_size;
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] aligned_addr;
  event received_snoop_request;
  bit use_prepare_snoop_response = 0;
  `protected
5F.7T?f\TCJ4;LB6WZ-1-KAWFHN(d[AW/3[#T0&+bV83c7F3ZK,&))V^6GGbbO&;
f2+@g5=SP9/-fDES8c1LfX5;CM&DP03[DbVGXG2]&CcaOd1>G+A(U(\J2e>6[dVd
E+CbR=P&A.ML2.1YN7<R9C]8SLM]XGR,0?B+)c/PN7(aA$
`endprotected


  function new(string name="svt_axi_ace_master_snoop_response_sequence");
    super.new(name);
    `protected
/J9-G6>4)\H->dO/Gg<@KN#IL<dSeX3@fNQ_,I9bS[ZFUPT,KGM7.)b\>0#1+IG(
QeVcU3VSg9)#>O+&V^7CQ?RCe[K3;7NE?670Ae=KFa[:7\J[AS]#c5<<a2@55d6;
JW7#BFI\-A.adW)J4TK2<VSNS<Q]OFeTI0c:U5,4]<a\PUcVCD72@g@QJ^97T&,NS$
`endprotected

  endfunction

  virtual function void do_randomize (svt_axi_master_snoop_transaction snoop_xact);
    bit _respond_for_overlapped_mem_update = ((snoop_xact.is_mem_update_transaction_in_progress==1) && (snoop_xact.do_suspend_snoop(!read_status) == 0));
    if (!snoop_xact.randomize() with 
                    {if(_respond_for_overlapped_mem_update) snoop_resp_isshared == 1;}
       ) begin
      `svt_xvm_fatal("body", "Unable to randomize the snoop response");
    end
  endfunction

  `svt_xvm_declare_p_sequencer(svt_axi_master_snoop_sequencer)

  `svt_xvm_object_utils(svt_axi_ace_master_snoop_response_sequence)

  virtual task body();
  `protected
FK[FUa,S78QWIbQ)_[DN+60H;d.F]10Acd89)-XW[-JQ&.T\3/fS1)A[I^47)EB>
7T(&E#ML-1_O+@?^G@JS<2/aSX)X9Y,=[T+XEMMS=c1\_]>DWKV<#<KT_R#e;9HD
aT,2,^bW]Z-](EZ23\F8),+f&&PW@:9=K6@)?2Sg^Oe>31#STG7R,&/ID+F=JVb[
aPNUPd27W\C9G6;MfeP.YRF>3>P:/8+WON-cM]E#FN><baDQ&2,S(L/AM2],J2Z1
T=:_e6aE;eWf9d#;(4FESHJVG8E@g(75\Tf8YHfH7(C1OMAc7<aCXX[#1a@SF]7\
1LOYATdTYd;\VZ7+XP3ZY1@3D@/SOS\:+D=OU>W-5QH<g<S&:B55=K39c/A8P[-?
TT2E[bf?P=9ILe1a,[?]M[FGWNJ<IS?J-dGRBHJb2b0^VR_bS^TSWH1YHDOXP9T9
#f[_RU=cQLJ3)2J5dSUbPBgY-+2[J8DG,F[O1-E(DTL5gc_ObA/^^(7A;:g086_J
2E_XPVM40,)+8VYb<SRNEP^]1]O//Y<QdHO#-c?N52V90Y#4QZCC?Fg0d/H[#1.f
0>CU<PLH3LabdTJZC7J31EU+cecN-VK/CGP,X3ad/0@O,CC0:RW4X3E5J8P[2b,S
,,:e7Q#2MS][\AfVXC&_+^]e9CVXN460\cgHdR)c2;U-N)]6TM/bXG]7F/-;O3@L
JeJKaH[3TRXSeUH??M1]]SG9/Gf:J4&bBB#^;44&DCP==3+HP]B5MKL@Jdc00:VN
K6&NI:b\aORWbN4N0ZY1JaFZZO>OAEU=Y4X.WI;Ub@J(R(TFT\2MfAU9(FA]\9+K
bgC:A9IPAZM:UC1GJC6P;(GA0GcMB([^f4/a.D3e[]:8.9<([XfNUG#6UT34CSIe
]K1YOS87D#bX-\T[#1=1>16:QAJX&7YMK<b0.S(NB+]Xe3L4IMgIHf\JBKcI^B@H
JH>OX+4Wc@81:6C1&6J2Q,]=B-YDc\_XgZ,-<P2[ed>gGfaSZa:gf[IUgE:QJ@[K
W8[.C&?+V?3.MV[BCKJPOVKJCI<eG0UL4]b]STT#9T2<@e?e^4NKSCP;dLEVP+E@
6^)<\P<=PgT(CdN^7^6ED,T^3_T0A.^?g_V+@ICV/O\ZEaE2P2<17F1B@,(Hc<ZT
ODb4;\F#Fe5g+AW5g4&\Fg5@A&G85:32M\bKJK4Y.WcHbJ6cI]K_<PZZS]W>M:O<
Q.SfZ3__80Xa[dcB<XP4+5_)g/>Z96I94YKKb^QLB&JU-bO&O+4fRZ-14FNc3PM]
?MS@GOc,Q6,@Ge^e8X.fCX01LF>FOJ=L[(J-Cf?I]EgD+T@:cO\N0XB.K/S3XQ#b
c?4I):;X</>()A>aDHC\EEc#Ib+,>+&PO=2,KVR:ZYZ==J94NXdOa1@0f+PX\\P9
)PEDT#(+XgPKY,V/CAY:):7NOY9Rf)=<7.1)<P(D<1YSF_W<QRc3_f7Q81eHB.P8
7VG@6WOLWO)PK:EOdWeKULEWP3dE#HQ^d?641NWQ5N)MXPSD8OX&B^WCQ9-GdFJd
_@.&<WN#V_]@)E?9L&;[0=@7d#79[VP=7OZg92)P/;DCCfA(&+?bg1<MKAgT[AAb
U8@42->;4B,.YB86=.7,0;[C??ZAHF+a6gC+bELAX4=MKD:V]L[QeR,VLZe9Z]/c
>T+^OGQ)Wd:B\KD)AK-GQ)78ERJS8[]\5:3#aWfeIf)bN00PCY)D6W^X(<:b7aPb
EM00CO;9J?cBJNR;56PZ^[B@LUb>-12,#WT3<C)eO-[[d=@3VB-M(T@/KS]?)DTE
]LXPR0/W7_Z:XOI3XZML9(AI//+4GNM5>_IO>DNMA86Jg<NKe>Pgc94:\F.]Ie;Q
LV9<-2,dUZ7#7\VZJd7=-0EfgC2+42M3>OG\Cf=YUG8?6/R)/51)a.fDAd3VDWMd
?MbIZdR36D(IN6fY&C28_0^4bBPY,d3.3?&?65TVY77+#7gA?,57Gg\f?;N.#S/X
W42\Ce#ZfSfX<B,54@2?^0(ONY,[7YH;TH7:T>9]870_c70(57+J90GJN\9#+(Z4
+e5c]^.4(USG,;&Q6I7VfXV36BbY,6C)S7KZUM\=.d]YJQeFXPS+9AcDO.:/8CTI
e-IT:--AQ20_TDA2(RUL1S_9MGG84dCTSe+IQgX\MDFB^TB_OC2/V[;dO@MZ1.34
U8(0D1_V;Y]X+@/@b7U<Z=L14>HV@Z;[LP-=_17>U&K,?6Q#OWA1b4II(-K?V]7;
#H?Ba/g\PX?BV6Ze7(.Z0HA6)HKIQ/Q]9->_E3]AMcA=6d[UdRbD<R&8>d2O,gSL
3..[gL2?@NUID9OX6;9c&7=TH1AWGCU+2U,MXHFK:1LH7?CXCaG_CJ;L=I^NdL:0
U4T[NQ-)a]:VdWeL?EYIW0+,E/cZDVD:BN8gOFVOFgE7c8:QYKIGUgZT/Z;JCcTN
]H9P973D;+J5=acXL]dYL4bU=JL]g6H9c</Q=fLIG8X[.CgCAI^4DCfAX4[-[Nd(
H[FY1VQO(/P4[]A(NE^5-eZK6-+\>-=#f0:F^WTM>ESBR;ZdW7ALB?E9_?#VJ,0Y
c;agdaULg,XMUOL54VBS:NYG46Y8-ggRg_X_0\@bT2Q(?Y&OU36Q,EMN)W2PZ2c@
R=G=[>\C[J+V4c\;S^DQ_F6/&]<.L((F]OU]Ze7?7?1M#D;8Q0KcS1/DH0gdD[Bb
Na3#_VYZB1Pd;46_H/]I;V(bK.G2/8fJ<LMPB@>d_T[]+3W?O(3L:&_A:A?N&)E]
\<Q-4=QbgMCg\Ic2.LAcN^_3-(G2B&:FV=65B/XRf.&HVO-Ne^N88L9H_0Q.)NQH
._4>?aQ.+V5Z@0d68PYa8=_?A>D0ABQ<UWHOISU\N(\2bRJa8cN3<OM7[R@(=LEX
F);HGY-R11ZGFZ)I&SN(W_;TC5OCS:7E)6,C,NC#Ae8GV6JR]@]?=AF(:[T?NC4G
g?&=&-R8Tb6<LK6IPQ5M-gLQH5f,#)b([C<0gRNX_H^VZ7EDPU49c1[B];#5M7).
0aWdb2YD9d5_e0]XT3357BVQ7:8@P4ZcBQXTXG<f0.Zg5eWB(,d5Cf:63Q@K7NVD
S2=89]URcXN:]P,eUW.)Q7D[=NN^_Q[><J3cGK,[U<cR:fQf_ACB11;B>PUa;a[M
+3K&NECM(aAFQT6SNX(:Gg4V&;XP?LQ&[g^2c?EK?KV]b<P;TKPMOOb3U(DAL:)K
\4(;3dV2IEW[e<.[,,VR[dI;UT112):fZ(fU8?fZYXQMf_/D,aXVgWBME5eFI&M?
]c7?WN_JJZ^_8B?:EA6]a#IL_J5@^_T\\>:_Z4O)<>NZC0FfWEY\NM46.&L?MO6:
_A\Cc17W0e1B41A8RDZZP@YfDULXANfK+0fK]S+_QSL1<4Z03K6^eJ0C[GeSL[6R
2B,1,/5L]9f)_/J#R2XXO7E&1<U(#)V^T.a5IJWL5:0gV+^I;;.P7Z6)1gc>,<M6
KLFd,WGa24<LP&dV^2I:=FY8?E6.DI4P+d\1RP+9QYSdE)\6M(9X,X2N0e/DYAf#
UXPAa?45IS/==M98RAE^Z.)LICH_K,<I9(9CRF59T1gM6d+LZ3Z]ObEeJ81g]QC6
gF-2-Pd?CNB1>bMLTQI>OX:aG@R2IIZ1B;NNMO2T=2MS5Ia1-cC0M4L/?^^?0BY]
&fNUZQZ_Y#U7>ee5.CbQKT>NWJcWY1Z.WHU)_5=bVFYCM=607:d_[Y9G-e09Fe>H
f6+a8TBGA4;Y7\2=G-f\WE,/)(M;O._(]]HL2d?4T+OVSbIVACbS@2[6>QO5_+K]
04f-?J].5INd(=3ZFbKGJGVd[#fH,g>aMNbgeSQTC5dJ5\7K,TF3L@@gUYdG8LMG
J73:=H76b]R-OY+2M^3QZ2XgPfb(Hd-\[+.8R4X\_9BNIdB93dB_XL^3RHHgW:>T
415L0;?AdAKbJP)[P<G<Y/O<SAR^]YEWgObXe0dR/_/B^XTJ3e&LZ-D;JPHg[Y(:
46HLBZ1V]9(/]F);ESeb0XRY1HC_OAAA^.B>Z44GZ/8Lc7[4<(@63Y=6aOQDI@ZJ
4+FM8WTCaPZ,1Td?Q-0P5S3X:U)CVPOT71Xa<LB9e&F&&F8HZQ)4+R_SETMdBC9B
SQ#X@<dZdZ..7D\R2MLOg0\OKABb9gVDEg<AO#5WU>af158LEKW?+L4?:7O8=FfU
\XB<,eK?W3YMT@K);d=bU6T@ER&W[E@VV=bee(gB-O0C#]##]4O6D<86DD8T>\Gd
H#=2+?e;BHfX1?Ab]<IKY[c.S9QRbcPZXYSZ1,9QLD9Y;]R7_5_GcdDP2]bA<dK\
W+//I07eD)&MFf<>1>7/)S;E:g8dU+g,UB6#8<]RM)bC:W6Z2=RXYf=;ZJII_8b5
SQ5#d0N/)K6E^#YN&X6/)VN#6XO0]Eda5N-g#VgMH[dJ/-<e&(,8NCD0[+W;\-64
M.A)5B<HUUed4D1[#36(=:DeDG2.>WS5P\1Tf7GSH/BQEeR8a=8RX-6Y1=]U,[=K
+J@?Vc7BS^I>;g-/796Q[D54;=ON_/eC4.^T]<7Ld;/FdeHT4]OFA0=P[/T9:;&G
3S.2Z3XUDa,S1_[@C[C7JLAQE3_M6AcF1Q@@d@?&?88JZ:cTNL\9SU_ba]-ZJ:Cc
GXC3[@70Z<UERS3EWZVP;)38+0IRV#KH)\#EM00^X>.-(P35.F)#[D[a</P29/A8
+Ed0P[SXJ?D)C7,V6&23VPd>gBXZG4D&QF5SXWU];NK]e^Q0OEW[O(X1<^,BJX@9
5:gJd?+._\R+V3;>)=DFOQ26.U:SS()U=0[S?G^=<OWUD&O9BL+JXU:b+A/fg_#\
8f@1KW_4-#b;[0)bZZ=)N/IIA^/EQVc-SY>]1Q==ddE2UI^F@gb]dM,4.&RB7YS=
O24<3PZ?06-ZGO.O1QPODF00I&8.e@],dPPAA4]-[#.VH,<FC.Z>@[\OP5gX\+e4
2^+Fe2DZ;QT,98_aF@KX&IX^;O^\K:+XX01]-+&4[X#,/LTCY5+B-^f/_?TNfgPL
baMbE;]fB[Fb8L,Z;1D/W\)[;/V0c)&4KN5e)#)I7+5[<9cB8ADRf=[F,&W2R\[/
S6YXA82NWB91LeKaC2g-;D4+D^/D)Fg7:Zg/Sc0M5WIW#.S+d.IJJJ_aEAAHU>9T
K&_L\Q_gG&(f/JX)]PSe)0P77S.gg\NEFP<B,Z8K<&GY]F#\G?Ef-+E36^VJKM)#
RO^&M3X8LTZBCVc6&Q@DgYRLOB@=<)Yf[2Pf]W=>6ae=WQHF_IXA=MfOQ^?JNcCN
7fb.P[545VMUQ\gKJQ4>I(PH=+1f=JZ(/\cGfd(B4LdS24@/8,KIVR7_YDQG.>R#
c4:Y?T)YNTRBB=T6W[0UD-@U;)P?;VNYaDYCH7@[5UeUJ^>Pc8<9+C_>Xb<T/H&S
HNR:XNJ.[UK[YEGS^Jd+Oc@Y<6Eg_=0B++9U9fOBOGMb).LO8-W&)acZ4:Ib,_QP
)_+DU))BCdDC6<P5g,(Qe&LY.NC>NfA4L<&#,DS:24H(/Q0aag<I9eULL-eH3C2b
\c^^g/JAIK.8OP):S&U;D-[:Z,c78&WeT;c40eOg-ICTT\JXZ\Pgf=D_O9=LS@-?
7N.:ID?K9\YdP5&KSJ^3&L3O,aZINa:55+&@VE7C7XC/L<YG-\)COUF]dL&Cc2,\Q$
`endprotected

  endtask

  // Directed assignment of snoop response. Not currently used.
  task prepare_snoop_response(svt_axi_master_snoop_transaction xact);

    //for cache backdoor access.
    bit   is_unique, is_clean;
    bit [7:0]   data[];
    bit poison[];
    longint   index,age;

    //svt_axi_cache cache;
    string  snoop_xact_type;
    string  pre_state;
    bit   read_status;
  
    //for user-defined snoop response
    bit   IsShared_rand = $random;
    bit   PassDirty_rand =$random;
    bit   WasUnique_rand =$random;
    bit   DataTransfer_rand=$random;
    bit   RespError_rand=$random;
    bit   disable_snoop_response_error = 0;

    `svt_amba_debug("prepare_snoop_response","prepare_snoop_response task is used to setup snoop response");
      //=====================================================================
      //step1:get cache state information
      //=====================================================================

      //gets the state/data from snooped cache
      case(xact.snoop_initial_cache_line_state.name())
    "INVALID":    pre_state="I";
    "SHAREDDIRTY":pre_state="SD";
    "SHAREDCLEAN":pre_state="SC";
    "UNIQUEDIRTY":pre_state="UD";
    "UNIQUECLEAN":pre_state="UC";
      endcase
      snoop_xact_type=xact.snoop_xact_type.name();
      foreach(data[i])
        if(pre_state != "I") 
           data[i]=xact.snoop_initial_cache_line_data[i];

      //=====================================================================
      //step2:prepare the snoop response/data
      //=====================================================================
      //------------------------------------------------------------------
      // if snooped master doesn't have the copy 
      //------------------------------------------------------------------
      if(pre_state=="I") begin//I->I
        xact.snoop_resp_wasunique = 0;
        xact.snoop_resp_datatransfer = 0;
        xact.snoop_resp_passdirty = 0;
        xact.snoop_resp_isshared = 0;
        xact.snoop_resp_error = 0;
      end
      //------------------------------------------------------------------
      // if snooped master has the copy 
      //------------------------------------------------------------------
      else 
        case(snoop_xact_type)
      //------------------------------------------------------------------
      // 6.10.1 ReadOnce
      //------------------------------------------------------------------
    "READONCE": begin
  case(pre_state)
  "UC":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = DataTransfer_rand;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "UD":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = PassDirty_rand;
          xact.snoop_resp_isshared = IsShared_rand;
    if(xact.snoop_resp_passdirty==0) xact.snoop_resp_isshared=1;
    if(xact.snoop_resp_isshared==0)  xact.snoop_resp_passdirty=1;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SC":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = DataTransfer_rand;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SD":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = PassDirty_rand;
          xact.snoop_resp_isshared = IsShared_rand;
                if(xact.snoop_resp_passdirty==0) xact.snoop_resp_isshared =1;
                if(xact.snoop_resp_isshared==0) xact.snoop_resp_passdirty =1;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  endcase
      end//ReadOnce
      //------------------------------------------------------------------
      // 6.10.2 ReadClean/ReadNotSharedDirty/ReadShared
      //------------------------------------------------------------------
     "READCLEAN",
     "READNOTSHAREDDIRTY",
     "READSHARED": begin  
  case(pre_state)
  "UC":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = DataTransfer_rand;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "UD":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = PassDirty_rand;
          xact.snoop_resp_isshared = IsShared_rand;
                if(xact.snoop_resp_passdirty==0) xact.snoop_resp_isshared =1;
                if(xact.snoop_resp_isshared==0) xact.snoop_resp_passdirty =1;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SC":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = DataTransfer_rand;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SD":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = PassDirty_rand;
          xact.snoop_resp_isshared = IsShared_rand;
                if(xact.snoop_resp_passdirty==0) xact.snoop_resp_isshared =1;
                if(xact.snoop_resp_isshared==0) xact.snoop_resp_passdirty =1;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  endcase
     end//ReadOnce

      //------------------------------------------------------------------
      // 6.10.3 ReadUnique
      //------------------------------------------------------------------
     "READUNIQUE": begin  
  case(pre_state)
  "UC":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = DataTransfer_rand;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "UD":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = 1;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SC":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = DataTransfer_rand;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SD":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = 1;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  endcase
     end//ReadOnce

      //------------------------------------------------------------------
      // 6.10.4 CleanInvalid
      //------------------------------------------------------------------
     "CLEANINVALID": begin  
  case(pre_state)
  "UC":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "UD":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = 1;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SC":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SD":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = 1;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  endcase
     end//CleanInvalid
      //------------------------------------------------------------------
      // 6.10.5 MakeInvalid
      //------------------------------------------------------------------
     "MAKEINVALID": begin   
  case(pre_state)
  "UC":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "UD":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SC":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SD":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  endcase
     end//MakeInvalid

      //------------------------------------------------------------------
      // 6.10.6 CleanShared
      //------------------------------------------------------------------
     "CLEANSHARED": begin   
  case(pre_state)
  "UC":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "UD":begin
         if(xact.port_cfg.allow_was_unique_zero_in_unique_state)
           xact.snoop_resp_wasunique = WasUnique_rand;  
         else
           xact.snoop_resp_wasunique = 1;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = 1;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SC":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  "SD":begin
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 1;
          xact.snoop_resp_passdirty = 1;
          xact.snoop_resp_isshared = IsShared_rand;
          if(xact.snoop_resp_datatransfer)
          xact.unpack_byte_stream_to_data(data,xact.snoop_data);
           end
  endcase
     end//CleanShared
    default: begin // DVMMESSAGE, DVMCOMPLETE
        xact.snoop_resp_wasunique = 0;  
          xact.snoop_resp_datatransfer = 0;
          xact.snoop_resp_passdirty = 0;
          xact.snoop_resp_isshared = 0;
             end
    endcase

    // force error free response if it is disabled
    if(disable_snoop_response_error == 1)
       xact.snoop_resp_error = 0;
    else
       xact.snoop_resp_error = RespError_rand;

  endtask

endclass: svt_axi_ace_master_snoop_response_sequence

`ifndef SVT_EXCLUDE_VCAP          
/** @cond PRIVATE */
/** 
 * This sequence executes the traffic profile in its m_traffic_profile property
 * 
 * The traffic profile is not randomized before being sent to the sequencer.
 */
class svt_axi_traffic_profile_profile_dispatch_seq extends svt_sequence;

  /** The traffic profile transaction to execute */
  svt_axi_traffic_profile_transaction m_traffic_profile;

  `svt_xvm_declare_p_sequencer(svt_axi_master_traffic_profile_sequencer)

  `svt_xvm_object_utils_begin(svt_axi_traffic_profile_profile_dispatch_seq)
  `svt_field_object(m_traffic_profile, `SVT_XVM_ALL_ON, `SVT_HOW_REF)
  `svt_xvm_object_utils_end

  extern function new(string name="svt_axi_traffic_profile_profile_dispatch_seq");

  virtual task pre_body();
    raise_phase_objection();
  endtask

  virtual task body();
    `svt_xvm_send(m_traffic_profile);
  endtask: body

  virtual task post_body();
    drop_phase_objection();
  endtask

  virtual function bit is_applicable(svt_configuration cfg);
    return 0;
  endfunction : is_applicable
endclass 

`protected
>,=T+Oe7FO/Z5-GI:[L9I<LUa>R4)JIL-=?XFKZ16#<#BKg-5+bU())]e0[A9B0e
Jb<G@U728]\8+ALGYfFM(>DCfgIWae,^QS5UPd3e3cT9fCQ1UOff[+>G3gH5VZH(
>E+RcR08b0/9F\LY+@?bA]P[TfG:>fT][G4\dS<#?TaYDe=BHW.6@HOHWIQ2(94V
Ea1cYK50cOWLSTE7Z2@\Y;8D)ZLO6eCPUbC<S(c^Kb5#Tcc3<&dB]3@SJ#>75.[G
N#Fc#Q#?L1AKN4#/XRVRYc8D4$
`endprotected


/** @endcond */

/**
 * This is a layering sequence that accepts transactions of type
 * svt_axi_traffic_profile_transaction and converts them to transactions
 * of type svt_axi_master_transaction. There is a one to many relationship between
 * the traffic profile transaction and AXI protocol transactions, so one
 * traffic profile transaction may be converted to more than one AXI protocol
 * transactions. 
 * This sequence is not expected to be used directly by users. It is used internally
 * by the VIP when svt_axi_port_configuration::use_traffic_profile is set
 */
class svt_axi_master_traffic_profile_sequence extends svt_axi_master_base_sequence;
 
  `svt_xvm_object_utils(svt_axi_master_traffic_profile_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  /** Handle to the master agent */
  local  svt_axi_master_agent              my_agent;

  /** Semaphore for acess to sequencer */
  semaphore seqr_sema;

  /** Semaphore for acess to the active queue*/
  semaphore active_xact_queue_sema;

  /** Queue of active transactions */
  `SVT_AXI_MASTER_TRANSACTION_TYPE active_xact_queue[$];


  /** Class Constructor */
  function new(string name="svt_axi_master_traffic_profile_sequence");
    super.new(name);
    seqr_sema = new(1);
    active_xact_queue_sema = new(1);
  endfunction

  /** UVM sequence body task */ 
  virtual task body();
    `SVT_XVM(component)               my_component;
    /** Handles for configurations. */
    svt_configuration get_cfg;

    int traffic_profile_object_num = 0;
   
    super.body();

    my_component = p_sequencer.get_parent();
    void'($cast(my_agent,my_component)); 
   
    // This is a forever loop. It is put in a fork-join_none because
    // the base class raises and drops objection in pre_body and post_body
    // So we must exit this sequence 
    fork
    begin
      forever begin
        svt_axi_traffic_profile_transaction axi_traffic_profile_xact;
        p_sequencer.traffic_profile_seq_item_port.get(axi_traffic_profile_xact);
        // Callback used to modify the contents of traffic profile
        `uvm_do_obj_callbacks(svt_axi_master_sequencer,svt_axi_traffic_profile_callback,this.p_sequencer,post_traffic_profile_seq_item_port_get(axi_traffic_profile_xact))
        if (axi_traffic_profile_xact.cfg == null)
          axi_traffic_profile_xact.cfg = this.cfg;

        if (axi_traffic_profile_xact.is_valid(0)) begin
          send_axi_traffic_profile(axi_traffic_profile_xact,traffic_profile_object_num);
        end
        else begin
          `svt_xvm_error("body", $sformatf("Received AXI traffic profile transaction is not a valid transaction. Xact: %0s", axi_traffic_profile_xact.`SVT_DATA_PSDISPLAY()));
        end
        traffic_profile_object_num++;
      end
    end
    join_none
  endtask

  /** Converts the received AXI traffic profile transaction to AXI protocol transactions
    * and sends it to the driver
    */
  task send_axi_traffic_profile(svt_axi_traffic_profile_transaction axi_traffic_profile_xact, int traffic_profile_object_num);

    /** Value of ID that will be assigned to the current transaction */
    bit[`SVT_AXI_MAX_ID_WIDTH-1:0] curr_id = '1;

    /** Last value of data used */
    bit[`SVT_AXI_MAX_DATA_WIDTH-1:0] last_data = '1;

    /** Value of data that will be assigned to the current transaction */
    bit[`SVT_AXI_MAX_DATA_WIDTH-1:0] curr_data[];

    /** Value of address that will be assigned to the current transaction */
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] curr_addr = '1;

    /** Base address of the current block of address if the pattern used is TWODIM*/
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] two_dim_base_addr = 0;

    /** Burst length of transactions generated */
    int axi_burst_length;

    /** Burst size of transactions generated */
    int axi_burst_size;

    /** Number of times a traffic profile must be sent */
    int traffic_profile_xmit_count = 1;

    /** Handle to the FIFO rate control class for WRITE xacts */
    svt_axi_fifo_rate_control write_xact_fifo_rate_control;

    /** Handle to the FIFO rate control class for READ xacts*/
    svt_axi_fifo_rate_control read_xact_fifo_rate_control; 

    axi_burst_length = (axi_traffic_profile_xact.xact_size/8)/(cfg.data_width/8);
    // This happens when xact_size is less than data_width
    if (axi_burst_length == 0) begin
      axi_burst_length = 1;
      axi_burst_size = cfg.log_base_2(axi_traffic_profile_xact.xact_size/8);
    end
    else
      axi_burst_size = cfg.log_base_2(cfg.data_width/8);

    `svt_xvm_debug("send_axi_traffic_profile", $sformatf("Converting traffic profile transaction %0d (handle: %0d. profile_name: %0s. group_name: %0s) to AXI transactions. port_id: %0d.  data_width = %0d. xact_size: %0d. total_num_bytes: %0d. burst_length = %0d %0s.", traffic_profile_object_num, axi_traffic_profile_xact, axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.group_name, cfg.port_id, cfg.data_width, axi_traffic_profile_xact.xact_size, axi_traffic_profile_xact.total_num_bytes, axi_burst_length, axi_traffic_profile_xact.`SVT_DATA_PSDISPLAY()));

    two_dim_base_addr = axi_traffic_profile_xact.base_addr;
    track_output_events(axi_traffic_profile_xact);

    if (axi_traffic_profile_xact.write_fifo_cfg != null) begin
      real rate_divisor = 1000/cfg.clock_period;
      write_xact_fifo_rate_control = new({axi_traffic_profile_xact.profile_name,":write_xact_fifo_rate_control"});
      write_xact_fifo_rate_control.rate_divisor = rate_divisor;
      write_xact_fifo_rate_control.fifo_cfg = axi_traffic_profile_xact.write_fifo_cfg;
      write_xact_fifo_rate_control.fifo_cfg.fifo_type = svt_fifo_rate_control_configuration::WRITE_TYPE_FIFO;
      write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle = axi_traffic_profile_xact.write_fifo_cfg.rate/rate_divisor;
      write_xact_fifo_rate_control.reset_all();
      write_xact_fifo_rate_control.axi_common = my_agent.get_master_common();
      write_xact_fifo_rate_control.update_fifo_levels_every_clock();
      track_fifo_underflow_and_overflow(write_xact_fifo_rate_control);
    end

    if (axi_traffic_profile_xact.read_fifo_cfg != null)  begin
      real rate_divisor = 1000/cfg.clock_period;
      read_xact_fifo_rate_control = new({axi_traffic_profile_xact.profile_name,":read_xact_fifo_rate_control"});
      read_xact_fifo_rate_control.rate_divisor = rate_divisor;
      read_xact_fifo_rate_control.fifo_cfg = axi_traffic_profile_xact.read_fifo_cfg;
      read_xact_fifo_rate_control.fifo_cfg.fifo_type = svt_fifo_rate_control_configuration::READ_TYPE_FIFO;
      read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle = axi_traffic_profile_xact.read_fifo_cfg.rate/rate_divisor;
      read_xact_fifo_rate_control.reset_all();
      read_xact_fifo_rate_control.axi_common = my_agent.get_master_common();
      read_xact_fifo_rate_control.update_fifo_levels_every_clock();
      track_fifo_underflow_and_overflow(read_xact_fifo_rate_control);
    end

    traffic_profile_xmit_count = axi_traffic_profile_xact.num_repeat + 1;

    fork
    begin
      bit rand_result;
      `SVT_AXI_MASTER_TRANSACTION_TYPE axi_master_xacts[$];
      int curr_num_bytes = 0;

      for (int i = 0; i < traffic_profile_xmit_count; i++) begin : tag_for_xmit_count
        `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s num_repeat: %0d. curr_repeat_count: %0d ",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.num_repeat, axi_traffic_profile_xact.curr_repeat_count));

        // Restore to defaults
        curr_id = '1;
        last_data = '1;
        curr_addr = '1;
        curr_num_bytes = 0;
        `uvm_do_obj_callbacks(svt_axi_master_sequencer,svt_axi_traffic_profile_callback,this.p_sequencer,pre_traffic_profile_to_protocol_xact_mapping(axi_traffic_profile_xact));

        while (curr_num_bytes < axi_traffic_profile_xact.total_num_bytes) begin : tag_while_bytes_remain
          `SVT_AXI_MASTER_TRANSACTION_TYPE axi_xact;
          `svt_xvm_create(axi_xact);
          axi_xact.port_cfg = cfg;

          update_xact_addr(axi_xact,axi_traffic_profile_xact,curr_addr,two_dim_base_addr);
          update_xact_id(axi_xact,axi_traffic_profile_xact,curr_id);
          update_xact_data(axi_xact,axi_traffic_profile_xact,axi_burst_length,last_data,curr_data);
          rand_result = axi_xact.randomize() with
             { 


               if (axi_traffic_profile_xact.addr_gen_type == svt_axi_traffic_profile_transaction::RANDOM_ADDR) {
                 axi_xact.addr inside {[axi_traffic_profile_xact.base_addr:(axi_traffic_profile_xact.base_addr + axi_traffic_profile_xact.addr_xrange - 1 - axi_traffic_profile_xact.xact_size/8)]};
               } else {
                 axi_xact.addr == curr_addr;
               }

               if (axi_traffic_profile_xact.data_gen_type == svt_axi_traffic_profile_transaction::RANDOM) { 
                 foreach (axi_xact.data[i])
                   axi_xact.data[i] inside {[axi_traffic_profile_xact.data_min:axi_traffic_profile_xact.data_max]};
               } else { 
                 foreach (axi_xact.data[i])
                   axi_xact.data[i] == curr_data[i];
               }
    
               if (axi_traffic_profile_xact.id_gen_type == svt_axi_traffic_profile_transaction::FIXED) {
                 axi_xact.id == axi_traffic_profile_xact.id_min;
               } else if ((axi_traffic_profile_xact.id_gen_type == svt_axi_traffic_profile_transaction::CYCLE) || (axi_traffic_profile_xact.id_gen_type == svt_axi_traffic_profile_transaction::UNIQUE)) {
                  axi_xact.id == curr_id;
               }

               if (axi_traffic_profile_xact.xact_gen_type == svt_axi_traffic_profile_transaction::FIXED) {
                 if (!(cfg.axi_interface_type == svt_axi_port_configuration::AXI_ACE ||
                       cfg.axi_interface_type == svt_axi_port_configuration::ACE_LITE)) {
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::WRITENOSNOOP) -> (axi_xact.xact_type == svt_axi_transaction::WRITE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READNOSNOOP) -> (axi_xact.xact_type == svt_axi_transaction::READ);
                 } else {
                   axi_xact.xact_type == svt_axi_transaction::COHERENT;
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::WRITENOSNOOP) -> (axi_xact.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::WRITEUNIQUE) -> (axi_xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::WRITELINEUNIQUE) -> (axi_xact.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::MAKEUNIQUE) -> (axi_xact.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::CLEANUNIQUE) -> (axi_xact.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READUNIQUE) -> (axi_xact.coherent_xact_type == svt_axi_transaction::READUNIQUE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READNOSNOOP) -> (axi_xact.coherent_xact_type == svt_axi_transaction::READNOSNOOP);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READSHARED) -> (axi_xact.coherent_xact_type == svt_axi_transaction::READSHARED);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READCLEAN) -> (axi_xact.coherent_xact_type == svt_axi_transaction::READCLEAN);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READNOTSHAREDDIRTY) -> (axi_xact.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READONCE) -> (axi_xact.coherent_xact_type == svt_axi_transaction::READONCE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::READUNIQUE) -> (axi_xact.coherent_xact_type == svt_axi_transaction::READUNIQUE);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::WRITEBACK) -> (axi_xact.coherent_xact_type == svt_axi_transaction::WRITEBACK);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::WRITECLEAN) -> (axi_xact.coherent_xact_type == svt_axi_transaction::WRITECLEAN);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::EVICT) -> (axi_xact.coherent_xact_type == svt_axi_transaction::EVICT);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::WRITEEVICT) -> (axi_xact.coherent_xact_type == svt_axi_transaction::WRITEEVICT);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::CLEANINVALID) -> (axi_xact.coherent_xact_type == svt_axi_transaction::CLEANINVALID);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::CLEANSHARED) -> (axi_xact.coherent_xact_type == svt_axi_transaction::CLEANSHARED);
                   (axi_traffic_profile_xact.xact_type == svt_axi_traffic_profile_transaction::MAKEINVALID) -> (axi_xact.coherent_xact_type == svt_axi_transaction::MAKEINVALID);
                 }
               }
               // Assign burst_length only for non-cache line size transactions
               // For cache-line size transactions VIP constraints will take effect
               if (
                    (
                      (axi_xact.xact_type == svt_axi_transaction::WRITE) ||
                      (axi_xact.xact_type == svt_axi_transaction::READ)
                    ) ||
                    (
                      (axi_xact.xact_type == svt_axi_transaction::COHERENT) &&
                      (
                        (axi_xact.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP) ||
                        (axi_xact.coherent_xact_type == svt_axi_transaction::READNOSNOOP) ||
                        (axi_xact.coherent_xact_type == svt_axi_transaction::READONCE) ||
                        (axi_xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE) 
                      )
                    )
                  )
                 axi_xact.burst_length == axi_burst_length;
               axi_xact.burst_size == axi_burst_size;
               axi_xact.burst_type inside {svt_axi_transaction::INCR,svt_axi_transaction::WRAP};
               axi_xact.atomic_type == svt_axi_transaction::NORMAL;
               axi_xact.cache_type inside {[axi_traffic_profile_xact.cache_type_min:axi_traffic_profile_xact.cache_type_max]};
               if (axi_traffic_profile_xact.prot_gen_type == svt_axi_traffic_profile_transaction::FIXED) {
                 if (axi_traffic_profile_xact.prot_type_fixed == svt_axi_traffic_profile_transaction::SECURE) {
                   axi_xact.prot_type inside {svt_axi_transaction::DATA_SECURE_NORMAL,
                                     svt_axi_transaction::DATA_SECURE_PRIVILEGED,
                                     svt_axi_transaction::INSTRUCTION_SECURE_NORMAL,
                                     svt_axi_transaction::INSTRUCTION_SECURE_PRIVILEGED
                                    };
                  } else {
                   axi_xact.prot_type inside {svt_axi_transaction::DATA_NON_SECURE_NORMAL,
                                     svt_axi_transaction::DATA_NON_SECURE_PRIVILEGED,
                                     svt_axi_transaction::INSTRUCTION_NON_SECURE_NORMAL,
                                     svt_axi_transaction::INSTRUCTION_NON_SECURE_PRIVILEGED
                                    };
                  }
               }
               if (axi_traffic_profile_xact.qos_gen_type == svt_axi_traffic_profile_transaction::FIXED)
                 axi_xact.qos == axi_traffic_profile_xact.qos_min;

               axi_xact.reference_event_for_addr_valid_delay == svt_axi_transaction::PREV_ADDR_VALID;
               if (`SVT_AXI_COHERENT_READ || (xact_type == READ)) {
                 axi_xact.addr_valid_delay inside {[(axi_traffic_profile_xact.artv_min-1):(axi_traffic_profile_xact.artv_max-1)]};
                 axi_xact.reference_event_for_rready_delay == svt_axi_transaction::RVALID;
                 foreach (axi_xact.rready_delay[i])
                   axi_xact.rready_delay[i] == axi_traffic_profile_xact.rbr; 
                 reference_event_for_rack_delay == svt_axi_transaction::LAST_READ_DATA_HANDSHAKE;
                 rack_delay == axi_traffic_profile_xact.rla;
               } else {
                 axi_xact.addr_valid_delay inside {[(axi_traffic_profile_xact.awtv_min-1):(axi_traffic_profile_xact.awtv_max-1)]};
                 axi_xact.reference_event_for_next_wvalid_delay == svt_axi_transaction::PREV_WRITE_HANDSHAKE;
                 foreach (axi_xact.wvalid_delay[i]) 
                   axi_xact.wvalid_delay[i] == axi_traffic_profile_xact.wbv-1;
                 axi_xact.reference_event_for_bready_delay == svt_axi_transaction::BVALID;
                 axi_xact.bready_delay == axi_traffic_profile_xact.br;
                 axi_xact.reference_event_for_wack_delay == svt_axi_transaction::WRITE_RESP_HANDSHAKE;
                 axi_xact.rack_delay == axi_traffic_profile_xact.ba;
               }
             };

           axi_xact.store_causal_ref(axi_traffic_profile_xact);
           `uvm_do_obj_callbacks(svt_axi_master_sequencer,svt_axi_traffic_profile_callback,this.p_sequencer,pre_traffic_profile_xact_send(axi_traffic_profile_xact,axi_xact));
           if(axi_traffic_profile_xact.suspend_xact) begin
             `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Waiting for it to become 0 ",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
             if (write_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Stopping dynamic rate timer of write_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               write_xact_fifo_rate_control.stop_dynamic_rate_timer();
             end
             if (read_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Stopping dynamic rate timer of read_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               read_xact_fifo_rate_control.stop_dynamic_rate_timer();
             end
             wait(axi_traffic_profile_xact.suspend_xact ==0);
             if (write_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Restarting dynamic rate timer of write_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               write_xact_fifo_rate_control.restart_dynamic_rate_timer();
             end
             if (read_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Restarting dynamic rate timer of read_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               read_xact_fifo_rate_control.restart_dynamic_rate_timer();
             end
             `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d.",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
           end
           wait_for_fifo_fill_level(axi_traffic_profile_xact,axi_xact,write_xact_fifo_rate_control,read_xact_fifo_rate_control);
           seqr_sema.get();
           `svt_xvm_debug("send_axi_traffic_profile",
           $sformatf("About to call svt_xvm_send. Converted traffic profile transaction %0d (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d profile_name: %0s group_name: %0s) to AXI transaction. Xact: %0s", 
           traffic_profile_object_num, axi_traffic_profile_xact.xact_size.name(), axi_traffic_profile_xact.base_addr, axi_traffic_profile_xact.total_num_bytes, axi_traffic_profile_xact, axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.group_name, `SVT_AXI_PRINT_PREFIX1(axi_xact)));

           `svt_xvm_send(axi_xact);

           `svt_xvm_debug("send_axi_traffic_profile",
           $sformatf("Converted traffic profile transaction %0d (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d curr_num_bytes: %0d handle: %0d profile_name: %0s group_name: %0s) to AXI transaction. Xact: %0s", 
           traffic_profile_object_num, axi_traffic_profile_xact.xact_size.name(), axi_traffic_profile_xact.base_addr, axi_traffic_profile_xact.total_num_bytes, curr_num_bytes, axi_traffic_profile_xact, axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.group_name, `SVT_AXI_PRINT_PREFIX1(axi_xact)));
           active_xact_queue_sema.get();
           active_xact_queue.push_back(axi_xact);
           active_xact_queue_sema.put();
           track_transaction(axi_xact, axi_traffic_profile_xact, write_xact_fifo_rate_control, read_xact_fifo_rate_control);
           seqr_sema.put();
           curr_num_bytes += axi_xact.get_byte_count();
           update_current_byte_count(axi_xact,axi_traffic_profile_xact);
           axi_master_xacts.push_back(axi_xact);
           `uvm_do_obj_callbacks(svt_axi_master_sequencer,svt_axi_traffic_profile_callback,this.p_sequencer,post_traffic_profile_xact_send(axi_traffic_profile_xact,axi_xact));
           if(axi_traffic_profile_xact.suspend_xact) begin
             `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Waiting for it to become 0 ",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
             if (write_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Stopping dynamic rate timer of read_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               write_xact_fifo_rate_control.stop_dynamic_rate_timer();
             end
             if (read_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Stopping dynamic rate timer of read_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               read_xact_fifo_rate_control.stop_dynamic_rate_timer();
             end
             wait(axi_traffic_profile_xact.suspend_xact ==0);
             if (write_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Restarting dynamic rate timer of write_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               write_xact_fifo_rate_control.restart_dynamic_rate_timer();
             end
             if (read_xact_fifo_rate_control != null) begin
               `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d. Restarting dynamic rate timer of read_xact_fifo_rate_control",axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.suspend_xact));
               read_xact_fifo_rate_control.restart_dynamic_rate_timer();
             end
             `svt_xvm_note("send_axi_traffic_profile", $sformatf("Profile: %0s suspend_xact is seen as  %0d.",axi_traffic_profile_xact.suspend_xact, axi_traffic_profile_xact.profile_name));
           end
         end : tag_while_bytes_remain
         axi_traffic_profile_xact.curr_repeat_count++;
       end : tag_for_xmit_count

       // reset values to defaults
       curr_addr = '1;
       last_data = '1;
       curr_id = '1;

       foreach (axi_master_xacts[i]) begin
         axi_master_xacts[i].wait_for_transaction_end();
         `svt_xvm_debug("send_axi_traffic_profile", 
         $sformatf("Converted AXI transaction (%0d of %0d) has ended (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d) to AXI transaction. Xact: %0s", 
         traffic_profile_object_num, axi_master_xacts.size(), axi_traffic_profile_xact.xact_size.name(), axi_traffic_profile_xact.base_addr, axi_traffic_profile_xact.total_num_bytes, axi_traffic_profile_xact, `SVT_AXI_PRINT_PREFIX1(axi_master_xacts[i])));
       end

      `svt_xvm_debug("send_axi_traffic_profile", $sformatf("Indicating end of traffic profile transaction %0d (handle: %0d profile_name: %0s group_name: %0s). port_id: %0d.  data_width = %0d. xact_size: %0d. total_num_bytes: %0d. burst_length = %0d", 
      traffic_profile_object_num, axi_traffic_profile_xact, axi_traffic_profile_xact.profile_name, axi_traffic_profile_xact.group_name, cfg.port_id, cfg.data_width, axi_traffic_profile_xact.xact_size, axi_traffic_profile_xact.total_num_bytes, axi_burst_length ));
       axi_traffic_profile_xact.end_tr($realtime);
    end
    join_none
  endtask 

  task wait_for_fifo_fill_level(svt_axi_traffic_profile_transaction axi_traffic_profile_xact, svt_axi_transaction xact, svt_axi_fifo_rate_control write_xact_fifo_rate_control, svt_axi_fifo_rate_control read_xact_fifo_rate_control);
      bit fifo_clk_flag = 0;
       // FIFO levels are incremented/decremented every clock. Wait for correct FIFO levels before proceeding
      if (xact.transmitted_channel == svt_axi_transaction::WRITE &&
          axi_traffic_profile_xact.write_fifo_cfg != null &&
          xact.is_appplicable_for_fifo_rate_control()) begin
        while (!write_xact_fifo_rate_control.check_fifo_fill_level(xact,.num_bytes(xact.power_of_2(xact.burst_size) * xact.get_burst_length()))) begin
          if (fifo_clk_flag == 0)
            `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Profile: %0s. Waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level)});   
          fifo_clk_flag = 1;
          my_agent.advance_clock(1); 
        end
        `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Profile: %0s. Done waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level)});   
      end
      else if (xact.transmitted_channel == svt_axi_transaction::READ &&
          axi_traffic_profile_xact.read_fifo_cfg != null &&
          xact.is_appplicable_for_fifo_rate_control()) begin
        while(!read_xact_fifo_rate_control.check_fifo_fill_level(xact,.num_bytes(xact.power_of_2(xact.burst_size) * xact.get_burst_length()))) begin
          if (fifo_clk_flag == 0)
            `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Profile: %0s. Waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   
          fifo_clk_flag = 1;
          my_agent.advance_clock(1); 
        end
        `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Profile: %0s. Done waiting for fifo levels: fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   
      end
  endtask

  /** Tracks the end of transaction */
  task track_transaction(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, svt_axi_traffic_profile_transaction axi_traffic_profile_xact, svt_axi_fifo_rate_control write_xact_fifo_rate_control, svt_axi_fifo_rate_control read_xact_fifo_rate_control);
    int _xact_index[$];
    int _num_bytes;
    _num_bytes = xact.power_of_2(xact.burst_size) * xact.get_burst_length();
    if (xact.transmitted_channel == svt_axi_transaction::WRITE &&
        axi_traffic_profile_xact.write_fifo_cfg != null &&
        xact.is_appplicable_for_fifo_rate_control()) begin
      write_xact_fifo_rate_control.update_total_expected_fill_levels(xact,svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, _num_bytes);
      `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Post item send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level)});   
    end
    else if (xact.transmitted_channel == svt_axi_transaction::READ &&
          axi_traffic_profile_xact.read_fifo_cfg != null &&
          xact.is_appplicable_for_fifo_rate_control()) begin
      read_xact_fifo_rate_control.update_total_expected_fill_levels(xact,svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE,_num_bytes);
      `svt_xvm_debug("wait_for_fifo_fill_level", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Post item send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   
    end

    fork
    begin

      if (xact.transmitted_channel == svt_axi_transaction::WRITE &&
          axi_traffic_profile_xact.write_fifo_cfg != null &&
          xact.is_appplicable_for_fifo_rate_control()) begin
        wait (xact.data_status == svt_axi_transaction::ACCEPT);
        write_xact_fifo_rate_control.update_fifo_levels_on_data_xmit(xact,_num_bytes);
        write_xact_fifo_rate_control.update_total_expected_fill_levels(
                xact,svt_fifo_rate_control::FIFO_REMOVE_FROM_ACTIVE,_num_bytes
                );
        `svt_xvm_debug("track_transaction", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Post i/f send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). write_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, write_xact_fifo_rate_control.amba_fifo_curr_fill_level, write_xact_fifo_rate_control.amba_total_expected_fill_level, write_xact_fifo_rate_control.write_rate_in_bytes_per_cycle, write_xact_fifo_rate_control.fifo_cfg.full_level)});   
      end
      else if (xact.transmitted_channel == svt_axi_transaction::READ &&
          axi_traffic_profile_xact.read_fifo_cfg != null &&
          xact.is_appplicable_for_fifo_rate_control()) begin
        wait (xact.data_status == svt_axi_transaction::ACCEPT);
        read_xact_fifo_rate_control.update_fifo_levels_on_data_xmit(xact,_num_bytes);
        read_xact_fifo_rate_control.update_total_expected_fill_levels(
                xact,svt_fifo_rate_control::FIFO_REMOVE_FROM_ACTIVE,_num_bytes
                );
        `svt_xvm_debug("track_transaction", {`SVT_AXI_PRINT_PREFIX1(xact), $sformatf("Post i/f send; Profile: %0s. fifo_curr_fill_level(%0d). total_expected_fill_level(%0d). read_rate_in_bytes_per_cycle(%0f) fifo_cfg.full_level(%0d)", axi_traffic_profile_xact.profile_name, read_xact_fifo_rate_control.amba_fifo_curr_fill_level, read_xact_fifo_rate_control.amba_total_expected_fill_level, read_xact_fifo_rate_control.read_rate_in_bytes_per_cycle, read_xact_fifo_rate_control.fifo_cfg.full_level)});   

      end

      `svt_xvm_debug("track_transaction", 
      $sformatf("Waiting for AXI transaction to end(xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d. profile name: %0s) to AXI transaction. Xact: %0s", 
      axi_traffic_profile_xact.xact_size.name(), axi_traffic_profile_xact.base_addr, axi_traffic_profile_xact.total_num_bytes, axi_traffic_profile_xact, axi_traffic_profile_xact.profile_name, `SVT_AXI_PRINT_PREFIX1(xact)));
      xact.wait_for_transaction_end();
      active_xact_queue_sema.get();
      _xact_index = active_xact_queue.find_first_index with(item == xact);
      if (_xact_index.size()) begin
        active_xact_queue.delete(_xact_index[0]);
      end
      active_xact_queue_sema.put();
      `svt_xvm_debug("track_transaction", 
      $sformatf("Converted AXI transaction has ended (xact_size: %0s. base_addr: %0x. total_num_bytes: %0d handle: %0d. profile name: %0s) to AXI transaction. Xact: %0s", 
      axi_traffic_profile_xact.xact_size.name(), axi_traffic_profile_xact.base_addr, axi_traffic_profile_xact.total_num_bytes, axi_traffic_profile_xact, axi_traffic_profile_xact.profile_name, `SVT_AXI_PRINT_PREFIX1(xact)));
    end
    join_none

  endtask

  /** Updates the ID to be assigned to the next transaction */
  task update_xact_id(`SVT_AXI_MASTER_TRANSACTION_TYPE xact,svt_axi_traffic_profile_transaction axi_traffic_profile_xact,ref bit[`SVT_AXI_MAX_ID_WIDTH-1:0] curr_id);
    `SVT_AXI_MASTER_TRANSACTION_TYPE _matching_xact[$];
    if ((axi_traffic_profile_xact.id_gen_type == svt_axi_traffic_profile_transaction::CYCLE) || (axi_traffic_profile_xact.id_gen_type == svt_axi_traffic_profile_transaction::UNIQUE)) begin
      if (curr_id == '1) begin
        curr_id = axi_traffic_profile_xact.id_min;
      end
      else begin
        curr_id++;
        if (curr_id > axi_traffic_profile_xact.id_max)
          curr_id = axi_traffic_profile_xact.id_min; 
      end
    end
    if (axi_traffic_profile_xact.id_gen_type == svt_axi_traffic_profile_transaction::UNIQUE) begin //tag_is_unique
      string id_str;
      bit[`SVT_AXI_MAX_ID_WIDTH-1:0] id_list[$], _matching_id[$];
      `SVT_AXI_MASTER_TRANSACTION_TYPE _matching_xact[$];
      active_xact_queue_sema.get();
      _matching_xact = active_xact_queue.find_first with (item.id == curr_id);
      if (_matching_xact.size()) begin
        bit found_free_id = 0;
        while (!found_free_id) begin
          int _index = 0;
          for (int x = 0; x <= (axi_traffic_profile_xact.id_max-axi_traffic_profile_xact.id_min); x++) begin // tag_for_loop
            _index++;
            if ((curr_id + _index) > axi_traffic_profile_xact.id_max) begin
              curr_id = axi_traffic_profile_xact.id_min;
              _index = 0;
            end
            _matching_id = id_list.find_first with (item == (curr_id + _index));
            _matching_xact = active_xact_queue.find_first with (item.id == (curr_id + _index));
            if (!_matching_xact.size()) begin
              curr_id = (curr_id + _index);
              found_free_id = 1;
              break;
            end
            _index++;
          end
          if (!found_free_id) begin
            int curr_active_queue_size;
            active_xact_queue_sema.put();
            curr_active_queue_size = active_xact_queue.size();
            if (curr_active_queue_size) begin
              `svt_xvm_debug("update_xact_id", $sformatf("Waiting for current active_xact_queue.size(%0d) to decrease. port_id: %0d. profile_name: %0s", 
                                          curr_active_queue_size, cfg.port_id, axi_traffic_profile_xact.profile_name));
              wait(active_xact_queue.size() < curr_active_queue_size);
              `svt_xvm_debug("update_xact_id", $sformatf("Current active_xact_queue.size(%0d) has decreased. port_id: %0d. profile_name: %0s", 
                                          active_xact_queue.size(), cfg.port_id, axi_traffic_profile_xact.profile_name));
            end
            `svt_xvm_debug("update_xact_id", $sformatf("Getting sema. Current active_xact_queue.size(%0d) has decreased. port_id: %0d. profile_name: %0s", 
                                          active_xact_queue.size(), cfg.port_id, axi_traffic_profile_xact.profile_name));
            active_xact_queue_sema.get();
            `svt_xvm_debug("update_xact_id", $sformatf("Got sema. Current active_xact_queue.size(%0d) has decreased. port_id: %0d. profile_name: %0s", 
                                          active_xact_queue.size(), cfg.port_id, axi_traffic_profile_xact.profile_name));
          end
        end
      end
      active_xact_queue_sema.put();
    end //tag_is_unique
  endtask

  /** Updates the data to be assigned to the next transaction */
  task update_xact_data(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, svt_axi_traffic_profile_transaction axi_traffic_profile_xact, int burst_length, ref bit[`SVT_AXI_MAX_DATA_WIDTH-1:0] last_data, ref bit[`SVT_AXI_MAX_DATA_WIDTH-1:0] curr_data[]);
    curr_data = new[burst_length];
    if (axi_traffic_profile_xact.data_gen_type == svt_axi_traffic_profile_transaction::FIXED) begin
      foreach (curr_data[i]) begin
        curr_data[i] = axi_traffic_profile_xact.data_min;
      end
    end
    else if (axi_traffic_profile_xact.data_gen_type == svt_axi_traffic_profile_transaction::CYCLE) begin
        
      foreach (curr_data[i]) begin
        if (last_data == '1) 
          last_data = axi_traffic_profile_xact.data_min;
        else
          last_data = last_data + xact.port_cfg.data_width/8;
        if (last_data > axi_traffic_profile_xact.data_max)
          last_data = axi_traffic_profile_xact.data_min;
        curr_data[i] = last_data;
      end
    end
  endtask

  /** Updates the address to be assigned to the next transaction */
  task update_xact_addr(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, svt_axi_traffic_profile_transaction axi_traffic_profile_xact, ref bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] curr_addr, ref bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] two_dim_base_addr);
    if (curr_addr == '1)
      curr_addr = axi_traffic_profile_xact.base_addr;
    else
      curr_addr = curr_addr + (axi_traffic_profile_xact.xact_size/8);

    if (axi_traffic_profile_xact.addr_gen_type == svt_axi_traffic_profile_transaction::SEQUENTIAL) begin
      if (
            ((curr_addr + axi_traffic_profile_xact.xact_size/8 - 1) >= axi_traffic_profile_xact.base_addr + axi_traffic_profile_xact.addr_xrange) 
         )
        curr_addr = axi_traffic_profile_xact.base_addr;
    end
    else if (axi_traffic_profile_xact.addr_gen_type == svt_axi_traffic_profile_transaction::TWODIM) begin
      if (
           (curr_addr + axi_traffic_profile_xact.xact_size/8 - 1) >= (axi_traffic_profile_xact.base_addr + axi_traffic_profile_xact.addr_twodim_yrange - axi_traffic_profile_xact.addr_twodim_stride + axi_traffic_profile_xact.addr_xrange) 
         ) begin
        curr_addr = axi_traffic_profile_xact.base_addr;
        two_dim_base_addr = axi_traffic_profile_xact.base_addr;
      end
      else if ((curr_addr + axi_traffic_profile_xact.xact_size/8 - 1) >= (two_dim_base_addr + axi_traffic_profile_xact.addr_xrange)) begin
        curr_addr = two_dim_base_addr + axi_traffic_profile_xact.addr_twodim_stride;
        two_dim_base_addr = curr_addr;
      end
    end

    if ((curr_addr + axi_traffic_profile_xact.xact_size/8) > ((1 << cfg.addr_width)-1)) 
      curr_addr = axi_traffic_profile_xact.base_addr;

    if ((curr_addr[11:0] > (`SVT_AXI_TRANSACTION_4K_ADDR_RANGE - axi_traffic_profile_xact.xact_size/8))) 
      curr_addr = axi_traffic_profile_xact.base_addr;
  endtask

  /** Tracks output events of the traffic profile transaction */
  task track_output_events(svt_axi_traffic_profile_transaction xact);
    foreach (xact.output_events[i]) begin
      if (xact.output_event_type[i] == svt_traffic_profile_transaction::FRAME_TIME)
        track_frame_time_output_event(xact,xact.output_events[i]);
      else if (xact.output_event_type[i] == svt_traffic_profile_transaction::FRAME_SIZE)
        track_frame_size_output_event(xact,xact.output_events[i]);
      else if(xact.output_event_type[i] == svt_traffic_profile_transaction::END_OF_PROFILE)
        track_end_of_profile_output_event(xact,xact.output_events[i]);
    end
  endtask

  /** Triggers an event when the specified time for frame time elapses */
  task track_frame_time_output_event(svt_axi_traffic_profile_transaction xact, string output_event);
    fork
    begin
      my_agent.advance_clock(xact.frame_time);
      xact.output_event_pool.trigger_event(xact.output_event_pool,output_event);
    end
    join_none
  endtask

  /** Triggers an event when the specified number of bytes given in frame_size is transmitted */
  task track_frame_size_output_event(svt_axi_traffic_profile_transaction xact, string output_event);
    fork
    begin
      while (xact.current_xmit_byte_count <= xact.frame_size) begin
        int current_xmit_byte_count = xact.current_xmit_byte_count;
        wait(xact.current_xmit_byte_count > current_xmit_byte_count);
        `svt_xvm_debug("track_frame_size_output_event", $sformatf("current_xmit_byte_count = %0d", xact.current_xmit_byte_count));
      end
      `svt_xvm_debug("track_frame_size_output_event", $sformatf("triggering output event %s. xact.current_xmit_byte_count = %0d. xact.frame_size = %0d", output_event, xact.current_xmit_byte_count, xact.frame_size));
      xact.output_event_pool.trigger_event(xact.output_event_pool,output_event);
    end
    join_none
  endtask

  /** Triggers an event when the end of profile is reached */
  task track_end_of_profile_output_event(svt_axi_traffic_profile_transaction xact, string output_event);
    fork
    begin
      xact.wait_end();
      xact.output_event_pool.trigger_event(xact.output_event_pool,output_event);
    end
    join_none
  endtask

  /** Updates the total number of bytes transmitted by the profile */
  task update_current_byte_count(`SVT_AXI_MASTER_TRANSACTION_TYPE xact, svt_axi_traffic_profile_transaction traffic_profile_xact);
    fork
    begin
      xact.wait_end();
      traffic_profile_xact.current_xmit_byte_count += xact.get_byte_count();
    end
    join_none
  endtask

  task track_fifo_underflow_and_overflow(svt_axi_fifo_rate_control fifo_rate_control);
    if (fifo_rate_control != null) begin
      fork
      begin
        while (1) begin
          fifo_rate_control.wait_for_overflow();
          `uvm_do_obj_callbacks(svt_axi_master_sequencer,svt_axi_traffic_profile_callback,this.p_sequencer,detected_fifo_overflow(fifo_rate_control));
        end
      end
      begin
        while (1) begin
          fifo_rate_control.wait_for_underflow();
          `uvm_do_obj_callbacks(svt_axi_master_sequencer,svt_axi_traffic_profile_callback,this.p_sequencer,detected_fifo_underflow(fifo_rate_control));
        end
      end
      join_none
    end
  endtask
endclass: svt_axi_master_traffic_profile_sequence
`endif //SVT_EXCLUDE_VCAP


`protected
Z,]JP-G]&Y;EfN\8[WUf-5(/50],_ED,2;L#\SegbOJCA0R7N/<e&)ZJ3+I7P(U7
L]?b>JLZ5EgLA<#+J@dDH/I@O,^Fe+5=OE8g(eWB^bUF[Zg>(@2:&bcb6&e\1&>R
Qf\ZKTb7ME(GHMQebH3g&SfaL]K8I[Wf-\\;+&G@.3#d5Q&ZF]\+g_>E,R5/aTZd
NCCf12QZFf[cCFY&ObG:+(-5T3QTK9;7d7Yfd)J;W8>O5A0G:c6-DfXTZIA7EE+5
J[[@)KPFR;NQ>c(,bO1cd950a3A;5:H9^K.;8CaFUJAI9b2D[&O\gCSS.;_(&^C_
CJHF1#L2[M[E(E10_:J2&QKDg;6GC1=ND#OOM3XLXVK(L(;;9\6A#.LdW.7(XW-P
AN0SeeV<7NG_Qf=8V+BD8H(6;T/E2E@B2WcS+C7;DZYc.G+[Ja)X_PV3dfGS#a/)
]LN45&)953+8>YI3?DOQXe(67$
`endprotected


//vcs_vip_protect

`protected
]PGJ70]O2=N+P.7)=,^,XH-AEcAL4P2>f25_WA4K/P@AMR@M[?C=5(WD+6\9Y8<=
FF^+CPB>eITaL#-5?@JOWR=gH^/]E.Y@\A213dWT?+/Q8-4+gM8F67FGXW9AKYEX
>U5CeNX28RT5gD5g>/O_Q,eMdVeVKa]\/F&?^:2(-(6>I(:W>WeD43:?QC>FG?MS
:]I9F]G#[L,0U?VW_aBV3NQWT9:5.M=DFZ+T8Z\YF.2J^ZS=[0b^0EN?4aLa(#GO
:-\^CgW\\WfE2KVW65<]>YGV?>M[2U/ObM#S<FKS]JK()/F>]d61;.;@b1#3]H_&
U<Y_,>7A<(R^8)GN2DbgCc<,HXA:\PSCdG97#K7cRaP5@W1QA8dT[8=eQIQ#M/I/
K@USGe2D<)1\MTWGFGe3:6U(CD>3A:.aTH>;F:._@6TSKQQ(N90+G8I(Q.Zca920
4C<Cf,:T\(#YNU@_7)VD+Uc<LA59N6f&Q91fLG1J<?ENeGeG0,&I:P4D.&A7\Gg+
;[FL6I<bH\EE9aRg@W[[&V>0RYg0&UK+Q[<^&;&>310+G&UAfBV_(5gGGZF8&.Kg
YNcH_Z,)U^GQ8T=S2R]e.gFOD@c2VUEVUAWPJ0VZF,E@)B97,5eP]],8Uc)_WJ::
/>;8T&,Y:cf;daZ:Y2bG.>HGOW:&<HG^Q((]fH6TWe&J.H(L@4@9+,Q5-NLeJ#W_
U==f?>)NTO(U(PISU,&eQB82cN6.X..SNc@IC1U62/:EM\X^MaSS?R?WCT3#O.U.
f;LS]^/^cZ5.XX1HSd55(SGW:bHd-Nf(3E>.)EG=H5)W(Y8^6I]V2Y0>b188EPdF
TVBb4SIDJ-fWEF>CDdX3I7JR;<JP0J-6^A[=1f<G38=;cEV5:,,T24L>GQOKDfH,
RGVMHA<Zd-<^eJ-F0<2<+9^&NG2_#QYQK>VS&\L#PC[>^SMg-S4=AWGCD&QIgg4<
RNg4E1LY9?0VAJ[X[H1BKDBP6e7U.=+)#D7O_cBGTDaER2IO/8e)f._JIW>7^@Ia
bI=TJTBW-U[>S_V&6VDRY@CFK-YAB\9^79E)7\,/=#Q3R67c&G,cebX^Gc9HQ?T<
Cc-->O3@J&ZN@-T<R;.(3?aWV6G6GgFR\6P:]Y0BfAW>16Q/ZDQ-EP\<d0-d]f-X
<,FXa1^g3^ZfZ53<(BZPPcgV:0MCBc(WI3H_1<46QM<LWgI#faQU\SbY9[;L_YN;
f/,4]_CVJ5Td^A0=USO9b&eJ^509S#^f9e4C&#9c_S@?gLY8a-A8a,L62#]bG2_<
b1b#=EaJ(QNUY-.=[RKRb[f>,0a>^1g#AgNZN3J28UJLE[L0Za6LGQ[BNacfIacf
G4,E(##[\JBW.[acJZ4,?://bYB8S:_ULSS6I@2BMH7G?g-Y#;NWCX^+5F_+D7:cW$
`endprotected


/**
  AXI VIP provides a pre-defined AXI Master sequence library
  svt_axi_master_transaction_sequence_library, which can hold the AXI Master
  sequences. The library by default has no registered sequences. You are
  expected to call
  svt_axi_master_transaction_sequence_library::populate_library() method to
  populate the sequence library with master sequences provided with the VIP. The
  port configuration is provided to the populate_library() method as an
  argument. Based on the port configuration, appropriate sequences are added to
  the sequence library.  You can then load the sequence library in the sequencer
  within the master agent.

  The user can also add user-defined sequences to this sequence library using
  appropriate UVM methods.
 */
class svt_axi_master_transaction_sequence_library extends svt_sequence_library#(`SVT_AXI_MASTER_TRANSACTION_TYPE);
  `svt_xvm_object_utils(svt_axi_master_transaction_sequence_library)

  //Required to allow new_item() to have access to the parent sequencer
  `svt_xvm_declare_p_sequencer(svt_axi_master_sequencer)

  //Removes all registered sequences from this library
  extern function void remove_all_sequences();

  /**
    Populates the library with all sequences defined in
    svt_axi_master_sequence_collection.sv

    @param cfg User is expected to pass a port configuration to this argument.
    Based on the port configuration, this method adds the appropriate sequences
    from the master sequence collection to the master sequence library.
    */
  extern function int unsigned populate_library(svt_configuration cfg);

  extern function new (string name="svt_axi_master_transaction_sequence_library");
endclass
`protected
<E6:CIA=K/T,(B@9#egLU=P)4gZS64gBCO45U_DHV43Bcg5@^3V;&)9a).6#KQKH
YX=JB\aeY>)=eXW64<@WO7@R[&16CCb=<V)\bce>4[G1LK6g&7D=OC\B9RQAPc4\
O+QI7^PW2B2LO[Y)+G4X[_<4<,B._&e(HYQ8=+a@]R)T/Oa9>1(_O^?H;e__KM5c
A28\Oa&#Lc5-gM&HM(\?8--:8&f<J[T4GeKfJ6O&Ec\UQUdL[//BZ]?#=60F-\,^
NCAQX?5,M#,T7BPM/dX-.@18e>EGW7+^:==EFQ8&M,YM8-6Y7C0[:N?#N$
`endprotected


//vcs_vip_protect
`protected
@YP+V8WF5CTE8c2bCC>g\07;#R(2.4]A\-cOQdL1KEdaaL_e&V0C/(1W@?L-E?S<
18=6c4e2(1S;M.#d>?gb,L9I4@7eKb)9.W^PWEV;YY&C-NAO]<ONB#XaBN_TJ13>
;.Z41_M\^4:,Q7UYIY?1H\FFf/W-PF5gJ5UJQR5[fRJ/J+1(SFO.9L@++J;:/g3#
ZKD+T8S)CI_(57U=CN)Ce@:Ae(aL+_;5?._]fMPM?[6)B).]g>Ud,A<-2bQB>GKQ
P#AY#8?HSgCAB0HYbNJ8_5C>SUC@T-7(e?dEOZ^^fSDHWg[E(KEI3dVS(72,3,7:
]<)I4cD[61)=9CB8APOg8,2a9/Z945:bHHRQLW>CIcZHN4\Y4.JcV?0-0>V-&6Sg
3(H3eF/-C0W9@dVY0X>_5Z[ZVKV^,^-F@5/.a<L6C.[0f_Ne8(@a0bVA1D1M.]9<
8EI+8gTK]F6J-QNFFg<d9TM@DDEXP<SWOIA5EK]L^??/#Gbf2@NFEA3=]FKG.&BO
US.5(ZA;N5]dAG33AHCLU)[\K_#/X+JA[fWGe(HSDd-T&Aa6?WFc>/9:G^T^AQV<
/bDf^/6-TE:0\BZ9a#_6E4UL0_63=;L\7QQ6V\a7g#D_0[TXA11KP><+QPZC<f6F
>B?:/H6+<_faDAES]X?aAdFSf&M,T_Q01+1&4E61<e6]VXX?GWWGLfSBe3JK?7V+
PJdJFVc[L/Y==3aSX]FDXA.4@/VJ:YQ[]V5<&V=UTKT\g-&/Y:O-=E<B_BXU5gX?
VUZ;;RQ;+,;X+gK+1>dTH[C+01.2dT.a9)BYXIE^e)?0^b_=<,c_8UBb;.2&->K:
6OcaG)U\eHROf@Q\U>eW)=Zfeb.#<SGfa9d/LF2)&=DJLS?Y=+H]LL+F,b_?aM1@
:8Y^+_Q[P@QS>eWLP:\@<,fLLFGX7Yf//.-E._PWL+dMGGB@[@:,],GaQYIGN=Jg
L(bB#>,\E8aN[4&LJe-/L>A;BGD-G#?RAYEM3f\FJ;R7VYa/:4T0,/-Q)5df.4[?
M?QReQ<UQJCW5PAd[=f+IOa]ZEY)V=YggRQE)fYM:;Hcg.QZB2DRdXBRD]\a>2?g
;2U),APPCH(N.+8>a>bW2]L<#)A6LHB>/_c]fLI[])E0,^H3E)VDaA3=V:[Hbc?_
A,@fQ&4Z8e/gKY<(c#6E)6J(/.@@[Y3&ID#:.&R4U;4(<AS.+-&9):_e/<V4g?Q^
?.@4I3BI]]e1/)\Y?;XM9WJ(5$
`endprotected


/**
 *   This sequence performs locked accesses 
 *   Each loop does the following:
 *   Send a random locked access transaction.
 *   Send the exclusive transaction with same xact_type and address as of locked transaction to unlock the locked sequence
 *   Each transcation waits for the previous transaction to be ended
 **/
class svt_axi3_master_random_read_write_locked_sequence extends svt_axi_master_base_sequence;

  rand int slv_num;

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(svt_axi3_master_random_read_write_locked_sequence)

  /** Class Constructor */
  function new(string name="svt_axi3_master_random_read_write_locked_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] lcked_addr;     
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr;
    bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr;
    int xact_type_int;
    svt_configuration get_cfg;
    bit status;
    `svt_xvm_debug("body", "Entering...");

    super.body();
   
    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_axi_port_configuration class");
    end
    if (!cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num, lo_addr,hi_addr,null))
      `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));
      if(cfg.axi_interface_type == svt_axi_port_configuration::AXI3 && cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE) begin
                      `svt_xvm_do_with(req,
          {
            xact_type inside { svt_axi_transaction::READ,svt_axi_transaction::WRITE};
            atomic_type == svt_axi_transaction::LOCKED;
            data_before_addr == 0;
            id == 0;
            cache_type == 0;
            addr >= lo_addr;
            addr <= hi_addr-((1<<burst_size)*burst_length);
          })
        xact_type_int = req.xact_type;         
        lcked_addr = req.addr;
        `svt_xvm_debug("item_1",$sformatf("item_1 txn=%0d atomic_type=%0d",req.xact_type,req.atomic_type));

          wait(`SVT_AXI_XACT_STATUS_ENDED(req));
                
              `svt_xvm_do_with(req,
              {
                xact_type == xact_type_int;
                atomic_type == svt_axi_transaction::EXCLUSIVE;
                data_before_addr == 0;
                id == 0;
                cache_type == 0;
                addr == lcked_addr;
                })   
        `svt_xvm_debug("item_2",$sformatf("item_2 txn=%0d atomic_type=%0d",req.xact_type,req.atomic_type));
              //wait for transaction to complete
              wait ((req.addr_status == svt_axi_transaction::ACCEPT || req.addr_status == svt_axi_transaction::ABORTED) &&
                   (req.data_status == svt_axi_transaction::ACCEPT || req.data_status == svt_axi_transaction::ABORTED));
            end

    `svt_xvm_debug("body", "Exiting...");
  endtask: body

   /** 
   * Function to check if current system configuration meets requirements of this sequence.
   * This sequence requires svt_axi_port_configuration::axi_interface_category is set to 
   * svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type is set to AXI3 for exclusive acess and locked acess respectvively
   */  
  virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
    svt_axi_port_configuration master_cfg;
    /** By default is_supported is 0 */
    is_supported = 0;  
    
    `svt_xvm_debug("is_supported",$sformatf("calling is_supported"));

    if(!$cast(master_cfg, cfg)) begin
      `svt_xvm_fatal("is_supported", "Unable to cast cfg to svt_axi_port_configuration type");
    end
    if (((master_cfg.exclusive_access_enable == 1) && (master_cfg.axi_interface_category == svt_axi_port_configuration::AXI_READ_WRITE)) || ((master_cfg.locked_access_enable == 1) && (master_cfg.axi_interface_type == svt_axi_port_configuration::AXI3))) begin
       is_supported = 1;
    end
    else begin
      if (silent)
        `svt_xvm_debug("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category is set to svt_axi_port_configuration::AXI_READ_WRITE or svt_axi_port_configuration::AXI_READ_ONLY and svt_axi_port_configuration::axi_interface_type set to either AXI3. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
      else
        `svt_xvm_warning("is_supported",$sformatf("This sequence cannot be run based on the current system configuration.This sequence requires svt_axi_port_configuration::axi_interface_category = svt_axi_port_configuration::AXI_READ_WRITE and svt_axi_port_configuration::axi_interface_type is set to AXI3. Currently svt_axi_port_configuration::axi_interface_category is set to %0s and svt_axi_port_configuration::axi_interface_type is set to %0s",master_cfg.axi_interface_category.name(),master_cfg.axi_interface_type.name()))
     end
  endfunction : is_supported


endclass: svt_axi3_master_random_read_write_locked_sequence

`ifdef SVT_ACE5_ENABLE
// =============================================================================
/** 
 *  This sequence generates atomic store transactions.
 */

class axi_master_atomic_store_xact_base_sequence extends svt_axi_master_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;
  
  rand svt_axi_transaction::atomic_xact_op_type_enum atomic_xact_store_type;

  rand bit[`SVT_AXI_MAX_ADDR_WIDTH -1:0] _addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

   /** Constrain the addresses to addresses for which CHI RNF has initialized the cachelines*/
  constraint reasonable_addr {
    _addr inside {start_addr,end_addr};
  }
  /** Constrain the atomic_xact_op_type to a reasonable value for atomicstore */
  constraint atomic_xact_op_type_for_atomicstore {
    atomic_xact_store_type inside {
       svt_axi_transaction::ATOMICSTORE_ADD,
       svt_axi_transaction::ATOMICSTORE_CLR,
       svt_axi_transaction::ATOMICSTORE_EOR,
       svt_axi_transaction::ATOMICSTORE_SET,
       svt_axi_transaction::ATOMICSTORE_SMAX,
       svt_axi_transaction::ATOMICSTORE_SMIN,
       svt_axi_transaction::ATOMICSTORE_UMAX,
       svt_axi_transaction::ATOMICSTORE_UMIN
    };
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_store_xact_base_sequence)

  /** Class Constructor */
  function new(string name="axi_master_atomic_store_xact_base_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;
    int unsigned atomic_xact_type=0;
    `svt_xvm_debug("body", "Entered...");
 
    super.body();

   repeat (sequence_length) begin
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
      `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::ATOMIC;
          atomic_transaction_type == svt_axi_transaction::STORE;
          atomic_xact_op_type ==atomic_xact_store_type ;
          addr == _addr;
          })
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
     end

    fork
    forever begin
      get_response(rsp);
    end
    join_none
   
    `svt_xvm_debug("body", "Exiting...");

  endtask: body

endclass: axi_master_atomic_store_xact_base_sequence

// =============================================================================
/** 
 *  This sequence generates atomic load transactions.
 */

class axi_master_atomic_load_xact_base_sequence extends svt_axi_master_base_sequence;
  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;
  
  rand svt_axi_transaction::atomic_xact_op_type_enum atomic_xact_load_type;

  rand bit[`SVT_AXI_MAX_ADDR_WIDTH -1:0] _addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

   /** Constrain the addresses to addresses for which CHI RNF has initialized the cachelines*/
  constraint reasonable_addr {
    _addr inside {start_addr,end_addr};
  }
  /** Constrain the atomic_xact_op_type to a reasonable value for atomicload */
  constraint atomic_xact_op_type_for_atomicload {
    atomic_xact_load_type inside {
       svt_axi_transaction::ATOMICLOAD_ADD,
       svt_axi_transaction::ATOMICLOAD_CLR,
       svt_axi_transaction::ATOMICLOAD_EOR,
       svt_axi_transaction::ATOMICLOAD_SET,
       svt_axi_transaction::ATOMICLOAD_SMAX,
       svt_axi_transaction::ATOMICLOAD_SMIN,
       svt_axi_transaction::ATOMICLOAD_UMAX,
       svt_axi_transaction::ATOMICLOAD_UMIN
    };
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_load_xact_base_sequence)

  /** Class Constructor */
  function new(string name="axi_master_atomic_load_xact_base_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;
    int unsigned atomic_xact_type=0;
    `svt_xvm_debug("body", "Entered...");
    super.body();

   repeat (sequence_length) begin
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
      `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::ATOMIC;
          atomic_transaction_type == svt_axi_transaction::LOAD;
          atomic_xact_op_type ==atomic_xact_load_type ;
          addr == _addr;
          })
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
     end

    fork
    forever begin
      get_response(rsp);
    end
    join_none
    `svt_xvm_debug("body", "Exiting...");
  endtask: body

endclass: axi_master_atomic_load_xact_base_sequence

// =============================================================================
/** 
 *  This sequence generates atomic compare transactions.
 */

class axi_master_atomic_compare_xact_base_sequence extends svt_axi_master_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;
  
  rand bit[`SVT_AXI_MAX_ADDR_WIDTH -1:0] _addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

   /** Constrain the addresses to addresses for which CHI RNF has initialized the cachelines*/
  constraint reasonable_addr {
    _addr inside {start_addr,end_addr};
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_compare_xact_base_sequence)

  /** Class Constructor */
  function new(string name="axi_master_atomic_compare_xact_base_sequence");
    super.new(name);
  endfunction
  
  virtual task body();

    `svt_xvm_debug("body", "Entered...");
    super.body();
   repeat (sequence_length) begin
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
      `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::ATOMIC;
          atomic_transaction_type == svt_axi_transaction::COMPARE;
          atomic_xact_op_type == svt_axi_transaction::ATOMICCOMPARE ;
          addr == _addr;
          })
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
     end

    fork
    forever begin
      get_response(rsp);
    end
    join_none
   
    `svt_xvm_debug("body", "Exiting...");
  endtask: body

endclass: axi_master_atomic_compare_xact_base_sequence

// =============================================================================
/** 
 *  This sequence generates atomic swap transactions.
 */

class axi_master_atomic_swap_xact_base_sequence extends svt_axi_master_base_sequence;
 
  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /**Parameter controls the addresses generated by transactions in this sequence */
  rand bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0]  start_addr; 
  
  /**Parameter controls the addresses generated by the transactions in this sequence*/
  rand  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] end_addr;
  
  rand bit[`SVT_AXI_MAX_ADDR_WIDTH -1:0] _addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

   /** Constrain the addresses to addresses for which CHI RNF has initialized the cachelines*/
  constraint reasonable_addr {
    _addr inside {start_addr,end_addr};
  }

  /** UVM Object Utility macro */
  `svt_xvm_object_utils(axi_master_atomic_swap_xact_base_sequence)

  /** Class Constructor */
  function new(string name="axi_master_atomic_swap_xact_base_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
  
    `svt_xvm_debug("body", "Entered...");
    super.body();
   repeat (sequence_length) begin
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
      `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::ATOMIC;
          atomic_transaction_type == svt_axi_transaction::SWAP;
          atomic_xact_op_type ==svt_axi_transaction::ATOMICSWAP;
          addr == _addr;
          })
     `svt_xvm_do_with(req, 
         { 
          xact_type == svt_axi_transaction::COHERENT;
          burst_size == svt_axi_transaction::BURST_SIZE_32BIT;
          coherent_xact_type == svt_axi_transaction::READONCE;
          addr == _addr;
          burst_length == 2;
          })
     end

    fork
    forever begin
      get_response(rsp);
    end
    join_none
   
      `svt_xvm_debug("body", "Exiting...");
  endtask: body

endclass: axi_master_atomic_swap_xact_base_sequence
`endif
// =============================================================================

`endif // GUARD_SVT_AXI_MASTER_SEQUENCE_COLLECTION_SV


