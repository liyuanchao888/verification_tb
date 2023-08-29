//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_ic_sn_transaction_sequencer;
typedef class svt_chi_ic_sn_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_ic_sn_transaction responses
 */
class svt_chi_ic_sn_transaction_sequencer extends svt_sequencer#(svt_chi_ic_sn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_transaction observed);

  /** @cond PRIVATE */

  /**
   * Response request port
   */
  `SVT_XVM(blocking_get_port)#(svt_chi_ic_sn_transaction) response_request_port;

  /** Currently running sequence */
  svt_chi_ic_sn_transaction_base_sequence m_running_seq;

  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_ic_sn_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
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

endclass: svt_chi_ic_sn_transaction_sequencer

`protected
>JW^,9aC0ICaBgAJ4E/+NL#.,X;C9+HEWaT#0J.AgEVAf3H,:&2d1)PP>,,WD.OO
D<+GeMW5@S#:3TBc:;GC@g.V[-VO#1L]Q0<gaKc7W&=PC(JBVK5CN++XX\]W.D&\
?.:^D<N=DC)LTFb,f62U^,4[\3E\@B87He-]6KD6JQ,:>AX>5O^LB1c]b[/Q_IF;
EWaBE8>KbN)KeQ&DPQ8(2;GH>?;.GTM+T#SaX6X>NH;_bL,EY<ab(>#PfCE0fY67
IG+5C7(6)&F]P0&eWEf[gZ8[0+O6X#>/W-Rad+->IdUM6&1D[G;D(ccXHQcUc\C9
W<^7cKYFH4-]5PLAFWdOZT;#(2.WO+\d_2@[-C:^;4)H]SUeaX;O1a2&b73,^R^Y
G\f7FMM:<#?]0$
`endprotected


//vcs_vip_protect
`protected
-0)&7[)8@R=-&c\3a;9+W[<ZHGeDEVE+@>H./.NULT5MJ6Q0dA_X2(9LD6K]29?1
3e3JBON5#XOc,+&Dd9K=8ZaR;N;b5I0^;5GOWbZ@PYZZV,+PgLHYT/@+a1+Z?=Gc
H@=W-&,7)IbP(Y41.BCH4GCgcKACR+RRf5(T[9_g\[a-=@JIA^0Z((//a&_T)R9Y
B16/J:4=a,>+7&D<?6F@CZ;D3Pb[^F;:KE30aQ[.ZgV0<IL0?RZIOS^?3+#2d+Hb
[XG2/aC_W0DV3Ya9,7(S[&M,]cfQ3R;S&2g(MC;OAJXeK+(IL\#6CN;BB+IbXaU;
+(ac95219Ka=_f-5/K?@<ZU5AaD=g\56IJ&AI&9Y<_,1GdA<=->9dVGLT@<R1+_2
=,C/EHNB33H4GcK(?a=M>cCg@[4]07/(5+Q<YbDXMW\F=)_O4QU2gceK=^R[gPNV
\gE0.VSb)-P4a+Obc.)8#SN3R.1ga=U]MQ#H?\:.R6DB?LGI]N@bU]g)a3Mg/Ygb
B/AQX(aeUd9FdFGa4Z;,CUAM&>O8Q^ce8=E]gXQLFN+_K]L7_UTfYG[7TO8P38XP
U[gT\S/WIS,1E_;W:PBWJRHW]^)XI8g\-QPgNgJV<J^1@5&Se50bM<7:G+5Y,((6
bKXbg-<>4L_H4>FU_:C<(=.X<,ON;<)c#?Xe.C\6DYDbdLTNDg(2>@PY9d+.,M#D
2Q.1TO?TG575_ID4.B1Ld(BKUKXN].WI5P_CT+UT>HF?VSJZeR+NU/+&-RPLAIa>
Wb)9;^/=.a)d.-2F3Q.3]b9B8<5caKLV=6TX&UL^814?JV3UH.L&25?BGWQg>XNe
G,@?H[XGE^[DXAQ?Q.K8/D?4Rc#/#XYMRe7]d8Wd([9U(?CR=bbd5<W3B5DF:IB-
4CNDd]^UIM8NdZ<C3cQ:U91M<D2E<(J>\5;/bZbKTdGd@fQe56YgV_4M^_gNVIC6
(];I3RXfe#VP/CM6?KYT0PNT-DVDW;R]4E080WSO(dHK]U<SHM3>-H:E0J\PW>8F
RR)U4A)Yd;bB@J.a4_ANVRgM+bL5S8/afa.N[W=;c+BX1@NVC)J?eT82Nf]K6g,N
&985.JBVJgBg-2I><FWa.@df>=9Xe);-[(^BU-ZA.A22.4)[0AbcaEHe7eY_RIZW
:Fbc7O;J-cY-MDcJM1H\U0F9@f(:^>@=2,g(eCUc#PP51/;[J@Gc,cK+U]#A[F5P
cegFLXM5^f8AW79Le8^RGV];)?.3#/<a#>5^.@?g>9F?[ZUZUNJ=bF(>(2C^R[=U
U-ePIOST@]7.WN>#D2R[S1(b3YaBK[E(5aE:aB>Ae5eTb-/?c2-Rb_/75)f?MPH+
dUGfH+Lf=&Y?O2V?W#ZffV/Sd6=6d#I2OHFB=VcZg=b1++5)UF79Uc&OQZK_?;:0
_Pf6#7#.=;O(R:]?C]+VB:D]/.MKc0GS(]aD0LR&I#HXXNc)UCDF=a<4fNH..4LE
FC&V9bV[U<RX+K<1Z&g[<QEYT_?=6IBeI=eLfbd5[)-WOKUc0+]O@VZfI+?B?@eg
(^^4g?:F\W^aDIDM6I>TGPMO<QOPRAY?e5a]fc#<[1NAG=bQaHRY?^=K^+;-VfE\
=:]b?2Y:67^gF?g.OP^61cSGCVBHeU.9QC@#?GcFE1&O3@ELS7DL[(4?f4W7X+R\
<,gTBbfJ./[F/46OeJ<>@+UGC\6JS=RTOZ?UCDA+BPPH4eZ(X9cUS8MZU08GA<9c
10-Z<cV^]>I4]H@Z5D>2A:PE+CV@L>dUOWb+F1;XE:TZT05#THZSH.VSb8fZP^N]
]DLQ5I)&e0[_Z81+MQT\I=P92W>6].,<5=OU[-,T+Y?/T].g8:E59HBEgU]>4U^&
.2=]V/I3N-S1S_,F[B^Q.Yc-(0CAC)[Qc0N70S2[0B])_MdSZ>2Q(===V6+Va0R+
YJSO4QHL#,A0UQ6HI.10?B,?aMK;=MXER28Z]DOc;NecNX^Y/G488cE#If7UdSg4
M(PM\#U_+-\0aTeVa>^IP3L]Y0D@2,Z0NB@5#[a^+G=X>VL7BK11D\CLILc2#a^.
8\,_-D=LM\&Q3G1Q0\#6J87IQQOO4PTI6^09R3FAf[X]RIG-6Pd&^MfRN3eD6HYb
,gHfL#@e]T.#Q)@R0bZ>AOBX+=OPS)15\Qe@FPfOY9,XV;:-OOL5CZA]cXPZI?:B
8:?#]?]/UJ,;FR/eFNbGfP?80,0]KX9)40d(489SC/RHFR]C5gbWVNeR>=F+Q9f\
AR(5eZe;Z,\[Z9[W[3^;MM93[])UeMa^)B1V2_V??IY0B.79C3GCJYe8J<9a>/&Z
H]c)VM.0B)EZ@K[YZNY4Y/3S,=5[b4[Q&72,@(0R:>]_77Ia;];F?P>B>&_,gI7W
3g0EbL,+^G=UOK&7OSa+e)gV/I4KgI;0W(KTCU_D2<:6V4;6cGOVS0X3CPI25WaL
LPDa@R3Ca#RD)(Q.)Y@.Rb_<OdS&fQER6)dJ;XYMM6FDeP;fSgSOHK(2(QF@SL#D
?J_T[T5PQ+D?UM[>24VL0HH+V#\+36^8&FFWg8eB+b2JYGg?7-TQ@O/G<d4_7_=[
IbD=.NATP,bK#YbUZXA<LCf5YW.7S>fZc7<;INC&FW4M>U##/W8e()cBgX#^Q+<G
B=_@9CT8F<3<&_JE+a0@4A@\1ff;0afZCOK+_L#F-T(SOg80GM6(@dODVEfJMHb:
7>D7P4Q?7=Xg0bB3a#AJ&TPaE/F7/#M2W\1]6)f4I(aFH]X]Ye^#9EcI9YK67[X5
K<B)W^JV2HE.1-dBDC5f1=]\4ZK4]c-?gY/S;=D?(4>[H6FC=Yc(9VcIN$
`endprotected


`endif // GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV
