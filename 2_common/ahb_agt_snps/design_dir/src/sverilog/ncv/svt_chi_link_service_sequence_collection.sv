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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
v3oBptflcuHPuV2BfLN6Uy6dc/ddXXlBhMXc+2qm+s2179fkkFHykI7YH5PTIEmf
GBQv0kSwaYuisSGSWK7i8bRVwvJdU+Jn0HmYor5ObGuyfDplf08uw7s3AhmPwiu3
EBU4cqH09D2n6aJQJE5HQeFUxdm/bc0iZxB1IsABme0FBICzx5oiDQ==
//pragma protect end_key_block
//pragma protect digest_block
qqCYVq/ESPiUrWLsG3W6rB/tuik=
//pragma protect end_digest_block
//pragma protect data_block
UgLQw6qTWsc6eqm4P1SMFggtV2i0P5ZfNjItoZ7CO0qeuLYMDlWW8DJPows1CvTm
/4WZuJghDuRDGKGXteZqn9Mu/kngbTKHbhRHss49Y4E4XZyaWLv9e7FD72s7TW13
ICDT/d5fTHgUUp1XH0ma47Zyql5ZGrqeDbel8Lwwtf+qZyiLMI4FWNc9D1vypr3u
N59Wwb+nlBudy3vxuhzshNwEn6y/nL0bMmy/UAR0t8T7egk8+SQw+qaR3K2I9Ms1
UG8cUKHPyDiBMFMKwnD6M92x//wxoy3xrxIBWbtQaeTRBKuMrg5t0SI+kZJuoE1f
4sXwIxcS9YWqcNCRG9fb6ToMkMrbIL0Vqyl0xm7XmNuSQlXQ6xa93zxR6vikPvOL
n2QltTKWF/KdmEzSt2M8j6WjSkDXNhaIbw4RIwNLr/bShebQ3uBaigxSV33ZM+78
fox45qI1KxIFEKh5cj2IByyVoSjVp6+gF++NasW8C9bKwzZjcyZGyoc/wwXF+diY
rnZaxeCPbEr1xM/+bXYijEiS0aKBIA0QfBjcwuAWadvCWg/wq5YCjTRGhdpeeFm8
9swBbZ9No0KxabuP1sjrlAUpuMz0B4I4CQ4dIr2O5174tWJ6J6km2fxQQwySY8fD
vTJTZbyg/LewQIInm1oIoQ==
//pragma protect end_data_block
//pragma protect digest_block
6+hth6MVReJho1EMhYh4LxjUD18=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
t7ybrJ2aIGp6z3gwTakKQJG3zvilYb3yGVE6zqIRcV11NvoOXiKvVauDkK8dHP+6
9Mm/ezi2Z8QzzFPpkz3oF08fr/zPXiuuOgwAJCD5PHoAI6KWxjsJfljas154cHqi
IyEget3bFoOXQwTkvUBhja/bb3jlcKxSjsryWyX+PWUgkM0cu7FLug==
//pragma protect end_key_block
//pragma protect digest_block
tTlap1kjjpakDfx/ynbR+vk0Qss=
//pragma protect end_digest_block
//pragma protect data_block
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
y0zL9yYM8Lj85+9Y/3rcQQ==
//pragma protect end_data_block
//pragma protect digest_block
GQryLcMZ8A2mM5zlZr1juhHT7vg=
//pragma protect end_digest_block
//pragma protect end_protected

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







  



