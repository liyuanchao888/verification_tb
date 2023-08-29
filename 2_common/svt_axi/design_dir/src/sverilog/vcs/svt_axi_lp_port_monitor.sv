
`ifndef GUARD_SVT_AXI_LP_PORT_MONITOR_SV
`define GUARD_SVT_AXI_LP_PORT_MONITOR_SV

/** @cond PRIVATE */
typedef class svt_axi_lp_port_monitor;

/** @endcond */

// =============================================================================
/**
 * This class is an SVT Monitor extension that implements an AXI low power monitor
 */
`ifdef SVT_UVM_TECHNOLOGY
class svt_axi_lp_port_monitor extends svt_uvm_monitor #(svt_axi_service);

`elsif SVT_OVM_TECHNOLOGY
class svt_axi_lp_port_monitor extends svt_monitor #(svt_axi_service);

`else
class svt_axi_lp_port_monitor extends svt_xactor;
`endif
typedef virtual svt_axi_lp_if svt_axi_lp_vif;

svt_axi_lp_vif vif; 
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  //vcs_lic_vip_protect
    `protected
.4AG:_aYJaf]KCD6<9M<>QaQ.=bRM,=B,T_d>)c)gJc6Hb#]ELX-4(D1S.TUKA>N
g&bR7PL2#X5J03W^IgQfO/E)b:4Ad-8@3VA06;Rd#;0MJbMe[gBdTa#.W#0b6,&T
4aXOIe0bGHN-94c?X[@AVH?\;-fcT9_0[6W,Qf]S@cB>?J=U\[]dFeUL-VN11?P(
;H,V,WWXX\ZE(:NWK3bWYRCS6IOQE<58PFO<(E0,P25Df>Ye<>bd:5TGJfIe+4.a
b38(&>FUacYS6X=DGeG>P^P#3]/,&A\_[bVL-R=-(d@&,0gQ^:ZHK8LJ18U5H+0-
(a_g(c2@f(7N)2CR4<H5;/-RC8EJ/c6fI\6JJLW?>JgF]B@YY&8A;<cO#eEb?fI1
,BdOWB\CZXbE03MRVFF>]^YCQ7)ZAe2&4@:e(Ua+^\4T(#DW8W+57=W4MD)2)4_G
#egU\NP2CU2I@O2ZXZZK9K.)eGa#f-eM=3Wd45VUS-=?2:2&KXba(7ZJ2FGc7&E=
T0Z)KGP8/>HcU)&G,KBLI4.)4$
`endprotected


  /* handle for common error check object reference */
  svt_err_check err_check;
  /** @endcond */

  /**
    * This class implements the port level protocol checks.
    */
  svt_axi_lp_checker checks;

`ifdef SVT_UVM_TECHNOLOGY
`elsif SVT_OVM_TECHNOLOGY
`else
  /** Analysis port makes observed tranactions available to the user */
  vmm_tlm_analysis_port#(svt_axi_lp_port_monitor, svt_axi_service) item_observed_port;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of axi lp monitor components */
  svt_axi_lp_port_monitor_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_lp_port_configuration cfg_snapshot;
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_axi_lp_port_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_lp_port_monitor)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

`else
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param cfg Port Configuration object handle
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (svt_axi_lp_port_configuration cfg, vmm_object parent = null);
`endif


  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
 `ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
 `elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
 `endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads
   */
 `ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
 `elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
 `endif

  // ---------------------------------------------------------------------------
  /**
    * Extract phase
    * Stops performance monitoring
    */
 `ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
 `elsif SVT_OVM_TECHNOLOGY
  extern virtual function void extract();
 `endif

`ifdef SVT_VMM_TECHNOLOGY 
  extern function void start_xactor();
  extern virtual protected task main();
  extern virtual protected task reset_ph();
  
  /** Stops performance monitoring */
  extern virtual protected task shutdown_ph();
`endif

/** @cond PRIVATE */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern virtual function void set_common(svt_axi_lp_port_monitor_common common);

  //----------------------------------------------------------------------------
  /** Used to load up the err_check object with all of the local checks. */
  extern virtual function void load_err_check(svt_err_check err_check);

  //----------------------------------------------------------------------------
  /** Used to set the err_check object and to fill in all of the local checks. */
  extern virtual function void set_err_check(svt_err_check err_check);

/** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
endclass

`protected
^VFVY+)TRccS&&CM5+db_\+-FT..=AeKZH+7X6DL5\=9A@\Ad>fG1)8V)A;S(;/V
4V99CfFYgK[#-a?3U^(-Q.\HbdLY9e71UFAA4:8bdMYWJf&FC_aA8;,\AV1U^TbA
-CVYOY0D6.gB)UEdR:?T,K^PG&)7W@WZbW6.27OH\H3;\a^M?<XD:ZT;2XcG6Ic4
IW&:5?f2J+@EODE<YPe@2?6O-W@7FKWgM@1Z.W21H?H3@#S0FHICX4S@V]K)UUPN
.X.HGXB@)1>JNaFCX/5e[:M-Ggg\[BY\=B9AKX11RGcH=<C?NZ>UQ@NA+U[NTELV
WOH2RDg4OAd,RTVS7N@:WZP[+:G&A+dM#g4];3[Q7Z.XP/N@,IA6-bU=Y\B.Z0dM
bP>YZN\9ebc:)4+3>)H?U+(P]F@QN0W+&dacEUF7N0Q05X3]MbL6+J71[S?TZ\A2
b]@L,eU/.UB^;4J0]@SHDefE>P60<#AWaM3.,46=X,3ICS,QGfXR.5VEWV#c_CWG
0gWPCC1^J0g1#Ge=C<B\eX..,C5NL.TX\=a.72-JB]\a;=.E,Cfc1-_25EO-B971
8[Rg14C13Cb[IOWe#TUegLfAE+TYYQd>/YW;a.I=(ZN4U+_eVR7Ka1=8X/5A.QM5
K_AIFU59;>ZKfGX_^:\#e?Q[EeONT6?]YK,_,:NGa/T3SA@VgF+;G-K7WY&/+15]
A<A6N:I_fd@d^<=(VKPd<1=2T2S=HaV[(.?d[#KaVf,)^0]TX[KC:2b&b<IF1eV4
?6=PaTKKVL^4d6R-)Ab,J;;(MC49d2\>IeCONe<4Z&;]Q=UDMT]JR3,-/CbI)XM5
^?.d)-bL;VB#^8OC9cL185SMJ6DI^4baJQF(]d2SZJY-EE<>Y#MF+#G@+&85bF>7
Yb2(OJUZ0.\H6_KG99e6-WU_E]<FcI?bD<K(V2NJa^TI#1S-3fK<119S3eU#f2@4
FX9F6?9KIDa5_.9gHU:3LQKGBc,0Gd#]4Ze&XgGW0=_ZQ4A+\a1@&13c^6#>g_TV
&2GK:==0@[LV<F]1ZB0(J>d^Z;R(JQXMN8[Q/(LeUZJA5JM?<)GR.JM)d9_=YD@F
Z)\M)F,SOLbM61=_QI[F/YP+^R(BC_P_NW,C9U8;XS-0c+bP+F0=P1TSZ#&@e(eV
9S6GK@GeM>[J/J6L)MeM1:\7e#>3&SE/C6c&0RaCIR_V@X?&EC-Pd))5[B&e[?1]
eR:0:XTG#+P/Z?Rg^#GaLF3a4HG#WIa3MLHTL/FDN]HP9A:N>?ZSGD4,TOVgMLQ[
NM=g>&87_C1)<(Z^^OYM@H9L+0gGYX_4D\Q24K,,5FTUfH.gJVEe+V[N<O9;56Z&
ZcdA-^89;fS7<5<-I-W#=bF(TH7@=XbCZP,3&)Vf7DK(eYJZ\IaM4+@E76><fF/\
QJ+?7TTJ1YT(CXQO<4HFA,WLg8[,3gg2[2NERYH@.AU;2P>(<8]bgSBHdT>P(9WO
R_K-/c.\D4,VB=6c<:(DARc(5W3Q-@72N/K)F#OKB^2CA-cb>)D;SS\YLEB-GFNN
()gWY::I)_ENWAJ]+QDba<@2a:X\J=>-g0I.CRA=&/g,c=XM[\=2&74gX5;C-0)B
\PQ5X\5[H=8+ABb.e11ORSaUJ<D+2\BB)(BK9=PeV;X6Q95FKS798Rdc6BL?)7MJ
Y(3Eb/,NT#02d^Q3d6e,[<A)]]BU]<eT)e:>MX[)c0[gad9W[aJOE)^5)T=d4VM)
1;\O5OJ^T)RIeOQQJGNIMQJ9[:\C>G(?2gALL/\R0+e-_0NP<[/60[ZFCBRRb)JVR$
`endprotected


//vcs_lic_vip_protect
  `protected
7.CA#54>QOd[<7#6cYTSNf(\)b0+M5b;Yc;MaMLS&<R71&8eMU\a-(O0=_A\BJ?\
Md&3Aef#a.0Wc=1Cf)Q,S,W\4NOceNcD[c:9O?d6\RT5;NR;0.I8e2>T3F&A-^L[
4OfS,[A&_a5)_VgI[.,3.^8Q8Na[3GL;F8B8W]@g0/YX^Z9^XIQ:7/Mf6dD^;f=3
IS;CVd1>c,gWZ;gTOM8/04:)bZ>AV\7-b/\,7G.RM+J4L3BJ_9S)[EUcC.+=_>L@
8+)A.\C31g-ODKb7/+5KW33(=91@KE/I&L,>-T)(VEETU4Y5gg2^dP8@c#E9Y@>e
-IOGCW1#UAXBQU,M=U.A.UE,V6>]Z^CcWa<LBB\/AKN@d<R_A8Lf4@VB9D2SJ=\F
5HM3EL5_G9F<b7,M/USFON3\J-+EDNbZ=^bH[4-c:4c\RC/cX/@P><(+6eT#AGF0
1cXfB^R/D7c)Z8-BU\29X^@]-Y-2[Lad:2E/#\D36Z-Ae1<81NcCS_e&#_)N@bQN
<d5>[E8@ce#-=7V8Ld.bLQAIR4F&.?#@R0EHe&LHB#>J6Bd;?M+W2HcI;0I1K&OU
Aafa4[?V/R=Ug6.bLO/Yf)>K:dOg(S]2NH09T/0f5Y\a#K2\SYf^<C6VSceTHa>3
fK0U[\5Y)@M(_:9TK&D,&BFDY-CE++@\<2A7[=(-_&FFc#AEJ^dNZOe]eO[D@7e)
DYe4RF\MW+gOY1JA2&_YIIALY>beUbXBC=-PM3E[a)[^(I4;-627LM4RN3N?\[+K
1;<V>R1LZYZ0G<RD=:DU1(Le\J?7VTb^.3>03Q5]9#MZD:5PfF[d(WO&N9+2D)WM
)TT\3eSZ6aeDbfO,/+IX0([FMP([:)6\cKG6Va@[MfLI:DSH#7g^YHCTdXZ@7a:O
>AG/++S-=/IMd&?(-FI=Y,#Fc<@6C<:]Y-\4E)<YaTa</,YRRIMf2D&.VfTJBTdd
^L^SddRG]<5DE;M1R6G3L>WP8S,Yc;5PSIBUU^K_?@HJH+M9LcW_H<V_OZA>,10U
I2=XGZNde=9e-Bc(MUg;PPB-&Vd<3XZA9KaHVMdeYJ?G.UF:NC#e_-[=BZZT3@a#
B=O)W;G1IK79;)@fTdf@T7@;GRYWe8.Y60P.g&_G>[fBe(?.E?aA=9Lf:fea)ONS
U9Of\P8:#/V)]O:7=C>;b(G6(S:5H^M&fB+Q0;DF9C\g5DZbC2N3.XG\2WXT9a1+
]:VNe,4C#ceG+eLG7#S.RddS0GbFRWe-^&eW04P@a712UCRYI3Y1d;P;HIb4;U9+
77?Z].ZNIY,/g&-1;IH^3J4I8SUXOVPR9e&ac[TTd73L)WQcC\e=2+aZG;8g#PCb
W/N//)c^>,B-[2F;<6)BR=@]@BKF8P4a8A1+,VN.<-f\[Y]Q9&GR_E&?-5SM4;FN
V6/^gc:b<@c>(cHPbBg?CGG;MD,&W_G_XBTZGdFGZ:b6-VfUY5BZZf\cQe-7)fM#
YA,DN><].<F+&GfRFV)e:@,4aJM?T^a<E?Nb+Ae#G<O.4+;)UZ_7LI0[-X;HWM[Q
CNN5TX83KF,=c^6O4-1BDW[SY:FR[](W_4bS:]ggGeXGA98D8Oe7KeQ?HCU&Y8P]
,02BGfe[<0(V3[QW.c,>P,4>5#>]>:<(<_Q,K77>c-3O+Kb5Z)@_VaU/D>_/1^<_
?BT+8^FecZ/7GC\C-QaG\4?+IWEFWgRD2^<N)A;2aLN#D_EE^;-,-40dFIYFKFJP
Rb\SU&Ra\)]dH6WB15DRNY,A,5FHI^)fDXU1NM)7;8\H,4.f5=(AcR@GFT?d-HYP
dW)9K.(Hd:ERAAf-,&?f\F80d7eI)6H5OWV?A4BSg^SX4-8]B[NBD3QPEb+,M3-:
_2NgMWKBZ2eRXbNK&LFeX?=H0&UJG7/9E>Q\Q,R)MKFG>O<FUY_THRbNc-DHBc8;
g0e=U[U2S@#ZPb]>S[b:31&>I.-@eEg@PMM-X3YUdUVZad36#N^_Y?]MaS?3)O\C
4#-7Bf-#@9G1K?JM7H9XBH[=NH5C,NT5eEXU_\bU)N5GH;&(V8.#JK862ZZf]94V
ZNSNB@+IO35G>7[;B7fMbBQ)/,0@]\7;2O,O#G.##6CMG41\K]9M0#feID85/]04
G@G:E\N>eFC2[8f.XL5,aLd>YJ?bM?M09QH771@dO;XPO?N]JF.V4]YbcCE.2C(c
&[?7)WZc@#:F1Jcg##5&^40e[JL?I0XXQJWaK)JL\)N:Q2)K5eU&2&.)8TPV)C;1
CFI8=gf>.Qc13WU,543>F>:#/O&T#_<Ia<O0\;JOZQVK5-CESO:./7V?a.(N2OIW
XO):8f316V]Bg,;<bNeMO;G1Q)+I9+;@=O]g:VNLT8@D]9OC=@KEY<\;D&C^+gIU
#VL8e>;V4T]bZU8DLCG]d-^5BD)>a\fEJ6cF&DO)G&;S:+]TS5&F.2+1c]4Ib3G]
H9bRP1@8N\N^>PWKa00M.B#TQR-#^IT#W?#JKZA&4E1,,EQZ.AYLN5XOD<Pf3CDe
c.L4V,9>SC#K>7\85V/8TBD/090VM?afP(8-^-G,3A;;(T]ITC4eZWAN^[-I<6<C
)OTLDcWWe@C:#6/^\V>[gC_N=(UT,5RMP6E=JNN9GRP<GdSIc+1M1<I9SZDD)cL5
HPgJQUW7#-CT8R^)geT2\OYCU:8e4^?3CUDN7L\9]g=@<[Y1/#-@U2C7-SWC.BbZ
ZYSXN20\T#))0FcU(TQQ7N[O6H?2=0>Hb]5.;;A?4TR^+N_[I=?>&L8C,1]JJ.-P
Ua9WW&\C<JGKH]43V#6\#YFFE:]S(_c.#[\EQ>f4J_#QV+Ce,9RcMJL-J,4(:9H\
11fA7K&fN[:N57Me5c<F@NHL:T7ZUGHVN_EgSFT\:0NgXDW;&@3BDDH0RcZa_I2R
BZ72g:eSU5Ieg:CM02J(+Yf7M7^7DEfI\W9Q55[dJJ+2S<A,CB,\^8MLGUH6fGNG
fX-We.V]XYD,ON.NZD,WF,5S0?G^IXZTWgJ&dS8\SKf#3JY4d=L6HOaCc47=Y3-S
b:fHb,/Q1M[g66M[(9O<J(PNedK^>5_&#+V:a8.,YHWG>EbY9d;a>R2d>@c9-DTT
c7g]Md_AIE3J>,?B@+&[F^Ic+a5JFP4Gg\]_NJV91ZS9Y5;).9aeU8Y4,U5<F&b9
W3IK3,aT5\?C53R5eB,N11.U(((,TYeF.=cJ;J4<b(2Jf[5SG=V68Kgf@OV)HZYQ
J=R,FdgU#TL/]3(fdPZ>JF2A>YT9=B[B0N(eLQ>c_9W&>]1M^-2<?<^L2fVgN,WG
V0<6C<PH-^9?d;K(A/MV755Q3Yf5R>U8EA]eY[3Ad;8YL_A:B:PD=HJ+3b78aLXb
A[d\aIS)2c\3]W9H1T<GZ(JH(#LSB6Se)\N3,5^X+HCGFaO(,&AB,>2J5(SQY\?C
fUA62&+#Q#+CB3\S<YE0b/&H7IV9c^\ANL#g<B[CV65Q\e84_@Y\)9PU#G^2]PIN
.X_(3bPeX]De<8D0T.)LH)+.0d[ea@01Df-K;bG)_G,)O,UA82)2&DC#_.713aL9
Lf@U18PGZ0\/WUV_8V#HBSJ>8=VcIVEDEQQTga8>H/T#cYgI>:]f1</YBG_aeZRe
5JR-SSFN5WZ(VGaRX]e5dadU?X0fa[>N&bO84DV/(dI3HSJEYOc.;L8)7+N&=DD@
QH80X_S/D:Q\M\Yeb?Z^0121I<GVAIOZO<5NF)^Ud7.Fe^2^=C;7\XS4,.:^XXM&
Y?/YS4\&J#._D#GVZLeeYXJd^:1]B@Y=RI?RQ\U(AYU===&/EaQ?K2=X4RF3YZ6A
d#=4DeIS(g+?\aV,,#:<>\aca#EAW:>La^MG\5f1CXQ,&W;b3K:O&#H-RJ\e0QQR
+Q]K(MQ:FbBMRBeC&F+N]V.bT08,TK;#4-(KcH60TJ.Z,>:3H0>RW&K^:9<3W&.F
/XU2U2eR6?3@KGFHg=<E711JAGJ_)8XU4SRBSc9)a\KAQ_&V+=5d&c+AK6&1+.6L
#-TENU.&Kb,JDa]H\c<d7b#_FJS,VcKG(Na6bK2&#fg=FHYfL6=[4P(K27gP-3O@
,74fb<NY4>;a]?I\B3MIeC.Mb(J6@=FgUVc=NQKTM2MNV_U/<9<Y+YAS#]3I([gO
W4/1^fF6E>9&#O(@0V16TVQ^bW>C_084>_Z0ERE>FD/8Wa<b6X6P69GQ;<;ASX_P
S;GGeJNN\2N+#a\7^-G9@]T&4SN5J1=4WA]#X=R=.RFAFHGQO+Sa(Z:A+B7VDOM-
5^bH\5S&:O=EU-HObU?A3JKFAN.^F&d&/U:4[b]^/1>\9D83OF0M#=-g=dQ]IWA^
2<:6MMZf+K#:#4).bc1GBdbc0bD&8-B;)[^[8BdFTgN@89g-988Z)OdDg&b)]eB:
Z34CEBGgUL#cC[\<#[_LME5JY,WB>G>;9&,2,7fIeMU?K.fgGI:TR1?]\8SSd?C@
F,GN9#[&+:N[4((OY6C<E.PE6T,R2U-W/ZZCX=f,MV\QLP.?.;5CM\#@3;JY42f&
78.R&&YV4[)W0=UYO7C/2C>&XU?0,1,VYQ61U^WQgHVO20L,f=[3\79L?7+1G0;.
TT,&?Cd[e^U9.ERcFJ1X+=agON5/I9ECY5?[W>-MC6FYJDKU#eZXcAP(?\3/32U.
PB^-HBLc</4F?UDD_P7@+Cd1f.M9-EdXE<\L+)C7C2:I+MY<M\)6AdUaJUS9YFH9
Mb@7HLHTe=deU08f;_\O=ZacSZ17eb>>bT?F,Oae,/V:_S+U&QZKNF0aLIPP3,MS
E[eb[RP<R5c\D>fDE518-+Z4P+G[X(0RTCR#Vg545aWOH:cA5_K;Y\TNBW5gSLW1
]N4b9<M[,RO1BS)aHQKB0DNgf1;f]GU6/]4;YV(-[=::W[25DC>=S6DZ:?6SG3I1
GMNI[S&+PY5b]Y.cFCeWZ1>_^D5TW<bW7EY<]-(C1E/A^XcZHKYYB4O+MI3U:CP#
B#c-]#EK=-0I^BgY;_c6B/CX?J+J45FU<)#KMD=#+TA^I=:0H_YIfG<ZPB?GF,9=
JLUTdL0OK=M?H59:;9MPNQV@&.L#BJ]T)Vf/O[,\]FKS^<[bH]7CE38WJ9RSSaH4
[0;A&)HeVY+>CE=d/3:#cO+OBNcN@U@VHb+/NgFJ1aa[aWAMGFP1d<V(59HVZB;B
cE,IZ]&7YH0Ef\IGI&H/5D_UMNZ#6B=3US-Z.UdE(Z6)=,I_b>.L@U&N114-AgFL
M#>Kd:7,0dRK8K(AB]9CFRa21Ad#CIR/HPC3Q)dX0#]+H\TMR/3d.?K]QAPI7OS]
?IU(Y@J02A.Q.W@HE6K=@J71L^U8>2+Z\_V+,E>7S#?D@Y^4B\#GM,7F<6OP38<P
R<H=)T=E+SEQeTa1<4VU=.XZ=e[a,)7:BfdUB2EWI5.E[^^AFJB+<g1]WZ7eH-0P
<14ad\TA<O54b8&T>0F8MLS^c_SU,72N?4B4:#bZC^-bOT2):9OS5f&9J^.S(fR;
3aA0&4MHT>1F/[4cQ[b[[dAC0<6ZL+U(f)Ic2,:LQeM65_4cYQ(GRHYB1MI:PSPY
fF,K#:QCeVXEEZ-&g3]190L>b?Q[1H]\8?BJ5W/\<L3We7=BEK<WGN-V];/;JV9]
)A@T?/3gE&0W,<<\9=N2@N_EdY]1?V(8,IW\BDOV4^),RO^43L.-;4_<VSS/NY&&
C;T[06#:a_<:b98T<8EBUUEPO5c:1PJ?fIIXFDY1g)O(YB<b^]G92S>/bg]R3,Y2
#R:Y3;326?V:0,-3^4PJB/<<P861Y#N4&HE[1eX;;a#PN4K)1U#F?eG4^-C+MSQQ
YR->34AR6bM8eF>ML[a2bE\2IK1:I2J,4.#@Z3Kd0=@7M(D:NG4&64W8bF:>HV7&
OT@3f/^A0b3aY2TC[?S,FU7H8?-ZUaHDZ1A&6&a_O]SJ2YX1ZJZPTUM.d&D:S2=N
N=)I?JD#YDS^]B]NL@05Bd->O;6-F#G/@1<D.Ke+Ec1U)M+K-gURX5cKRGV<OR;R
Y4:(VR191WB5f-YA3V.aGYb>e?/31>dU25f.Z;-fMQB_55VD5cLMcS+5>TB@VL-S
R/[?VB\a],a9/ES>9AQ__5cg\WMC=CG4YF+)KeFC@Hd.R\LJ;+6#TMR8DF.>fH1E
R#AX._f^)(8aJ0;CBC:K72G(fHDZT(>Te2g,0T@/Q8T^/)HL0V>\gA:[J<QgbUS2
JW=RH)MO]ZFF5PNJYIJ7B0^)16.2Y^QYTV.b6LCNRE;ac&P4I<?-BW\>A?,8SaQ(
d.H<d[WBHfP2WELbEZF)_BI?aW3P12f^PCfZ\eTK:Z4QBA>DbYBbJVM)-0>90FY)
ITR+GAdYF:>S+_STTZ/9_PgU1MY?6TL)>IfO\#SaOB.&.C_?A4)>TNcOBC_eAI0_
;be\M+<F>MJ7(EDc/TW#-d21/GXP6HW,-HQ(&6b-3:9X/_.2=HK&XKWF+c2]X_#:
Y6.;2(CRSfM-;Q<cG#SWP8c8&[)XSaa/DP,a8&JJX^JJO;J9H=U8/[-7b5NE64NS
&4VN+)=8b/(&2)H#&TVUPgc83$
`endprotected

`endif // GUARD_SVT_AXI_LP_PORT_MONITOR_SV
