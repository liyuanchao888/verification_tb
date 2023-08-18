
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV

`include "svt_ahb_defines.svi"


// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_ahb_slave_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_ahb_slave_configuration handle as an argument, which is used
 * for shaping the coverage.
 */
class svt_ahb_slave_monitor_def_cov_data_callback extends svt_ahb_slave_monitor_callback;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Configuration object for shaping the coverage. */
  svt_ahb_slave_configuration cfg;

  /** Virtual interface to use */
  typedef virtual svt_ahb_slave_if.svt_ahb_monitor_modport AHB_SLAVE_IF_MP;
  protected AHB_SLAVE_IF_MP ahb_monitor_mp;

  /** Event used to trigger the covergroups for sampling. */
  event cov_sample_event;

  /** Event used to trigger covergroup trans_ahb_hready_in_when_hsel_high. */
  event cov_hready_in_sample_event;


  /** Event used to trigger response for the first beat of transaction. */
  event cov_first_beat_sample_response_event;

  /** Event used to sample response */
  event cov_hresp_sample_event;

  /** Event used to trigger response transistion between two different transactions. */
  event cov_diff_xact_ahb_full_event;

  /** Event used to trigger the trans_cross_ahb_num_busy_cycles covergroup. */
  event cov_num_busy_cycles_sample_event;

  /** Event used to trigger the trans_cross_ahb_num_wait_cycles covergroup. */
  event cov_num_wait_cycles_sample_event;

  /** Event used to trigger trans_cross_ahb_hburst_hresp covergroup. */
  event cov_sample_response_event;

  /** Event used to trigger trans_ahb_htrans_transition_write_xact covergroup. */
  event cov_htrans_transition_write_xact_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_write_xact_hready covergroup. */
  event cov_htrans_transition_write_xact_hready_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_read_xact covergroup. */
  event cov_htrans_transition_read_xact_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_read_xact_hready covergroup. */
  event cov_htrans_transition_read_xact_hready_sample_event;

  /** Event used to trigger trans_ahb_hburst_transition covergroup. */
  event cov_hburst_transition_sample_event;

  /** Event used to trigger trans_cross_ahb_htrans_xact covergroup. */
  event cov_cross_htrans_xact_sample_event;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Coverpoint variable used to hold the received transaction through observed_port_cov callback method. */
  protected svt_ahb_transaction cov_xact;

  /** Coverpoint variable used to hold number of busy cycles per beat of
   * a transaction. */
  protected int cov_num_busy_cycles_per_beat;

  /** Coverpoint variable used to hold number of wait cycles per beat of
   * a transaction. */
  protected int cov_num_wait_cycles_per_beat;

  /** Coverpoint variable used to hold response per beat of a transaction. */
  protected svt_ahb_transaction::response_type_enum cov_response_type;

  /** Coverpoint variable to sample hresp transistion type for beats proceeding. */
  protected svt_ahb_transaction :: response_type_enum cov_hresp_transistion_type;

  /** Temporary variable used to hold address pertaining to last beat of a transaction */
  protected bit[1023:0]  addr_last;
 
  /** Coverpoint variable used to hold htrans type of a write transaction.  */
  protected logic [2:0] cov_htrans_transition_write_xact = 3'bxxx;

  /** Coverpoint variable used to hold htrans type of a write transaction when hready is high.  */
  protected logic [2:0] cov_htrans_transition_write_xact_hready = 3'bxxx;

  /** Coverpoint variable used to hold htrans type of a read transaction.  */
  protected logic [2:0] cov_htrans_transition_read_xact = 3'bxxx;
  
  /** Coverpoint variable used to hold htrans type of a read transaction when hready is high.  */
  protected logic [2:0] cov_htrans_transition_read_xact_hready = 3'bxxx;

  /** Coverpoint variable used to hold burst type of a transaction.  */
  protected logic [3:0] cov_hburst_transition_type = 4'bxxxx;

  /** Coverpoint variable used to hold hmaster selectted for a transaction.  */
  protected int cov_hmaster;
 
  /** Coverpoint variable used to hold hready when a slave is selected.   */
  protected int cov_hready_in;

  /** Coverpoint variable used to hold trans_type per beat of a transaction. */
  protected svt_ahb_transaction::trans_type_enum cov_htrans_type;

  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new svt_ahb_slave_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the AHB Slave Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg);
`else
  extern function new(svt_ahb_slave_configuration cfg = null, string name = "svt_ahb_slave_monitor_def_cov_data_callback");
`endif

  //----------------------------------------------------------------------------
  /**
   * Callback issued when a Port Activity Transaction is ready at the monitor.
   * The coverage needs to extend this method as we want to get the details of
   * the transaction, at the end of the transaction.
   *
   * @param monitor A reference to the AHB Monitor instance that
   * issued this callback.
   *
   * @param xact A reference to the svt_ahb_slave_transaction.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void observed_port_cov(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.  
   * 
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------
  extern virtual function void beat_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is sent by the master.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void beat_started(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------

  /**
   * Called to sample hready_in signal when hsel is high.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void hready_in_sampled(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction is ended.  
   * 
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void transaction_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  
endclass

`protected
T^VJG&C[/e#ab_@[Q.7E,9CfI3A(.a^BNZfHdA25US,SUL8@N6,I-)::7+?I>GPc
V=^9/NL]&+DBf/./;?0K5Oe1+\NURAV^)R;@+K&/&K9Q#d:fYB)2Qc_&]<f2W@U8
f@gF4+DcN^V3:2;P3RIB^Eb0WfF](M/2C;058VdCF@4AKAVbdDd.[BLM;f:9eMHa
MWR8)@5,8b,CGDY9+MQDgE?OY7M#Wd\::O(4X4&7cgLI0dJ/GR4_K\>L,04_+H]4
6T9.6C5):#;YEZa,[4+D^IEQP4;49QY&eHC-YS.a6&L)(M7D1P;@bE#_4)fXMJ4)
f(066,)SW66XE:_^QW]0UI(g.>([9Y;.KE]#4R[SGfG:])GDP&;gc/Q),e-Z\77,
8GO<+?D64Sa2c-[SC^Fg+XP/I64LYf3:=7VTeI\IWH,Z:=>+?d1+?db4&)=@^I9J
QC2&:V(])c.bfK5E<0\c#2Z1[e=J</)[5GBA+6YMTJBU\<Yb8]aCHDF-93^4;6Z0
AEdf,NKX4L/YAeT2Q/HL33K/3?D-NF./?A/F41DcJ-_>ZQ^:#B<?2T7)SW7^^T3Y
gD_3V.eV3HXd6LGDK=5eJ>;4d44XNLX>Y&QXD7<dV?2g4/S3+_D=B8Nd4WE]\3;D
ND00#dIW0[/2I4:[+4SU/@g@cX;JMY?FPcSaZKUEAfK^7TN0gg)8P9EBN1HZFO7\
ZUGE5e^OF8]#F/)HCWVecOG,<Z-Z5[^EOR-(5<[?2AO5BR988#_W\R[JP,/^0[LT
80gR6Z2Ob^J>eU13#[T@P3gI639<a9UOJBac&]]^=ZQ0BEMgAC^^(QeT2O]T++65
X4(^@_fU5L^-(0C-4Ga+SG18NV6X:FNRBT+^J2+U(?>&4G6]JKX+&2bVYRF)2?WY
#IN&=W=c9.Te75FN<AY59R];b87>6P.6Z.Wc[8[+?6KSCP#H.FFI##cZC+,>D493
C,b.gfSBV5-JV<\U_WZXAef[H+<=T&&=bXgY[KPfB=8^E45F_f.NP.^2??b49TDg
\JBNFeFR?Z:>O<,=MF9B&^RMaH/90R^()E^aWB/:&BDI7T(^P/+Z(.R9.e\F]XM+
.(CbG9F=;\bK\#bb1\:ZQWU/J&0gY1>V5#-#I/e3P&#0\5D.Lb3SV\@MB::0]#PL
d5U_?R/XLCEZALKOET^-Nc)]E.(0&RHb=?KBB5:F_XT=E:\V==^X3++K_D5GU+GI
X>F@^X<Z15caTN:1;-7W>H]cS3ML8AgCN6beOCKS,5\/+.^]M/_XX<+/C.P2V.S)
gCG1^0E0^KD_XNF,=)2/BM:cD5N\Vd>XH5CU4]K/aOC?XdV.VXK.[V6\^I.O:2;T
A/gO.(B4MOe;\^.>P#N7c>S2.I2G[<bZ4FZAG;)GYSb;f2<SH4K:\UCX/Q..]?OG
XG_17(N#a.ZG,1B-_aQWg&A&#6MSR-WI_cB8QY,Ye+::^De?d[YY;4@\aANG;g@g
2-GS@AMV;;Hb=F7RS;^eP+2RI]2),10]0D6TB-2I3\],>F57,FVdcDeD4A#<c2P)
),2M9.2R1=#DG]0N=06KX\\JT<=LGGE^<GZ_(:R0QXQ^fH/1<f=(5d.0F<>>-9d;
I,&KaKP(6b78QdDZPAS:efcPI^.,O^DQOd2Y,-.CQ59)[fU_b^ZSN^T@17Y)C-_]
V\aRSGAD&dYIGB8P/W><RJ=F3W]:<CEM85ROC[G22=Xa3ec]TGLB\PR5REcS6Sg8
#W.EYZ>I_Ab7WJW=eCFU3BYOPUR>/#[D&G:3U>():EQOKOUD2[C&bZ;NF4cKO,GU
UFO)QWVZW;8QH[5[.H7OO<DFTEBM6b,)LdGe1LHN4MX3LN&.aP&_JR@Z9T4Y3EN]
>9-VcBO&;Bf44f-#CUd\K(@+2DIbPMaP5T=:AD\^?eaT/@ADBM-FG;AKa[P5YWP_
B:WC=7Pc95CC):R8W9gId5>7@@Bc3XU[9YJ-^2.G:F;-NXGJ.G)7LX_]9&RY<8+C
:OaVC@geMb(:(IO6YJX.)LA+bC;QF6_(BB:?YB.;P0J0M.d:a@/UYeZ+6]X=/R^R
S#)]L)D2/CG8J0;>877d=1K;62UWaOD775Y49;eD(F)G?IL8PcZE,VfJ66UQWU/<
\+I3\H4>E-&P7N,9<7F1<ca?,=1c3BV-H=B)JOe?+4K)Ng.AI5Q;g,_4O_:UC,]f
&fa4QgT\N\ebPQ.=gV[#0#K3EY?gC5A-;L>=Z1fRN:41?7CVM?U1XRZ;2_2c)5__
[O)]F\).bee_\_GY8I4;/Q29Z<bfg8F8_-&2+Sd:2+bFK3J_Y_9e3X@4dLce\C^c
S:@)BN0bdP@?;P9f,84KVLAHg6YA&^+Af3fcYRK@;CD(0)B]bODdT8UAA7N@830Q
/]#DR[6@UN7DNY66>0#=^R>>]DW1Zd;#e1AH2R^8d_Tfe5-]L9YdQQ:A4Q3AVI>4
?f+db<c^XP3g/<3&g;=I,2EE>BX+))1GGOFI#La,EN=X>g,b2Fb>@H?a,Y[86.\(
,9C#@26ON\KDCF&gDf<\a7RBY6I.DcB=Y(<1)Pf;J;QVc0g@AdJgHI>KgZV&I]HY
=#YITH=UNV,NcbfOZ8a9_LT<DZ<BT-aZ0FgRd,-H<,G;M(?)&Se+(#Y0<#4:\=N(
:A.YW>JdfXd-,&G-B\)DB(?@\^#?]c27R[21XC;cBKNb&4TgD9<,_31&Y9IVRGD?
9L.a00;Q0QRgG2gXg83Pb=/Kd->He7XD5M?U4,<CMB/@67KSF10,dV0aN+4)5+^:
ZB^G2@G,][_Z8OG,A?7ZZ]CMC^W5&I5\E>3H7JddgO]b8G,=TZ.6XUQQLV(T]X/<
b0RWQ9eH5W?)NgJ//D2RXAb5T1R)2#Vc+XXK_dDX8<7)J:;T4b<[&Jd#=52_ee_N
QgNHL/XZW>#D+<+a(L>8SG@dVF:YC]T2E5Rg(e_gc:9f_HR]aT^OH+V2F/3ZJ3Qd
3E&+K]]].\;5FUR58cWXH[J6DAfM^E94P1Cc,J\;@=b;aTDT_H.O1R/<7:0)[-&N
)]c+M\L0:+b8]_2fTA9X?.R[a2:cZDWgH4d.f5HH\806H/_,<ECce,84_82N7T5-
TP3#\P/EY9/ZZK=CPPG?_ODb\4Ia9Y34RV#&MDLHXZ4)1S1Hd8R8@PBYYDRHZdFL
+fJSB480BbAH#,9X;N^dWdL+&@:fSgddaXAAL[-+dM\GL/YH8@_)(&C-2JW,UH<Y
,GKVgK0V<GVVW0+9O/S1P^&88^GG.1\?dK3_A60(B\&NC6ag/\70F-bMf@Bc89e_
,?=ZU;c;DO@V=IT\2+S=^BR\0(2L7eHUT0M6#B>GM#;3a_D4\&;OHTA2M[eZf^c(
_NQ5]+_[GC<YYU3&g_Abe+YO0D8@Fb_@@51gUFQMI]VLCbH.(KF+G7=MR:bBBUaB
,dK(DFUF/PeR93cL4WWX]PgTN:,fJ>_5+5gNVd/6f54fQc2AHL-?SS8#<B@UV;_L
=;+@5AMDCeR#IfVEBTT^.YW+b/.I>G-UO7EJdD)#6W:5VK[?M0LT899,)3DHQ1>W
?FFb)Y2Ed_T_04T8(?>\122NA76E:g&:68Tf8PWa(T&BNLEEII-N>e@R3fM8\(@;
G>W0W>[DHVGQ]b.TJF.Q9-gZ7e=NA:&VCY,&>-^KONG[)J,e>:(:(66:-9]76gc^
W\afV4dSG.,]-+X7D@20]\HD<?a7c)+\B^EQ<;)JadMf-0#=b.g:?e[BWd7<5WUO
0e&+GQ^KMfKJ+f2=M[FgUcdQ@SQ\&4,X,HQ+^JNB+#\&>S5LQe\V,<8QMZBNdM-e
@^8[5N2a@0X&>@Q@XG0V(_Qa:f556H)_6@OM<&-TRLOFY,/6LUF3ZG)NP/=g0cB7
;E<4DREe[ce2-0H[IERW25[-9g&e6>XOJ^4Y\=FLDVe/C,_S2Hb1(=6OPcHK)8LD
2=VQ/3S)8@BPdS8/[f[5)ROf<<aH),9Wa_gK5TD1R=3:CS(WaH2K76,?e<e_^U=+
Ua@@Ga55J,7-0\_]JQRO<4.DM_SCNMdQOcWM[ZRK>d5.IVbFM1a\2U_eQ[.0^;C;
WH#G+LZFK\Y&#-]K1J-?JQ0d10.0VWR<TD/\&[]ac^S+1bHE69<ZGIed]J[81KRb
=.,#_;Hd4&W6<+><bH55gCF<&N?1CN>I+TgOB5gd1e;[V>BE>XYQ;DC]M^NG=9+;
a&IUbR#/K7A6NaPHX?SR,BUgNK\2<OS@\(8<V<bZf]:L_X2SWf4@,,(P<NdEd&65
.BBO,FFI[4&]gFeLPe0A^)8He,-R>+GIAcAR\GA[7VN@gAY;;;9,6LeHM#cUSAeX
(G-?C4K7dfEM9a;(/N8b<bWGWf_b)c3QI(1&g>LONR>\9e2W(a6L2aE4b/XgX&+8
K6:bdWUO8@^2.&-A<W#/5c(Z3=AT(KKY:_[35\+3cCEC[SLY]&D;V]F=>T-eK[:K
V-CU@8.OAVDKD\Me7=@Ha;IMBJ0A^aA3WHPZ8Rc5+Y-6;ge-H@\V.2+4G32K2K=f
O@96ESK.NW8#WWeTFOM[@LC)41H+7WX^#8I&Nf@>E9J(1^dZNLgMKK-+U54)8cc<
WWJJ2>9A8C@ed=#>N(9AQQ241ZJRJ((#BdAa.f&;):H.^,,?_CXV0:gE\6C/N]UL
;6EQ#>JSEQ:@J<B>,XC)c/I,DW?FSCN#.@9a+>\?7UaXF1_d9?_?AO/TT/A/c)]B
g7OSKE\CWH]QSZT8VF[PI,+5_GAJ+6f-4O/=QaOUJZNM&U4cL.?6KfC>EK+#I]O6
N6=1@(2S1=e8FbPKgMTK4]+bAH&)H\#I=.KF>^B-gGcD(DG+ZI&S82TY-5BSD_&M
]d025WH+GRYE;NdD6@N,7.-@AHIc6D2.XZE.6YA&fD_O=&-A?)Eg?62E-<W>.Q_]
[>@NI:;GS/=2X25f.HO6f6=2:Y<I#+d&VUgN-ADfR0e(+[B^[.LP2=&5a:Rc(:=L
X?S?TETa=V>4?\cMYC#bL2.E?XO5JL,&<7G([FY]^?;?BZGHZ>VOJ-Q_Mf1(_W=<
OLU65C6@K=_7,MGQSTG&.VR-^ZS,BTDP&XW?cGV@2=<ANGN_LdCH?:TGec1_>e&A
XH[YICVOea3Yf1KFXF</_8(\O(Q?RP7L6R&RAAUHX,7Ree9NFgc.K#9gB[5)5OJe
/>\e5[B+8=#9@bNON?OfL[d_82T<<V:Y#Z5-)8,D.Bf]YL#<TB2WDM4#1#EUXcIQ
>E^^MJ3GOdQ(&0+9T_He8JNRD]NRYY>eFHLT3.IE/LY^K<IMA6>1]>4R/<7+C8N=
QGQ^^)C6ZN0RU-LC/f8cN5YXgO:dK?/T?C:UZ?KNd-Tf>&@;(VXUE[7XF)F\PgIA
E#VEa+CDWK:8f?TTDVF2Z#Xg(L2Vf>&TW0c;7_M0AZ3MMae)9)>7J85(U3NCM>c1
:5YA^#:]:UBW-71QN:#UD9Sb:dO[5Ya3^=5a=fYUb-cc/#Qd->e.]6gSV0TE3.&]
b?-^2Y102XLf7J,AJ0.VPR6NW2<4a^_3aRI\c-+7>fNZ8gP#aAUU8N\(d:EO(W&/
-[S6O(4:eY31,97&AR2N-MbPL8e],.<a6W(<H:.EN,^JV[5WRWCbQU8g(,,@C-eE
/RF+]:KR3aCSdPSD8I=bR#KK(1/],E]VAPE/;H#G-CXb=LXSQ)&1QQ,_gZ.<6[BS
532:#Q#g0=#2I390PW9F74RCL40>XD9W:6,][YV)4J+7&)FB+fDg>4[:9V:W)Q,@
<eI\+^0bT6EeSZT_aKBCK#X-\6,Wf=cd&A=017[VTN(S)#6L=4PN)7^DB_ZRF5^Z
QN,bTbA)BH->c48G((TS-=\)=@LB&:TS].ObHW>a5@B^VaA78Qg(]UQf+M]C5gD@
&D>2<egUOI905>XMI[ZOG:N,c-K?][c<?UN9<6:gC27dB^Z2bDd/)8/bV:7-f?^>
X@<9O[_3e]W<3Q+D[f?F#,Qg)_bXX-b.?^S2MUNQ)a0-,&N4^6=d2EfKaO-#[O#Y
QM=P^O?ZQ>-&C9a&N\UL5>,0HQ?@[5UgEP2F-TG=.V/ET4eL;Z5#FCFR0QgX<<FJ
>f3/0FJ8G5[E1[QC2d8LNPA=O4SVU_<C&GG8bb<D(Q#UJV2ZT>8RY5>Y.)[g+\]<
6V]Ve2+>KX(7SB#,@(05g&\aOa/4RPX@=KbU7\Oc=OMOb_1?5K)JWe)#-KK>3K2d
9(;3E2Va96?35\+?g+YHA[P?Q(-N0_#3S76f.E^-5MDB9/CBB0^;gQbG,WEg6A=W
-Q5P5=<4f(YV[:X/BfX^S]aB8J,Nc5g//(QUH<6S+J1_W5P0@:a:&.2VJ9-6eW.:
7AHWUb?<N>A0[Q)X&gV/FXP9Z/3]2:F-&NUCOD.a&WNSS9g<@,\32BT<#Y;AIL45
-HO\Sd:E#KGUV+UW&ZF[HNSSJ2F;SUYS<J?3=a<2QaI^#Bb:QB8VZ@=L@+B_@.P_
D?]6P7I67Q]V2:9V3V=I<D+BKH<5-W=<AcGWOeeZJO/FX=O_):DBB0cD9cKD6)2Z
[CJS?R?FW2LJ.OD@A4gBfTWQFOL;db];:VJV&dOHD=-TAf?cRR:9f7DXB2J#I);W
adLeK/NX.WEXUN^&C-#VKSN1,a+Z>I-gKV/M2O=M)9#MN=SPM,GO6>UL]9G28R#A
(TU4TB?N5M+4+L.@7;^K-:^E3@Y8KN2X7H5YCO\=9HH1<.6e>5Ye,6-^:<,ZB<LP
<0.=LO#YD>D?ge:Z8)5DYDMgd3+Q[Nd\5)bV?/3R.C2J7E8EK7,cZSJJ(0^H,>T8
SRPf+JIE.[V7(R-&/2c=+O]L7]@#.a;:W<I&JR.<:?W87Hc5g[YAf>73?WFE<7=0
+/M<dGC;Z_1:S]G]bT&]ZCX2=+3PM6([LLIKe1\OQ[YCK-a;g[FdTZ)NWV_&5:(F
PVJ2fNP=GW#^<A,5HZ(g\a1GN,?dD&?>dLbPcG=9O/Ge371P;\:@D<.WUFgO6LbS
ZU54VZ:NP_U#=,Y=]Z1#bW<5RdRc;ANDf8ZI[2GabDI2D0fL4Tg&#YP0McRVRb_g
E#]H>#HUH-PX(L()1@UB-\RMNJ_b6a_#Bc1#2S(7UbQW),R9T=b[E()aOJNWC1T0
9FF;AB^A6T9CK(LDE=J2-<E]1H2)\<6>-^.SfW.>J+2b[&X8\<E_H[aFDAJ.g4de
);ZbFcAJM<DAO8XN>PK+g>?a5@C[X.36gO=-BM=fd^64>AY_TGcZ?I6AEXe?5=&/
TIS.8ALA\2c.QX7.)DW/_#,,W^(B-;Tfb:VM8ZEJA9&..9ZM1+PV_HTATHQP-^T\
bSQF<.O>M1f1]A1(G/&5Z(_;:edA]bJ<,LBKB:f7^bNJ+@fa0ZQ,a]NQ?G,.0#6+
d<^eZdW8Q\U],IH?\eL4,&814\091])IP&(T+V.M>)QT;/RRe(B\XY=UL];:,3+<
?C?]C=P1G^XUS_];FPS;1KO,eeR((O)=QVLS-7C#/_Q_65#06fA5^@Ug;c5b.#>0
9RXS7QF?#Ng_P1G#&85Uc&eUS#N\U;=4P@+gCD;VF/W#e1B:3((.TI5)4SY=Z#OO
VRXO.<\)eg#b:_POaI25)RL(-/XAELb@g+IW.dT[O1.A9g[6]^\30X7^R#NBD(1X
@QMY/0<6X?dYP]+\gY7A1F5/TVH1OJ8V;.WX4T.^a2MK9ZRVZdK0=G?AV34gHP,:
f4cYQ1:44^C(0a6+1=EVQCLe55,9VTU\<ZOY(9^LEU+-8Eg15bLK[;3A1EQ@[5>K
-Sf98^)1&6#TW?Y10V,SN3e&-aVV-83,ECU5&+-S@RV@R9ZWQOQBd/bXHH1UT-;S
9Q>d1[K6X#Y<Ab2.#f<X9IY0)M:PB/J&N1L.PH]X_=WMQ8]L-5@T>BIM-J&),+#H
01D^TfMQ)ZeM@\@^6Nd+M1;25)3^-fRN#20gHFN(#,>UEKHD[W13O&BI<#X):R&C
CS/N^<g\62F?X&G+6G^=3=#gUZa,XZ6J-SKCC><XQ04caDHcJ1&J4>M?)1E1#^gC
cN?99T:gOB>]1Lb,f2<XQg0;Lb:V,,g8X2fGPG#P9<;^?8I[;=PfCF_TMCKf4]1P
TOK2DT:^MM0,\a87[0aWZJZNIca[\-\<K<QA8fM3GaC4@=MCXSQ56U93T;#]J^O8
RVc5eB+^J4ZFFDda1IZ0#?,W>=g?C]f_)HeQQ)WI4/(SZES1[PdfKa3(g\ZJU=]F
+6/V8?GP<]X^;4a#Tg7,Qfbc6P9FE5[KfVN0R@6_)81BSX.4Xba,])]MD.DO;TVO
0Z_;\8aJeFDA&c1]DT=:-&.@0Y1+SQaP@6[,#3\X(Z^0Ac82ARFI.FR>Be\fSN6R
D]&fR2VZJedEYB[]YPRDJ&W4+8XH<DSeE5bQBB1KK_)X-#5G@SOb^BRc,>0SGQMG
O39B.b5_O)7:JGdH]c[\>:+.>ALN1]F>fZcW<B)ULaX<>Y3Q@L=HGZ3:5bb;P[RX
-O3P2FE0>)gHML,K82+0^=P7L2@Q90=a8R5J\(A./\>=fEOJ?Bcc\[OU5#c-N:=>
DF#Q_\W\&HVY)4/@@gG(3B;?0?(ca@MLIT#BGJDX,XZT#.\B#VeO-3M0d2_5D9+F
9Y[&<\M,+.>?Ic;IXRF1V>AfN0,K7>?4KS<;4,aL6Z)<-a2N&H8O,K/6O5FS:\2J
2,3KMdXJJ1J0+@1]^33@adIRLdERI3;<7\[8/f_)&O[a]7KZ5JS<OH]HPE_=fAb.
)ZKJNQB89>M.==SHU7d3b=2)_a9LgO0;5E1G(;dI\IbP^_(?S1J\54)EYGRB1,fe
#R+@#Q^GX[#UHBZ6A,K>B-EHOF7/Y,e(Z)M]#(8Bd5\dE&b>B(0E<1dX1R?f:>A[
DWaVY-\]2QFZMZFK,L\(bM6GW,<bU<]]&OT+I1UOO3-+E&RY,K:Sb^b.7_/P\aOT
D\N1J.?DTg;=L>8LQ>TX=.[GW)[N4]S9\]CK[B_1W=PM^E7?W/0EUa-^:;2f=#ZR
g:MNc<I[-dN^A+f.d\P_](E78CcgF6Z:=CCcFD<I,/LAb-\ad24)DKQHR&8E@5D7
[fIIMR\Qe[+4Ac1&/]K1<Hg3fU/MgJ[eOHLU,RJG:KS^?I-N\&8^6MEa7ATS,-dG
bF5bM2fK64.If-a8O_;[Z[b21EO64)(aUdE=g]1^.])d1b8LA7MPE]C^PH^@CU14
T_PHS)R<F48))^a\?-L7[A<Ig1:W7bV[cW04A],106Ggffa=74d:2<cZYEO\B6MM
#Y<TANFH>QLKAIRRQ+4C/GRX0Z?PF[(7Le@@S)^1TIe9Fe^^Z6b:+YJNTH4B,N@B
MUCe/]Rd:c8cHB/LS7K#Q?&8-K?^\7A:(/e]1f&\L0>>7WZYAP]>RTL=(.UfP9]C
V8>/X1V?+E?5^UB9-RV[b,00<NCY:+,cfOW093=?KcdFW9C6@\336VK[:NTG^>9.
B:2]3<>,=]Y19d7(P3WMQ_gC]LM#K0=:Og+Q1W64#YF]EBN4>MeA,G@/BOX_TU(X
>_VUX/Y:I_c?>D69a[/B(ObNXBcEL39DLS#6FER1:#@9dIHF@US.NQg&_#JNM.U6
aQ@EM5U-1Y\3+557d)MOg<62,+(FMN/C9TU6-8FFPGCc&JIQ1#.L/FNeF8IW8851
XA=YDI1VY3EV6UXFJ1e@&,P>#N,-g8^bFX_Dff_-_g_GE>=,(D\CF_WW8.G]BXT2
9B/[UH.59gB1W;<Z;:41R.D;(OR;>GNT)/:M[OAEF.\f&HD3a&=_;P2Acb@YbFVB
P^GSJ:X5_8BT-8#L:/V>+@@LSQf0,U7ST17Z]L@6IC+V6f_4_9W@H[,K\#_7eXUL
]W4WDfSg:1e/cfAD0)^#A5U57A0DMF]@=SQ)X-f5Va&&]W1_;+3fYZA<cLF__0?O
/_V=/7gP^(\<B>0gR<&N=PB7bH8<28f]]S8PB<KD2LFYPHF8+d,/-/1UI84M1CLU
AS3M@G>WgQ?.9cP7U6S<2TK.&JQ;N.<)cH_2N<)^G2XdOI15:8[F<?<J-K)Ge?Cg
?aUQ+REaES+I>GR;P(,VcP<:3>;#a8f]R=aa\(CU+Xc2(L_g,8T6^.UHT=bFK3I7
4\\Pc:ZF2;J@DK6<X7^O1WT<NYE1N:23^9OF,b^Y3]#J/HH<cgEAc6W9]_K<fY7\
773\S+Q+W^4g&-f;VE2Oe@9F1QQC3W,Tf0c\C+_A]U3?S=ZEAC;b&UFBV5,,ME51
K]]6F.K[XKOd)GO[<RYK;4LC7b-cd02X+:VA^:3UWK5O?MP1HV1K+Q&da8HWRS\Z
(F>:g)=4(fBSC\.87^5AUFGOgeKVPBM6V2LLTR-;X6X)OP]0D;+A^OCJU[PEgLI?
b;XXUI^NZ34^^B<1[eYK,G2]0OHJI8#\ZN36Je\NHBX)H$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV

