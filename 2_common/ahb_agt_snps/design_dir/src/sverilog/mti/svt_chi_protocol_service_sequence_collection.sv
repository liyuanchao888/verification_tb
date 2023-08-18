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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ap9s5vpu6o4wk6ZXKVsDxiu0bRrCpQVqX2dGLcfJ0nHBotUrj+vLfJRqG1NXx3VA
I1OnWe76BjBSFGa6zUD1Qjo2AxxY/MwOTOt2IfhVKDlFDMNw18Q035s5dFnBAtRN
uf+kYcjSpwQEYqQLv09gNgqeqbMGjB6GbDrQJdF2jec=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 334       )
kzBzUSAtIkUqG2j7MYoKaRZgV6i4Dug+l3g8GPd+I/dHOuq1FmXPFRbHNew0eLKs
2iqxPB9vudpcW+/ek5MQ9R338D1qGFh3K/nDAt1k0kBx3iQfdUlxDMDuvyVyY8+e
ZVfYXaGdiD5ikB60Jo0AQeWKyNvpKymXxTpxn0Fn8wTS0RqTrNdyPA6pXdqAhR5l
Le2JHeSSnDs8Ro+KuEPl5pJbuOd4lICOYz8ccFjsZpw12WzvZ42n2xLXAWU1zTJ9
zVz9lEMLXWUuX4I/oouf++ZUMCe3VXS2YNR3ywJLj9Y2hUXMtFTiDakjLeYtjbYz
RCZNpxbQHy5xpc6V1M3mgyZ5eLh32IJVHTWrDao+x8xLYto23fC0+v9TSRmt9WS4
vt3qGIS6T2V1AKesScd+WUOprt1rlvhnN5Tmoh5dhQ87fL+sd0Xs9aLfbEXcC71q
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
b6g7HFd3w6UpdpLvctInds2VIul/4/W2hd6KfzxHMKVuGWrdDng8wDkZeQXIqw09
OJp8hq2qW1pb3jBjsmKJrRQQFjYxvMp6xPJWX1tkFSGOWlkB1kKWZ+0yRlMsMe/7
40Con0IFEQFMXskwWLf32Lbh4wsfSZHvpmL495KPd7o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1521      )
ddvKHMc/JKvhgAquBE3mtBUr02Iaoc2xGea1NrqaObHavj+Xl1UD4qKh1mxCLkp6
IGvnlzJ4bw3KC3agKowNYz7VutDnDNgL0wB4bjGgQ3faHQ0im0KzjMp7hcsvbLI3
scythysUo0GfvHJNkw5DKieO9ITlcIHDMJiN7hf4WyzaFvtBnukBjki2rNNw6RTu
XfXWuE5H6NP6biIF61F5l0pWdfOazy0gNaciozfmXTt/w996Dz6uyAFFy9QQb3FY
uD6fOvMPGMelEpOdo8e+nw0aSB+HHPWdt25zsLmtfHkR+IXj5vbtJcfo94R/mzT4
pWR3DdIX0IET9EEPhTs2Bw0d/0ra2EeylzfN++y0LgyRRzeBC2Hsb4A3ejVoF1CE
0WpSEPBTVUDSrnUaG3wG00K+jJ58r3oiyhTso5GnJqcQtlTFJVNhOWfrq26tyPyN
6iYAvEXWxo3uZtNcb65e9uI8eStmh2wP3GkZRz/bdyr25DyRFvO1c4tfGzHMLJTm
Q6W7udnlXD7evGunMUntA3VSipMkeoTKA2MWbiGVtgEfmFM5Wmkpr2Lof6F9EtXG
H2vX5LL4LiY8GuFPCnZI5/wT7jdu75u8ZbN7sr+Npyh0fgbQLhjmAxBVPysE4gba
dJ5b/bILmPNYYakjJtJfNqS28uRNwj8b7Axq4yYabyzuusz28wSxvVgsr0kqGFas
PfbutZSRXXxZfw//LXEYACEpiSGvOcxyp33/A1kkQEiNBlaRDd3as0lKBhKspy4r
ukVJPU7sEcEpGYIXMo9fdn7CSBiwDTNl5KA1ISoQRDfwFJ3ah9QmxpLF4QPjsWn2
PyKNJ6j07ZpKGIwyR9sJ45wfHI0mBEH+FSjhQAH6BKly4G0q/9/8QhA0kEsihHLu
XUNU5JfQd6dNLlrSq0k8KcFqw8qanoN9eSa8J8s+VuAC6W91tJWZiIw+E+xObh9M
QmOPEKL76nahKKpbksPILTrUIUZNd2NheWg2/mmtnB9iaeAApb3GrcIYhsBIh+nt
OpEFKhrC+lNiiYlyrL6bZ36lFjXsyweFj8e4/0HAF9+WFDwMkqN0mgGP2w/OO6kH
nubkY5U6kmF3MYqQVk/KNv1513LqAptAEje6yCs/OQBX1H71dqnzoJbDFhOt5xYd
bndhsUAJz6t3TPwO8oox+aXYKZxiq5i4QIW/5aamaZf8+u492XkF7Ubvw8QxH65f
7f/iMGjOpK6g9Gn+KztpMxXQHRKis361cJ3S43+NE3l5J8wyPWQtAvIJbCBm8uQN
RewGBFL/dhSofD8KRFovV9N2xGAF5/QPuUoarD1C7dr2CDGGGWwP7PI3X5IfEvPt
396OItp1k/PQ+NJa7GzZOr0qlZTUx0J3PPnbiTHmxzpoXwXGe3ePSgV3R9cTRHgz
HsIQAAWMVbmhi0aUUVim8SuM664LwKq2rzicRWAcjdgV4uAW7cGyZUqYofPJ7a77
jJC0OumMpbAi6mvj8NPz5JqzrjWGrEkfarcz4xNjyseHsdx6ow03RKWcXz+JO9xq
9cKTWLn/ribnWdl3ask0DQhb/4PoRdhVByfZSU8cQA1YKtjwCP00tgk5gqgvbijq
`pragma protect end_protected

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







  


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lMmNR5WghedvphXEsIh6m5AEPO5/+CbBTNNWEPHDkFUMse6AvT7esviQA2WTH5gc
78+m1M9u/4Qfzt6/tOGyXvUc3BcO/7WPIY6dsOcPvwnPay0nqlXASSap/Pyob+O7
ZCnoqg0A4zT0dnY8M1tBr7+XweDLGEeqNAukWiSX+eI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1604      )
SnvWypQM5BlW9NM91k7tJfzTfnktkxTK6y/uf64RxlSRhf377o/NXTP75URCgNbI
oXYCP4Qhl5znjAip0ywBOAOYFF4RnlrbfSmWmsbByYox46toAHnTDaydCV0fM7Rj
`pragma protect end_protected
