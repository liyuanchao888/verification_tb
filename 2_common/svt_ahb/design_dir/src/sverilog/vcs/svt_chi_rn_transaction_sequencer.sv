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

`ifndef GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_rn_transaction_sequencer;
typedef class svt_chi_rn_transaction_base_sequence;

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_chi_rn_transaction_sequencer_callback;
typedef uvm_callbacks#(svt_chi_rn_transaction_sequencer,svt_chi_rn_transaction_sequencer_callback) svt_chi_rn_transaction_sequencer_callback_pool;
`endif

// =============================================================================
/**
 * Sequencer providing svt_chi_rn_transaction stimulus.
 */
class svt_chi_rn_transaction_sequencer extends svt_sequencer#(svt_chi_rn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_chi_rn_transaction vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;
  uvm_nonblocking_get_port#(svt_chi_rn_transaction) auto_read_get_port;
`ifndef SVT_EXCLUDE_VCAP
  uvm_seq_item_pull_port #(svt_chi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`else
  uvm_nonblocking_get_port#(svt_chi_rn_transaction) auto_read_get_port;
`ifndef SVT_EXCLUDE_VCAP
  ovm_seq_item_pull_port #(svt_chi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_rn_transaction_sequencer)
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

endclass: svt_chi_rn_transaction_sequencer

`protected
Z,Z@7fG,9a=a@R[9Ic2&caL9#b<_g8_L>b^AHS#YM-9,[>+M-f6M/)1)Cc,25eeV
)\SB.geYN3BgDfPU_5(.3HZ4<XA6=&8>AC#,#Fb9(G2.dfS&4b,H[W\ZZ\RV#]Xe
@T^>X4,ag2<B&c(]+d<aFOY:S,[AaaPBHW:e2S6AN>\Sc0+)C7O]0I:)9<X(g&U.
^F#@g&@a@&-+a8]?=&S5R9(=8^QPRCHb:7c(BOJ69)-([ZMgZ0faXXX:K<dL3M-C
aPS7f(QdTI?O>71gOEf52;\LH0PO5ca(B^Z^&Kd5X136^=f34BeaaZ[GUa?]W]cY
E)W0#Yc##?/L5BE#b@1L8\JI?85gR8@6gCG[H<bEaPRFed.d:dTE(8&UZ3M>0-TW
6L1;G^(?[>2PZG,bQ[MG@MfSSN5B[>YW/,QY/dQH=_(dPIGROG@^Qdc?[)PL7cg^
U1?3#?+M=,IOIF)ZSK<>=BYXFKMPL,W7J#[WE.?K2;P.4HK:]/<P;3a@gYKOT/^.
Dd=U@>#L7O-_UF-b/FfaHKYKU5R([KFKSc96]dD.fg4a8V^Q:TX8e[IE&/2O9[J:
BH;)dD(>Q+#U5;[3?cV;/JH/ASG@f9U6beLgJf8bI#g8GD(ddDU54WV.A(8U>L]_
EQ-W:2<N3:[\#7gWHF;N2V@@YR(>C6TLZ2A@O/S^\#FR1Cb_QGdNXS/NF5GTG)-f
.DM3I?b;8A6]c(,1^FA5?2e,8WY6a:c^e6/40:@1DGMb[8VGEBg(^XFUDK^?_SHAQ$
`endprotected


//vcs_vip_protect
`protected
X_J7?H/X)15Wf)TNfYY+OH]C,NOd4\:-F\40&f2-4TK.5c6KDS#B7(+XIc]J5f=>
CXW2S[[J]P?a5F4]U;[=?XOMf8[22BSR7dSPK[6H+-\Z(H=0H,]6D#4\-Y-N?&#Q
X8?ZKX,S.KG;EAEd6_=:NOPIJbKY_-.KD8([W<&8XI#Fe32]B<GF+eM):O3AZcdM
Ea\N2>d+[0H[UKNC<A::(II<PY:RcE5J9?0<ORag_<V\F,^fUV/]IdXV8,D0QVO:
2+ZK?_07ab>L6RJZ9#I(&J,aeWADO=WR#d<Y9C7>(J=&^L)<A-MX;R?>bE7a8cgZ
A&eB(^1MZcVJCg(5<^KTIAV44VOBG<7@5_?/e>CUe]T[RZ/0@46I0L_VDF\3[aYU
];:.:>fY>^c:c&(9;54aZ]MO0c-)b_6;E5+>aWI>4EP)D<E6;CTS;Da^+:],F4[J
^YK10ceK^g@O+>::&O\JM\/:KGIaJ2]^HH86UL2fU]?E/>eR[PBVR+.;J8b0>Z5W
6e+-8aHJ/IK2X@YBXgFK6X#,Q)S:E,&gR-J3H.MTN]]Y>5E5A@Y6cZF#Sg1K.U8F
_/VL=b>Y&4F=0N/#KA6_\?/YXg+FSYOaEH#X8(SCbU3(WY9eHF?Q#686WbS1>QRF
LS6:FABXeZeYZKdDRNJ)JEeV.gU9d,FbcTKg)1\bM4T5Gc5(#E121eQ9dH4d&BP<
4_W9YGKD7b,aL_e#6C<&HJaOP,;.GEgZ[WaN81WT]3CEb)]I5)#3[DR<\#?=M>#L
[Q.6S_V,9UJaP<CL8G\fR2UWHEUA_VH37#Z:9)7[03LDL8+G0&U[>[U4f/J]^8X)
f9+d-YZG_-&HS:PCJ)Ld4We?8WIAO0CGV&T9M6P^bZF:fT2-8e]a2Le5^DebK1=>
b<)dN]L2D@?\[^G4P.P\If[Z(.8#>-b]?4XR1bY3^M?=J_e8&2618MeV1VFAI^5e
_H)80_e4D25>9EL8S[]AJGF#H#U@K/8[782\^g)G)(UV]ZDa2]54<H#W813]9_a&
O&#-M@^^4#H^74;XZ3F94OD.D_[WfYIFJ+>67/]<ZK2Z]PM767GcX<b5Y97SLJ^D
9/da2.ZE)M:<4Zg8/_XOIWU09\,8MX)F;/(L>f.W:8YHOQL=e)49_<[6YGCO=-_f
dLcAHH;Tcga5.]@ab2D9GZT5_\7&?7^<gbD<#6L9F+V-MS+ZBD9E&B\g=Q2>NO(E
&.f(:f#e^?.C1b[EVCIJNd+eH&L@\ERDKC\6BC^D7Je/bY4N>?)]KGU.@QX<26Q?
@S]c+WKO7:B@E?DDZF9=cE<HZ27SV2bO-01;J+bLZ9Qc5?A?V#@G[)EAaY?AJ.=\
)XaXX:NDPU(DZ_IUfAM[:Ea>64=A@2MBfX+RR-G75d8<3G]++.7P#UXUgECGdE@9
2,N:+5201+7]DD37NE?#^SFK.7NSEJ8E>bYeD8WPSKFLVGWOP^eP,N467_P29&IL
adQX0#-SaUU?&@f=)#4]a:YAD<W56[4THB_EKWI[7L5T[?SU9^_8A^&_-cTH<4^8
D98ZEdbG+f0PH\b(dQ/_L]U\f_KM]Jc+RRK<^U<=2:PSB69_]=4//D/:.CPM=6#0
[<@FMI69&(ZS0MI\WI:d:PHY.S3IC-7;<<RaYJR\L#=W^eQQ&,afGE.FII]Ufa6c
7KB]Mc=1A;&CN_AQ6X-U><_H[GS@[dgd-6/2Rb\?8.Q\#LUQ6?bCUcTA#\eeQIXH
/-#E:ZegJQ-+)#Y3;+D,7G76bY_??IP4,X_F4@.BY<I?W_f=FfMO2(NL:^]@N_&L
cK@dD^[dUaZ@K(O);FAY9WJ<4TZQ#R7c85FFb]05)QY8(6(XK<D/4[)Z1OT\SdGE
/cCG<BZLfCedTd](?@gH<Q(-?HcFAT,.Y<)DZ7_LK[8Y;Y[.DU)T2FU,#LGaHXNP
I5X\D.KZ[(\1N]I^12C[4_WA=[f(&I7#^DI<+[<7#L2+0H(HA<cg(1M)^QL0>#DW
1S(7JL//QOJ5MI<JIY^6g_e2J+.0BJ9R_HVQ?/KT3VHg[]HCLY20N#R4L.RS]IOD
39<(TG8W1\N]=B?NLf?R]&Q@L4bF/?SL\:QPb+,B.NLcf\[acS0Ee_SO1A4LB4&+
XJ[LaS;(9gLIR>0)Z3A2\2_@5^FdU<6TbKV<2Q4\C]#;M6X4HGDEK@:8C@c1#)37
R7-];20?@R@ID2-eH91;8T0VP)KHL7-)J:;CL/g::W7:WC0?QS-=9EV&:=N=>2bR
AK?<X7\RMg(R#,^,/BW3+:H85X,;+B+,?(&H/a:QBYFD1HdX)]aY.(:E>@QU)8Q.
1.+Z<?L+Q[c2:EAaZcJa.YcSc0)2G9.WY3Zaf.fP2:K+M5d>JZeYd[F2IQ9(_:fJ
OO99\5cG#XUf(E>C2Ge((8]3a0a8NJXXgPf7ZO0[&O61YNA2?2:;5F<V8Yd9()/;
\f<D.QNMfR.WH>4/Xf)^fR_N]=FV1(.)>&Ve241S0#DJ/<fM(B=1+52eV:8F63Mg
EJPPQB439NeVS(;R8aS_,bYW>:B8gINYTE,8[Ce3DTV3]^GL8,dgcNR&Na9#TY;1
5[=;;b):\6NNc;?80W@KFM?XJ=)9(S9+5OFRa#Q0_g[0KDRXH;#2B2g&0&4Cg>A)
(deQM2V0\&J3OSYIf/K+]H1d:La@E8a0(W02/V;ZJHYLO5e8Scg9AUGeX<fb@g..
T(V[^2EfXd<30$
`endprotected


`endif // GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV

