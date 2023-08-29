//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCE_LIBRARY_SV

/** @cond PRIVATE */
// =============================================================================
/**
 * This sequence creates a reporter reference
 */
class svt_chi_sn_virtual_base_sequence extends svt_sequence;

  `svt_xvm_object_utils(svt_chi_sn_virtual_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_sn_virtual_sequencer)

  extern function new(string name="svt_chi_sn_virtual_base_sequence");

  virtual task body();
  endtask

endclass: svt_chi_sn_virtual_base_sequence
/** @endcond */
`protected
;?gF#6Sg?5QNI-EeLN@Pc<N2RG._2-\SA[?NdNAgBE#,NGH\],_D6)AESd(]dK<C
_d0WNVQ@[c.=?)BG6A/0=Z]<;3D>./>]Z8>X9W)dC/&RORbB_EZLLT&/=:UFca\/
,[^X&]/40&&RU:>X,\5XAE]1\9?9OP?>^gK/)RLbXX;4=0^W#L?=VK:\f.bW8DGf
T1R>A]EV6_B;V5Je3eFG\B9V/]HV^c8K56\5K(GF/4U[(SQ\0O<S:W7@Q+[A>O59Q$
`endprotected


`endif // GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCE_LIBRARY_SV
