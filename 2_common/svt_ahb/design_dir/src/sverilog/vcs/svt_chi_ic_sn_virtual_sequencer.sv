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

`ifndef GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_ic_sn_agent.
 */
class svt_chi_ic_sn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply TX Request Flit to the driver. */
  svt_chi_flit_sequencer tx_req_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which connects to protocol layer of interconnect node that connects to an SN */
  svt_chi_rn_transaction_sequencer ic_sn_xact_seqr;

 //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** Configuration object for this sequencer. */
  local svt_chi_node_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_chi_ic_sn_virtual_sequencer)
    `svt_xvm_field_object(tx_req_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(ic_sn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_chi_ic_sn_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
//  extern virtual function svt_chi_ic_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
V<RF?Z6^)AbNRKX(]c?a9@7dW:-4JJD??_\U42,bN9UD@4]96).J3)-c30):eg@H
4<Bf71T]F/aBD#?=@5YX(Q.K2AR)/JUb5X\_FY7LR<W4[A3W5Td@)Xd\Z,?TJA8^
3S[7<60+/W95_1TYeN+S3_).4SYT8QKE/OF2Y(Z<:;c+=:_bcU#FaY3ZVg-7K)Tg
,d^4+_K?N&e3f7W5?4K<+?;U?9^G>/+&#Y1P<_^)NI3S#::USOf,R/&(C>g>X:+3
GWU+,&4^;N.<48#=LDQ<:=FSI6BH0A4PG\>^Se+1.S2K/=M492AWSX+IC,M?BC]f
288EB2G9NCM7:>@-C+N8AS<(;dPO9QE#/5KR]f:7F[gKE$
`endprotected


//vcs_vip_protect
`protected
KJLZKb[F0O7]a43a+/E+TcLc@Q.FJ[5J&V=JYg<b[GBFfARX\>Ib1(+e:Z1AW]+d
X15F>5J^eHUZd(,(LKX4^b^eX;S5]Ea(14-G5K=Sg.QQ2B.J=bHSd;)[7;8+/A-6
(E8[=X[X3N?B\SUgMR_@a=RXWd:F_>YW;H=AGON)&<I9ZT#4/[K.ML</eU7#=a1+
-=#ZNUe\&G_CacX++U,:f,&@]fN,Hf37-(JNQcKb,=_Q+gX&L;?&VJN+J6AI(Sf:
-SKdZBT8YHI-6KV(@.IIJ#;&XJ&f4SII#f:gg[gO2PH2TAN23?03GZSaaQ6RY]S;
\/)@E6]gZ8WM1&5ZD9cURTf<-L;5^LX[abWd>U>bgC87(G79.T38:G@P:7gUO<Y7
#2,YSJ8AS1DJF:g8XB8\f@OE;NIdTPe4T#<L:GWgfW\:V+eTM,O&PbN:GB/#4AA#
b45DG95<(\^24[Jg6U5\8?E,d(-T>3JFHH6:?,[<FC>;@QXNNX?[N3C/_&O6;Ce1
SBJO=4EgM2NKR?(]S]PHEf<H)>2Z\;#5KJJ8LWFC8BgfPRJcK@.UAH/OXR\:-4-1
80TfZ;\C_L5D7\=N_#0ALZO=0_BI8JT_W\>[GWXW++OePJ@;fKPT9/e&=E,3FQ/7
_;[eTGOfEHUgCW3[_@1#d+<K)JL(#D;SH9/_9RWQ4b6<W5UgX.8^NRA0UZ2E8=F]
5)4=Q?T;FH/UYHg8&OL[&2Fc)K(058&Q@M@g;WKU3_<VcH.J.33KV5f-Z7C#][<C
=G#gGFG[KZ3@HJRT;0B<c(MJd>X;8(3W,C,#9WG\beegTX+>1AHb9.7C5_g[#,f#
0N25aGN7-5U:7KN_/IHd==PO2dQTa.ScM+aVX_C3OYCGHgXa:_D,e2WQ?._9;ECb
LUc;^_T9eJI@XK[])@g?JTIP_A>50;gLL9-XJO\A234dHL02SQRPa#ER6dAV[a,^
9)M\;[N[7::^P^0e;eeBe8bE,OY]&d=DY:2:0B0^\P@>@/PU],A)4^OO:a/O-(>?
8aUcVMb83]?M1V@AVRf&c4A:G7,..;/W2cb->5M<g\0<]G#Z?T_3aDdb^<^4T3ca
HMI(A5g_Q49:SB7ZRN=\dS3>LdLc\_[F91^((1-,QF8RZQ^:,d3_F0\::5<]fHDQ
O=IbMCR]YI_\<3N\&5SPXGJcGC((H&a;9O/FD6VIW#/4W]P?[#VfJ)0:PMd3Re_)
WXWfJcU2<T1)C5:]5]E>,N_c]:>.M>L+/Abf3^5?SZKJA.PB1e6N.HBaS^TUZI<_
U[L^d=7M1_bPA4SN7MT-Y(f4gb[=Q)?P3VU<X=JEKZ4;e87gGEaE0+GY/af&<:EC
0K2254M/HJUZI\_[E;M\FG57XHMSA=YZ0ZVM>#L[JQNF4Q7Ng^?&8F(>]9;fM=6Y
\O=@88G<;VZL^UQGNeaMB>@,1UG7-<c&MX>E5P\JU8U)RJc?@]^eA?WS0QC]L0E3
]]+YUa71<M3Lfb/f4P\A5I4Q#_Bb[_ZcJ(LTa7]0fQdIVCPG3=\XZ+N=XQ^^#B.R
ad=J0g3T>.TcE6;55B,)Ud&X:C>98JFg,1<VRXg3/3abO,G/6+;3b(N;3M#/LGJS
@(J6O;D39dJ1N-/3_I((8?,<U6.A;HAB<eVGROG\2@XRX?SfR(Y)JCaL[#>K5YcQ
MZY=KY1?Pb<R=3QLB\gPZ,9ILZ#&Ed+Q]7fD24K?]TT+1E6;RN&BB8(?FX\3?^P9
K?,T8(S@C3U^Y[;@]^8-RAK:fMRTS5f-8J@2B([_1OH_0I8H/QMAgDEN8#67LHNY
3YS_N[TS&ad3QU)B,bUcMKg&=>5Dc3X#)cfD1L-0-,JN3Q-B#&]N(-Ye>H#OV;g-
()3dC/277423.g)L.?IW;1B4]CMHbfM@a@T/1#=U14)@VG1B[]5fRI<Q#cM]7P2H
XK^>[-(3\Hdcf(B@4.)6E=)bHD3S[<?V3a-Z6:CQ8V8RH-O](5]fD+\&P(C9[]_0
gEYM_WCFG&+-O.LS\.a#>-[PJVddBSMHbf,5I?U0#R-Cc./=RIAIG<82NaYBMcP1
c9R^,M(.9,J,BC/<6HEHYYW?1Y_a^?/-PO#1P#;9<2aCD$
`endprotected


`endif // GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV
