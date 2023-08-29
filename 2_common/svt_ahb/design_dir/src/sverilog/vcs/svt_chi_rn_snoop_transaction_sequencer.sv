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

`ifndef GUARD_CHI_RN_SNOOP_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_RN_SNOOP_TRANSACTION_SEQUENCER_SV 

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_rn_snoop_transaction responses
 */
class svt_chi_rn_snoop_transaction_sequencer extends svt_sequencer#(svt_chi_rn_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`protected
K3.EGC),H);f)OgAF43ZV4KRE(S)f&D^;2AMBf#?^&VBQ)ecN5B]()B9ebLD,UYg
[OG2b>7VX@ge.@P=Q2\?<))g?HH4cI9@a]QC&95]7AC&3.KL?JH=:V5ZOYDW(a8/
PHF[>-.?&]\gK?9[\GgJX0=E7[N.NVF]HT&1gP7ZM[IH(Oc/-TW+]_1-FZ+Y5/<]
X=7#PUI]C7eV>MfK,daH(T=E1$
`endprotected


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_rn_snoop_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
 extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_chi_rn_snoop_transaction_sequencer

`protected
Ld8++d,J2)6F+Zc>_1d4gK7B+P\5Eb=N-373DNcc1MN8X-1<);OB/)N<9/W8R:9G
CMAGJ]37YB5Y<=,\<5JZ#29+/E:T8K?>7faV]\I1>.(KVO9[U6P1/BSeOVZ_Q@F,
[MQfC]-9dHLgJcV+M+<V#2(<>P>4LSfWGa;E](E_8Ma33IIQG5gV&.1YRcNbQ9PF
0#Z,WD8(SZc7Z#1STY-/ae_,2)&b0V<D3?7GN&e+6=a^PE:_Z=./+QDI9/A<If<P
((@6H__F#a1<^E#&^eeL:<<EZ=dRHRIVDRcMB^Pc#KJ+C:\J>BM.IWQ1:.PM_G<#
YQG[O^L>>YIT?U3T_QKLFOfgN^?OA#]CP]Z-^bK:6HPd-?,Z7MLJOR;VUSQ:g(X(
#AA4/gNENHP\U8U+])?NH&RWGggIW#@2<$
`endprotected
 

//vcs_vip_protect
`protected
\NSP/bQP=G[^ARKY7M/&J8<Q?VOEU0?+AEEY&UX)93T5EE><[^0[/(H30S,;@T<N
3E-+J1)Ic?S\[Zg.738?c1QO@K[W]53Ab5VG=R7#VFZ\NS=>NST8?a_]Rg-P-VU@
[[fB_dd5CV2AB[R^6a(:L7/g6UDQ)5/[9RX:gXD=CaPYAb?8_K3M9Q1F@3D]J9D]
^g[^XW),ZE..>/<)=IG<>5AF>@7#,C<^>++&@>.JHQE32\+LeUF<?6KCLU/cQ-X8
HUWdY#_A(P24TeMG^XUecLM\0JI]3U<U];6E[HcU^<R8>K0K>\:ON5W(2g=L7(X,
K6+2(b4?0C=11_DL6@==>AW^F&CY7<1>>S5?\E_TD3B/LeT[d>JGb125ABaE3><g
Q:#?I>BI5X@F#g4VN9?4gPF&[.Kb&fcANM=WEHBf:H3fU7(-;(X:;X)DfcI+ce8_
]?=9AP@=ON^-a?P/RgYJ,EY@D9<D[D,cO865Kad0T9]SZQ0.JV[IEYM6+g\<YO9d
\LDI#FLJX<S/(JV,K^\AH7cU&@5[bIfS<1CgMYQ^@<NGN/TD&^]Q;)aUOKVI0(5N
U_P)15@bZ)S]NZdC]B8_0]LF,Z:@[=?W60E/2:6?S5\45[]X:5)e1QUSK9MMV<X;
]&_C(9I??e@GUa@;1d^80ZBOB_[>-?0d^=?b;:FQ4AG;4G(2-F6#B+AYLFP@.@\H
AMZ-DB^\3:149GZME==]5JRP-2;^41e,04\;B=Vc2a2EHZ-.-^bQ/cbSL<HKSU5Z
W73)CGAf^dLSU6gcD/VMLgc9H^Je:UEH_9XD6#GJ_@aURb3,Pd),\6+P/c1E]fS\
L)HIWObKa)#1\RK[84.7MA3K,4D&NI25P/8ZP8K7XI>-c:IF@gc/TFf6P=W)2N3g
ICg.CU51(g>@<NNQ&N@dBBg,4#OXK^_R<;UDC?V4aR,EGD,<6/IPJ?6Rg2D=TP&\
<,C4K49NJ8.6e]eEB1g5gb,F+_c=>YeKJdZFI@5_OIJaD:)+_V&]759I>c^\,F+_
Tdf5WO>f4eNG=>XAIC&Yg0MPM8K6&@+2B,\)FVKa7V(^1^V.SFC@W<XH#Q:;;>[a
YDAP9X>FHBG81<@Xa_LNaN.]?X_9c+>6LG5C_UK^[,/Q1HHA1FTWZ&ZZfR@5Ad.4
64^;K/)6I0CU+AYA;.0K(#\7\2d3N48N&c65J0a@#I4>UJbO)LcM669Y#W:ASD(M
P2>ReSW[E^gKC99aM7\8YW;0YEbD4Hb&894@,TbEPWD8.Y7LIO7dgQI-6eM9(7)Q
OA.0QgNV1Y\O=3350.-U),5-XgX1G9S::\2@W<S<Z2-X2Y4Y>CVSg:=@#X^?=GB\
]N2g_/e6Gd;HH,0^P9^BU;LWTSDKUUUG+:+6S@4N>LT9LJVeaO;9++Q/<a<SZRL6
Rb\T8>\\C7L8+7]X6R+Z=fSE7>PGR:NP?IUYWSTPcCV5;<f6==-^E(=KPdEdK]//
XS/Kf(X5.<A@F(=VgK4O6@HUNI1F;C7b#QVV_]K6IG3.>>L2TPL<>I-8-<F&)XTE
K:4B4M-^P@8CY:RGJH)PPc;CU_B>>L#@7B.\ddTH(6d=-<IbR9d&+(&PB+WHb;/=
Ng\NB<TR=T/+dN+EGU^SY&DdWY^b&Egf/;^9[\SO3U[D;c2b+)5SEZTVG;UPT9?E
[2C+M_b?]+9^]3I@<]6AIg##8Ta4#:IDAH_IUF+.VUVJ#174ZBa,&V,Fc=SFZ3-c
V_f/=_@>]PQC?0?ZT0/<e&\Q2,WIV(9Z]:W?_:SLX:+KU,ETT@MI>I(=9[G?.S7P
E6<PP-eT7>6-]0L3(gRcH)[5@f>\PHRME1GC;4f<-2Y?dZ.X:fD1eAH-W&37:X26
D3L#QT_2eLP13VII^YP@b&4ccDfYf^Fe;#D2?@7(3E\c^6LKN&HPOQPX4@0ZMMKU
;SSQ;V4-:VB==PJGYW-7R(cM)5H8AZT:93b/.E+^H\,-52RLLQ.[?]W4R39:;2/^
P]4Z-a9(;CUSX?2X([f@Hd0BG.edZT5/S5-G2B8(L)COR+>5-68V,K/Xd+KNI8,R
9EYJSLT/GP=KA9=0a..G\^C[6X&4a?Z2#TIPX.?]E0dIL^2>R^d&a_;M]&^P5QL=
dB>?D/e;^+I]_aG^J?TAM&4g>4BNB^UF^62:\\J<5#b9;e9N4GX;\?Qd63,.JNfI
7+_5QC16-A2B+Ed-RW6LT3[ZO7GC:e[9V<=^@e__EMC89)QA;<;K12CA6Dd.>Z0[
f^X>b29UKeKR)TGMeB&F\5Z]<8^)48;;4d</8dBN^acdP0P6)5=J\M+.+SL[;b3=
e(S5&Y)8YO\^W-EdS_+RJ4WQHP7WbI,063acKeB.G7K?-[0+S[Z]8)2)4L02-Z7<
._1dT)M=93)<3W_9FV0&FZJ0d[4>RC8:4R1#0aW18f<[(H^=I7:13?,(PMCW4NdD
0U[&(J1F(&UQ66-/O0.f\Q^J<.e,TUAIH1N_7eG3D2OM5Cf9M>.]CG,#\;#:/0T_
J.UA(8d5X9PQ)$
`endprotected


`endif // GUARD_CHI_RN_SNOOP_TRANSACTION_SEQUENCER_SV
