//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_PROTOCOL_SERVICE_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_PROTOCOL_SERVICE_SEQUENCE_COLLECTION_SV

// =============================================================================
/** @cond PRIVATE */
/** 
 * svt_chi_protocol_service_base_sequence: This is the base class for
 * svt_chi_protocol_service based sequences. All other svt_chi_protocol_service
 * sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or
 * sequence clients set the #manage_objection bit to 1.
 */
class svt_chi_protocol_service_base_sequence extends svt_sequence#(svt_chi_protocol_service);

  /** Sequence length in used to constrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_base_sequence) 

  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_protocol_service_sequencer) 

  /** Node configuration obtained from the sequencer */
  svt_chi_node_configuration node_cfg;

  /**
   * RN Agent virtual sequencer
   */
  svt_chi_rn_virtual_sequencer rn_virt_seqr;

  /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

  /** Sets the failure severity of is_supported functionality of the sequence */
  `SVT_XVM(severity) is_supported_failure_severity = `SVT_XVM_UC(INFO);

  /** Status field for capturing config DB get status for silent */  
  bit silent;

  /** 
   * Constructs a new svt_chi_protocol_service_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_protocol_service_base_sequence");

  /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_rn_virt_seqr();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** Empty body method */
  virtual task body();
    svt_configuration cfg;

    if (p_sequencer == null) begin
      `uvm_fatal("body", "Sequence is not running on a sequencer")
    end

    /** Obtain a handle to the rn node configuration */
    p_sequencer.get_cfg(cfg);
    if (cfg == null || !$cast(node_cfg, cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_node_configuration class")
    end
  endtask: body

//-------------------------------------------------------------------- 
virtual function void issue_is_supported_failure(string fail_msg);
  case (is_supported_failure_severity) 
    `SVT_XVM_UC(INFO): begin
      if (silent) begin
        `svt_xvm_debug("is_supported", fail_msg);
      end
      else begin
        `svt_xvm_note("is_supported", fail_msg);
      end          
    end
    `SVT_XVM_UC(WARNING): begin
      `svt_xvm_warning("is_supported", fail_msg);
    end
    `SVT_XVM_UC(ERROR): begin
      `svt_xvm_error("is_supported", fail_msg);
    end
    `SVT_XVM_UC(FATAL): begin
      `svt_xvm_fatal("is_supported", fail_msg);
    end
  endcase // case (is_supported_failure_severity)
endfunction // issue_is_supported_failure

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pg6Sk8assD2Af0zlLlCPyZDaaGWyVgaOyBpE5J84yvMZvl2rziWXLZHz9MZRZ+kI
HSwEQ0STeVmngywIf44FnPvt9sqCr1UmGgmuzWStPUV6yZjN2VwBsp4eAfqtjLOA
5hMm24ugq7mfBdVGVSEXHk+FomyvuCNKj2HK7XjsxfakkNel5EgztQ==
//pragma protect end_key_block
//pragma protect digest_block
MpuovtpT7Iqxux2y0PYfhvMcJto=
//pragma protect end_digest_block
//pragma protect data_block
I6Y+mc2JrOxN89Zyx6WZPlwMdMeah6jA/+f/b9kdvxoLWfzcnGnwZmUJcSVxtzdr
M+lvCFIYLcNFu4F8zidnu7fsvouzLeA4NjjBoiydRnlQeHTd6Mp3AuPDnEEIpVCT
TsKmJr4WKK5Tx6rnC4gWt6uImvi/tChhXpyGRR8jUn0qLND11ZjKBNlPFV0e2tL8
ZoNx7icOapHlEtsI8URSCNS7mQODSwSENaz2yIQxNe4QY7vBN69SS3jq5GmKL0hj
z6DxpYHF1Npc9BYysUaAPwgbmsOA7/1uzljf+MSCiMVF/nuAp39Qth/ZihQ+eWcs
wPvbd5t5gRl5Sl6ZZpEHW3D+Xhx3DVv8LwF8haIkF6dwpIInMF8naMZbnwpI9CM/
jgTkUH6dpx0skJyiBGwGzLeL9vHz3z4WbEtL9Gq2Xo1OiI8wdHOWa49hTwwGfjM3
MHeYrUH0Fw9rgQ+K9QJf7HfVVPH8F6HB5I9SjL/rgItyhYg10PBIQYf0f68Y/Se1
5GIoXUCutXK9jTic5OItu7aLA8F/Ik916BcZWqjnbZRD55o2KkfKqjEwTmCk2weI
Q1M+z8pzVD5U6lEd1kXEfJMy/96zJikInKwQ8KiGE9PdMkIWu8IreWIU8jBgrZUb
KTUaDVaJVaMkiNWCQgDPYhF96kqo2dQtcEpFuaUEA30=
//pragma protect end_data_block
//pragma protect digest_block
Nda+Jne9mM34eaEvd8oCU1AdNjI=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
WFqS+9wf7RtHxsVTWFTwOyNdUscWbyB1vuC8Lj8ggamIvP5eBwxg77KRKV+e3uf/
oxaLh0O2grWG3IGtwgbKIo7l5LLvgbEnZ2uw4lguPEvqvsOtEjjXy87UYtmgEajG
ZA9huE51MKNAqkAkjLqhOgA0LGIhUS9m2/IDYKX8zxno8t3K0hKiVQ==
//pragma protect end_key_block
//pragma protect digest_block
f8KCq42rADA01kD7pw+AhXObyOE=
//pragma protect end_digest_block
//pragma protect data_block
TLleosC3JY2Nf/qP7m7r5e1KZFeOT0Fc85cPIlbbohFvR8y7xMiNk8+Kr7UUqBYH
p0XrtK5lDsJrm8bPUyikkNDuv8fmFrYo9vb3qW3vu+P5rHLmLIPFS2HRFx0dqr7b
sQLYt16mG4y2nelWu5TfE+jm8AZoNgGGuSFRJkDwyzSnYNhjasffZNzjdpG2z9Dj
anW1GWOVpec2ea3Mnh5dBSAFE5R+BpbVX/GJATVl6PwJFivoV2spTG9e9D48XQrZ
znwjhdQ523fJV3ifxDfpfVjtfMUgCYPUxLRc5PSgCX134yvzw39CLKLX6CtayrBK
CBnPk6IGNRopLirFozc8tw/MhXBMTfralba+vyk4f1h7QzzEFp1QHC+Ndm6vYVHZ
56lU+sigsRo3hgUwolIYW+p0v3VpOwcgE3OjFhCP7fVc930bf+Dbc5K1cK3OSetQ
v6+mm4S5mqGjZhttcuQDCXtxtxrSbQICHuLXn8EBCX31ZlwOubAXcurPvrLn2Ae7
6M82dseUysUDkHSZ2wA4HGVm9Sd6K/X4H/gldmOPo0N+y1ni326OZzfUCDtaLKyb
VQZaAXZbZnEkTnNsY2PSnKzYTXfXZsXIhOM+WEHDdYu3USwyBVnLV7aMRZtunB18
wFoNABV2DfNgNaE5ORcePc8PHCwoudGr1/hgV70qojTG8egTlotSbpvBNncgIfnU
XlP1cNjeR9IYkj0RKtz0ku9GtATClXznn/xXuX775j6ArGFrttTmYcPfjWWtpkLv
Jl/zFHoXcrRq+Op9kLlfWWGHixKYoZ7KtMEdh/8+37QsYft6cc5ZiRSWWg90Q2Ox
bh48G/xCrsJiS/CYWbHOOWsg+OTBpa51q2G57uCtc2kuVWe+etcaJ1Xbs9fJ75b/
kU895GuAB39IneLLSNOVjrZk10k+I80UN6UzAD/cJbMAv1u5TYzXLX0wDshnobLV
CSNKNRgN5JJCLO/fY0VeUM4/HKjC01MGNAyOiEGRdZ73Kig+mVQtoGLkwj3ggy9U
tmV2hOg7/7DwD5dPDdHckTW50E3jaZzXtuPyn51yuk0xj4lvRb2otui7/WP76AcO
lC8ktBQkxFjBUkrLrr95ePEehwmNKBEPZ1AQIwIGK0KMFHWVqVkf+y0y12u5oLOR
rnBvVV4zbBvc9tb5OzFk8/g+yjqMarcsOcMcplPHP3pnQ7uPyPNpd5m1PnvBttAw
KETDtzKBIO5e8BKFmZf+JnpK9TTaawChXUwlgaf/AvBOyQYoTVDqoLpcoeNZqLKA
aYZbgWZGGjVJrMrlVngHFQP57F6eQQMnYnNz2CsFZXuxmrjGjWINOr3c/+4foRwy
9UYoRSoK/tLUdrmsQ7wuMTow8n4/RYe1Ix2ig2h+7mAlPsSPpGz1rmyx9bY45GCF
2hL8uWaMhvaz5q7Eyw1xj0hs8C+bldJgNz6RwR0bpBs/vb8itThauPio02O2tO5g
3FjziQNRSVh9dbRnSWOSCHEVkFEq4UYdRssikLNO8/WdWPNiPVGpsRapQd/K2///
hNBLmKCnjSXqpTe2i5s1lJtxe99KM8dywAXp3hYIuHj3ybEj3STZlBndgQiCaxxx
wyVoohJG9G44b4fwxbGZ2Xg4gKlI7ng1/BkWUh8RUs6S+Vbc6GrCkxP8pXLRf1Ug
rLry5T2fRuioomrwa+SQ1YE6pLMbMfcE0/iGzjnbgegPXfKD0hWwMaPt0qKIuWeO
+ZB34Mfu3Pk/rPLrfFhS8rghGqtXmD3zJeolK6RbYSFEzN3aUI0ZimcyYx1xZ9GS
U1eqzGoo+E+R9sz9Pn2BAg==
//pragma protect end_data_block
//pragma protect digest_block
UtR2Q9TunNkIDIs7c58SjVxoofg=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/** 
 * svt_chi_protocol_service_random_sequence
 *
 * This sequence creates a random svt_chi_protocol_service request.
 */
class svt_chi_protocol_service_random_sequence extends svt_chi_protocol_service_base_sequence; 

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_random_sequence) 

  /** Controls the number of random transactions that will be generated */
  rand int unsigned sequence_length = 5;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 500;
  }

  /**
   * Constructs the svt_chi_protocol_service_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_protocol_service_random_sequence");

  /** 
   * Executes the svt_chi_protocol_service_random_sequence sequence. 
   */
  extern virtual task body();

endclass

//------------------------------------------------------------------------------
function svt_chi_protocol_service_random_sequence::new(string name = "svt_chi_protocol_service_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_protocol_service_random_sequence::body();
  int seq_len_status;
  
  super.body();
  
  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  seq_len_status   = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
  seq_len_status   = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, seq_len_status ? "the config DB" : "randomization"));

  repeat(sequence_length) begin
    `svt_xvm_do(req);
  end
endtask: body

/** @endcond */

// =============================================================================
/** 
 * svt_chi_protocol_service_coherency_exit_sequence
 * This sequence creates a coherency_exit svt_chi_protocol_service request.
 */
class svt_chi_protocol_service_coherency_exit_sequence extends svt_chi_protocol_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_coherency_exit_sequence) 

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /**
   * Constructs the svt_chi_protocol_service_coherency_exit_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_protocol_service_coherency_exit_sequence");

  /** 
   * Executes the svt_chi_protocol_service_coherency_exit_sequence sequence. 
   */
  extern virtual task body();

/** 
  * Function to check if current system configuration meets requirements of this sequence.
  * This sequence requires following configurations
  *  #- Interface type should be RN-F or RN-D with dvm enabled
  *  #- svt_chi_node_configuration::chi_spec_revision >= svt_chi_node_configuration::ISSUE_B
  *  #- sysco_interface_enable should be set to 1.
  */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);

endclass

//------------------------------------------------------------------------------
function svt_chi_protocol_service_coherency_exit_sequence::new(string name = "svt_chi_protocol_service_coherency_exit_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_protocol_service_coherency_exit_sequence::body();
  
  super.body();

  `ifdef SVT_CHI_ISSUE_B_ENABLE
    /** check if current environment is supported or not */ 
    if(!is_supported(node_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    /** Get the user sequence_length. */
    repeat(sequence_length) begin
      `svt_xvm_do_with(req, { service_type == svt_chi_protocol_service::COHERENCY_EXIT; })
    end
  `endif
endtask: body

//------------------------------------------------------------------------------
function bit svt_chi_protocol_service_coherency_exit_sequence::is_supported(svt_configuration cfg, bit silent = 0);
    string str_is_supported_info_prefix = "This sequence cannot be run based on the current configuration.\n";
    string str_is_supported_info = "";
    string str_is_supported_info_suffix = "Modify the configurations\n";
    is_supported = super.is_supported(cfg, silent);
    `ifdef SVT_CHI_ISSUE_B_ENABLE
      if(is_supported) begin
        if(!( 
              (node_cfg.sysco_interface_enable == 1) &&
              (node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && 
              (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_F || (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_D && node_cfg.dvm_enable == 1))
            ) 
          ) begin
          is_supported = 0;
          str_is_supported_info = $sformatf("sysco_interface_enable %0d, chi_spec_revision %0s, chi_interface_type %0s, dvm_enable %0d", node_cfg.sysco_interface_enable, node_cfg.chi_spec_revision.name(), node_cfg.chi_interface_type.name(), node_cfg.dvm_enable);
        end else begin
          is_supported = 1;
        end  
      end  
    `endif
    if (!is_supported) begin
      string str_complete_is_supported_info = {str_is_supported_info_prefix, str_is_supported_info, str_is_supported_info_suffix};
      issue_is_supported_failure(str_complete_is_supported_info);
    end
endfunction


// =============================================================================
/** 
 * svt_chi_protocol_service_active_sequence
 *
 * This sequence creates a coherency_entry svt_chi_protocol_service request.
 */
class svt_chi_protocol_service_coherency_entry_sequence extends svt_chi_protocol_service_base_sequence; 

  /** 
   * Factory Registration.
   */
  `svt_xvm_object_utils(svt_chi_protocol_service_coherency_entry_sequence) 

  /** Constrain the sequence length one for this sequence */
  constraint reasonable_sequence_length {
    sequence_length == 1;
  }

  /**
   * Constructs the svt_chi_protocol_service_active_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_protocol_service_coherency_entry_sequence");

  /** 
   * Executes the svt_chi_protocol_service_active_sequence sequence. 
   */
  extern virtual task body();

/** 
  * Function to check if current system configuration meets requirements of this sequence.
  * This sequence requires following configurations
  *  #- Interface type should be RN-F or RN-D with dvm enabled
  *  #- svt_chi_node_configuration::chi_spec_revision = svt_chi_node_configuration::ISSUE_B or more
  *  #- configuration should be set to sysco_interface_enable
  */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);
endclass

//------------------------------------------------------------------------------
function svt_chi_protocol_service_coherency_entry_sequence::new(string name = "svt_chi_protocol_service_coherency_entry_sequence");
  super.new(name);
  // Make the default sequence_length equal to 1
  sequence_length = 1;
endfunction

//------------------------------------------------------------------------------
task svt_chi_protocol_service_coherency_entry_sequence::body();
  
  super.body();
  
  `ifdef SVT_CHI_ISSUE_B_ENABLE
    /** check if current environment is supported or not */ 
    if(!is_supported(node_cfg, silent))  begin
      `svt_xvm_note("body",$sformatf("This sequence cannot be run based on the current system configuration. Exiting..."))
      return;
    end
    repeat(sequence_length) begin
      `svt_xvm_do_with(req, { service_type == svt_chi_protocol_service::COHERENCY_ENTRY; })
    end
  `endif
endtask: body

//------------------------------------------------------------------------------
function bit svt_chi_protocol_service_coherency_entry_sequence::is_supported(svt_configuration cfg, bit silent = 0);
    string str_is_supported_info_prefix = "This sequence cannot be run based on the current configuration.\n";
    string str_is_supported_info = "";
    string str_is_supported_info_suffix = "Modify the configurations \n";
    is_supported = super.is_supported(cfg, silent);
    `ifdef SVT_CHI_ISSUE_B_ENABLE
      if(is_supported) begin
        if(!( 
              (node_cfg.sysco_interface_enable == 1) &&
              (node_cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && 
              (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_F || (node_cfg.chi_interface_type == svt_chi_node_configuration::RN_D && node_cfg.dvm_enable == 1))
            ) 
          ) begin
          is_supported = 0;
          str_is_supported_info = $sformatf("sysco_interface_enable %0d, chi_spec_revision %0s, chi_interface_type %0s, dvm_enable %0d", node_cfg.sysco_interface_enable, node_cfg.chi_spec_revision.name(), node_cfg.chi_interface_type.name(), node_cfg.dvm_enable);
        end else begin
          is_supported = 1;
        end  
      end 
    `endif
    if (!is_supported) begin
      string str_complete_is_supported_info = {str_is_supported_info_prefix, str_is_supported_info, str_is_supported_info_suffix};
      issue_is_supported_failure(str_complete_is_supported_info);
    end
endfunction

`endif // GUARD_SVT_CHI_PROTOCOL_SERVICE_SEQUENCE_COLLECTION_SV







  


