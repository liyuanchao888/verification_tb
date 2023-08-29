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

`ifndef GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCE_LIBRARY_SV

/** @cond PRIVATE */
// =============================================================================
/**
 * This sequence creates a reporter reference
 */
class svt_chi_rn_virtual_base_sequence extends svt_sequence;

  `svt_xvm_object_utils(svt_chi_rn_virtual_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_chi_rn_virtual_sequencer)

  extern function new(string name="svt_chi_rn_virtual_base_sequence");

  virtual task body();
  endtask

endclass: svt_chi_rn_virtual_base_sequence
/** @endcond */
`protected
#YTR4;U?,V)6CL/&0f9K.K^AO-JQB70SDP>Z?VDTJ_XF4Yc3KC<Z))&E[cgUMEJL
0(C^+W<G(FRY3Y?RSO-YD.198@ZX)UT.1>fe3Lf_#NP\7.,7^GU+;KDaAaXBddP>
8BFLW5<QLGbJ(3XB_<]RQK>W9b@OYa;.@D3\9ARNG#><D];M>X[Z@^UG#GA_NeU.
98e9;3+b^b76LUZa]6;6H(I4C,7UTV5&.U(D2@T\KOLHP;O#36W>0?UGO$
`endprotected


`endif // GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCE_LIBRARY_SV
