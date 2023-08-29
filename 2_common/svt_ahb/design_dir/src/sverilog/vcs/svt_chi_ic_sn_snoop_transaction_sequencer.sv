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

`ifndef GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_ic_sn_snoop_transaction_sequencer;
typedef class svt_chi_ic_snoop_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_ic_snoop_transaction responses
 */
class svt_chi_ic_sn_snoop_transaction_sequencer extends svt_sequencer#(svt_chi_ic_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_ic_snoop_transaction observed);

`protected
Y:YSQf4:=W?4E.&5MfV&aS25K2VYe00W7X5#J(_dE;:J>SE5(&]\0)Gd\LER6O0\
JB?\@?#SLFe?XH:Z_R9bFATRM_(,9<X@+bC1O>N2OTEW8WZ2N>dD=4<=TJ8B1&UM
2Sa8\^ZAL7<J20O-,T1AJRW\UJB#_H8[e,Y02?^e.@\M&([+)9J/B#0fM0W/D<<Y
^8b:1/OfP^Mb+OJWHTcf.5W,YK/+&9@L/R=WU,02W7#I:PWf\]Wgg;/-,8Me(a<7
^;>:]#^[cOA-8E/+O9ASgHF\X^]C&9]2&2&JB9((GSRIB$
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
  `svt_xvm_component_utils_begin(svt_chi_ic_sn_snoop_transaction_sequencer)
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

endclass: svt_chi_ic_sn_snoop_transaction_sequencer

`protected
+2O9f4\7G0E^f31UI0D,+dXK,)deab<D,^a#[FHgJ:0cQ?WWT_-[3);dRfB?5&>/
)7/SI9#E;#F7fBTHa8cS9e=I?,d]bfABYD@FF=J^bZ0fT(DQY#UY#59[1\31eMF_
60a559ce#B,U&R8f;CLO@cbWg3JLMP\;X/W?D?b89&RVcS=52?<6BA6fcEONTU)b
6^P&PN^AI\CR&CE/+ER0=e022P:BY@W3^]UD?L)5J()1^c:EY-feCcEX&2<T6fD.
=(DJcKMNX5LSdCOMge1>SO0)dJV;7\FKC;=-018I/WXVe[O0(_=\0aV<RFAS#,b4
8[M9W^1C5&:ZEcRYcK<&O-]7YHX#F;9EfUS0_Vbc,Y+RCPCbT+:9W?V_gEE0K;M1
[K3ac?Y@1X_cZEY6ZFY;I8&7/Dcf>NfH0KAH=QHOMYRDc\9WUc,YgLMIKB,5L2TG
&OFOKAB;>_SD-b4EQ]Df@TW]d)0+=NfQF@7?:C.F#W<\X:bf))A\8BeGX,<CS:A.
>8M/11&,_I+HJZIVR;0QEEF(UCBFNR+FQ7S:@c<>gBg#7eLE:_HV];&E/21;509d
I-c>WB-e/Y(=#/Z]0,/1PN.0=TeO1&TDD;?L5)CMW_,aET^Q;\UTU&bYXG=XP_7E
OXcI@7Z@db\U/X\e7+d:OESb-#]]:W9gV6FH:S8PULU_cg\BIc=M&8#-^8.EVAW(
IGI=8_7WN;I\Y_WM&=QI;6c4O8XIOLPLTgJ:;^K-fBBHXCWe<R//>Qfc5N7TcDYY
R,;4^R5N4M/V;EX[B@b47S2fSF7/8Q92O2MeY[[.T?ND=TCA58Za97+c-#FCYaf]
NT<U7+U,[XJJI0=\CN>^c[TbM1],-efLD-IR#YH?5U3Kd:W6gKWe.)()FS<KLPRY
(/b[.LF,A,6B_#FON=6/;I7BP4?X&YG.bLg\]G?SI76CJQJH_]eAS>cYI:^-cD=H
Z19J/d@0bPLS7M&B5JOJa^M^cLYKeI(=FACEUa7D&>cT740BF.dP7g#QGGgHKGTO
TPY0VQf#F)9PPE(KY_cBKF\/PJfC6[Y1LORW@<2TW]1UU6)HFNcI-3#P=EI#cX85
HV4&(S\A8:W^RKYRY.S_Va-B,&/(,1^@0BDdFVOK;XN_c&@FU9LT^]PfY[e2+,NB
ZHZ.eNR3LJ+.QWfO7H)(VAKb.;L1-Ige.=5;Ac7M6=IgRD-AU<DTeLg)Z8B&B_&Y
H=PFDbYHf87eYMb#,^5Mc-fA+-+]>caNdYdRTL\&?#FQ?c:F<88cVIPT7c762PA<
)3aYQ/3<;8fB(;\5cT>7F-AIOLcBX#=Ta^=VUF?DIEZH[JAdH038=]V(J=73fBJ]
I)T[@8\AH5R@(Z-_;08Z609g/HS44R?4P5=\?1UeLO4(bbZE=:S:K.BUbZIU,QfB
5\QD^5&SSH1,TfTJb4La#PKG@MO24E;SAD_BB4>=>HbQaL/G\cG5]\E74^<QSROg
(f7)C>[_]2_e[1bI)(TISgSMSeRY.cI5MH@T;G+R)+FYJCIV/bM?3:Sb;\f21WgX
7E?8K68C=KO>2b6C6SB.>9MS3H(c3+E,ACNP^CbX7IG.V5?VNa;f=>G\b/@@R2@f
VB+DXC,JDXR)&];7Y(LIgAN_3<ZBC:3W3MG89,3de=FS4W_]HJK;=8P1[c,OP4.3
RM#JOd4[B&(V+?dVYKV)GLHO?2ecDP_TCCGXC@#5?\^NHBJ&Lb,C]U6-+KF,WIR1
1?8bbAGbK40gI]&T^[ad)]9a\V&P;<C0/;Z_&2KX?ZXGfecOSId25S3Y&/)JDgWD
c]DdM.3BA;7Y6YE?PGg-Yf:/C-/#B_F.A&aH]XZJbELFW&3CSe69)fF68_2eBJe:
D^6#:X\43QH,^8\7LY78L(R#c5+d9Ld:>--1.=GK#+dJc3E4>D+GZ8#57W:/U,&A
A/ZFcb-bdVE?&_XPK@=D397OOGGASCa)B/g,[a1/>29M^eRA.FU:3>D@X_=cG):+
RYO4?_\9Z)R4;P_2A&<d9+cTBT#UBC#^U+2D\H[G#26C9b7eKLLJb-a28^N/K/X-
WO3&NY#_YE>:cU2dX9VE8PSf5,@]:V5QaMaUOcSe)T>b41\T/MAM7T?0(Ec.76b2
1GRSV.#,9bbKe8d41J\f5BDbZ2+.J8=K9&/9e4?XUX/ANKR<-PO8DOU<@N@2\<EE
E@W?b(XaUZ#NL+?1b<^\c+/,G;_bAg#WPE:f^eP&7I5+L_@16E78P?1)QL(b]IC7
UWSAO.#TJ@OV52^_<E-#A]5K=X<;Ma3bOX>.KBV(M08VfHWaf&MQ+E.JM1cOfT\6
]d\CO3RC&M+K3R6CO/2P9bFH]>I4N.AWCcH&O[Z4NK<E[.&Z62^X6IM=b0aWJ+C9
?2L(_+G6O/.3BaI?>RSK<gOc#@Xe>PgZ?FXA627eAe:S0P?GF(Y]LTI2)FU3)\9R
?4FKg59/=2&WNKK+>0G+U)R4GXWW3]T-AA:/>1^84TbW(ESL&-(O[Q&dfA1.,[NF
EPU6&+8RgSgbG0bCZGB5fOaSJ^(_A^B5AcFA3.=;/C/Z4KYH(.YU[^&dI$
`endprotected


`endif // GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV
