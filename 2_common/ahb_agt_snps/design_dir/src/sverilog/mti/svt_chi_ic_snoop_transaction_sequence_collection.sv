//--------------------------------------------------------------------------
// COPYRIGHT (C) 2019 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV

//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_IC_SNP_BASE CHI IC SNOOP transaction response base sequence
 * Base sequence for all CHI IC SN transaction response sequences
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/**
 * @grouphdr sequences CHI_IC_SNP CHI IC Snoop transaction response sequences
 * CHI IC Snoop transaction response sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
// =============================================================================

/** 
 * @groupname CHI_IC_SNP_BASE
 * svt_chi_ic_snoop_transaction_base_sequence: This is the base class for svt_chi_ic_snoop_transaction
 * sequences. All other svt_chi_ic_snoop_transaction sequences are extended from this sequence.
 * svt_chi_ic_snoop_transaction sequences will be used by CHI ICN VIP component.
 * CHI IC SN Snoop xact sequencer and the Interconnect driver will be using it.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_chi_ic_snoop_transaction_base_sequence extends svt_sequence#(svt_chi_ic_snoop_transaction);
  /** CHI Node Configuration handle set by pre_start(). */
  svt_chi_node_configuration cfg;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_snoop_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_ic_sn_snoop_transaction_sequencer) 

  /** 
   * Constructs a new svt_chi_ic_snoop_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_ic_snoop_transaction_base_sequence");

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();
  
  /**
   * Listen to the sequencer's analysis port for completed transaction
   */
  extern virtual task pre_start();

  /** Empty body method */
  virtual task body();
  endtask

  /**
   * Stop listening to the sequencer's analysis port for completed transaction
   */
  extern virtual task post_start();

  extern virtual function void do_kill();

  /** (Empty) write() method called by the sequencer's analysis port to report completed transactions */
  virtual function void write(svt_chi_ic_snoop_transaction observed);

  endfunction

endclass // svt_chi_ic_snoop_transaction_base_sequence

/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_snoop_transaction_random_sequence defines a snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_snoop_transaction_random_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_snoop_transaction_random_sequence) 

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /**
   * Constructs the svt_chi_ic_snoop_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_snoop_transaction_random_sequence");
  
  /** 
   * Executes the svt_chi_ic_snoop_transaction_random_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_snoop_transaction_random_sequence

/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_dvm_snoop_transaction_random_sequence defines a snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a DVM request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_dvm_snoop_transaction_random_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_dvm_snoop_transaction_random_sequence) 

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;

  /** Enum to control the mode of dispatching transactions */
  typedef enum {
      DEFAULT=0,  //random dvm snoop transaction
      DIRECTED_MAX_OUTSTANDING_SNPDVMOP_NON_SYNC=1  //issues only dvm snoop transactions of type non-sync
  }select_mode_enum;

  /** Provides the mode of dispatching snoop dvm transactions */
  select_mode_enum select_mode = DEFAULT;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 256;
  }

  /**
   * Constructs the svt_chi_ic_dvm_snoop_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_dvm_snoop_transaction_random_sequence");
  
  /** 
   * Executes the svt_chi_ic_dvm_snoop_transaction_random_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_dvm_snoop_transaction_random_sequence


/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_snoop_transaction_directed_sequence defines a directed snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_snoop_transaction_directed_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_snoop_transaction_directed_sequence) 

  /** Enumerated type for addressing mode */
  typedef enum bit[1:0] {INCR_MODE, FIXED_MODE, RAND_MODE} snp_addr_mode_enum;

  /** Enumerated type for txn_id pattern */
  typedef enum bit[1:0] {INCR_PATTERN, FIXED_PATTERN, RAND_PATTERN} snp_txn_id_pattern_enum;
  
  /** Snoop address mode */
  rand snp_addr_mode_enum snp_addr_mode = INCR_MODE;

  /** Base address: used as it is for FIXED mode, used as base for INCR mode */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] base_addr = 0;
  
  /** Snoop txn_id pattern */
  rand snp_txn_id_pattern_enum snp_txn_id_pattern = INCR_PATTERN;

  /** Base txn_id: used as it is for FIXED pattern, used as base for INCR pattern */
  rand bit[(`SVT_CHI_TXN_ID_WIDTH-1):0] base_txn_id = 0;
  
  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** Make sure the base address is valid */
  constraint valid_snp_base_addr {
    base_addr[2:0] == 3'b0;
  }

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 1024 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         base_txn_id inside {[0:1023]};
       }
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         base_txn_id inside {[0:255]};
       }
  }
  `elsif SVT_CHI_ISSUE_D_ENABLE
  constraint valid_txn_id_values {
      /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         base_txn_id inside {[0:255]};
       }
  }
  `endif
  
  /**
   * Constructs the svt_chi_ic_snoop_transaction_directed_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_snoop_transaction_directed_sequence");
  
  /** 
   * Executes the svt_chi_ic_snoop_transaction_directed_sequence sequence. 
   */
  extern virtual task body();

  /** Pre_randomize method */
  function void pre_randomize();
    super.pre_randomize();
    if (p_sequencer != null && cfg == null) begin
      svt_configuration _cfg;
      p_sequencer.get_cfg(_cfg);
      if (_cfg == null || !$cast(cfg, _cfg)) begin
        `uvm_fatal("pre_randomize", "Unable to $cast the configuration to a svt_chi_node_configuration class")
      end
    end
  endfunction // pre_randomize

endclass // svt_chi_ic_snoop_transaction_directed_sequence

/**
 * @groupname CHI_IC_SNP
 * Class svt_chi_ic_stash_snoop_transaction_directed_sequence defines a directed stash snoop sequence that
 * will be used by the CHI ICN VIP Driver and IC SNOOP XACT sequencer. <br>
 * 
 * The sequence generates a request of type
 * svt_chi_ic_snoop_transaction from the IC SNOOP xact sequencer within interconnect env.
 * 
 */
// =============================================================================
class svt_chi_ic_stash_snoop_transaction_directed_sequence extends svt_chi_ic_snoop_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_stash_snoop_transaction_directed_sequence) 

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Controls whether transactions are dispatched using blocking or non-block semantics */
  bit enable_non_blocking = 0;
 
  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /**
   * Constructs the svt_chi_ic_stash_snoop_transaction_directed_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_stash_snoop_transaction_directed_sequence");
  
  /** 
   * Executes the svt_chi_ic_stash_snoop_transaction_directed_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_stash_snoop_transaction_directed_sequence

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q9g0Ydy57vICadiTlQboSltdXM0RXNOwQm3Wnk4yLGTYjAN+tyI/I0mbA9fUKIPL
yA5i60/YGUvNgmCenGCaQTLyhnPz7oOrQZplbmgpmt5NwSWFHBfas7AJNbDuQkOT
2YZuPu6T3RsmL0XddopwpKQl+C79Xd407ys5YU8mG8U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 342       )
z94C7iCOr0F6QObUA6k32x/8r6L8f4tHK+WoKvi3Fmub4VEhIQJ0Vw5jtpPjfdeO
hnymMmYcw0GXwGnFH+W62vqLhf5yXoDBjLGWvGuQsc6u47D+t/zJ7LD/ilgy8gjr
aN2rO0Hf83bRnvoGpXKYFYMmekOq5x5092yFJXQd3jbrMZFHLyXugWxL0QPsbizE
3q596ClPPi6Q5z+Up3rHDR4xjz09n5Y+V0E3YD78Zy5pQNMGX1IYrYAIWoeYO6Ea
22LcZaw6xbHC98Wo8oukH7oMLyjSpsDcM1Ssb1/aA+mh1cxOvtExObzfsouuqEOV
uWmJvd4HLdyXzJCBvYh86WPuY4ZRWhGVsG52kTt7MKHtgcrlz/jx8mzxUaH6EmL6
N7rGTunZIvfd2lQOd8hTEAFfcXk0zphLsF6zC8n7M45M4eI3+aEDE9pnyUSkxZ1o
7CJPuFLhz+sBb6jX8ymSMg==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iuaQfDWBQqT3HxrXksj5lFnMmNLkmaYFHJasxy4eLwbX5fiQ9oJIze21g3EauhFB
T+cvBUbnxfCm4X+BfkJ6+2hIBvZNYYYwXJBZO2IFqh+H3TeyiE4BPl9e1e3Q1tOJ
qG1ObDKnaT03miF+qTDeWbCgP+lqBnutaDARDR9hdnk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1995      )
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
`pragma protect end_protected
//------------------------------------------------------------------------------
function svt_chi_ic_snoop_transaction_random_sequence::new(string name="svt_chi_ic_snoop_transaction_random_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_snoop_transaction_random_sequence::body();
  svt_configuration get_cfg;
  integer status;
  bit seq_len_status, xact_type_status, enable_non_blocking_status;
  svt_chi_ic_snoop_transaction req_sent[$];

  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));

  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin
    `svt_xvm_do(req)
    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});
    
    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");
endtask

//------------------------------------------------------------------------------
function svt_chi_ic_dvm_snoop_transaction_random_sequence::new(string name="svt_chi_ic_dvm_snoop_transaction_random_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_dvm_snoop_transaction_random_sequence::body();
  svt_configuration get_cfg;
  integer status;
  bit seq_len_status, xact_type_status, enable_non_blocking_status,select_mode_status;
  svt_chi_ic_snoop_transaction req_sent[$];

  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));

  /** Get the user select_mode. */
  select_mode_status = svt_config_int_db#(select_mode_enum)::get(null, get_full_name(),"select_mode", select_mode);
  `svt_xvm_debug("body", $sformatf("select_mode is %0s as a result of %0s.", select_mode, select_mode_status ? "the config DB" : "the default value"));

  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin

    if (select_mode == svt_chi_ic_dvm_snoop_transaction_random_sequence::DIRECTED_MAX_OUTSTANDING_SNPDVMOP_NON_SYNC)
      `svt_xvm_do_with(req,{ snp_req_msg_type == svt_chi_snoop_transaction::SNPDVMOP; txn_id == i; addr[13:11] != 3'b100;})
    else if(enable_non_blocking)
      `svt_xvm_do_with(req,{ snp_req_msg_type == svt_chi_snoop_transaction::SNPDVMOP;txn_id == i;})
    else
      `svt_xvm_do_with(req,{ snp_req_msg_type == svt_chi_snoop_transaction::SNPDVMOP;})

    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});
    
    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");
endtask

//------------------------------------------------------------------------------
function svt_chi_ic_snoop_transaction_directed_sequence::new(string name="svt_chi_ic_snoop_transaction_directed_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_snoop_transaction_directed_sequence::body();
  svt_configuration get_cfg;
  bit seq_len_status, enable_non_blocking_status;
  bit addr_mode_status, txn_id_pattern_status;
  bit base_addr_status, base_txn_id_status;

  svt_chi_ic_snoop_transaction req_sent[$];
  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
  addr_mode_status  = uvm_config_db#(svt_chi_ic_snoop_transaction_directed_sequence::snp_addr_mode_enum)::get(m_sequencer, get_type_name(), "snp_addr_mode", snp_addr_mode);
  txn_id_pattern_status  = uvm_config_db#(svt_chi_ic_snoop_transaction_directed_sequence::snp_txn_id_pattern_enum)::get(m_sequencer, get_type_name(), "snp_txn_id_pattern", snp_txn_id_pattern);
  base_addr_status = uvm_config_db#(bit[(`SVT_CHI_MAX_ADDR_WIDTH-1):0])::get(m_sequencer, get_type_name(), "base_addr", base_addr);
  base_txn_id_status = uvm_config_db#(bit[(`SVT_CHI_TXN_ID_WIDTH-1):0])::get(m_sequencer, get_type_name(), "base_txn_id", base_txn_id);
  
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
  addr_mode_status   = m_sequencer.get_config_int({get_type_name(), ".snp_addr_mode"}, snp_addr_mode);  
  txn_id_pattern_status   = m_sequencer.get_config_int({get_type_name(), ".snp_txn_id_pattern"}, snp_txn_id_pattern);  
  base_addr_status   = m_sequencer.get_config_int({get_type_name(), ".base_addr"}, base_addr);  
  base_txn_id_status   = m_sequencer.get_config_int({get_type_name(), ".base_txn_id"}, base_txn_id);  
`endif // !`ifdef SVT_UVM_TECHNOLOGY
  
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));
  `svt_xvm_debug("body", $sformatf("snp_addr_mode is %0s as a result of %0s.", snp_addr_mode.name(), addr_mode_status ? "the config DB" : "randomization"));  
  `svt_xvm_debug("body", $sformatf("base_addr is 'h%0h as a result of %0s.", base_addr, base_addr_status ? "the config DB" : "randomization"));  
  `svt_xvm_debug("body", $sformatf("snp_txn_id_pattern is %0s as a result of %0s.", snp_txn_id_pattern.name(), txn_id_pattern_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("base_txn_id is 'd%0d as a result of %0s.", base_txn_id, base_txn_id_status ? "the config DB" : "randomization"));    


  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin
    `svt_xvm_create(req)

    req.cfg = cfg;

    // Set snoop address
    case (snp_txn_id_pattern) 
      svt_chi_ic_snoop_transaction_directed_sequence::INCR_PATTERN: begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_E+1));
        end
        else if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D+1));
        end
        else begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C+1));
        end
        `elsif SVT_CHI_ISSUE_D_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D+1));
        end
        else begin
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C+1));
        end
        `else
          req.txn_id = ((base_txn_id+i)%(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C+1));
        `endif
      end
      svt_chi_ic_snoop_transaction_directed_sequence::FIXED_PATTERN: begin
        req.txn_id = base_txn_id;
      end
      svt_chi_ic_snoop_transaction_directed_sequence::RAND_PATTERN: begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_E, 0);
        end
        else if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D, 0);
        end
        else begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C, 0);
        end
        `elsif SVT_CHI_ISSUE_D_ENABLE
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_FOR_ISSUE_D, 0);
        end
        else begin
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C, 0);
        end
        `else
          req.txn_id = $urandom_range(`SVT_CHI_SPEC_PERMITTED_MAX_TXNID_VALUE_UPTO_ISSUE_C, 0);
        `endif
      end
      
    endcase // case (snp_txn_id_pattern)

    // Set snoop txn_id
    case (snp_addr_mode)
      svt_chi_ic_snoop_transaction_directed_sequence::INCR_MODE: begin
        req.addr = (base_addr+(i*64));
      end
      svt_chi_ic_snoop_transaction_directed_sequence::FIXED_MODE: begin
        req.addr = base_addr;
      end
      svt_chi_ic_snoop_transaction_directed_sequence::RAND_MODE: begin
        int lower_addr_bits, upper_addr_bits;
        lower_addr_bits = $urandom_range(int'({32{1'b1}}), 0);
        upper_addr_bits = $urandom_range(int'({32{1'b1}}), 0);
        req.addr = {upper_addr_bits, lower_addr_bits};
        req.addr[2:0] = 3'b0;
      end

    endcase // case (snp_addr_mode)
    
    // Set snoop req_msg_type
    // Set the default
    req.snp_req_msg_type = svt_chi_snoop_transaction::SNPONCE;
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SsFhiYDhHmbqaGnn31++cC2j1wLfsZqVEbsmeslki8/CH+yL3CRls6gaMVK1I6xM
CRP1ko+pjZF0Nf7MSmuGbWNBSFONB2A16BOZCiLip9pOYl4vaAocB4aR9HY0kzJh
qLNSsRgiSUIuhpzWzrbmEfmAcFMtZW0zFQuk5FOxQq8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2155      )
UoYqww8OjhJvdTYd34q7hJp3xy2jr13b2SLAra1WkyHUPtaFawAAudJ7b8Po512e
L6L6tZlh9Nqolwo+ZJJDP2l0wVb+MS9w5zIpq6suksGqLvjQMrWiFGmvt12fFx+c
XVU1gx67C9MsKnY4Mz7ywUGwmBURZBo2pYTXULOIZ+y3P9IUukK7aoVK55gagGoY
sxg4d0ZQwNzLpnhFpQhxfYyS7E9Coz7MYscdHomhd+M=
`pragma protect end_protected
    case (i%10) 
      0: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPSHARED;
      end
      1: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPCLEAN;        
      end
      2: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPONCE;
      end
      3: begin
      `ifdef SVT_CHI_ISSUE_B_ENABLE
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPNOTSHAREDDIRTY;
      `endif        
      end
      4: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPUNIQUE;        
      end
      5: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPCLEANSHARED;
      end
      6: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPCLEANINVALID;        
      end
      7: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPMAKEINVALID;
      end
      8: begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.sys_cfg.chi_E_later_node_present_in_system())begin
          req.snp_req_msg_type = svt_chi_snoop_transaction::SNPPREFERUNIQUE;
        end
      `endif        
      end
      9: begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(cfg.sys_cfg.chi_E_later_node_present_in_system())begin
          req.snp_req_msg_type = svt_chi_snoop_transaction::SNPQUERY;
        end
      `endif        
      end
      10: begin
        req.snp_req_msg_type = svt_chi_snoop_transaction::SNPDVMOP;// Issue is seen with SNPDVMOP transaction hence the sequence is designed to not generate SNPDVMOP transaction        
      end
    endcase // case (i)
    
    
`ifdef SVT_CHI_ISSUE_B_ENABLE    
    req.ret_to_src = 0;
    if ((req.snp_req_msg_type == svt_chi_snoop_transaction::SNPUNIQUE) ||
        (req.snp_req_msg_type == svt_chi_snoop_transaction::SNPCLEANINVALID) ||
        (req.snp_req_msg_type == svt_chi_snoop_transaction::SNPCLEANSHARED) ||
        (req.snp_req_msg_type == svt_chi_snoop_transaction::SNPMAKEINVALID))
      req.do_not_go_to_sd = 1;
    else
      req.do_not_go_to_sd = 0;

`endif //  `ifdef SVT_CHI_ISSUE_B_ENABLE
    
    `svt_xvm_send(req)

    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});    

    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");
endtask // body

//------------------------------------------------------------------------------
function svt_chi_ic_stash_snoop_transaction_directed_sequence::new(string name="svt_chi_ic_stash_snoop_transaction_directed_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_stash_snoop_transaction_directed_sequence::body();
  svt_configuration get_cfg;
  bit rand_success;
  integer status;
  bit seq_len_status, xact_type_status, enable_non_blocking_status;
  svt_chi_ic_snoop_transaction req_sent[$];

  
  `svt_xvm_debug("body", "Entered ...");
  p_sequencer.get_cfg(get_cfg);
  if(!($cast(cfg, get_cfg)))
    `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_chi_node_configuration");

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
  enable_non_blocking_status = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "enable_non_blocking", enable_non_blocking);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
  enable_non_blocking_status = m_sequencer.get_config_int({get_type_name(), ".enable_non_blocking"}, enable_non_blocking);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));
  `svt_xvm_debug("body", $sformatf("enable_non_blocking is %b as a result of %0s.", enable_non_blocking, enable_non_blocking_status ? "the config DB" : "the default value"));

  /** This method is defined in the svt_chi_ic_snoop_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  if (enable_non_blocking)
    sink_responses();  
  
  for(int i = 0; i < sequence_length; i++) begin
    `svt_xvm_create(req)
    
    req.cfg = cfg;
    
    // Set snoop req_msg_type
    // Set the default
    req.snp_req_msg_type = svt_chi_snoop_transaction::SNPONCE;
    
    rand_success = req.randomize() with {
         `ifdef SVT_CHI_ISSUE_B_ENABLE
         if(i%4 == 0) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPUNIQUESTASH;
         }
         else if(i%4 == 1) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPMAKEINVALIDSTASH;
         }
         else if(i%4 == 2) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPSTASHUNIQUE;
         }
         else if(i%4 == 3) {
           req.snp_req_msg_type == svt_chi_snoop_transaction::SNPSTASHSHARED;
         }
         `endif
    };
    
    `svt_xvm_send(req)
    req_sent.push_back(req);
    
    `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), $sformatf("Generating the request %0d ...", i)});
    
    if (!enable_non_blocking) begin
      get_response(rsp);
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(rsp), " enable_non_blocking = 0. snoop request response received ..."});
    end
  end // for (int i = 0; i < sequence_length; i++)

  if (enable_non_blocking) begin
    foreach(req_sent[i]) begin
      req_sent[i].wait_end();
      `svt_xvm_debug("body", {`SVT_CHI_SNP_PRINT_PREFIX(req), " enable_non_blocking = 1. snoop request completed ..."});          
    end
  end // if (enable_non_blocking)

  `svt_xvm_debug("body", "Exiting ...");

endtask // body

`endif // GUARD_SVT_CHI_IC_SNOOP_TRANSACTION_SEQUENCE_COLLECTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
i3bDJNnByBuzrU+0SS6x4E6Pk7wKyLJnoHB9UK608C99tQ976LFRRzEJAOUru9w6
kA+5gYSA/FP2KXLNhMSIvYhJWRoQTc0Z+ZWbVueSUw/vvaexfJy5QuckbE28S0Wr
YLkeNJ0jiXhAtGqVRlA4iiYod7fkiHL3FajZ0XxllQs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2238      )
KJjGhvXJH48sDqReDPY9W7db8dSsSwaFPAETjbgyuNeGUPGvTUgkGDGNuZ95nO3A
XJUjXmwWE3NuTHELhWCEuhJO7DJmu9KDzfO1MmZP2sd6U/iPVxVRCgxg4/azpOQX
`pragma protect end_protected
