//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2019 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_LINK_SERVICE_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_LINK_SERVICE_SEQUENCE_COLLECTION_SV
//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_LINK_SVC_BASE CHI Link service transaction base sequence
 * Base sequence for all CHI link service transaction sequences
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/** 
 * @grouphdr sequences CHI_LINK_SVC CHI Link service transaction sequences
 * CHI Link service transaction sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
/** 
 * @groupname CHI_LINK_SVC_BASE
 * svt_chi_link_service_base_sequence: This is the base class for
 * svt_chi_link_service based sequences. All other svt_chi_link_service
 * sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or
 * sequence clients set the #manage_objection bit to 1.
 */
class svt_chi_link_service_base_sequence extends svt_sequence#(svt_chi_link_service);

  /** Sequence length in used to constrain the sequence length in sub-sequences */
  rand int unsigned sequence_length = 5;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_link_service_base_sequence) 

  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_link_service_sequencer) 

  /** Node configuration obtained from the sequencer */
  svt_chi_node_configuration node_cfg;

  /**
   * RN Agent virtual sequencer
   */
  svt_chi_rn_virtual_sequencer rn_virt_seqr;

  /**
   * SN Agent virtual sequencer
   */
  svt_chi_sn_virtual_sequencer sn_virt_seqr;

  /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

  /** 
   * Weight that controls generating Link activation, deactivation service requests.
   * Enabled by default. 
   */
  int unsigned LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;

  /** 
   * Weight that controls generating Link activation, deactivation service requests.
   * Disabled by default.
   */
  int unsigned LCRD_SUSPEND_RESUME_SERVICE_wt = 0;

  /**
   * Config DB get status forLINK_ACTIVATE_DEACTIVATE_SERVICE_wt 
   */  
  bit link_activate_deactivate_service_wt_status = 0;

  /**
   * Config DB get status for LCRD_SUSPEND_RESUME_SERVICE_wt
   */
  bit lcrd_suspend_resume_service_wt_status = 0;

  /** Config DB get status for sequence_length */
  bit seq_len_status;

  /** Config DB get status for min_post_send_service_request_halt_cycles */
  bit min_post_send_service_request_halt_cycles_status;

  /** Config DB get status for max_post_send_service_request_halt_cycles */
  bit max_post_send_service_request_halt_cycles_status;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_default_sequence_length {
    sequence_length > 0;
    sequence_length <= 5;
  }

  /** 
   * Indicates minimum number of clock cycles the sequence has to halt after issuing a link service request. <br>
   * Default value is zero. <br>
   * Based on the requirement should be set to appropriate value, because the random link service sequence will wait for a delay picked randomly in the range #min_post_send_service_request_halt_cycles and #max_post_send_service_request_halt_cycles between sending two random link service requests. <br>
   * Can be programmed using config DB. 
   */
  int unsigned min_post_send_service_request_halt_cycles = 0;

  /** 
   * Indicates maximum number of clock cycles the sequence has to halt after issuing a link service request. <br>
   * Default value is zero. <br>
   * Based on the requirement should be set to appropriate value, because the random link service sequence will wait for a delay picked randomly in the range #min_post_send_service_request_halt_cycles and #max_post_send_service_request_halt_cycles between sending two random link service requests. <br>
   * Can be programmed using config DB.
   */
  int unsigned max_post_send_service_request_halt_cycles = 0;

  /** 
   * RN interface handle.
   */
  virtual svt_chi_rn_if rn_vif;

  /** 
   * SN interface handle.
   */
  virtual svt_chi_sn_if sn_vif;

  /** 
   * Constructs a new svt_chi_link_service_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_link_service_base_sequence");

  /**
   * Obtains the RN virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_rn_virt_seqr();

  /**
   * Obtains the SN virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_sn_virt_seqr();

  /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_virt_seqr();

  /**
   * Obtains the virtual interface handle from node configuration. 
   */
  extern function void get_virt_if();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** body method */
  extern virtual task body();

  /** Get the generic cfg DB settings */
  extern virtual task pre_start();

  /** is_supported implmentation, applicable for all the sequences */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);

  /** Generate Link service sequence items */
  extern virtual task generate_service_requests();

  /** Post Generate Link service sequence items */
  extern virtual task post_generate_service_requests();

  /** Pre Create Link service sequence item */
  extern virtual task pre_create_service_request();

  /** Create Link service sequence item */
  extern virtual function svt_chi_link_service create_service_request();

  /** Post Create Link service sequence item */
  extern virtual task post_create_service_request(svt_chi_link_service link_service_req);
  
  /** Pre Randomize Link service sequence item */
  extern virtual task pre_randomize_service_request(svt_chi_link_service link_service_req);

  /** Randomize Link service sequence item */
  extern virtual task randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);

  /** Post Randomize Link service sequence item */
  extern virtual task post_randomize_service_request(svt_chi_link_service link_service_req, ref bit rand_success);
  
  /** Pre Send Link service sequence item */
  extern virtual task pre_send_service_request(svt_chi_link_service link_service_req);

  /** Send Link service sequence item */
  extern virtual task send_service_request(svt_chi_link_service link_service_req);

  /** Post Send Link service sequence item */
  extern virtual task post_send_service_request(svt_chi_link_service link_service_req);
  
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gCA1HHlHsjTzDc3JzFqnE0UPinLGktpHax8c/skzgxKu3Ey8r8IDa+FQrwu14oa8
dYN9AhwtLyBjUSt+whmIJugZq5ay0hfVh0TtpvLQc7jQuu7F9C9TEqKCiy6SXUoN
RJWUdFVWXRMnrDTYywEac9JPjNv7gjGZMQOaPJHnSn0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 326       )
P13/k8NByddx5VA45emMcdaS6YlD7ON/1hbdgoMf6pYqWgnVegpf30Uq84eeauXC
BOosPfvhCPQ8BdFPN1RvGRn6AH1X3KEMbyg4m3WvFZYC3+tXVdedlPwNC4gizRdm
DPb/I+hQqzg7q6esdseNn5WnIfXe0ej/gISKexXLFnsjhnsZd7P1hvinBogFfY+n
h6V6GjDpccTyNAq2QVD42y1J1fJkEx2swWDtZHKW2YCkAC1i9C+hnQ6rJA+u9b9y
kPLueteG1QPu5bVMoTrgd4dspmbUvFFgaqfmzzEH3sVnzbbA2sIQkUJnquICrHTu
nRVjmKrEE56bFxY7BxGThzVZf/hhPYoN6NY/bIMtr1fjKIkaDK2ZduyYjBej9T3t
vFy43DblQpDylq+RWJs/aPubCG2fGFIcWd5EugZuj2poN9YBH2Z9zvNyZEGnl4Nm
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Yj7C9DrSiCPrktAp77sYgcCz8s9kqSsj85ld9NsRa3KssgcJ7LJMjfcz7p+Ewfy+
snMqUNqwDJJQNl/YZLpD7iVougTt3BULeZh2dFnIPbsYCcLWgUL19DrLbuhCJchr
oXCugr+IAEn5ciDBEt3B0+JBLBL1hTWtDWREg5Y4gC4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3628      )
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
`pragma protect end_protected

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::body();
  svt_configuration cfg;
  bit silent = 0;
  if (p_sequencer == null) begin
    `uvm_fatal("body", "Sequence is not running on a sequencer")
  end

  /** Obtain a handle to the rn node configuration */
  p_sequencer.get_cfg(cfg);
  if (cfg == null || !$cast(node_cfg, cfg)) begin
    `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
  end

  //  check if it's valid to run this sequence or not
  if(!is_supported(cfg, silent))  begin
    `svt_xvm_note("body",$sformatf("This sequence cannot be run. Exiting..."))
    return;
  end    

  //Obtains the virtual sequencer from the configuration database and sets up
  //the shared resources obtained from it.
  get_virt_seqr();

  //Get RN/SN interface handle from node configuration.
  get_virt_if();

endtask

// -----------------------------------------------------------------------------
/** Get the generic cfg DB settings */
task svt_chi_link_service_base_sequence::pre_start();
  string method_name = "pre_start";
  
  super.pre_start();
  
`ifdef SVT_UVM_TECHNOLOGY
  link_activate_deactivate_service_wt_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "LINK_ACTIVATE_DEACTIVATE_SERVICE_wt", LINK_ACTIVATE_DEACTIVATE_SERVICE_wt);
`else
  link_activate_deactivate_service_wt_status = m_sequencer.get_config_int({get_type_name(), ".LINK_ACTIVATE_DEACTIVATE_SERVICE_wt"}, LINK_ACTIVATE_DEACTIVATE_SERVICE_wt);
`endif
  `svt_xvm_debug(method_name, $sformatf("link_activate_deactivate_service_wt_status is %0d as a result of %0s.", LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, link_activate_deactivate_service_wt_status ? "the config DB" : "the default value"));    

`ifdef SVT_UVM_TECHNOLOGY
  lcrd_suspend_resume_service_wt_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "LCRD_SUSPEND_RESUME_SERVICE_wt", LCRD_SUSPEND_RESUME_SERVICE_wt);
`else
  lcrd_suspend_resume_service_wt_status = m_sequencer.get_config_int({get_type_name(), ".LCRD_SUSPEND_RESUME_SERVICE_wt"}, LCRD_SUSPEND_RESUME_SERVICE_wt);
`endif
  `svt_xvm_debug(method_name, $sformatf("link_activate_deactivate_service_wt_status is %0d as a result of %0s.", LCRD_SUSPEND_RESUME_SERVICE_wt, lcrd_suspend_resume_service_wt_status ? "the config DB" : "the default value"));

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
  `svt_xvm_debug(method_name, $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));

`ifdef SVT_UVM_TECHNOLOGY
  min_post_send_service_request_halt_cycles_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "min_post_send_service_request_halt_cycles", min_post_send_service_request_halt_cycles);
  max_post_send_service_request_halt_cycles_status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "max_post_send_service_request_halt_cycles", max_post_send_service_request_halt_cycles);
`else
  min_post_send_service_request_halt_cycles_status = m_sequencer.get_config_int({get_type_name(), ".min_post_send_service_request_halt_cycles"}, min_post_send_service_request_halt_cycles);
  max_post_send_service_request_halt_cycles_status = m_sequencer.get_config_int({get_type_name(), ".max_post_send_service_request_halt_cycles"}, max_post_send_service_request_halt_cycles);
`endif
  `svt_xvm_debug(method_name, $sformatf("min_post_send_service_request_halt_cycles is %0d as a result of %0s. max_post_send_service_request_halt_cycles is %0d as a result of %0s.", min_post_send_service_request_halt_cycles, min_post_send_service_request_halt_cycles_status ? "the config DB" : "the default value", max_post_send_service_request_halt_cycles, max_post_send_service_request_halt_cycles_status ? "the config DB" : "the default value"));
  
endtask // pre_start

// -----------------------------------------------------------------------------
/** is_supported implmentation, applicable for all the sequences */
function bit svt_chi_link_service_base_sequence::is_supported(svt_configuration cfg, bit silent = 0);
  string method_name = "is_supported";
  `svt_xvm_debug(method_name,$sformatf("Entering ..."));
  is_supported = 1;

  if ((LINK_ACTIVATE_DEACTIVATE_SERVICE_wt == 0) && (LCRD_SUSPEND_RESUME_SERVICE_wt == 0)) begin
    is_supported = 0;
    `svt_xvm_error(method_name,$sformatf("This sequence cannot be run as both LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, LCRD_SUSPEND_RESUME_SERVICE_wt are set to 0. Adjust these weight attributes appropriately, for example: LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100, LCRD_SUSPEND_RESUME_SERVICE_wt = 0."));
  end
  `svt_xvm_debug(method_name,$sformatf("Exiting ..."));
endfunction // is_supported

// -----------------------------------------------------------------------------
function svt_chi_link_service svt_chi_link_service_base_sequence::create_service_request();
  svt_chi_link_service link_service_req;
  //`svt_xvm_create_on(link_service_req, p_sequencer)
  `svt_xvm_create(link_service_req)
  link_service_req.cfg = node_cfg;
  link_service_req.LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = LINK_ACTIVATE_DEACTIVATE_SERVICE_wt;
  link_service_req.LCRD_SUSPEND_RESUME_SERVICE_wt = LCRD_SUSPEND_RESUME_SERVICE_wt;

  create_service_request = link_service_req;
endfunction // create_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  string method_name = "randomize_service_request";
  `svt_xvm_debug(method_name, "Entering ...");
  if (link_service_req != null) begin
    rand_success = link_service_req.randomize();
  end
  `svt_xvm_debug(method_name, "Exiting ...");
endtask

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::send_service_request(svt_chi_link_service link_service_req);
  string method_name = "send_service_request";
  `svt_xvm_debug(method_name, "Entering ...");
  `svt_xvm_send(link_service_req);
  `svt_xvm_debug(method_name, "Exiting ...");
endtask // send_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::generate_service_requests();
  string method_name = "generate_service_requests";
  bit    rand_success;
  `svt_xvm_debug(method_name, $sformatf("Entering - sequence_length = %0d, LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = %0d, LCRD_SUSPEND_RESUME_SERVICE_wt = %0d", sequence_length, LINK_ACTIVATE_DEACTIVATE_SERVICE_wt, LCRD_SUSPEND_RESUME_SERVICE_wt));
  sink_responses();
  for (int i =0; i < sequence_length; i++) begin
    svt_chi_link_service link_service_req;
    
    pre_create_service_request();
    link_service_req = create_service_request();
    post_create_service_request(link_service_req);
    
    if (link_service_req == null) begin
      `svt_xvm_fatal(method_name, $sformatf("Unable to create link_service_req the iteration %0d", i));
    end
    else begin
      `svt_xvm_debug(method_name, $sformatf("Invoking randomize_service_request for the iteration %0d", i));
    end
    
    pre_randomize_service_request(link_service_req);
    randomize_service_request(link_service_req, rand_success);
    post_randomize_service_request(link_service_req, rand_success);
    
    if (!rand_success) begin
      `svt_xvm_error(method_name,$sformatf("randomize_service_request() indicates Randomization failure for the iteration %0d", i));
    end
    else begin
      `svt_xvm_debug(method_name,$psprintf("randomize_service_request() generated transaction for the iteration %0d: %0s", i, link_service_req.sprint()));
      pre_send_service_request(link_service_req);
      send_service_request(link_service_req);
      post_send_service_request(link_service_req);
    end
  end
  //After the sequence_length number of serive requests are issued, this task will check if any RX VC's are in suspend lcrd state, if yes, a RESUME_ALL_LCRD service request is issued to avoid any deadlocks.
  post_generate_service_requests();
  `svt_xvm_debug(method_name, "Exiting ...");
endtask // generate_service_requests

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_generate_service_requests();
   string method_name = "post_generate_service_requests";
   if (shared_status != null && shared_status.link_status != null) begin
     if(shared_status.link_status.snp_lcrd_suspend_resume_status == svt_chi_link_status::SUSPEND_LCRD_COMPLETED || shared_status.link_status.rsp_lcrd_suspend_resume_status == svt_chi_link_status::SUSPEND_LCRD_COMPLETED || shared_status.link_status.dat_lcrd_suspend_resume_status == svt_chi_link_status::SUSPEND_LCRD_COMPLETED) begin
       bit rand_success;
       svt_chi_link_service link_service_req;
       link_service_req = create_service_request();
       //As this service request is auto generated overriding the weights.
       link_service_req.LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 0;
       link_service_req.LCRD_SUSPEND_RESUME_SERVICE_wt = 100;

       if (link_service_req == null) begin
         `svt_xvm_fatal(method_name, $sformatf("Unable to create link_service_req in post_generate_service_requests()"));
       end
       
       rand_success = link_service_req.randomize() with { 
                                                         service_type == svt_chi_link_service::RESUME_ALL_LCRD;
                                                        };
       
       if (!rand_success) begin
         `svt_xvm_error(method_name,$sformatf("link_service_req.randomize() Randomization failure in post_generate_service_requests()"));
       end
       else begin
         `svt_xvm_debug(method_name,$psprintf("link_service_req transaction generated in  post_generate_service_requests() with service type %0s: %0s ", link_service_req.service_type, link_service_req.sprint()));
         pre_send_service_request(link_service_req);
         send_service_request(link_service_req);
         post_send_service_request(link_service_req);
       end
     end
   end
endtask // post_generate_service_requests

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::pre_create_service_request();
endtask // pre_create_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_create_service_request(svt_chi_link_service link_service_req);
endtask // post_create_service_request

//------------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::pre_randomize_service_request(svt_chi_link_service link_service_req);
endtask // pre_randomize_service_request

//------------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_randomize_service_request(svt_chi_link_service link_service_req, ref bit rand_success);
endtask // post_randomize_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::pre_send_service_request(svt_chi_link_service link_service_req);
endtask // pre_send_service_request

// -----------------------------------------------------------------------------
task svt_chi_link_service_base_sequence::post_send_service_request(svt_chi_link_service link_service_req);
  int unsigned num_post_send_service_request_halt_cycles = $urandom_range(max_post_send_service_request_halt_cycles, min_post_send_service_request_halt_cycles);
  if (rn_vif != null && node_cfg.chi_node_type == svt_chi_node_configuration::RN) begin
    if (num_post_send_service_request_halt_cycles > 0)
      repeat(num_post_send_service_request_halt_cycles) @(rn_vif.rn_cb);
  end
  else if (sn_vif != null && node_cfg.chi_node_type == svt_chi_node_configuration::SN) begin
    if (num_post_send_service_request_halt_cycles > 0)
      repeat(num_post_send_service_request_halt_cycles) @(sn_vif.sn_cb);
  end
endtask // post_send_service_request

// =============================================================================
/** 
 * @groupname CHI_LINK_SVC
 * svt_chi_link_service_random_sequence
 *
 * This sequence creates a random svt_chi_link_service request.
 */
class svt_chi_link_service_random_sequence extends svt_chi_link_service_base_sequence; 

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_link_service_random_sequence) 

  /**
   * Constructs the svt_chi_link_service_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_link_service_random_sequence");

  /** 
   * Executes the svt_chi_link_service_random_sequence sequence. 
   */
  extern virtual task body();

endclass

//------------------------------------------------------------------------------
function svt_chi_link_service_random_sequence::new(string name = "svt_chi_link_service_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_link_service_random_sequence::body();
  
  super.body();

  generate_service_requests();

endtask: body


// =============================================================================
/** 
 * @groupname CHI_LINK_SVC
 * svt_chi_link_service_deactivate_sequence
 *
 * This sequence creates a deactivate svt_chi_link_service request.
 */
class svt_chi_link_service_deactivate_sequence extends svt_chi_link_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_link_service_deactivate_sequence) 

  bit seq_allow_act_in_tx_stop_rx_deact = 0;

  bit seq_allow_deact_in_tx_run_rx_act = 0;

  /** Controls the number of cycles that the sequence will be in the deactive state */
  rand int unsigned min_cycles_in_deactive = 50;

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /** Constrain the number of cycles that the sequence will be in the deactive state */
  constraint reasonable_min_cycles_in_deactive {
    min_cycles_in_deactive inside {[0:`SVT_CHI_MAX_MIN_CYCLES_IN_DEACTIVE]};
  }

  /**
   * Constructs the svt_chi_link_service_deactivate_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_link_service_deactivate_sequence");

  /** 
   * Executes the svt_chi_link_service_deactivate_sequence sequence. 
   */
  extern virtual task body();

  /** Randomize Link service sequence item */
  extern virtual task randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  
endclass

//------------------------------------------------------------------------------
function svt_chi_link_service_deactivate_sequence::new(string name = "svt_chi_link_service_deactivate_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_link_service_deactivate_sequence::randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  string method_name = "randomize_service_request";
  `svt_xvm_debug(method_name,$sformatf("Entering ..."));
  if (link_service_req != null) begin
    rand_success = link_service_req.randomize() with { 
                                                       service_type == svt_chi_link_service::DEACTIVATE;
                                                       min_cycles_in_deactive == local::min_cycles_in_deactive;
                                                       if(seq_allow_deact_in_tx_run_rx_act) {
                                                         allow_deact_in_tx_run_rx_act==seq_allow_deact_in_tx_run_rx_act;
                                                       } else {
                                                           allow_deact_in_tx_run_rx_act==0;
                                                       }
                                                       if(seq_allow_act_in_tx_stop_rx_deact) {
                                                           allow_act_in_tx_stop_rx_deact==seq_allow_act_in_tx_stop_rx_deact;
                                                       } else {
                                                           allow_act_in_tx_stop_rx_deact==0;
                                                       }
                                                      };
  end
  `svt_xvm_debug(method_name,$sformatf("Exiting ..."));  
endtask
//------------------------------------------------------------------------------
task svt_chi_link_service_deactivate_sequence::body();
  int min_cycles_in_deactive_status;

  LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;
  LCRD_SUSPEND_RESUME_SERVICE_wt = 0;
  
  super.body();
  
  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  min_cycles_in_deactive_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "min_cycles_in_deactive", min_cycles_in_deactive);
`else
  min_cycles_in_deactive_status   = m_sequencer.get_config_int({get_type_name(), ".min_cycles_in_deactive"}, min_cycles_in_deactive);
`endif
  `svt_xvm_debug("body", $sformatf("min_cycles_in_deactive is %0d as a result of %0s.", min_cycles_in_deactive, min_cycles_in_deactive_status ? "the config DB" : "randomization"));

  generate_service_requests();

endtask: body

// =============================================================================
/** 
 * @groupname CHI_LINK_SVC
 * svt_chi_link_service_active_sequence
 *
 * This sequence creates an activate svt_chi_link_service request.
 */
class svt_chi_link_service_activate_sequence extends svt_chi_link_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_link_service_activate_sequence) 

  bit seq_allow_act_in_tx_stop_rx_deact = 0;

  bit seq_allow_deact_in_tx_run_rx_act = 0;

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /**
   * Constructs the svt_chi_link_service_active_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_link_service_activate_sequence");

  /** 
   * Executes the svt_chi_link_service_active_sequence sequence. 
   */
  extern virtual task body();

  /** Randomize Link service sequence item */
  extern virtual task randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  
endclass

//------------------------------------------------------------------------------
function svt_chi_link_service_activate_sequence::new(string name = "svt_chi_link_service_activate_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_link_service_activate_sequence::randomize_service_request(svt_chi_link_service link_service_req, output bit rand_success);
  string method_name = "randomize_service_request";
  `svt_xvm_debug(method_name,$sformatf("Entering ..."));
  if (link_service_req != null) begin
    rand_success = link_service_req.randomize() with { 
                                                       service_type == svt_chi_link_service::ACTIVATE;
                                                       if(seq_allow_deact_in_tx_run_rx_act) {
                                                           allow_deact_in_tx_run_rx_act==seq_allow_deact_in_tx_run_rx_act;
                                                       } else {
                                                           allow_deact_in_tx_run_rx_act==0;
                                                       }
                                                       if(seq_allow_act_in_tx_stop_rx_deact) {
                                                           allow_act_in_tx_stop_rx_deact==seq_allow_act_in_tx_stop_rx_deact;
                                                       } else {
                                                           allow_act_in_tx_stop_rx_deact==0;
                                                       }
                                                      };
  end
  `svt_xvm_debug(method_name,$sformatf("Exiting ..."));  
endtask
//------------------------------------------------------------------------------
task svt_chi_link_service_activate_sequence::body();
  int min_cycles_in_deactive_status;
  
  LINK_ACTIVATE_DEACTIVATE_SERVICE_wt = 100;
  LCRD_SUSPEND_RESUME_SERVICE_wt = 0;
  
  super.body();

  generate_service_requests();
  
endtask: body

`endif // GUARD_SVT_CHI_LINK_SERVICE_SEQUENCE_COLLECTION_SV







  



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
c8Kln0lVXj+EYZqCaInsynxivrwL8sFBGBhLZ8pqeeVz2O//If0ShaNbZbLhKoPG
sfr9mMsx5U6/Q3/0BKhkzlVnhqL3Si9UePIpcYMnHSd7q4lfKlcQOciHgY5HqKjB
IOvuZQNtpXVxKAAhC7Nilx+4nFtEMX1H6K98RFKwho0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3711      )
x1rg59ztH7duCD1/8wKdgqjwqAt9YrJV/bK2KnB8ZxTVuNZGpqjcbqCjPjg5zICu
WntiVkMpLaP7syoXXLr+nnY+HIldD8lCr924QzOeez6x6iGGz/eMoAjuOdZWTHzg
`pragma protect end_protected
