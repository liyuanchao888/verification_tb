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

`ifndef GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_rn_agent.
 */
class svt_chi_rn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply RN Protocol Transactions to the protocol driver. */
  svt_chi_rn_transaction_sequencer rn_xact_seqr;

  /** Sequencer which can supply RN Snopp Transaction Responses to the protocol driver. */
  svt_chi_rn_snoop_transaction_sequencer rn_snp_xact_seqr;

  /** Sequencer which can supply Protocol Service requests to the protocol driver. */
  svt_chi_protocol_service_sequencer prot_svc_seqr;

  /** Sequencer which can supply TX Request Flit to the driver. */
  svt_chi_flit_sequencer tx_req_flit_seqr;

  /** Sequencer which can supply TX Response Flit to the driver. */
  svt_chi_flit_sequencer tx_rsp_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which can supply Link Service requests to the link driver. */
  svt_chi_link_service_sequencer link_svc_seqr;

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

  `svt_xvm_component_utils_begin(svt_chi_rn_virtual_sequencer)
    `svt_xvm_field_object(rn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(rn_snp_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(prot_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_req_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_rsp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(link_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
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
   extern function new(string name = "svt_chi_rn_virtual_sequencer", `SVT_XVM(component) parent = null);

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
//  extern virtual function svt_chi_rn_status get_shared_status(`SVT_XVM(sequence_item) seq);

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
)L_A^HCD)MM2\]PL>W553CGY7<]A5OOaJ_Q#^#;((d&,X&-UR=B,,)8A;4fMfA?,
BR<^7UFD67?JUF6UQOZLBB#O3_5#YEGde&UQ7F,8=&dA3&X_03R7C;HDB]L>ddNb
[YVca<fP2?43[KZ6DN&-]25E^K^#)A-N/_8=#9TBE;eb?/=GMITfNZ\24e&W&X<Q
9JB-WIETFaDM&QAG;=F<1f+9#O)PaWDBZe(@MGA6/@b(J>O9^db1^4UHELC_=V?8
,(XRbSXEQ]^@O@aCbMf?HNIF^=<E4A-_Q?]Qd-?/KPK^12aL-_DVf:f.T:YN,#3#
:FT_g/;69#d>fJ.<NG)EF62Q0Vb76E[@?$
`endprotected


//vcs_vip_protect
`protected
0gQ5]21^VE61?<)D<<d4ARE0T;dJ[+MXDDXW>)1.<,JM5NW7@PAX((N3N&b/.6KK
Of)6_TP2agZSRCJ3^]8O@Y27[bP1HKIJS-Z6DEW>2L52/PFPPEf/;B=VS8E&SDXA
7>^IS\C3:;D>cTAKc50X4=5PN52\9CIIXV7KD0HI5/B\UCPda.H60a6O,F2UH@cV
D(4F>dVCVbL[&fQCa4-5_M>3NJS3Cb;?_,aD.RGU-2J7SdCH)\?SC0d6VW;8P3OF
/E_X-C^<dE@U89F\T_Z?02+18aX6T(Q6/QP<5<YgBBH.c=D)#W9&OXD9<1=IB^Y3
g,&d=Sc3[M6QY1:J@Z?(FZJ?D6.1PT#X\Q,6;T^aZ(TRdCA#b-fV6/fREBKQbe07
:MSUOM#X&B9./QQ0-PH/2#^XBg.6GT:@_0(;-DOaY+(?BH^ECJ@1AX^>956=@ZS4
Q>F8AG=1+#0KNNOEBd.[@-?c/SF?#A#7ZIa;;XHFg7Y944ZF:&2869))?/+F2+QT
^NA88KE;=d8CUB9FFOg:CU0e\7G<J3gF+NdO,9ObNd3KJ;0D<7CN]KW0U2>\<a5E
GBH[WR<A&5.,f&.;CeR@O6^-:WI-f38R\ABI/,EQgPK]KZI=@@b&<<:4QTH(Xbbg
]U@JQL>CE>7KN=ZHA+G\#<c(3?I4;fY9[6g/05@X>PA/EeA)0=4A-JM(8K\POg(M
<aPVd8K@40DE9:)/04?R<FLPa;B)_7Za)Q]TK6/eH_91I0,Rf8;-f#)QPK,2bELT
\F2U9FCb_3@UHF\O=<OZ0=SNUC,+DZ,[?7WJ[9:d?X#8]Vb_+20CgeS9Y2\Rg_E\
-^Lc_TYN=1D=+[W>BANcK</_0B]B5E72#=\S-@(.aG\aE6=>?,<MTF@]1@(+S_d4
RUO:,G]dX9,1)NHd)==ELVB(#A\Q<3DLY1M76E=>+L>>W@>39eXQCKFf1H3<U/E9
8=<&<8S81eU5_R=;1JZ0<WY,K@@8W\<:e[cgHR?0>O7^I50G_Z48_V/?g&-7]5(J
gJa4;eS=CVJ:7\&0BZ</Q(>N]aQGQ]@6;1=2<?Fg,#TX-:F,SV>8L7Zf1T;LSCXI
6AK1#D7ST3+7R:=>f]Uc)(B#T)]?\ZU_=[2:JA?GXOO,B&Xbb(aP9LT_(SQX)5d5
M\\:ef)gRCIV7f>@?.7eC@OALZ3E@08VAcM7fP?^VK),/4WacR-)Hf5N2]/Kc9OL
JCI.9/cS[Y)(5(KH9.a6^:@acR?=,6QUXT1/ATKaaK?LbL=#RV4a.H.>K6>)&&XM
=><T[a@P6(2GFec)>EICNB36TKV1aNA8&X0:4Sg&Tb#\GJI7#)9e@4XRQ5K=f1-]
VB3]eICf;dPL+1215P,8J>^EX;V?Mb?A,5M#-O,&8Ka<A)(=0T#F^OP9>LefZEa>
G:^>QX6:=G2=Ga<a8T\]Nf/MLOb8M=@.B2#I_KU+MGQL;S]dV<dceJ00=JaCU5KJ
7?&0.cUL;G8>[.1ES7J<I)L#JUT\cUCU,MM1OIR#==e:<0B]#9fd_>DWSNUII3+b
B2c3-X76YfdW-,gVB8Gf#\g)-M@8NdV@+LN?X4f5#8&0LYOO4M7gaQ)VJP3HedD5
QIDfIc[g7@aOC>Yf)aIZ-T_+:G:K&Hg_efD0\ZddNBX&>@<Q/Q[584<[^MIB#=JG
_L4,+WSG9@?7/(R.RcD@O@WYG<RVBF)/@f^?+98O;4f_6C17=bQ3-O7PT-_:1gdV
E37;\1POW_CEcK8QFDNC+VS3&YbKP7#:,OGL(eF71<)C7^\a#+H8Dde+O)X2aA_X
KL.+X]N\U2X3gb_@6>d^B=W>@LJMf;E;]9b]9SAK<^X<NU-7=7DYDLfOPd,O&.2(
d-,]^7:)GFBPA^]_dV9C(]B#XO;1P^/(I:\L407WfMSJ-9,c-,BC,2?Ndf\74BMK
]Y?M6L(B,6W<PL&L4)D.X:XfU?,9ZLR1V^UFA3,8PR[.576Y/#CNZ3N6WK>8X,ZT
+JdN]5UDUUgg.;YKgP55a?BH5fMVX@+].D]d<c7,dM=SJ;L7+GD[>HN5^Eg=0RJG
T3-U5QL]P#HSOY^_4Q44I-&aA8O.VR[L]W\O?H55,cgfR1ef5=BSLLY:daG=L[&[
f?A\XB^Bd]_dK7VE:f9R@(HR8R=?PM)U^E(fb)UbHE1Y)0gc[Af4L6PTGN(&2GbR
D?=82)aCJUDP/2fH-[C0Eb3.9-=//9e,R>U;4^9(-C7cI_:D5fNXcQYTX=CI5cJJ
+U;78]OgK<Qf00(Z8#.3&gSL1Hd=g3OC=J>--96.bL+^7\@[gE,([\I=H\+?64LV
X0KTf<(BWQ62UKQdAS.T1D[XbaAFWaYFg+WXDF5?YJ.@?\Na0Eg@K?:,_I26#U3X
_a(<,#8X14S,F:MBA6]Se2;\9GF-e5A]KSWW);,(U;-67.aHUAYcK::Pb2c?GB[M
O9023]],&(5&O5<,VM88CaNg)FDgU_?ZM:,TP23V\6_(EOIgV?Za4-@<&)d2\XaA
IY3B?<IW:P+c2e=Q;_]+<e705T?CF7J0-ZL[^#=1/8MVN6UfHd0aH>-Q568WbW]b
S(YdB5Rg-UCVVN7WQ.FA99R=Y5:RA@V5.->CQEL0CSfL:JD?@dB7U2:6FBQEH-?:
-BdI].&a&fg8)((ELg)K+J]0.?MR0=9>3[1Qb[2YNa(8GAZ2[F5HXH-4@WUKTA9?
86]>Yc]DB52L8&YGM;Wb@U1UBN09@FYC9EN-g6ZH-].,J7YU9H>baA:EV3.X<>FT
UE)c/BIA>GJ/8V3B>E1b.V9FJO;)_/&4cG)UGLeM,#(C#Y:];4:Q5W6A>WLK^40f
?Y-6R<1Z=REM+<6CV2;7N,D5L6VfRb(&TZ,<S>](X7KgA9B-@=2C@b/=3d>VC&g5
T-S/,PRNGIBZXcYaPA>X:JK2<d5gAcR>a[:^BFI#(EB7ZbXT]+@a<4JXBSZC26=c
PJ)Vd7KR([/&<d/N^5HFBA[AO@e)H]-K3>SAbbP)L>bZ_c,F4HBN#C\;?fTG2aNd
QEB+=39(cH2BaV&XRFU+@D>4?96(Ed49<1Y(UAZ9:):2^^gZ63U2L+=@9ScV0.Xa
ZY?TD#J28c5^8E0R]C:6U+1H:bg8GA(bECUG50Sf0UPTI/<S_A-17,@H:;g7=MZC
,[#BVOMG;EcWbL-<S\4<eN1H7$
`endprotected


`endif // GUARD_SVT_CHI_RN_VIRTUAL_SEQUENCER_SV
