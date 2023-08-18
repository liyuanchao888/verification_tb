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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uf/6Wg2N6i0/5lOwabCv3eAJITc2FmMko62m4ovHorw/NpweIEBTPMiASQTzpDT/
BcNgOpam1gIHgYpqg0ESvGui2x2qb/Gv9YpnRdoGF4jXqYJfj0y9urDuvZn5NANl
2XK8oAoWGFjWEOn+uH6SYV8w3VtRvMZlMG82XKBjGiAMiY3hnofk5A==
//pragma protect end_key_block
//pragma protect digest_block
bRt9r3oy7vuyMSWXSg++jwK2Mr4=
//pragma protect end_digest_block
//pragma protect data_block
o08Z7BTyqs1OAYchQzNj9t9OuTaXBlQ3wxLIB0k+kEfRuvQ14Zvs9Oibq/XD5zuY
aKutbHRPJt3M3GxNQNlTbijEbd+fPIhjWVPa+BNvpNpSH789GbK6wo3graXmerR6
XWZhsmzRKxq4zvlPKSfEchzxuARP1inOE0VCVHUxMOlW9/r1H3S/k1iLoYPfdiR3
rWxIES0p2JMFe3vE80570oc0o8UaXxTQvTQtTuNnQ+q4+E0pu95w9q032QlXimeZ
zTGI0fTJZhze85mg03AFBzj+6x8mx2Rka8EEvStjjb3VALXtP7o6PSdjhZMH9vT5
cfpfS0KLi6Vu1eJCKtwaQrYNYYZedvE3VSyH1R1krdAtJ6LNaMKYdQ7RUIZQT8+m
AHMtfNDBqex8ZXv6t6yNzz8r3LKCtM7izLUbv4hu3+a4si6eIAbrk61Oj7BkZxoR
2V6i3FMSqHcpH/1suP8q31WVj4yaom2O0v2oFrVj6JsuZaSQlkauaOJvGZ0Xawt7
fXmtYBxHZTuuj19KCJwJkLEkJh4JXSGnquEJeltZ01OT85EBYHRZ1umgvDQksuRT
37kiHQRReQ5ku3MITyjWUSdOqD7mQxdUZ/TSe3rVzHK879Is6i/2w9qsqpP2gC89
z9kWNDJa/JtxrcnE55xjMN+LZ71dm6DfHorK9Z9XKJU=
//pragma protect end_data_block
//pragma protect digest_block
ihKmCIymcNKa+7JyHElH9rrBYCk=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
I9hJzW383rWk9NVGs/3jkRKC4MgxqXspzdUPzieWtvMAdp81CoX6JTjcoiYgn7Mt
Oh3kutRIEw7j9b26f8x22g1NQvunz+yGVbRAuGWb8LFn0WTTv/NRFVHxTV2TvcbA
bXDyax3pSTr4CIpIWbZu57eqK/EManBjUA/BQ846sdSPTlfBz1KE6w==
//pragma protect end_key_block
//pragma protect digest_block
0r1x6HFqEfyC5RJpCmZceqhAit0=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
b5gX7fPDnzO5RLzdhuGMeZj/TpI=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
D+kZ7C3bZAZpv/uRwKtMnJ+6YHDecCJTYNOnjsMuwJtQtHSaAEPUj8Lt6QFalbag
ypXAHUFG0Wzt0u3hfyPSXLjSfjCLfOLGxFZzE8vTTAzeBPqlV1TYeKYw6n0LBLAp
vFFTs/uT9/YGcu3RjdstiL2rzcNSYPxJtlqWjnGaiEhAuqfHNDeIsQ==
//pragma protect end_key_block
//pragma protect digest_block
waAnV5s2WYki17TQI5u2qtHiWxg=
//pragma protect end_digest_block
//pragma protect data_block
E+0axS+uE+30p1r33R2uXhhT+sQruMmThj1m6kV6fcS1mDvldEyq5KU1dF120GRr
S3BFJ9b3Ok96HDh84U6IQmaMP+fXfzy6eYzlFmthdUOXTS1DfgrASLtyJVTem+08
TGUu+jrjlHJUmt8TElzpk4PoUtHdjPCx2I4ZGZvX/s2FxOVnQLrGFROVFK+BsA6U
s38sgI8DJqbqdKmGQ1c6KiWmY0OeZkkdb/4yRSx5BZ7cJK4KOsgbcUKe8SSOloI/
UZhd2iRT32RkMB0juh8d6b0whgaxfoJcZ1oo0a4YyOjBTrH1NyBLJVaGdOAdYghc
CL+F1Bn13+LnjRryQthBqTaHcLIIM8mDBqi55hj6VEdB6u/adQ8s9V6iEvATyDBw
akZx0Xr4CZ+djsTe0QZKHxKms9AoOLVf7cUiHQX0nNESobnLitSp6KCDddZ10fft

//pragma protect end_data_block
//pragma protect digest_block
DOb+bhhHVXZaZfCZC44r8Ec7pCI=
//pragma protect end_digest_block
//pragma protect end_protected
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
