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

`ifndef GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV
`define GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV

/** @cond PRIVATE */

// =============================================================================
/**
 * Class that accomplishes the bulk of the RX processing for the CHI Protocol layer.
 * It implements the receive logic common to both active and passive modes, and it
 * contains the API needed for the transmit side that is common to both active and 
 * passive modes.
 */
class svt_chi_rn_protocol_common extends svt_chi_protocol_common;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  /** Typedefs for CHI Protocol signal interfaces */
`ifndef __SVDOC__
  typedef virtual svt_chi_rn_if svt_chi_rn_vif;
`endif

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /**
   * Associated component providing direct access when necessary.
   */
`ifdef SVT_VMM_TECHNOLOGY
  protected svt_xactor rn_proto;
`else
  protected `SVT_XVM(component) rn_proto;
`endif

  /**
   * Callback execution class supporting driver callbacks.
   */
  svt_chi_rn_protocol_cb_exec_common drv_cb_exec;

  /**
   * Next TX observed CHI RN Protocol Transaction. 
   * Updated by the driver in active mode OR the monitor in passive mode
   */
  protected svt_chi_rn_transaction tx_observed_xact = null;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /**
   * Next RX output CHI RN Protocol Transaction.
   */
  local svt_chi_rn_transaction rx_out_xact = null;

  /**
   * Next RX observed CHI RN Protocol Transaction.
   */
  local svt_chi_rn_transaction rx_observed_xact = null;

`ifdef SVT_VMM_TECHNOLOGY
  /** Factory used to create incoming CHI RN Protocol Transaction instances. */
  local svt_chi_rn_transaction xact_factory;

  /** Factory used to create incoming CHI RN Snoop Protocol Transaction instances. */
  local svt_chi_rn_snoop_transaction snp_xact_factory;
`endif

  protected event is_sampled;

  //----------------------------------------------------------------------------
  // Public Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param rn_proto Component used for accessing its internal vmm_log messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, svt_xactor rn_proto);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param cfg handle of svt_chi_node_configuration type and used to set (copy data into) cfg.
   * @param rn_proto Component used for accessing its internal `SVT_XVM(reporter) messaging utility
   */
  extern function new(svt_chi_node_configuration cfg, `SVT_XVM(component) rn_proto);
`endif

  //----------------------------------------------------------------------------
  /** This method initiates the RN CHI Protocol Transaction recognition. */
  extern virtual task start();

  //----------------------------------------------------------------------------
  /** Used to determine the extended object is a driver or a monitor. */
  extern virtual function bit is_active();
    
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** Set the local CHI Protocol Transaction factory */
  extern function void set_xact_factory(svt_chi_rn_transaction f);
  extern function void set_snp_xact_factory(svt_chi_rn_snoop_transaction f);
`endif
    
  //----------------------------------------------------------------------------
  /** Create a CHI RN Protocol Transaction object */
  extern function svt_chi_rn_transaction create_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_transaction proxy_create_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI RN Protocol Transaction object */
  extern function svt_chi_rn_snoop_transaction create_snp_transaction();
  //----------------------------------------------------------------------------
  /** Create a CHI Protocol Transaction object */
  extern virtual function svt_chi_snoop_transaction proxy_create_snp_transaction();
  //----------------------------------------------------------------------------
  /** Retrieve the RX outgoing CHI Protocol Transaction. */
  extern virtual task get_rx_out_xact(ref svt_chi_rn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the RX observed CHI Protocol Transaction. */
  extern virtual task get_rx_observed_xact(ref svt_chi_rn_transaction xact);

  //----------------------------------------------------------------------------
  /** Retrieve the TX observed CHI Protocol Transaction. */
  extern virtual task get_tx_observed_xact(ref svt_chi_rn_transaction xact);
  
  /** This method waits for a clock */
  extern virtual task advance_clock();

  //----------------------------------------------------------------------------
  // Local Methods
  //----------------------------------------------------------------------------

     /** Pre process transaction before adding to active queue */
  extern virtual task add_to_rn_active_pre_process(svt_chi_transaction xact);
  //----------------------------------------------------------------------------

  /** Adds READs and WRITEs to separate buffers if separate outstanding
    * for READs and WRITEs are set
    */
  extern virtual task add_to_rn_buffer(svt_chi_transaction xact);
  //----------------------------------------------------------------------------

  /** Loads transactions from read and write buffer and calls add_to_rn_active_pre_process */
  extern virtual task load_active_from_rn_buffer();
  //----------------------------------------------------------------------------
  
  /** Method that invokes the transaction_started cb_exec method */
  extern virtual task invoke_transaction_started_cb_exec(svt_chi_common_transaction xact);

  /** Method that invokes the transaction_ended cb_exec method */
  extern virtual task invoke_transaction_ended_cb_exec(svt_chi_common_transaction xact);

  /** Drives debug ports */
  extern virtual task drive_debug_port(svt_chi_common_transaction xact, string vc_id);

  /** Triggers is_sampled event */
  extern virtual task sample();

  /** Accept a TxRx Transaction and send it to the bus. */
  extern virtual task send_transaction(svt_chi_transaction in_xact);

  /** Updates the cache based on the snoop transaction received */
  extern virtual task post_snoop_cache_update(svt_chi_rn_snoop_transaction snoop_xact);

  /** Adds a snoop transaction to the active queue */
  extern virtual task add_to_rn_snp_active(svt_chi_rn_snoop_transaction snp_xact);

  /** Waits for a snoop transaction to be available in the snp_req_resp_mailbox */
  extern virtual task wait_for_snp_req(output svt_chi_rn_snoop_transaction snp_xact);

endclass

// =============================================================================
`protected
[75VO<K8^Q?_@=KL+O9P?N8X=X.,d)BKgM\4.,g<gE4YLIB;Y_NF-)JbbG13=0VB
g6DC1#X(9IKPGV>53B+<.@,>FTO]b\WI_=OddU-8<4.c97:VBUcG2bK:We_d>CJ6
J29GPJRcM)gZ7DgNT+<@1Ua&QBN/9F)Cg#^8F4;IO-;4<SaWW7e4M<F?CQ.+RgL\
]3HZO.3_Na:QB)R#TZQ>D);NTR_K6&B[d+2#?/P;f3>2FSCJ4K>O_@7+&d7RN=6a
=NA]?+XQGgU.N3KOagM5Y)JaOg_#A52>a0DL-E?O/V5+?&L\(P3bT<FXYX)03^fC
(&XA4E1-/A[JEHPI@VbHX^fQDMg.QdIcL9:gL6>G]Y):3YL^>Y0C8HSeV#acJE.U
B;L]>._K_H42B71G?WZJSE:U4Q,FgPSKD6ZJV4/#>_I@b/CPE)@ZTF85[9@cA)<E
bJ0e>ZL@QaH(3=F,<?3F9Ac(1WeQfZ3W9^,6;gK2RHQK/31cYXXfT[D?_fT91FU0
IC^W7]AC\8b9G<R#ZM24+4dE#CK9TVEIbc6RJE@+a5?C4GQKeJ#<R.GSNGYF@-+Y
<^IVH3X]-XAK6+dR;0(7Z3bL)e;eNcLHMFdO;7V\:5Y^Y@:CME@OAW56NcRY&UDI
&0=gaB;>]24NEVHf(Y-X:#bL4$
`endprotected


//vcs_lic_vip_protect
  `protected
99OD6)OFM3.VAQ.UGeK#c3)6;F.B,]&eQWH-VaO[/<3Sb7eSO#c02(G^&/DBDfOC
D=[=XDMSM#YJM:FZC69[(NCGbYIbdK2g>C:TNaES,RB<eg(IV>K:b04X/QWI8#80
G61J-LK+;#/IgK6#&]_+.LYeRUGg#Q9]<E#01)6]G^UYQ\.LOKOGf4D8-Qe]-e9_
P+N4]IMaXJD?),g1LR/BV+&eV+U2c#bY9>CF4fHJGb12^aVXIceC_Q-H@T\Lg?eK
bAV.HPXg@RP(=(VTT,e_MDee\H\EH>2;[W3XdgQ3-32?XK5If36IDYE=VQR,EIAL
,/c@^Z,+e-S7.QR^VOM[<g)R+3D5eX;PX[VYRJ6\Ee(_M<KCNMB)_J@?1eb,G5UB
a=.c^+M;:/=SCbFVU0b7,ZZ5bB1N,XUD/=3FN2]8V_cdd27QA6[QM40K]G=O4TTM
/3>7;aL(\K(U4PSBGeRX#f]/I)1[?c3-1=^f9@6MFHCCA)_]A^^20e/@;SVd42e4
DC;[NNP+B-&US>A_3+=C80SNX,_4&f7N^_2E1F0[gD=E#T-a[]cX-7A(7VdfMB)5
g38_fPc)4f33Mf2W6GEOR:7J.6aE4Se?INUM&Ub(5CXY\.08X0b^CZ@ZUG2KXH1+
I.,A=O?L45-Z5-V5@6)FDE-,80#1PVeO6#e428bLS<YWMH/fdObY4(0XZG3T+3TJ
\e-&[J.BF25?D5?MY8IK/6007+]+)bDW61S22b:CM+N0G5D;CSY;?_=;A@--.58R
-HNZ\AH>b68b#EO)[S;>W+dZ?H#)&P-75E7NCS[QaB/M1C4GOI\0B&7:5e3#G)T1
>/O_YC,(\FN5-7A0^?>>Ab#M);Q>=bKBe^cJXc/+C9L^g<LFe0g=>dP;P9KHE(<Q
IHBEg6OR]P+F>^fVS,C5fKR_#4g.L#MBQSGda5?7>g1Z@:b[eg<8HKE4UR>C#^5P
97M9T&f)_)eMZ(S3\df7fH/XA?e=ZCOGAU[/JbBBf#UVMWGW3gdd\Gd=#ZOW57df
JLeK9AKC=;A<1(f0:+Xd+I_=0e1dMUE7N1Y8BQ/U^C>;eH;Na(864@2.TUE5WH):
#<I9>>DB@@9^AM)VX>E[8WS8SG=HH_)55T^IPOY]P+37<VG]Qb&RR[T+bK&VbC^c
N772QVKA-#5.H?.496-E<4XUM]O<8c9ea&b1,(7f@EbOd_S^bg)c_N7g3Z5RF1-f
[gO^MP\d+cV\?^e_ab=9F4/.bB0EKV7eX9ccH<14GE?Ef=.@I4S@WZ./8_L;g:^.
TP_FZ/fdY<R)DAC[)AP)BO:Q-?;8[>BT?/R#Q@A#6ZM>2Ef\T4@W2]F3:GZ3.\>B
a4P_?QF4FcM>(UL:6cZ-^XG[>A0[D^JR,.[B;[/CJV/AG9/e&X.gDNKQX@;?1\TO
2g_#-2^8R1-M(UfbE:#C)CDSIWFBD[OEKeEc,.7L;\c&80DE)PfR]5PP7]#:cC+C
^LPfg(^a19a=,R<[]NSETDe9aXHI^=0:&OdNQ/XBJFC+Q3Le1d2c4?48eCXeC3L2
Z@-MN0-Jf7&3#,OSfY:AFA>GF(UT<Ae0MK8IY+b2/G=a6/&^@TM5CC=+]7:+QDRP
Ga[&(O+GW[6.Sa9g^F70,KMgUQF6YVd;WO_:1CZOCAFfUJMM^Db#^]DE/LCD[OLJ
g69,\OE[d&5&()He?O(1Q,KA^EQLQRJLI_C&b<@6TgEEb@/3U<<^f#,aeN8McQcU
6/Ra846>ag<MGY6Z?8R)O_B3.LD1_IQCYG6Fa61ae2C7E1(69DDe0bY2f(U+8R:/
LTE6TQFgRU:,P#dVA:\7K61H8+9C3]f6^>D/6F1.GDB:SI>WF4g@@XbZ(fA#T@fT
I1[RF+EaQ/IBcF9ceOU@[JaAa.OKAdOWAc3:58W&fW5ZT9CUBS6DI[P/cH)eDYLO
IGZN9XZ\_&F1Q_EWA2^Yf;Pee=^cAMXAP_TEc]6L,X&.-7QFS2X,a\\(^1?&8.XK
?,(?8EC:e([(V\DIY1CXfF-K[?cLX#V#fZ>.]]cU<g-+aIdbMF)GYfMUU[C00De>
c#(GB6>Q2N;YS?FBg2+2]bBM\a7@3V\_.^&0XHb-[A4#Y:#(ZF+a-W@eZa^6\eC;
:J0(DVaEJZG]AK2&^IGLOCML6eYC5CD\<KUK7GO.D^(/a.#JVGA-=&1(3-_HUZL(
T@8BSM.OcEab2^]6GX?DIXc#a3cF@4JeT:1/#/0NVA-.&07_Y2/QWdAY,^>.<<K_
/BD@V>c&c),K80P3:Ad]AD2N[T7T/NVL1VF&<D(E2GYT_]D14]_I^7OZU#;3U/VH
VC&S4L&=SL\2;M8SZSMZG)5=2CZ_ACR.0=Z\1+>Ed#)GeH#gOW2G[\C>CU(VHQ17
JX#-4+OB<-^d2^J6]&.O-_GD1GS#;/VH@JZ9IZe.AW#1P0EJ\^^P#W_3+BNIMJCH
X-#GF@7@CS>B]>3e1ZHBgJ868B#,e4Zd(E;3C&J.a5bgd5EgO2,<c-B]g\Ace0+\
)2[])B/-NaJ;^)b.02YA_gHa<d9?,@G[a<^OeILSeAM./Tg&<],E9H2>FA=@O_GX
9S/CJ[?,HdK>3X@2_NI][GJ6PBg,D/Vf,U-aAAF(d04+I+=VHG[<C<YY+S8@XN_T
RcDT=NLS7O<c(=PD[SbOV,dUC3OSbX4++6/YJ/KKa)F)c<IAT5B)QP_G,FEW/-E<
1.[W@ZAaTg/#@UFK)OCU23U(A?M<ICWRM\N7@8--@M#BKbSVQ;97_&)>XM0+(&O&
AbD/c7=OVf)CL<?7D835cUd(Oa#acY?;P+B>OEG8:7,LDU3e2aVT3.dgcWL:d@/F
@Xb^1)Y.?3V17Y7/+IR/(/fKR1?:6:FZa2>KW0QIS1a8L&f,CR8J8X7;Pe_BKC++
>VdXd.7A&-Q&@AI<:)d?bKL=AJ58Yfc#)AT=WDacgCDg4JT=cg64_LE0XTB@ZGWG
_)5;LEPST3U<>4,c-e:8M5_IM,b>W7PV53AXQ4&P;V=eO/+2;W&UY+,H-Of(]BLa
8fd;_fQQ=0W1G;OQ1bMHL47HNbF^1:\/((668;MZZWZL777;V]=LS>Y9_C=&Y6\<
[2MYF[1W=5]ZL[beH+e@D^8NN0/7I=:-<Nb=ZNdQ;Vc:2W+QL/8:^e&ICHgEAHdT
K,:)fW\Y+c>[:4aX#7-)IO?/P^CD877GMQfBdbN@M4QFLGR<5<4V5M58B)0V(Ld\
I]A6G/IT<TMeWGYQWTcU-M,YM)#e@,-;]>8f(KaGM90:3NA7V+gYUCbJY,^N3A.;
eNP]fL,b1QL.:#F8:QVAU4O&)aS\K9e\fCHAYBb9_Q32+</R\[P87>(XC9G[4>99
I\E\6KO-eE&+@:fR#+F#@_c4Y<@#7.fcT6CcK@8K/5O8C,9Y;9@HPK@&OP5&P9M7
d\d<B.OQ-#[(((BBd@]c>UDSB/f=XVD;&4T\5GR^8XbV]FE)2MA,<PS726)J04IV
:0MJOcI;GR7]&>&G2dMDaP78EZ]N2:3;1da:,WgO8[VQ<M/]3[c;^VL/H.9.EN(7
_N,)bV<gSFF8Odb4LKZ5[&-_TUCKN6[PH^YK7HH@/gG^:eVHI4\/#W&Vd41@.3=&
7?T^?Z=G=-:K:_0FMO^(Id?2[H;OD>4]bGJ1/_PZf0^3[5g/3]]\,M<a?MOHe2TW
+aX)>eTPTF.7c>I)N+.:R-:(RDd8ER&7g0WE5BMZ=a4NQT\<T/KJ5.?=TdR.5;I2
M4OWKO3TK,DE5N.9B;[19\V^HddKeLPD-S/T\AEdN)Nf+_6@fBDX(B(BN?^SFQ0F
D5:f[Z-@eM70Z_P_Xea#1<KM3MZ2gHMd\T63H?)H_0WSN=(;B.76DUYH8_V]MecK
\V:-@G@d5GT9J7Q<>S3(gb]_,[8<P:<HA>[,(2]<7.K(X]eW;b7c:O3MTMM>_T@I
GX&F2gZ-@+HYf/755HRCVRGZd.BB.__G07PNM?BEQ+YW?4A7\d0-LG_ga,>K@BXK
^GD_RXND@3>NW/E#9/ILUHaAef(aSdJE3@9JAKF,9@HPM0fLRC37&Sce:-+_VfYI
WUc-Na-TB0UNbScC6)eQ2X\ZL@6^\AeVAJ=G2/7LQ8N&>[VISA<+bXbf=)KQ^7/&
ag@cRaA^W3XDP3_L;7R+0]fW=#)&_g7<>dR:BR>QcE8A/gg7>TD:UHd_eLRJL.Ub
SIDGL087Va^7>.;M>UW&6RZ82/D5#I0gFP/VSJU^,Zc/9@8^9d)c7cf;+>V=Yb2>
2V4KH\7NH#CT\W7)F\^TNXSICA7a+MV[M^^D8S?)_\5Be1-I;@ffbATJ&(W4_:):
EbMI6f#,-S?H@e)Q#ZgIfK#Gc3\?D4JEL[KMXA2DHeOR[V:1.QUOA)5;AQ<IZ+_R
DCHE_<H[T^P:]Cb6@fE[@O:GB##Kb17>&X8N\BC..<B#;XW^/GUA_Z5+VF;2+dMW
^GbFKYP1>7.9?;41/Fg;#2@0ce#=c#)U+TOgf1]1G7)SZ_6B9C-de>ZbbA9B.\U]
/R<JgB3R>28CL.#C.fG0C-G:^<(<F:H7-,49FWc:0XXb?7K2FZGBH-Ma?#+K#U?X
M6IBg@&W;V;^CHQ^dJZ0I24Qd9cNJBVSf7M7R6;_DD,]K#BKM\=[SFK=../AF0W7
6TX2\e1M=45=D=[)3df?,M8Pg>4,C]T1-J@7\N<6BeBe+8>,I#._B,=K)_6-?BG&
bgRZ&CWHD>eQ425UPR.cX<-,>>beNI.]4[Q^8.UJKVDff5;:]gM/6;UC:-774;N/
E2ILQ]?[A+RNEBT\-@IV7K^cgBbX(Le7H?@FQWM]WY.eU&/:P3Q09Q[d#Y4aN7-D
WAUfIRYcKVXF_D^:\16IXE0?WCW^L9ZGXZ[Ve^9@).bXg/.X6;\JFWR@2[JLU,J3
fP6@fS(9=HE2_RI?6UWNS>LFX4S(,1E,:W9T0>c;FD11Q8EY+BZDU9D[UYaUM@CD
?@U#?X)#BNJA)^Ac>WA26BQZe7\E-]9EP]BK<PIe;S/:C6B.^ZWPHJe#AJ\-2f0<
VBZc#5S??ZS-)9NO@(;-4S3.dD=AMJB<cVT^<G_\YdL32,TYO+1RaP.39[93+.N(
6U@:NUYC>dA8)#ZGJ+?:_HXF7S7,IV--U.7?TALN@D?9[_0F+FL+bO5e[[1eW1H9
@OWIN&]M4?aM\QF0K<aF^?#bCH:ZDDFcg<1NMUQ(WZ(GF6[+BD]AS;184T<[##NU
K8AfH.B(g_:1EBE;-]4@I>_E3PPLN\(0))9VFQ5a,72F/U8Y6[g3Yf0)3a@YKA]b
c)_/GC/=BdBFKB;?GFVP[B+DC71;1_U#L6[g&S5aYW3(SVfIaebEe=Y2FKN#IYK<
S7<S(EYL0CZ_J3]ISVXLO,Sc2LKIXGC+NN5c6V#.,,UOMZU[+bFQ)IM9&H7F3EBe
FR3)dE[g:>C08LR4XCBP^KPX;AU=(K2J8A/8S:T94(\Z5]:,J-N\=&aL]?)012Z=
#X^CA.OQY:QG_OS6b,/gS/Y6)Z\g=bNL4GXZQ^f=A^D+e#d:+bR)IQ]2bZLC^QQO
PZD=X]8.^#cHc:.:CR75Gd(;HQ.EJe;e:49eW8])=Ecb82aV387CY[IU/D:TD:g-
Le0[UOYK3:NL&BcZ2Y6b-=-0>6.B3-<1AUMB8AJ5BOC^GeYKdY]>F9?Icg.:MU_:
8S(&C@MHE/UMeEVNGQ9UPX#eAgE;dR@.dJVDRZ9Ogf5g.K]1?V<]=B.:34Z#8(AL
;;:a6#.L7THF7bH\=5Gc-NI7@2X)WZb>ODTW;0Ye^1aR_FgSQ/OZ+-P\YYFCYfVQ
Lc:Z?N=&Ha@28DD,27P1]93JO?HX1+#Q)D1e_&_DWX@\/#TcT-,8=G;^4NDNJSTY
B21gFR4N=ZT_=&H6YM<CH-b:DQECU8d=KQEc\:8X\83eY/65LAEML9cUg,VB^OID
#GMDV7;6LX]9[U6]=/X8a^d(<H7SCM4#(0QQ:S5V<F1U8fHNNX<97CT\F:Z\QaT/
GeA\[/0g6)930SOcS6D>-AP+4Z=73+[T?RZ[Y:(<eS>91AdIJ;VFB<ZP&cU3KFUb
7V2=_0MEJ&FO7.K4^G[<+CNC,5H)4^.V>PJXOB\(4><(:M@2OJ3+O>:]<b5g-2N4
&c&]fc^C\V?P^AV<E9)6_QJBF(/=K9RJBgFJXG;A]DXY1?@\Q?ffEY&\f4Rb)9Ec
&:>:Z-84]ZI73N6987<KDFTO(N_8)1LQC3Db(Z[NgI6S^2PW]5.V_<Jb3Tb5MXR+
&#)aD>_QE5\[e1US@^<^(E0DY:cAAOC<2O)EO1Q1eEV2Y9-Rg_(6@.-YCdXB?F&Z
01P\A@=Md4aaE1:-S;W=[9(H0[PCQOMb:=F_2LZGWPFJSM3AB@U5O.IWA.aT+)MV
^@ZcK^).,S=;Z5Za_EJVO5DWKPKY)5[#9)=C?;>??.>\JU_E:TU[g9IFU[\B(c+/
B8D#-H#<D25+\L[A57L7[O0f?Rf&@AD(]+,0.;)Z)-AHY7GA[gPG(+.]+>D[AT:a
We+DD07+gZJM5256]R1#W:J_>+SW9A]TV+P7E.;1RaNSUKTA,=g.c8UBQ14;3>J_
#?a9cV_&F2gPT:_g5(c&N7+64;-:X<40S>TKF:Z&QUNUIYM23(A08MFWQ=[)H,E)
eaDWL_3(a)e3<4JS;0XS0JeA>f]YfV:_QTI-LXM?\EPX0UT/^9NHDAPc0>1),UF]
HV:Ja&eKJ3^X9.PZK:W[dV.Y&J^1U(6cCd9ZBX59DU.))cKO1GUMBPCQ+RJdN46-
6PFPe8a\#46,LV-6NBC^C0]=J#]=EPYKF/JbFI/T@MF9[O]>/=#\/P.dP\AT#CgL
6(A-6aJPbT0JPG_8E\TWc8;=.U)BBN;G:X=UXe3<FL4#@L&13D,X9^ag7.1S(\:a
WfTG7RRK707]>a6=NGS78:5D;<Z#\DH?7Y5_)TNH-^:0dG?P(B<2HW^#I(W:[/R\
<bP[<BX]E:-&3bS)N=@1AQ40aN:cM=T18;g)@S;bNCF6WJ=WDZcPX1U;OGU_V8(+
1gR&d\f@IdRB/L6CJ^cDFT-adD\HR)/;A0;@S,SS>^J<cTS)RV63AL\UVFfT,e/)
N_YW#?\LXQ=8G[#g(Q]TMX13IZe7(EF>;U/5MC8CHF8+UY4T[/W\ZfN5aBE;gY]H
?&;KI:4TGTBIaESQGTQ^8IB<77=4U(TSW>F8<Xea74A-JdeL#0CO.9,TB]/TZ@aJ
B2RK^@QeP#?K0f#C28&8B@]?Y]WBW^73MZ&TX=79fN3:&2J7BdE7\\MK>:BH=TXR
1B),>WU1eMFT0BBf1ZNOLaOZWIQ:74f5P6AL]Y&>V[?L<Q/0Y88GW,Q+L;U8cYf]
&CFf_c470>JN.=LWA6V?\<Ag/@:62_&a&CMA1,U<5</=T42=WBW_F+6IWIZ:@C2<
.UIeI]@C#F:]9c/EgeEfcffdVCBPXZ0?=;LD,d?W8M0J[C#2DY</GHV0FT6g;W]c
7PMR^[IZ([8RgDZ0HFFM6CHN@()8TH(N:HE1=C5)#?a:Yd;4fU,&2NO4@C45[Sfa
070662f40@AA9c8;1]V3#>K?^J8C=5/U2acG0.:A2:6;QV&YNX9<M-.VdUfU?K]\
dFV,RY?Q+YLP#Ie?d:5VR2aZI+;8a0@9\RV:gP__Te?_,Sd^>abEg#(/+Y&UFU@c
RA94)VYTbZ?LJ(MWGcCSATUX@PVBQgR+66_6TeVS2H4>#W;BTgNcMH0DEZS3?F4M
/T-UW,Q]e38O30;Yf)0=L(,ZIT@+f@B[bYa#))fg.cb?OMAD+FcI9Z>4W64<;Z4H
;V9d:GB>>-J]C@b?@=.GDC3Sd_Eb-S\:?TAWVWg=W-EO#,Lg\?MBd;]Je^=H83HU
6\YJ[8K\ZR5[[3TO0RZD)V=+].a_53CP(K4DLHP=H1]VFYIN)QCJ<=MZLFfdR2Pe
-EK,#SW8>[)[*$
`endprotected

`protected
f=1IgbL8T<S)MOIPdA[/XQOHM?:>g/T\>fZ8/@X^LYWP/@RVdE?M,)RbLB,U3HT;
9IQaSVA-dRPG^PQJYa_3dPVT=E59CJH.=$
`endprotected


//vcs_lic_vip_protect
  `protected
DKI.B?<[.b)&3BFZL88V83I8?d:;#=+f07E)RcdTV6VFgT^:,c8-0(ZFM^&V8L46
7O@_WB^0Y)(:AIdG#cg@EF>840@@<+:NFU^/7ZV,^(d,F^E&=3++g@Wa5-PdYHcR
+GcUL^=_C&-[b3d;4a4DFRQJ(]J13>CXSPK&(Z4/@;@11=E8P5R2=&MRMBQQH8<\
/)0AXAR15M[M1<4>H>S3PBBAR0aPgE\VQB\\&I?X[SO3e-71YYYOR<J&HKM<:=PQ
T4LG&f9<eaZRBbLB(6JM_<F6aGNE/HIBO)c\#dXdJ3]BLbU\XJ:M3/5:7-F\#-O1
LM6U89S0&PA#^+f2V5?5H689Y>>/JF:@O7=7^5W:6FBQ&F0XC<5=S5MEU?Q#ZY/b
CZXU3E93/fT<dH-8DY/W_P]Sf.\WPR^@(XgDH>,?I&[N4&U-<OCV?35ZcDg6ZY#L
K6:M3[J=9K[T^Z6f61/3NPRK?C0A[Y10e[]bE0<gYC3-QHUg+_XZ\5Df=AdJ+\K2
=B-\,gS(9=+;>af6X\SRZM4Y/@[(f54/ac+7=S4:3,b#Re.0gV=#[d@(fL,adQ88
<eVS=9=R-#+XLV1?/1W(P=9S/QR>5=G7_--1aKM[f1[,#6<7#0E@7d<@Td22PG4>
8&4]d5[X-d;ZK\?BX5I1,H/,W<b+cWDHeU,^OL.EJ=^660=Q)8Wf5PE4,.S9W_QX
Y@;fK=+7CB^/CSEE0P=Z=bL3.\>Q9.A#)19B(Fd(O8D?N1+,W=P.aL-3ZSO,AcA_
E81^d.^^eU[,+b.b)S1).A:X(?EdgTJE<FE#4]@cO;P.WDWULZ\0a,Y6>V+68K.c
V)L?;5EPFZbJHgUKa@0ERJP?XJee72IW-4b@>7WT5J<&KW=I\KY.I_SUcGPQ-,PD
:ee&RFXLI_Q,>.e_1;<KX=IYOP-<6?)<Gea#c&?UP@FT8\T.,dZXR+YK)Hb./>Vd
JUd&M)^>C>6LX0.\)W6Be\7A/H7c)ATTH(M=&=Z[C^EM(HU1X)ZQ^2;)U0D<)GT5
TX)U4-(g5c<823\\Y<I?N>969eTV4ZaK/\f#e1<\U.T5VK-eH,0F(8gTK3AN,(/3
0Z,#K3eZQgDA/1;0?O^=2(X4.1,J]d;NHgT2Ya.CIWKAB+6df#:M,3aI+HG/.CSJ
@B/d5M;M4Y@/+UL(USN#)=a))NSVDZ?Ob<QC46G/:(N&=URfY-]L6+..]3H_HQK4
JT?bYNf.2V3[E0@S7C\bT@;cWTGMN<GB9NNWe=;JB,EFMgY#ZJ:2:aD\a[#)4G1H
#-C[K>KUdb:9aQ4Cd];FCJ=M^C-1>Y(@2KA(Sf1Qc?d_ASQ71GPXFJ8O5RIcWcWF
a:dWXAIg]5FN?bF>&RWcRc2f#.9#9_S(DY&.[d-7=BU0)Qe5HM&deDIA=#cQLbEU
VA(G8Dc=?-4J859gG0b@TC0^?+ff9W(@0\a_E3<;9/6^8J6D:Ya8+U.?XJU)S2BR
EHgF])Acb0>&\VJ136@Q,dc\4dF;5<TdQNLSJM_]ZcBR\S8C-gVC4M[0(;VfU.V,
RFZT+eAU,LUSD4H4-T#Wa@LHJFKR3O)J9D=59&ZB-3Ma/KgI2>5Z@)dU4;QST03L
AJIG2YN^07>C[e\XEf4HQ45?.S+_F=BQc,RVF>e^FJKGdc_J9I>&HE[3?Lgb+_7K
5=gG.2Pc>eW^&?C[PbIACcFY(5\N-VdFeV:=&\DU]9P=1CL4RE(,D0LT8##AWEQ,
@/0UZ6c9DbDM55[?&8g-B+aY4E_^V4NUGF4W-a2M6+&aH[X;fa[GLIYWJ6/RPV&L
9@<Y/;.c5+)&M-LFgIKF#X-6RMR#:(.([T(PS1AeD&dT>^ZON.A5(D-RZHM=V&_Y
_&Q&Q@+46Gcee1I^DN6,cMHOZ8BV0RI]d?N]DEa^+B;<GJOG8GeKg[OL]S3\7cU/
d<Jd\II,J_Dg(ZO[[FE+a-Y4CJ.MJX9d4A<Qf&_GDDB_Q)Y2FN]#-<(]?D-6R0Me
#35/)ea9&(1AO5I:\=c=Yd;_E5,SFF^gPdK72WP,#eC+(_RGYT4C:MN_eKRP=8B1
V3B>9a&^](6)M.:U1C3)2_\FX,JCDYA:(U^Ga:LRV,O??LQgP-M9Ae_H1Ma&cd[>
?>=E2cUD[BT#?PS^cVeE?&DC_RZC4Q6HaV.?+\8II)[AJgc](6/OYPYP<II9eAc9
Eb/.bYXU,g&3=E(H?81GLa9?GNS#9H0[Z.>VVJJ_),d3##5</]F^J]2c7L8=e6CK
[+C\M]W5/>9IQG#4&M8P^bTQ_aeH@#-abC\?NR:^?B2SW^>eOa6[D@2)GE+4QF,3
CE6/daD93TNSPT5fM,7DC^=F^_7137BN<$
`endprotected

`protected
CgY3C1U@55[g&-Ob&Y]^5GN.1?QF.>V7+\M9)I0E/W1J8]^,S,ZO5)2<TQb0YFAV
3,gG?>,6Nd^&U2Q6&ELQWT3Y/<gL^C+9=$
`endprotected


//vcs_lic_vip_protect
  `protected
_&Ieg59e6agPZIAXVe.S7J<U\J,[38YdgJA_ZR_8^?F4<3>fM\1a4(4=A31C8^SW
DbWK:@a;C<6-S@#]6MW-J9?0Eae4430&NC6)R5[Y7D6U9GK^QEGQA<FRA02F//.E
^ge1?>GQ7d,bP-BC;RC/VV,TbP+gW9GTI,#3@:b;(Y<2AQ>V-\<Q:^+K87/g]/eD
2)):Qeeb3^L2D(_W:EOe)EF_6A&O9T)9-)fdLA7c1K[eJVX#-.OU_EV6:P[0,RDY
_H(6I)&LIb9A]4^1[L#DSHBgZ7BU9gOJSM.0#L),\@)<ZQU4b(Z?a?G6>3P1]Fc,
_9/3Z&0PC>-UMTT;=LgI]-g=5aZeaFW0(c\^^Q0P5S48V#c4X]CRV.B]C&G_-^#]
LG89^a#2Oe7MOC(Y+V6,^gIf]O@dFg/W_#P5cfC92W@a@Z-HH-#dBNQS2:>0^.c?
U,dBCA?C4G3OR[5_7B/K;=RZ,Q6SH_+S>SdCXcU&c(R@M^1^S,YO:7._-;NZ\=2Y
8&C:_L(EP[TL])L5LIIVV6[N.Y.>&G3-cWF.aG>TVVR5T/9K,7R6P&;IOcCPg=Q8
1QbA?E^LZ[YTA^fgJ@V&5K>E/NQ3B@-S5H)A09^0A2b69=g<bF7X72MC,\VYP7?0
A=W6AJcI_7HX8_MB^K3X,5(J6+)>#D63eU+0@cM?>X/VT@[>WFY<<69c=U37;;AV
V8\,Sf2#Q=]08Q99W&8YeR2eXe7D0#WDM(QL_P7f[S<g_^E,0NC,F[.DK-5K3]bT
KU&g^:M;B;d<&KJ97QZV_c+U;>d<:SW&Q>PPR_^LPO5PR>QGHAcc[FXVW/EVMVRJ
\PdR-U_VBHA0FKTWM/=3/Y/cO9;]1S04PDR#g&:;Q(@4+YHJ<4H6Lfe6FFZ]dRg]
-:TK@fV6Z.LB)a9KQ@dJd_@4#AEb_J#CO_.6gL6HB;(aN;PP9H-SFNVQa,SL357N
AM\8c5US:<D>C&Qd::NX:b3<2cB]A)5&[&2#.2Z>.R,I))0U)8_NWab8b:02_[QR
L_XLXe>_.2^bB=bMNZgJJ0AN0=EY7^9B:a+KZ-07FI4VYN/^)H:BHP8B[>Y.VLI=
:,CHNY7L./CRf:>/cOcg33/RdCEG4^ZC;&]T&;>d2>;6IR0d-:<+7)5:1:YZBR)=
-]:@&F&-eg1CCBNCR;0,;<Z<>+E4>g^7gWaI324+Z9(<UJ+I,V[VH\9<[/_>1;,7
GRHg_(\E8M<;Y:[6[GB_C(DDN>JD3MH&)W5Pe_M:K\FfQTZZNa^X.\_)eTa+b(Q5
[-<BNR&P\(D/8gXY;63f793Wd-4]\/f&V;6]W4PKY^=&We(#[X+XB(M63;W#d^27
[=0^7fb_J44A)_SSPc\<;eK3&,=W0MEe(2P][(<@P)<cAR(N&d>&^<9\C](X]++F
H&;LMY7fZR8=EMf4(:a,Z4g2DVbBNW#_W]?eAX,V@((ZQ3E/N1EDACecQ.a@Q(Vd
eAA[SY&6P--O6X]_S)YQ]8;OI2g;P)LJQK8-gQC#0=&;U2L90eZX0&d(?72L@_:8
H<^GCJ:T6<@F3C=M?+^UAV<+I_FQ69U7cLEU;8,FeJR2].P+,.ZTZ2W1FJ9[TgXQ
].6ZgeOb#@]?)G-S=3TJDS=eZ=0((O0cR]B8V2<AaBIZX_]AU5Z.f>C?(0)4H]/P
-gdC)_X#EW.:-dW52^6#VW?X@(:5H7EB#dR9SIdL<HaW.Z?8eXg/.>(19(>MbSg8
+PEb7?f+/2TAILQ.--BO[XT(AHd.[UO;DN]V=Kg,)XAS==Ga[cGQ_4g,-aF?&&Nf
STEN0gNKd<Z+25Bf)RQ5+5P(4_,3[^FOJb0=,^<eV(VUKbc3ca->g;81@aJVaE_b
_fAgd^Y[I)]GESV.#1b+(:?3;VQaf9Uf@F<>XB:LV5ULRV&AfCSKM+)gcO=H>6c&
Q1A@3_^C9f&]A6),()9K204\ZHSFYM/^L^DZ/E@]VV_X(d@-7Y\eRP3f(g#X(PWO
Zg[UU2e_XKXbcA=Rc5X1H@dT5BNBFbSQ?5N\(:#H0&)\YJSC(:c>)ICC^&J-24Ha
=&8+bC=F9XYQ@K2J]LT8aGF-<(SE<99):+71#YKcCICG-=B9@N2PF^H3W##PP^(E
bRG_-1A^F;CG[M\(?LQ\AI?X.#Q0[e_5H+#[SGR?90TK?gI&5)4e)WM9[Q[_<NOB
<g_)Mb:2V]=U^V4D#CbG.64gD&_1GW[NSZ0Ggd6GM(L9MDBOK,TA1DNf+Z).SM@f
GT+aUIWOPY-P&=;Kb=,8<3&QfV)SU?N[9$
`endprotected


`endif // GUARD_SVT_CHI_RN_PROTOCOL_COMMON_SV
