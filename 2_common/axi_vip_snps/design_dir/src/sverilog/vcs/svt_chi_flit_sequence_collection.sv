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

`protected
D7U?/@4Z=ef,.IL2D(7WKK^/;.[gVcdLIS@TFM@YF2bH0K,aH-\X-).@BX.O+GRD
8S[1:S2CUI<2#)gO,/1dE[TW:OM#g+EY\]EFeCFE1++1cHC.YVf87dPPSX0?MM00
[P.-.K;WY+^>?88HA8<EIb1-eUA4c^X5CX=LYOe/_9?(61MA)Z-2_J;A/IUaKf4W
O-=c4QdgWIS[/Q+fg1,5E8e]VD3CS8BZ9.6bKFKb9]C9/gP89SO<J2-;WbQ^U:1K
WXE)Xa3&;2a[,$
`endprotected


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

