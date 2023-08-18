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

`ifndef GUARD_SVT_CHI_FLIT_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_FLIT_SEQUENCE_COLLECTION_SV

/** @cond PRIVATE */
// =============================================================================
/** 
 * svt_chi_flit_base_sequence: This is the base class for svt_chi_flit
 * sequences. All other svt_chi_flit sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or
 * sequence clients set the #manage_objection bit to 1.
 */
class svt_chi_flit_base_sequence extends svt_sequence#(svt_chi_flit);

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_flit_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_flit_sequencer) 

  /** 
   * Constructs a new svt_chi_flit_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_flit_base_sequence");

  /** Empty body method */
  virtual task body();
  endtask

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TD1NrpcD57AExEVtVwUwqSvcv6uGtgGSvJ+aYAV28pXUBTONcoPv39x4AEZqWQ8B
oY38Vt9zMJVGEuAXWM/UHy6l6nGtbeT0IHLIyU1UclATw7G5YHrXlzgY+2/yY5DP
vgaeKWwAVGfGi7nNHUMiK3bQIMg2TBL7q6vzcM/GkVU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 310       )
MPrXK+G8OTKn/k3L3k178EfpYLwASqcUUxK24O8+MC37m790pXxggRlr903TZ9c0
vTppg5NzL/zThCVSSjDuKrXzurDN/A3fQnVdZ+lqPJGRcMWL50MgDVyK+Xbz8opf
K5Qf+9MTIK+Kv5Xkh/LdeZcDF8DXRB5fMqy+oR622NAYH9Mtd65tlf6VtAyhQ7h/
Wnqc7Fqc0y7nMih7IgXKnzOgXjoHUuDRWLSor7rMoK6y960dpMHH22/dAtTNwCUX
mgDISDnalU33up7BRwmjtT9vC4s7drtWZlW74kLSC5lS1RpYhpgVN+4Awl5Vwx2T
JwsPjzvHRtLhBrugA9kZs8+azW/POEyau8rYtjPet+c8O8IjxIOJA8nOCcLST461
DfeAsylcmR2irvQNZzf25mmXYAAsSkNJvjGOYnLi7UY=
`pragma protect end_protected

// =============================================================================
/** 
 * svt_chi_flit_random_sequence
 *
 * This sequence creates a random svt_chi_flit request.
 */
class svt_chi_flit_random_sequence extends svt_chi_flit_base_sequence; 
  
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_flit_random_sequence) 
  
  /** Parameter that controls the number of svt_chi_flit requests that will be generated */
  rand int unsigned sequence_length = 5;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 10;
  }

  /**
   * Constructs the svt_chi_flit_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_flit_random_sequence");
  
  /** 
   * Executes the svt_chi_flit_random_sequence sequence. 
   */
  extern virtual task body();

endclass

//------------------------------------------------------------------------------
function svt_chi_flit_random_sequence::new(string name="svt_chi_flit_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_flit_random_sequence::body();
  svt_chi_flit req;

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  int status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
  int status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

  repeat(sequence_length) begin
    `svt_xvm_create(req);
    `svt_xvm_rand_send(req)
  end
endtask

// =============================================================================
/** 
 * svt_chi_flit_null_sequence
 *
 * This class creates a null sequence which can be associated with a sequencer but generates no traffic.
 */
class svt_chi_flit_null_sequence extends svt_chi_flit_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_flit_null_sequence) 
  
  /**
   * Constructs the svt_chi_flit_null_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_flit_null_sequence");

  /** 
   * Executes svt_chi_flit_null_sequence sequence. 
   */
  extern virtual task body();

endclass
/** @endcond */

// =============================================================================

//------------------------------------------------------------------------------
function svt_chi_flit_null_sequence::new(string name = "svt_chi_flit_null_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_flit_null_sequence:: body();
endtask

// =============================================================================

`endif // GUARD_SVT_CHI_FLIT_SEQUENCE_COLLECTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lK9dxsAqFyAcFncCOF0fLGsD5lPUoUR9jQv6itIbzylrLjbEHPLLUmvYzp7wdS3a
JfVzRxJ1c5b1Hb0SBYn59eXObZlnvQDd+RSrOa11lZjNDco2ZJa+8Z276bMUcpdM
pvKzKVP7vxD/0zj3rVUxl7rqpwmMo1sHqPVEfmIDXCM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 393       )
6ieJiuH8yFT1d1QOVsfk2uv0ZnUdaaEMNKFELMa9slJWNtDo4AxcEtjI0RIRkrYf
iHm5nkitrclOikvaAEMa6OFhZSLvrVhInj+DRoNEHDtywuERW7/NylatsPeqZrUh
`pragma protect end_protected
