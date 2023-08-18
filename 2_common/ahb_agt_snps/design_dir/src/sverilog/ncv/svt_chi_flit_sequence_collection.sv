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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ewh6cIqUfnKxz3XIp+rvGZOCnm1cZ+beysgROhqo2x7d4WU7YleUvkEk1oWyGXaL
YIPAJ6uKtTtmoeH7pjOWWc2S56uNd31YaLc+h2LDEWSqf33GikfdCZk+L7NsWi13
ypUngB3QAcGgEgXqDTRpvOa1VI/ibN9LC5Ut7NQ/XODIruEmQbzgmQ==
//pragma protect end_key_block
//pragma protect digest_block
rK58IMe+lId177XNnj7oIAHkowc=
//pragma protect end_digest_block
//pragma protect data_block
/Bwy9JFDMZou4acP4+f3G28ScQUTggFCNAtXCj9O9rckmJhUYbwT5dAvdxfvq5Oj
4n4Orgbkg88OdG3ytIrWYz18QyBYHsulKfNlBrsqiHkDOqGZNBzFE/a7n3H6rqJX
cFnSuEZB9susgac99EXabI+Lb+/fevwplVxzrlOBHShtQbE2HLijooOGfJabVwJ6
05pxBRv44MoMiul+UEw2Q4W6eQht7VjCOcVLAguXPc45c32W9HNsdeC8xpNwSJDX
MK7/TeqZAoPBZe83+/s40aqI5JDM5EzmLEy0m83ewD7jl9SofWRwwiEywkYcN8ls
GXgVMhK3GaOHQG60GuQDBjT8Ng1CzfCIKhXkaz/zBlDOG/ITfVZ3Rl10h7rwzHxG
rrndT/yROFmwDzgFq4/QvCsES+yTrWuBBXbkl0CdkszXLYUO+39NbSB1bzXZUr/V
LspaCcvgdUhSJ5/O0IEEKXyNRZtqEEK3Eqsq3G1o37Da4BqMM06ixS1Cp1+p0VEu
zCzPc22O3ycKHpHkF+a/DWcCMVP1UCwPbzSE3giepNbpvQ1YxciQKQ3ZthgCBSpf
uc0VUdg7egzIi7xXuQscw18FEpPM1LEQuAshktoYT9PtePLgGsgNdnRo7fIcWeEc

//pragma protect end_data_block
//pragma protect digest_block
sZZ+mkam4lSbQzWJ+eYQJx7OEcA=
//pragma protect end_digest_block
//pragma protect end_protected

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

