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

`ifndef GUARD_SVT_AXI_SNP_XACT_TO_CHI_SNP_XACT_SEQUENCE_SV
`define GUARD_SVT_AXI_SNP_XACT_TO_CHI_SNP_XACT_SEQUENCE_SV

/** @cond PRIVATE */
// =============================================================================
/**
 * This sequence creates a reporter reference
 */
class svt_axi_snp_xact_to_chi_snp_xact_sequence extends svt_sequence#(svt_axi_snoop_transaction);

  /*  Response request from the AXI Master Snoop sequencer */
  svt_axi_snoop_transaction req_resp;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_axi_snp_xact_to_chi_snp_xact_sequence)

  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_axi_master_snoop_sequencer)

  /** Handle for CHI RN transaction Snoop sequencer */
  svt_chi_rn_snoop_transaction_sequencer rn_xact_seqr;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** AXI Port Configuration obtained from the AXI Master Snoop sequencer. */
  svt_axi_port_configuration axi_mst_cfg;
  
  /** CHI Node configuration obtained from the CHI RN Snoop sequencer. */
  svt_chi_node_configuration chi_node_cfg;


  /** @endcond */

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /** 
   * Constructs a new svt_axi_snp_xact_to_chi_snp_xact_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_axi_snp_xact_to_chi_snp_xact_sequence");

  
  /** Maps AXI Master Snoop transaction to the corresponding CHI RN Snoop transaction.
   * The mapped CHI RN Snoop transaction is given to the CHI System monitor.
   * Once the AXI  Snoop transaction completes the AXI  snoop response is mapped to
   * corresponding CHI snoop respons. The CHI snoop transaction is marked as completed when both parts of a multipart AXI DVM snoops have completed.
   */
  extern task map_axi_snoop_xact_to_chi_snoop_xact(svt_chi_rn_snoop_transaction chi_snp_xact,svt_axi_snoop_transaction axi_snp_xact,svt_axi_transaction axi_xact, bit is_sys_mon_usage, output svt_chi_rn_snoop_transaction mapped_chi_snoop_xacts[$]);
  
  /** Used to map AXI DVM snoop Payload  to CHI DVM snoop Payload 1 This function maps the first part of the transaction*/
  extern virtual task   map_axi_dvm_payload_to_chi_dvm_payload_op1(svt_axi_snoop_transaction axi_snp_xact, svt_chi_rn_snoop_transaction chi_snp_xact);

  /** Used to map AXI DVM snoop Payload  to CHI DVM snoop Payload 2 This function maps the second part of the transaction*/
  extern virtual task  map_axi_dvm_payload_to_chi_dvm_payload_op2(svt_axi_snoop_transaction axi_snp_xact, svt_chi_rn_snoop_transaction chi_snp_xact);
  
  /** Used to map DVM operation type */
  extern virtual function void dvmop_operation_type(svt_chi_rn_snoop_transaction chi_snp_xact,svt_axi_snoop_transaction axi_snp_xact);

  /** Used for mapping AXI Snoop response to CHI snoop response */
  extern virtual function void map_axi_resp_to_chi_resp(svt_chi_rn_snoop_transaction chi_snp_xact,svt_axi_snoop_transaction axi_snp_xact);


endclass: svt_axi_snp_xact_to_chi_snp_xact_sequence
/** @endcond */
`protected
[^#QF_=Ga<+aHNc=2+?Y^68JN_<gf&aVMB#b;S;)c;HdFGCQ)E;[6)NI^TQ#&E#/
QcG\H#.[8d^Cb?H7UX,^cUNYPDD_=?93[JM1CTSc>&:cUdZ[APG6eWa8Z\7>J:bV
9V2R\63d>)G-/f#ScN8W8OYVR0#CBIU-[A;&_[a<Hb+1YI_&=7<a@4NfbUKJ#N]X
=^FBSV;?g<58[&Wa\:YQT\J/80IT[@4O\\K3PGcU-)+O7/<NR24JQD1Cb0B6U44L
A<LVJTQ\0C=WK1N3[>FbX\S?NZ+MBX6H,<X<J<;#C9U.H-AIfd@Tc41?(g-CX(7#
(UacVIP<Zb1Y_,d7]N#,^K21LX2NKYP6^C;@Bb[@E@@FAZ1T7?[:06(JS.gX62XP
1e@^:;,U4M.X(-S7b4b-_81T^O5Kef][_K(-74N,ZU.MXW@OGUY=#Z_26^39:H4Z
ZVK]:B>VQ:H+PZ#+ST)Y:Q7O+&BI@H6P)MRIb;09IW3d35;++,bRP/\7.GUYJ.V>
-<d)A1Z@<Rf_e1:2R?DL;:N2]T1DXI/Y9)RS/f5F^0eS^eW3?a/gB3D+eeL1#.G7
J4W,43G0g-V-WOAX4H<5+6&(2\Ye(O5;a7A+I]e^1-2<OXcM40P&5VYWII.7>S8G
e;]dRMe<17KNT7d.30\4/.NC;-fa9b@+?IVFO,1aW:<XQY#0Y6S6V<c1KN5,55[(
K3WX0@b=@476JJdAG4ECY4(=4E9;C:VATe[+4>O]R@OM]YTX)a]Zed<_O7W<@F0C
]MdVQMXCIZ((D<gOES5D-DKRKF\/ZYH:.8>SPT2S8B7[(D\V)(aI]HRA1[Z;JG,G
GV^\O(XF+#TXE]+EJQZEE)U+3TPcgID=/JZ.[+:D&W.YSR3=G2[5\LfPd/OHaJP#
c6d2cQCZQ?a:QM:48SX6BC63#g-b^=/<B6NQ<b&SRCT21V,a:669LVTS.OK6W2)Q
.QKWU-]c3J&M/<-9933PD]1GRHZQ=HX3L>7+(W^7W7G_N<WE)5Z^Y_&G+1ec_^VQ
K7;UA>KL5VSg+c(d+Z?X6.CMRN4-UO0RZCQ+JXU8NSR#EdIW]PM=3=Sd4eK(X)[N
HS/d;b]/@RVdL><d@-DOOTJZ_4TTfO.J9IV<0?98.XGK,GHc,AG#:9f9ca=4Xe-L
/Xa-89bYC?2Af(UB/@KN(f?QMSVfL(0DGJF6+JQ8#]NC@L#.QXYeYEZ976;Zc9LZ
P>AD:2\[U[J=M.dbZ0?]ND#H<[.BVf1RTMH#-6M_@1<K=Kd>8d+^Had;cB;F.d_A
M:<gc3V+WKLD,7TGX:=(c]EI+&A?bePJD(Z;a_c5[N7.5I?c58>QWB#eZcd514Ib
.Y;&JGZQVX,aUB:]810ObfZ3UNJI(&Q3-V(7BZOcP.]bQXK3cF<#QM;,>Ye6C\GV
I6d[.T/^51bD:g8PTG3_Ccg<8TWPAV_g47AB8RdH>L/D^YQP#:?HJ]O\Hbf,cA7K
#0^IM53f9Q=&gUC[aF&d(9^5HC.^XEE014&J3I=e6H2-4BIGb[b_\2;]Y_,/@;W2
-<:f^#@-;EWZaeHK+ff[MJ\<P,dV3;DfdXTQ;PYT)fHI.D;&[Gf7(\1G<K[3MDYY
P=K6?#G4DAKI)1:>.0@cN=T5D+<H>MC:_?F7Y\0#?B_XY02&<33Q>[PH.HQ.F]DJ
L1-]H&A[@+:G5>>CIYR?1U#=ba5Y.E_?eDb\eZPgX64G>YVR.&OaN(+B>B,>FB^e
ZK[YZU9gg7:Zb&/4>.QH]F1UC12[WL8cb?>FT]?P3:7,]a;012_.39N/^Y]-a6=7
JQGAT63f4NN1[+2fL^5>65bY::CMGVH1.Q,Q/E\f;d9ADg#0H/4FgCbNG.6(RS_@
g,V2V7E3c+MG+T[N_Jf_Y+,,Me41,JGQEC0HZ+-O<_SBNG4M\)Z=RYMVU8V2.]f4
41AR_3bBABBfW^_F2ZSGS#=QEP-b)\3a+U;#2_(:d;J0e0\ggIE(BB^8Y[ZU2)W)
),_Z3a92ZHJb>I9dBDT8BeR>bL27<M+>J2GfEb-Rb@.1&@55F<^)V@5b\gQ=?<Ya
6]ISIP9JA3F3V03\5d\Z+WK0Y3]O[S[.><dK+04_SH[B,II,P7&&KV4Mg/Z-T6VE
3M879#5a\GBJ;,Q+]H[bX-&=/>>I>MLK8b>E[(-P#SK^A>HN9:R6V\>c98#I;OV4
HI>N,&KKNfYd:9O:8HC90IAEXA8(#<PdM]B@#B=X0Qb-TB&gMTfJ;==S5.8DZP?;
VR-._H/?)8D9H)]<d99g#Ebc166;?BDF#DaY[]=\3UT)MVE@eW+-N0:b52(H14V;
1OS92CYR^-bUO8XYXfS=J:T[8;6M:59d4Q->e=0E+G:H3Q0=Q(NbaV67?G9P=R6,
N?-HH]3aQC_(5Y#90J#R9+EJ.1/M(RGLSH)YK:eXVMU\DII3?:Z[[&>X1K/9\&+Z
HC<\e^T]F)@((QMBBIYOZd5\SACeH/V6<,cS+EUV]fC-(>CF8E4/b42X&6QM^Z2D
WFJZ@E]HB6^@BI4Q<eGO55Ke9+dRNW^8(.//6.^e=2DR8,aILb\F6_:9FgBHG<>b
,[2UWbG)cKb^d@>6g0&M/_N]=7BG253H>\ZJ>13d6+V/0cf\5Vd2,;HM;0ESQ8=g
S5S8HN?E1NSQ,P.<OdR+HY_OF/D?A9e]2-IQ+XU[?XQ-S)/A3^U7G[/2HAWM7SK.
,6cCK[VN\bd(X:;\INO_0_:\P)<>bD0YFcQ,DHW<0FBWBfE\EWR[&M10M\ZY&2KG
W(&gD6@R5:_b<C.@e)ZU]N_T\g<=]Oe5H4@XDHa^YR&(:)a-MF,c@FM)bNSPLG_3
TGW5[+JIaI(B/Le\C8&NNQcJM&T[?BZCKgYcUU=L+1Ybd@2Ld0J_S\\/J@TZOKQ]
;-<Ic5T?f^3/74P\bJVdC8R[_-+GUI9X&c\KT\:[L/d-,7Y:.M0WI_.0O:cfHD\]
d=,+:+6[_3]U=LWHXKQ8XTD&2E3H6MJ8+/aDN1_;Q/-:5>#K=ZTGZ12;-3?&3YJ-
M)=K:4?P-Vb=2FHbD&>FHa;c=c^F00.0(PP]S:>4)+M:[@WN0gBa?GZ80]6<:e5b
LH?3#_\F:)AZ9Y=e\F_e)F(\1?d&aKO5e142P)gHXK@MP0+B9?b_N-OQR5:;8BA]
.LfReFU4a]W1W9\\F#fM&)-@AV7_]WF\4\NMXF07b:f>]XW#7\T@ODdWYa&0.f/(
a6b=A&2-LI/G.[_\PM#J&MY7DC:FYE6d2F\LURWN[gX<\13:BZ4\\,>Q/c6B#5#A
G=A/:]G7W37YcL5<0\V_)CS)E1UKPEO+_a#.=0^&3P?baQ@VeB7I:G4@QI/#CeS.
FCWZ?^]?Mb&XQ;?(2d645XZ.-eg.GWMg41X(#+9HGMNY@IIRUT+](P?8WG38<Ef#
I:-G:NZCVUQPQ:Kf)7/3=gY.TeAVcbB1H6SAMXEReDZCQM[f_c4R^WYUdf=@&]aE
M<++g9GNW_feBH3c12L7Db\_-96APUDf[GM;:a^-8Q:3PBQCW-1<B4^DMgN+e>Q1
04O#P@Rg)4^9H?<0CMa[+UGP6^1[3[X]\Mf8RZ\0b-\>834a#<B<F1^=XX9\AU=:
G.@WGLPgD^)2#IM[1]A6d]a\FTcab#OVPb)9^097+DcDLZ(fdg@8?ac?A>6XZ,N=
62WHL]-GGa?44CV.&>1Bb>EU[dgaNf(F\^]PW3,GAcJdH^8G7P@FP6F]U[G14@(O
[ZSe#8Ce:A3F6eSf\UREGd;Fac<@2(Ye,0-9+]gW;:KMC7S95NJ<4D#1Z,\K;c&M
<H(bC/_S<UZ_b7KbV(E57/5<.cLEZ^P&YbV?UbVHK>8R)ZQP=ZTg4=YE8GGPE4+>
Y+KA8bJ9ZF.ETHc/Y4c2RfSNJ6R5e8:6\NTf&(H9^9d?607](3_0=]7Oa>SBdJY1
YB^eb&FgEIMC+L9Cde<.NNAG^8RS/CUcLVY36VGg;\NG7,cN9R&BE]F#0HVVeD3b
(=>Q?]Uf)VT-R(-+EBFQ1=bFF>_402=E<Q.U377OW;C3e+O/>\;8]O/W03Z_YRIV
);&5/H.<+_+N,)e0;5=?E_^)8L&-V?cW9Q>C8Ea@8BSXYHA)P3[P@EN6]Z(]d+_G
]dFFeSeB\Aa[54.^>_#?2I5-O;(23A]P/T[Hd1#0J+;?]^1,-VT/INB79IGX)JWQ
POL9U9.[=0=NHIP8O]Ega#=)-@ad3VA-I0Ff[U,M8FfeSU)QBf,GA[=,.3PJRQ]5
PRIe.PKUcV0O1N[/E?>&V\VPR;]Q21\.:XR,a5cC1(])_>Bf8HDDSYU;LFXOD0_8
@eT&1ICHG;B9;(&<#\IFRV,9+,f?;9\Y34](B?Hg1[M_J?/]<=d^&AC9W7,d=K<C
-SXG42:e,XBJWUU5-:]0XI3_:3dNZY15:0g?O+35_4+8#E74+#].J>:H?F<1#^2U
3>0ac+_QH+N?ML_8M27VA.S&#>XRZ#+1M2R(61d,>7^RWFB@O[VDE27-#ND,>C=-
:g=TG\.\ME-EUX#UZ+KId:LI:5:D\@0U)Kc;=>XJ7ba&S@]ZJE3ZXFUC)9D1,[1^
;G(>=4dV6bE5I(6PXI.YM]O4#+(7C5TTHd;EPY6G7K\99T@1EFBdHAVIIEcg0L1W
8IdS12DE<Q6=F^8f[>F4d#(T7Q.9TeA2]YQ@dDFTeYI;VWT5>Z]XVb.SU?KgEPg2
SMHY\9JR-/-]LJ7aMMBPK:3NBA3a=gCA_YU-+YMQP0QZU93<Xf4,5.O0IF)+B0HG
M+ef_61JBI5-\ZcEU8DdN2YF^Ee3KZ:<TX_M,QTFOBW2#];F0^AE@M321TUBPZ6F
c0W0&P8g,[8]FF(5+[1FB]YQQX5X#U@0dZ0DAO01L^.S)V)9aDM]?+)BMLCa->P&
g5eP3ODV4_H6K-(d=^Z,S;XK7./-,?g7OX?GO_Y#<gc/WDB46PVf[^Xgb7b)E]Ke
T_&f10K/1V.2bF-c],&Ma:C\L.eYW>df94\TJ0=@3AR3)Y<JP)R?L2II_K2WL67M
[M==N#/)LCH_Q_^-#SX=,-WFCZdCagV2>Cd+;PfD)B)QCSI4XP1Z_8L7YSeJ7cUe
)5KNIK;K:GSI-+)efEDRQOI51N634=[GCDLQWJBc93I5EfAg=.eDJfNVF.IWV.1[
JYU3C.5LgU(0<INfgJ&(c+XOK[Ga2[94&-NVVO6^GUS&3c&LZIT<F?CgA;R^)+,]
MbW=9)6X-VWe>6MD6VFB49(E/QAd7,D+6/L/T:]A\;e)_b;83IJ@e5P>:aFbb=P7
dbGS:.fBID+UcZ8G>;bLc?4>:LeK:3b.ZQ>.Z6FCcE.G=9;79[;_[#e<[VZ+QYYQ
\3ZM1.SR1B\.^Te>@6CfZ80B&-b>3ASE9LI\LN&Q;HQ+:<0+a=_DaC],bO7.;&44
V9bN0>WU9IcTQ8EZdJXb<OX]07Df]C7JT)b&/3QN/),V.@8K15\W[&#/4(V\,,?E
cDLH?5D++-VeQQN-#UN#V\C/YKA[L2X9F4d?(0EPDK<W))AUEP\#@\379[3-4^MI
V,+c&WD=)@1;L^:=Z6K0b)\P9@d\/_TI6aaNf/,MU5[0OYO-a/7D]G0ZYTVVS51Z
1R4TJ8C(?U+XG>=]&2KQ#692JSJ&46R>D0]G1=(VDDW#-[4F=K8I?0Fa(LAH;DDV
2MH3gT66d#P,&5O3L2/Eb6.Dg:JKM577a]FFE\FW-KO5<G(R+TeI@@)^S23>]>/d
>4UQ]?EcYU=H@dZJRIGYT,^[A-N0/ML6UZ4@[WB;=>^bc-S_fD,gBF.>1XUE:1LM
&7bKTa8FT>EP35VH=QL4W<?c+cR(_HP8P3\3-@7&1@H&,=:?-1gL@Vc3K;[K6cG0
,/S[:K:J=dDgg;gU6D,C[d6#N)\EE,837@5]J3F)8eU.4Q<\+e&,JE]c##]eJ;b(
dgJLRX\OcRb@6=f__Q4BTe307U)]&LS1@Ma/C96+7=Jc6UP>_N#F7;P544g_(L,6
#0&1g]@]YL,6gQ1:PeO.\b[b@I3.9B>g#4[d?Y9eDEf86Z8SFBQ\=P[?)gJc1^]M
GK7A+?Zce:2T4Hc7UK?0RTfMHBIb66be-#^YL4U7DM03ZBH(P)75bW.a-OGKGgQ/
Q71);2.]?:fgI>PP,0OOVTLUb;c6?cJa7JKA:GH553WYD8FGN@/g#(7N=XWZ4TLa
AE9KEDaN0K,ZGP&WI@_YW42HRG_L;0@^\@NR^^(aOaGUN-Xf5A6-VN8USXX0f8_[
DD\E/^@daMBZR3\K;__A(a06@P3\<.O4cb<>_KaT31fN[0E=XMXg4,RgLIeFT7>U
3=-aE6g9HQW[,9Qcf0<SG>H57YY>eZ4MAZG8\G;];J?D[JW4/[YcDRHO,[g_b50[
]Q&;2M(ESPVA8.&Ue7-EKJQUW0_;[NULAFDK;67N<O?+T_PdK4XdZ&_#Lc\9:T5-
)c([DOLW0DAe9WIb6IXab(S7dZ&>-R50bK:4c</?;O-XRc8W;8RA[MG=2>>IA?MZ
?-GP86[3bX4b[Y/Fc12HfFCM)eS:&4I8,#R9Z4YI\-R^.MNG?B:aZ7<V>.MCAWP:
dR5<HdbPSBSH#&=T4N6A]8=L(ae3-L8H:X;aM0C84BC;:H:e4c2HVOA(Jc^#XK]3
/OL#.OU<(V:TU\6A4+34TO]6ePB/HT][c9E<OG93ZG,OT)34SD(C\WLeCIN014fR
<UR4d;e[?FF,MQecDM#64V-?-Q<;Q+#<8R[D>V&a5MNDH0W@MU+A+=>B8]]Ee340
08cg4?X.72SS57-BD^<9MR)G[HN#21::VX)dc=bIaH=W=#:2<1OI/IR8cf(d^/@P
NAMBdUF&;O_OL^.+/GK^FeR&+CVCPEe](7?&>_59c7VLD0:H]b_FZ2/0f];&JRf7
181a/<#8@a-M5D.O\FBR5/.eU&2<>BG1OL-4,.G0b0aI-1W\\#O]/@>=5B.;N7D3
9c?cY/T#0_1O0Ue1HKc[R13=>+>bOY&)<B;a[1_J+3J^:+I)L6F4LRdb&=JK]9\^
FdeXUBg>@,=@JE22fc/K3-^@KRWSCWP[/9EfF4g:2fC32MVUG>eR^[+H<P[5/N85
Lc,U3--F,>2/6bWgLQb1\bKa(4Xd()e[DC&<)I1EPRYWe4V:@E]4QSLPNd9YJa?b
J;fDJ@OM0W87.?_QCBTg<@\SD-S\F?;H@_Vc1H2bGM;P+dSL5EOH(LdOCQ^J85VK
g+5)\CSJO0SA8>GHH.Qa9M_\@3X7+(H?ITIdS@NF-f0S[68\E;]16PfEaL1Xb>5S
Le4UL+AL\RXabV.IUL5YXV#2R#Da&1A(U9H@C7eaGd)\TM[fVB/6_DJI#W0/RgFB
@+.I:ASg\[]e)=E,U=FALN_)Ha^O@M0\4IQ\ZA6W?#]JY;C@J)./)LG<.)28+8ZD
:1MfK1V.]?NFOe-?8A&-;,+YD;gL=Qd1/fca?f1PEgEDCfb6-Q.K]6;VNcL2Z-0d
PUcCY-<CH8Kg#4P&)7c9BIc2ZK..;He\PSMGWTA@[=5SP+^cZ/]LfZ&JM=c2;/KY
YW_)Wb5<7@=IH[5+P,NOMVgZL/JM^:41BEJJ^Tb1^gX>PaPS,eV3PYNXXQ(O(NH=
f<ZQ40M<0+ZCXec]T:4?IbI<_cf+5_1#Rb2.28f\WJd^Y=8#ES3+H50.Y[Y4RT18
SaMQ9b+#,/4UP(LQ1FDLL=4B9@VQ,38\d9Xcdb@_7-[KFeN.-MaNg((R+<5GfK_,
J<dg>+H<:O<Ved\Y6\T[f)5H(VUJKNLABg=-)CR0Jc2_ZP[eXES)<0@LBAOK+[+-
KEVOE==D9H=CK(^3))1ADVK6Ig)g#=Y&;D6YD#AEX;G^:VB:VJ>W0\[SgceW0X\+
0YCZNCMeb4AWXMI@_9AZDOZ>?,L)FBF_,.d3Y.T?P#&)]#@>YB3?,?M<X0P/;98c
^W[g<a&e&L5KH#BJ]fUCa(H5=eSg9F7a2H>a)Z.3O;3FKA-S8^)1,I-1NECc>eZa
cN8RdGU&,TOPdZAHB1/9R9S9dCc9+c2?8,&/_KbO:SY#C6QFgM>(e5g,G];db4a)
-Df#Og(DS0O4AW_8Yb1RFaEdI2d-a^BU0/I:M?DSY+DF8+d:J7)eEQeZ(+-Z8;:g
\_NgVD;]Q1:^W..N+IB3g^XVNAW8LUdB^2E?2##[Id?Q,D(HKJSeK=Of1eT/0TX:
:LJW[0UIY[T@#;[WL65;]<S8/9bNHMK0C02WXDK+639P,AI)+/IEC2,M++ZFG3We
5D;U526(Z@^?M^]JMU7P&D,XD:[/+[\.57:[.aP4]2Dc?I\7(V.?@=FVBGIa:fZD
.GF^a\e#(FZQ_Hg^LFI<<GRP4[J4B6f8Nd\abfTQE77L@#UKAW4dDYQSWSBYbAK^
5DH<KIec5\>A?g8B\:fXgI[BA9(,6eMA6@7g)U0=1:;Y]AGT;fQ\#,OP@3@Cg/3,
69:+3K+K)E<1KD7K<@,T&/)N.g/d<(W?O-&@UDH8K/AbfeFbW0.8-3@Qb;aQ0,_+
eLHI\BDV/.EX@;E/I1Vd3R\EU?^ZH,OVd&:7BG6EY&<b<\_Rc.#H.WFW0Z<397L;
97Oc7bOMaU4KY>9PQg598?;>/CVNf=Rd-I26a3S>R6L/+3-RI+-gQE(SEZRb75aV
&Y-;HE15F0TM:WJ.acd;7d84T39B?&E9=#Adb]:<?Xc#W.gT;[A(&>PV;/V1C<T\
FT)UT)WS&#fTa_BHE;4+XOF^GT4]N<dYaFW015DOPVU7B:cLgaD]S3GIP0.:COM,
J()<2CgR?&=0>E9<J0Xa)e.c?Bb9Y(ZfE3F3WMDIWCT1/@eQK.&38[fMAfYgB8c9
_/HS^<>8Z;S#^J.>FW);bU(FU0IKMg[J1G0-b7ZH>IK91#15g0(ZbO@)U&dN6_b(
N;7+Y:,3U)G>53SC6ZcC6fI@1,eFN9f^K,.Y<CBN,)ID?F2:48bS=.:^+-MY;_,J
OX4/IARG46CKe;&Ge\FR,?Q_2ceC>7W/[(^UJPF]JQ[,=<dYUJ?F.>1e5MSLOD0/
9EK,\_TNIENE63c-W(Z-8=f;VH&(W8&fGdI@TdH2+@+._,IPdBW=?Ndg_\7>-WRX
,>C[R,6M?PVgS[EI40TI^;G=<9Z/\_SO+a8,&]);Z#4<87&UNIKPT^0J95+#CcZE
I[e5IV4)D&:K]W#T3GO=[-7A(aKADZ.AX>@cde_ZIH215)b-/:#QX332Se9T^A?<
5LMK6PgG).0^FUC6JUd^.K;ZXMG\JKLI,7)6<5KW_=:[03gE?/bfF5g\N3P()6,.
+<7)IK:U3L@Rc-G=T4MYZ>Vb)G:ESf>(-5<55>2ZFI-a1J<2S))#FfE<5D&?g;PV
T,#>4GIC?_S&04\H02@bB=a..KCW.D>M=)dH7gW<_W]E33SC7;d==FdJCd0H_+ZX
Kbc4#JR;^TC-8S6Q.Z,b(bRL+KC9F=c]8gS7?\?Q7:(U\E@9b@Y2agU?bd=@2>TW
1(/R4Q0aTVVBEWYDc#R]UK&+;4):G4P-K((6FHOE-W3D5G@1NMBC;0gD<0+GR^La
1-c/1MWc5]VJT(YT[+O<f1I&N/C1]9EKG[/LSIW.W<Y<38W[P^:eF92\(_:Z7N5C
aOde_?4RcBa0bcYQG9.@0<=c_PSMePT-^<:eAJg/>D0WBC,-7O^VCd;M)9BK055O
[<a)67KbRB-9-43QcCWL[7Q=_)Q=4;ZD(4V<;cB,@5Z>^U9#_Y,PL:RU0J,GQgN/
f0DV58YfBXdV+bDaMQ@?U1^->N#g_UbW3A,7]GZX\Bf5d=CVUTZW2PQ>\e/@fEDS
(0c>\8Jb2:/0R)6T-cDcT6T(Ga3DPURW\egaMd+#=\EeGF17,I:[^X\QW(:<@Z(a
@7cCbVJe6gLPZKZJL7;BJ?g#]^,0R_.-2VS/?5ffFbA[JTGI;J,#.&DMObG-9<@[
6PbS_9FbaY1cNBG7>@QY4:;H+Z19)7NL8:,aH)&04:Z(S#U)Yc;6Ge2B<ABA5V=E
M&,K5CD^8(9c,L0H+TU[::Q4Z)^dB6Kc1XL<fCVQN:fT(cWPAPWMdWGGcZ]NJ.H4
Ld,ZJW2H9.9>@N=>VUeffJ2B2a66GH5a=Md2f[8d.S,R7#X^:U(O@@CCOc\ge\cJ
GR&aTS3)=[#^N[.2ff@>?0U5S^&W&LH4C-K3K3VI[^U#]XE)f1^LNX,=IQg2E<L#
5IdQR=:G]3,BR8=JH0F?)J_IVG1&Ig>[g7M2\K5,cI3SI5H_/#Yc@/Yfa27LZ;Zd
;10+_&+QS<F&999W(&g;)+Vb>ZHAPHf^RM\=;b)0=aT01X/Hg9:;>fYNJE:6DCb,
D;I72I[>4<=@aBd8NLE?46>Z#HFJT6+=AXG+<1EgZHR^GfI1PMH4(Z].,WBP_1/H
[4B18DH4J6c\:U3VLZVJ\]b517S[\/WTcWR_65<&c4eCJ[J)gN#,J5aB3f/4Ua43
[P,HI4UO7QOWe,S0d[4bMAeX43bW?3B+>S2+NG,VV:I9&>]ZT;d5[.P:QLXU[NGa
@2,&I7f)^3HLT7/K(1\;T:@244>P,G#;(I/b8.-e9/Fc#-b\KM1+1EWeSIP:35_D
>/Dg>B/8&JYe&TUPBV0]K21SaCRBeE170Z&J;[<4ZdN0RYgQMdL(R4;GHbfQ,5]c
WZ:b;CGf_D6&74@PFXW=D67GKA^XC-:.PW6[Gf]PfHGOI37WJ04#?2egIA)SAJfR
Te2D86&aM:P\#+.P1R]6ER4OL5VD3?69M^[)G.D9J&6LfIS\@1^.PIPWJTY8+(;Q
?DRZ=4)G-6+55,Z?CFBWaa@Y8;0P0OYGF6GE;aEfYR3Fegd@L1ZB-9FMc0+>)GDG
N-_f>RUe86,F</<U#9bW<5.5\.=6)d51gSYGD[UI/_.Jc8)-C_YUW6RY;OZ4b+T&
&>d7M#M]).\N6fg9>c/@QQ^Q8Hc0(0B0#NC<7>CHDaTTLQe8a)O/cfDU1^V-5RB2
9]&C0g.g_/,B[b(_7R((N9UXT(-Y@4KK31Cf:;GBC)7=]aIcDH08TSE9eb;BVGQY
FZ7U,9[4B=(H^T;TQE0a.UNPXN(;PSV>I[_#P3IEHd:(&MFF;;N^bb@&14YBfG-]
.LFNBW5XU_:[CDF4ffUcD\Z3^23S2.Kg?NFD+.K(.b/AWIGLEMLUC^R.T+K1IA>,
cR>@ZW>(_g,@;QXN03T>^fY,,,-e-+cU5XZaX_XD55Q^gEabV=Ub7^3c<;L=F<cG
3:0(g>Q_\e:<5O:)Sb.<ZbRDAFF/4>8J#I1V]bY0X4PaNKV/H8G<UKM)N0]Bc(TI
)#0=DF>^Ud8RXfe:c=7L=WAe>aW;V:0BC\XP&CQ:?&98&2b=6?/M3).#C+@6?D?b
1C.[^-Z<.F+I4HgE91Sd.?EJK^ZKDGLgD,HUN4PfO.^2BW[DUY#N8([Z1c:U6GWV
d/X\Fe<fbL563HS6N1=b;-WJ;We#E)<EG@KM5/b^6^KaFcdg.19#)Z.6W76H])DY
N&.G7[45^[Pgc#dIJ>5&I@M+[2[]4I,M)UTZTMY@E)6QA4B4<X@88+&EP:F,H3U#
(BHU)T#.;9?L4B9eHgI0)CVb9JECa8F1MDfe-BX=Ue9/<F3)._,>59?F.DK[R)]e
>caG3Q41>f[EIfbeb;<6V@J&KX99OO[;8KCMNCHbS-K(c&:)96MPaZd(\T9.Uf(,
bU@3EeY>(6X;cbZ20N:?,C16<&aag7Ba(S3dWgWO#8@,BPC4BJ:Y[T?C#[Qc\#Ya
-&[I+XXAcbJKBH9)#V=K?0#B6DC1^;TF,,-0Ee:ZXL?@QW6eN&@BfB>+@d+g+/#O
I[N&K,[?-3ZO@S9JbBf]bX;b;3;OF//B+&(]RfWc^.T;N]a/5.g4c9\W;._<>RbY
C#C(\^T\4G=CNT^EAFAP(S8>O2=239#AX=.6@ESMD]A\A1dX<L?#;4SSG+d?UYb4
M,Q79[eF;9G.DH7X;AX+P,E\eH4fS?6:MgO[B13UbS1YO/YgdA8HUCI21(C\fFH^
-7gSV9]G7-eUWQEbXf\W6[YTe2R,.C6XaN(\&3,^>N[4>.UR)5=bL;?:-^fFZ16A
cU-4U?/Ze<1G?2;OP1eLb\H(5?,aV<c-<U#R_WCWQb?:EZR(?11^eag^],f#H9M7
8^G&cK4b-/_-FeN1g20QMY?KA(gYXL29GB]DW(ZO/baO:T8@0V\.&b.6W2e:W0+1
1T>)c-GI1Z17@@AdAQGT]^I]1:VO_.F(O,(R1>+-a@2VU]B#gPATP0&F=g4/U(YF
?CeTU3gWIGRQbG3PT=_)Oe19Md;>S=/GE/_AX9(ZEVf36Q.ULb>^SX:H3@)\d>b,
SaU/c.@P+X[MRJ^O\R@XB8>4T9g/AgW5(af(PYa-YXO,2VED#(,5OG6cV:=6HbUN
@=Ne)6S^PKSDL[,?a#(dS[0-7J^a-fMDY=GC-e5cYA[+M[M/(]XP+ZDAWe:a/82U
RD[H^F9IA2ZKJa[X;.D;TV2K#EC0>]I.=0VH-_VIG]>RTC&1Yd;Ub->A\I?K:19T
HaDe)d=7YFFHTdR[U\e4(+O&#R@LSW#40E9US,[;P)15N)9S-Qcc92OWJ)>Q]V<?
D3I,0W@&#JOFP6)IS=P\EIB_\e9(eT1M+2Q@&I5-NX)3fR)b=Td4=9cIUJW@5C>I
/H9/Q+[c2S<PN<G=\DJF7AVXLe#L&e?@#>K[\;eRe<Y)B:V<aGbN.WB_Kb\4aNE9
W@5;P1e,&P5_^Q])7@-)N5(gP/e-=gE@LHD&;ALb-IR)ZNg4O4a>0N0Q^#WZfA4#
8GV#[&Lbc,cLFSa;RIU9)GK;DWVc?#H&=Wd<f_[UG5T)88P;c2fRW0CPR3SB];7R
[5ebHXGB<?bTUW?:F>g5e/6<Ng+O,]X0)WOKAd]P=\^7KADg^GeY7M8^T-?&T)CA
0N,FA0,56+LTNIcBDE/6;K)AHIca2SO88)cG;)g#WJ;ef6dd;7aDg810Z,6]HL2[
-H(c8gGY0Q>eJ1b/MI<^d;[>5:[8/]2]3AI-fB]I?-P7Udc82YK#NZgIb4-Z@KNc
<>A3DOgW3>I+?GC,B<?<0DX?+#AAUUEGGe3R75)&g8B0GF@W5,\T>7_cA/eY;?^^
YM\^S7Z;X5FT9:XCgB5WOG@cSBeg1-)OT^E?NCgP_-_47TX^.C?GB)-dKK\N;dKD
:ELfQa.S:K500gY?fCF8ddcTP?>21ZGe+d.DPD=UCa(;;d6P<B5IKTJ:/:PB^;(a
gAJ+)=_/V)&UF[/)d>0abP1HN6g?R@E1d-MY>b+.^S)(;Nb,b7LZPN0GTCUg>.&6
E^(QAG30ag+0I&S76W>\8#dW2c,Q&/FTT&[DB#.KMeG34P49&(KVH0T0_fGLWdMF
\a+R)e[cYYGG_;0G\HY5Vf&U(SG0G8?9E73,@GGa>E&SK[BISFJU8CLD;G(E]FE;
T+H:W@,?D.I99FMAfKDOYGW>PcadTJ]C^Ae^)5Z/NdPQU+Q#eIE[+?bT&LG+IL->
A7<<.RfRL43^:@fF6:H&L6=QSZXgLRTG5X,D<2,Ye)B^KT40fLPUS[YOcI2_C6<<
&cY<@@ReXGZZUG=EKc4c9Xg0TVg-:W5DI__<c<-3eaY^-JSPB/=)43-/8VSaPE3+
GUNW;)(-WG@^E^]/85T^cMA[5J:=bI/4E=-9KWS.eJ+ecdM)4A;[+HRBFFA:0([N
A&U#-G5SVKFF0[&(X6]S869J^@/@DH<+dJ2HG68QEf0&N=\WE,F0ZA^/X)aeCF;-
<aHT[B1L<5Q4O9+I3PN7O=901K[cG47TN6?3[FRQ+>#T36R9+4XUK&QQRO/b=T^O
FCYb>&>aO-/6(?D(I5\GeF/Z3,\fD^eb/0b=^-9IRTKKU;#6B4\g<Nb0;-X66BXK
,,@]E&:=ML>N-ZMEKU?GS,(+=+);Q_JJ<;ZFB5FX[+-Ta1?;aP,4V)>B.+d&6_-/
b;TRCFPMc4\OD6G:C01+8L0E(^IE1(_)T3N.8CcV@[E[B\U&0ed^C8>P,<=Q[6YT
3ERIg5<0b+,BKaFDVR[4S,BSE(3)>PbF1b;11c\Pg3e,1=0]d-2aH-/QMdeM)ZIF
K0X>@9LeM<DEd.O_MEUE[dc7][VR8T<YXC(Tb&>K@S-eP/\Q-R2C/Y&Y_8CE59K(
QJ+Z_=@VK[KBZ\UE#K:-)Y[Y9G28CP9WO660UCY:\:^:+/SHA(-MTFc79@.KZ4cV
WQIRR-(^#ZQD<RCa]1MJgJVEGP1YFO_0bEJ,BWLV8(9Gf(]66E9aBgPcY++c;/IW
KV[;6H1:PXTJd52Z:fR\RALE-^/]W(+#g).[]d36&c4/326RKR0)/=DfFM.TIZ]D
RD34bR&7\CK(5AE>+a?(R]_.B?F7&e@<-OMT=I&=dc=_5B]F;@M?T-Re^G;//&0I
7A/4P<D:Z<Mgg/,^2,+IXd7TaW+A_&G[PD<D<RB6?7U@2Z).dKG4-d6QBC2NCc=?
MFUCKPd+gL:JS9T2f9=(6J_0gf,B>dAH3eBFZ=UR:(UAgSHCYJFSNOeJ13g9g-Y\
(9GTE#H-MIGeVfQ@?K2NJU2POYfHHdU^];+/,/&\I)cg=UR3e+;/DF/PSC>,cFY5
/NXLT<?5C\[UfGJU8O1>5]XM6)9BQGE97?2NWUeKS8bDc:Md/NIWB2Rge8SZfZ1I
UWGg<ed8H1,;TDY?b\6\#O9ES5ULU:S4DABa.UWI]M4#@G^aWQgJ);eEKP-8Y#_D
UVYdP72Q67HD#?Be\>.B2D0:7W-a]L+C+LS?e(]NG75bI/9Y:=0T0T.;be+;V]&L
60fM[7D1VXGD.gMU_J;[\>4G3O.4[\IL<+]U/\6[>N<A\08PVR7NJ:HP;L+<W&\<
/e;QVKW#2<A<NC3PD0Yf/W0[UY>6(_3>M4+IM5?B>60dM6Seb&W[<2THR4PYZZTC
/4MJ\,F-WPT;Z1Hd>(.V/&H_=4<M];K]PcMIW^A_#87@A)+O/^bS_]=]<7JQ,SFP
Keg1e.RA-b6d.R@RdK1LJEIJ>/5/_1O4Ug\3;83:3c=S3V?,<??_,^I]](_,P6@g
=KWX+U(/_@=Y>J#Z+)RWIcOE(QH#,BcOCN]Hf/T9Lg7UTOH)NXG332,CSD7Oc)U;
eH5XgB&R2.859Y,Y7)&U64DU7LbZ96GKKG_?N_-.X+[59,Kf47a:gD<^_UVGegb)
HRI/NO,/-g0f57<U6N-De=H:#S/ENI+SF]e]I#FfE,4P,E-1SF4K>/O]C=Q<)ZID
K5^?96O0H=#@UMF,-J6P1#2<YA(F7X0N.4HNZW7+CQR@QUGea8bH(YZ>XXLOPaF^
YY8\ee:dM]-X#AfdKS;B?\3c@EGbGJ9_e4-Y3K@Ocf0J&J.e(be[Pc\(AFX[bWEE
N]9LAWW2YUO5;V&/92E7.C9D]6fQJED\X_3VY[?Oa_W:?ZJ)de=B>a+ZQRXGd60T
IM((<4GLIGAGe.BgcIcWH[;1bSM0)?7)d2(GaSER,A3EdBQ\LfZ+=I=3W<FR9]L1
f\2M4PX9aOec)6PC]A24-V)B]XJ?BT0<MfdJ;-](@:SF\6Tc,C-F[#S4-YJLeA/&
QbVR&G:bf\1NPV^(B?Yb:O5DI=U:df+cOYH74AZg-/c@a?,]/_R>ZQ@?[9J#O/KX
^J46?Q_?PPKE,HAITc=JDBd[ad,4c>2@]:ITPWcV3DI5C_AI(7L(7fKE;Vf6^g).
Pg]AaSY@2>3f#1,7D[;CM@ND,dH[PMZg_U&2^:Y0bVCI7>Nea-gHJI[B^A\N8Va]
8d<f.ab<,SV;<D\H#BeOF4R<=VW7<Sa3X4P&-J4Xd2Gca-MZA=d16E]5>FAIL2KH
:dH=;gH0YZT:6@B(c\]8Pc=9QFE/+@aYK60fYf2^\E8HNLEI-@?e5BM)d=c(@8#I
+UYFQcMgMR6(7<DEIMZgVH&BFYIb&06^-.OEgNHV3>=0]:L76?79<=675VE2>JTM
#LZT<MX-8^a4afR3NTgD7D).E=C,YJGNEEg14Yd#R]/?cZEZVd2.K28D_E.d6fU\
;;RDfZ-N]?S>a7\;FD^5&W89@6>:daEcU5QBDb,TU[L,5a<aT[R65(?=3\,XH</7
UJ39ACM<Q5H(X2@OXf/#bM<c?eg6O7DRJ9YI92FJ(YXRg,fE>/gSUP^Y__bH\4MO
07ZTe7dI_Y?7X:LFJa8?M1FcRVeX[d#cf42MU7]@R[FbEYbeJIJ]\bJ()LdTH]R;
8_N;Pgg9+8,U8-GU3T@F2=5g\.\2R=_]+]E^LLaFC##gY.CQEQS_:@_77KL_-4KN
c<D92;1e^NgS^4[0d,\KW/6O+.B4#RIW(F3cB&\4\VZ?/d#TA^GcEaZXDLS;Z4Q,
7,FQ7D(SQIS-]Fe\cA(W1b@KJX54b-WI/A5Bbg9,X059TKADg1LZ#NYF[gYfd<K(
Q)H<==A:^5KJ0[Ve;R9<9BZLN,(eMNIOTYd;;a[UT8LN#Q9S3_].?3GV>@f&0e9b
H&S.bb5J6DEGT:Z^=aFZ2V7KVV3(HT9M7X_SW#C#EOIc.YEbCZ5Ac1^I#2+<R:B1
?R&eB+M/LL?/>H)IJ1F/H65].DGec1cE\:]FU-/3)FHXeNgL8R#@c0EcGCbH8P/@
>4Vg=[Sb,<]=\^\R+?D2aLgET=_;6VP=&=#/]D2aY&eDBHe:X]I5_X7P.-X+#,+M
TFI]3>L:<[6B7,.;FI=-Jf;KL6\VNTddWFf:)(<R>;ML<N9g=1#A&0^D<LGa3?VS
:<:JR8aKG?=.UT/&\Z^.d]0?I[DBce&[L\=B7#5T8(:(f)&b7XgOKC=9@>F45]<>
NeZT=>8f2IJ+Y@c^BMCY8N(+DJI(?&UH2P#C<.5I@1Ae(TPE;>5<eH#e:>,3c+:Q
QTc2VYDK5H/Q.2g\]-2U:T;@AQG,gT6@9_F1).Ge8_^KXNc=8VUW^];EcY\LTDB)
-DX8,L1OdD#NU[BgWB1C]4:M1AINNP1d(2\S(BgJCfWfFNTY\FMb+X=I)g&M<>Y[
9VM&V<AMEbZRT50J3fF>M-5_&O.3X\ADA0;eUPWVIZ@(9FHdfI55B7<B80aG\@BB
JKW\P:7?UC]&U5aKg4560=4(Ab@8/.[[&,b/0NAGSf]BYFbD]\E,=N<+,Z@dcOWQ
]Y-bSE4S8#?ONYaUfK_9^0/T@(TFTFOS=+)O_Qf8N64VG-ZMR/EG3Tg8)KQ,b<0b
bL1fF)b#9(4R@4\@S;Tb)87,gNc-N4A5-]T1--QA^eM;T6L7KYBX)6Me/)3b/C,I
Bc[AOS.,R5/9PBZH-\R;2b([\)9(A;bbDO>ePSd4@TGc=d><_((UE#F=Q)#FcHT>
VZMd0f)I-UCE4S+50U1SI7^C.,67(dRQ#3W,U=7#.E.Y4)B7>K]RUIIM(JH]_3]e
VG7fGG5ZSa(>-E>[\)BR(:NIf3;;\71gdLMQLdBKe;9d>6Q>X^3];KO>^CXJ[\67
bZTBBS6-U_WF.6SY5]DD;gRLX0C]cWR]QDVDY_+L&cIMQ4WD_H8Q0LYPQ@3eOGQO
@,H8_)IT<@g6;^YQWTBN;SZdEO6H>5),0gF=c1VRW_N@e_)[8N-9&5IOeH0>AM_K
DcK8L@ICGQBMMc3]HRP/eEH]C</TL&63PWZA]Lf(C&?I:QJf_-L68QHKT1STFXa0
&BbGcA_8f2;,\;E:GP;I30Daf^L5VLE#d5gc1>UY+A+\<5[BKaQNfZFYQ4F2R\PD
_(?Na<C-[B]LTfa^\<K<L2/ZU6QV[Hb?4VQB&)B>2)U#V6L^9V,T?Td[C.d)^I5?
68#@PVJ7^X[3+S&.YFE+8U(D<QM8P#V#8L_^fQ_-^Je^RR2KVWWB:/\<P9FPIabO
DfPc(f7_g(WH.-2bG[WXK4&a4T>\V7J-P1#/M@V9.cg6(dbF8+8^J6S>3+K<DgGM
ZX6[U\6SE3T.YKV@=e/.Z#>D;P:;\I9&_Pc@<L0.3/C=e4:;]Y(@KZUZgF,T8O+/
Y:AD]c;8Z7[E0@W6#NQF4e/9Z9YC[e:\9JL/3^8CTa_46\93E+R#-F?+X)EOe,5S
Sdf/)D)>9VP<I,14^:M\:IDMV=IQ4IBf7Z?U&a_-@7?F/bVa@_;.X82adJ?O82S(
S1-.12V[1\)5P.SC(V)L\;F&]^_\]XS<)QG>;]Y&K\2>VS=Ne)P)P+?DJ,@Cb^I#
CA9&@YA)I6>UG)?+>2&aSJ(V05/J#-AMJ+T68>&][N\eA;b_7-g+DFJTGRY4@B]I
G+OWJM7AUg_IBGLL-E8_Bf-D6([7,N5<[d?ObW1HF0V8e>XdU15(&aTe?24Ue@ST
3J,2eB\7^[OH9.#J4.3^XZF8B6ME]_C0JNcIP,4^QTgIcR,R,FG/S2LRT<S26W1?
\X\_;)e[A>_T0MbE;AKU_2AP=N5#@X)&Taab2;J:TMYVOGf;APP&TFT-1.R#=0Bb
\_(:2W++Z31\e[FXQPQSNR#--Gd^/a>\-8Y/B(eR<4XR>H+e_7^fL0EJXM?7+0</
5@N72?W8EX\\;#,1RALB40JCY-=;Oe]00H@P5B?-cF:QVPDaV+C1O7XKHg_3K<>g
3KXaJ0ZKcfAJ])\7JDIQXW?,J&I?,ZM<6Agf4]3./]e^OW^bI(8BAad[@0fA,]D6
C1Pa_=BIIQI4+QNV:@bS,PV_[C&#_/H)_FaRF;Y8MSeMN:R9=?Z@HQR)G^gG:BBZ
EB+;EJH+(GW-e(I96a74?Cb\Ba?=;OHMKI/ceAK^A2Y7a4OTf805aY.bJE\9&H<g
DFPU>fOg4LH/7&VgcMX#9E\>-.G.RFJ-gPc23]3CO=J]+/RXD)GEHJ0dE6^LDUf=
F;eA/T0._(AN#LUBD9^(@BfMMQD]cg@>d@\XeK_]5c?:AGBXAYa?&_3[+ca6SaWZ
NLe]RG3b,Q.\=(f[2c<^BVIV,f;.3=BBF]I]<-SL&)84/A3-a+TW@?:A-CKADMB^
2J\DENCX]5PHCIPC#8=MgB3:J\ED&C(B\55RX/ZVN0)XJE08aPfFHPE-6T)Sg]X8
F1F:@[,aU;,8YVZV\gD?RW<c[)/;[.b:.M2C_V7JR0b6;5SJW28KA2@O+O<Z\W5T
+^eE/]1?@.[+cB\U@af)f;\QgO3e9FPLIb&O7>d9+XMRY6HS=[Dc>N[+=[+3Mc<T
dTY(HL<]7Kaa6B)Q4>ZWeL;3FL)]7V9LQRa/F=-CR6bCSEBE;XCaaXXPRbe4E?W4
4]CC6_ZI(H3D_aODEH5>7Le=X:dYLOJe_58KgD;/\I6;D./RP#L<2ZDZ10FJ3])@
;4F6=,@DOQfdUXEd##//OPPJNOf>EA&(&&V+W-2=.^,JPYaQN9W4P1=RCQ-RG>G#
LN@1192@55S^K;\MMOf)M71W:&eGHFZ3Y.b\D82=TNc7>(UOaEg6\88dGY^3#6R7
=fT&B?&G:[80&VN>;.V)&V/FG]U[UPW\&7Za7VPUH@).UQY7P<bg0H;<aeZ@9&7@
T0RLUD-\D/UD<c5];1IX-ed=ROS,49TD+B9K);6gL8RQ>[UIJ;f\eM&&^SKB:fIM
H52R2,T6d3L[OPf4#=FIAR\5^/PQN@QNeN_Pf-@B9/?/S8=J\H:T&c&LKX7ag9@;
::/MO28JDe4<;[31Ba+@<c+NT>T2Nf;)AdV\3[>1QKRSF7;>-=E)U6Yad?W4&JF.
,3EdU\BN\a[aUA#>-P6bX>FRZE&JJG?Z80G9#N.Z@8F>@9,Y-)EE;))099<@V8DX
fLRZbT(e^-W#?bJ^0/QI+U_JK#_:XG8Yg4<FG59G/[<bZ>XRKNH9dJ<+L4./D:-G
]O[dYId=dP0X<ZN6,1.V3N#/;]e0)fJ/E90@_bE&1E:69>\Ta:36;c,QW#]\NeY.
;/4G-g\O+U58(c=P]aRO4QPb.LFIC.&H94fKVM>V?b>,LT/-[_S2)0N[KLO-()N1
0+SGSe7XLggS(2)#:_?fYH<Tfd_T>1U5?G^c9.::.VfR8\f42E0aER&>+1[(:]Rb
Z-H9;#5b0F;_>3QCH:@KSUdaOd1HaEV_3d;,QXfJ&6YVeOdH^#a7#gT]C2#&2^KL
3^>6eR?8N/,8fSg;EMeSb:(+GB)<I+[+1WQ_472KI)PbC\O/KAKa_C0&dQ(+IAIN
W(/aGfJb&eY,bRKb8F-X6dQ#?2AK->;f5;HB5C\===9AR&L+fUeARYX<VRTaNFBQ
@FYN&]WA>]^93IA+-CW98\X33TV67O\@W?I+7=?]<?DI?Pa5V6]-IP/(4RS<?X;g
a<(KBD42O1W,M&&;aWbVg(V[Z2&]736dX61Ig+&RQLc3#b-+O/g9?CW2IXW[0Fad
FJ8Of4aFB^4e._1>03cRc<AXOJL[.g7W^5FI89=<+LXcPS-@6_OO;PT>]]79bIK@
OM+e4Tg8XZLGXNML[-aH.A)Ta[]I#B<HZeNOS6g(4Hf5SWLa<VRR&L85&T9cPIgE
5>)f6T\XM.,2K+GdI&.-Cg0SAV)fS6TXH.7:edK#PA)=P<Y3^fCcSFFU0PR/_R8c
JB14>6W^Je5&K8+3CEaLd=E1SZd?/TIG5-]=:E)_KT^,5O8-X_6f<SO<_Q1c7NC_
0[Q-b7V)3SYM;ZB;dDQS7=Ne8)]Q,JV,QMR7c_[?d7cP?3b9&0?AcXd4J(<,I]c_
2PcVF7PgMVU4RZ<3<U6PJ:&H._SJHZA;QDAGB7AY[9>AM6XL)PA3Q?)aEc3U;e;W
g)IE(FL5E:^+&3&QT=I@(JRW>fQa;ML4S/99BfeW&=WK<JE2IVX[4g?3NdQ>gMJG
>aRHQeWXED11#A=M_/+3VZFE2T)X.B+fZ)8Igg8DegBAcfFF1CE,##Zc\NM[SEA]
<8d7E-TNAB22BX\_5be&f)51/-ZV0gcQBfH77.9&^_5T4@e6gY?XMCY=:V,LJ)A8
Z&<H2@@0BSE.7Z:^NJZd]NIDJM1E^E(bKPD52@BZ5c:a[g/W;I^>Q.IdXbI/aG?T
H>?FA,H<\;-N(RW,&COgY@3/T31:G@_&]F@RUZc7Z:PEPIWS;GEF5A#gE,]4I\gN
HC<=N4-PYV.VSLF);Ca2DRYO67H2TQ4_557.#-5C6I@Q7@A4HME4S4Q,:=+_&Zg@
Z&Z>dB?0YZN?)P6O#C3A2R/L241B(gfP7Q=_]9W?(SK1/.:Z1I#>,H4R9MWX9=)#
ED?SSg[RdM+2gMD(8YW+Q0Q#)^O+ceH(_.J2MKMWVBU)9eSbCS2==aQ>:?RGg2Z1T$
`endprotected


`endif // GUARD_svt_axi_snp_xact_to_chi_snp_xact_sequence_SV

