
`ifndef GUARD_SVT_APB_COMMON_SV
`define GUARD_SVT_APB_COMMON_SV

`include "svt_apb_defines.svi"
typedef class svt_apb_checker;

class svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port makes observed tranactions available to the user */
`ifdef SVT_VMM_TECHNOLOGY
  vmm_tlm_analysis_port#(svt_apb_transaction) item_observed_port;
`else
  `SVT_XVM(analysis_port)#(svt_apb_transaction) item_observed_port;
  svt_event_pool event_pool;
`endif

  /** Report/log object */
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_log log;
`else
  protected `SVT_XVM(report_object) reporter; 
`endif

 /** Handle to the checker class */
 svt_apb_checker checks;

 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************

/** @cond PRIVATE */
 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /**
   * Indicates that the request was driven and the master is waiting for the
   * slave response;
   */
  protected event access_phase_started;

  /**
   * Indicates that the slave has responsed and the current transaction transfer
   * is complete;
   */
  protected event access_phase_ended;

  /** Event that is triggered when the posedge of pclk is detected */
  protected event clock_edge_detected;

  /**
   * Flag that indicates that a reset condition is currently asserted.
   */
  protected bit reset_active = 0;

  /**
   * Flag that indicates that at least one reset event has been observed.
   */
  protected bit first_reset_observed = 0;
  /**
   * This flag is set to 1'b1 at reset assertion.
   */
  protected bit is_reset = 1'b1;
/** @endcond */

 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter used for messaging using the common report object
   */
  extern function new (`SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();

  /** Monitor the signals which signify a new request */
  extern virtual task sample_setup_phase_signals();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /** Initializes master I/F output signals to 0 at 0 simulation time */
  extern virtual task async_init_signals();

  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Process the new transaction */
  extern virtual task drive_xact(svt_apb_transaction xact);

  /** Returns a partially completed transaction with request information */
  extern virtual task wait_for_request(output svt_apb_transaction xact);

  /** Process the state transitions */
  extern virtual task update_state( svt_apb_transaction xact, 
                                    svt_apb_transaction::xact_state_enum next_state, 
                                    bit protocol_checks_enable,
                                    bit apb3_enable
                                  );
endclass

//----------------------------------------------------------------------------

`protected
A7X3#.J]CS)aU=D?G&F+TI[Ma5)H[-;9<SK1G=?:R?P(H/=#U^;?&)P/g7PL3:1@
VB,OI>=S-E7LWX6<PNC@[2M.dN_;PW;-]O(-)Rc-.f,b:\gZa;Xd:/bb+QAV]LP_
2.[bF>#<WN?]_LDf9R>ORJXO1_d/#9?7O#A[QK@H[M&5H&B99YN9b./;&<J63[G7
Adf=IXf+VQO2-^I].C^CE<.O.K[4[aI5V-?#HN:-HPSUR&AEENU<GBI^D]]H+_I(
=C?ZfH2S-MH[LWFKb0T>FQE(O;fZLBEDSa6^Q3X/(;BaedJWIPF:,<-^G[XGdg>a
:cXI?2IM>:U]RL0S?5b]#,26FGME@+0>41?M7?]APMfR.;TY?39PV#ANKD5W=939
XG9IWK=0G5R\@9_;?beS#L262$
`endprotected


//vcs_lic_vip_protect
  `protected
<7AF5eQM71W6dXBNE&X.IE3<KQ2MB=+4]C:]e(KeK@0e\dX8aK2C)(14^63cO;O-
Fc^I-/e+<X?a)F\V0487?:/8K^87F^TJM\Q3J8eL(7.,RK2/89G=@_7Kb=S-341>
EHYTQ=TW:=YI=F_ZBeW4@J.Za@ELE[DDE9,d2Z7TEUSXHcAgVed(UG6]Ff2@fg3D
E=KcJ9@6aI^VV7@,==,a(O:c:4MQ\GF/NSRS8GQeW36f(2f>4;IX03-d3PLM>EJK
3YN7ZS&JGK/VQ8cS[N)?A)S#&RB6aJGOX)eBBKHBCdR.W2;;g\@OZHf2-JU=1G99
Y@=OaDN[<K1QR;2);A0<G:Q>B-H0G8a1HDY[B)KPACQ4bgUG&)7bQ68^T?9Nc;KF
J(WS.6;1^MIBa5E-a3B&\PQPSPULgI0>LeU[)?C=EF4G-fBd5JV@9YS4GLN#Q@HI
\CR<0e9dSHQ-,>cbPI#2@5b57&\PKD5baO>#4U)JabEgK#WX^3<+?5D\QW(ZFFgI
eTCU#8E/a7>PS53ZO^5dcgEb-FXP]0KFU#/235LF&-)7LCG8f3OPEa.ETeSUJgH5
e=>HaU\8BdLTG9+;INRRM.bDF9BUS9Y@?M>7Y5V[JCBG:BNXOJ2J\Y12U#M3e-@/
fRPE1KFA4b\<A>F/-ED]ZVfWB&WZ[ae>?ceUQ2,CAB8&R.L<@-=5B^(JdXX&6U/G
NZ@#-\=\e@ARH=T+DKVXT?;J3JD74W<J(K&de,_V<Z0KLFX7,3WC.33.]>KLVcB&
N>?0Q:CF@=5;gZH\<(>J[Z)=6DLNC7eW)e[K[NBT>.[g3=3d?<PdHUbf&0DPF2-9
^Q[M#JbD+;0L8R=47c._Fd/.,KLO/ef?Z+Pb\0>4((-3;B1<)R/WD(FOHY\8KaYd
1P2Db;>:e8M#AV\LM=&AQOg]U\cA9#eFM8;f^/8CPP)OP&+-[[[dK.0cQR54=\KE
MWb@^,HVg3GV5:Ndc7dL2\K\e.G#eCTB\?#F@E:f@ZB\:,Q>LW#2D[]89N5T.>Y:
,U^K/H?Ud>I_BW72C?.e.g?:L7DHfT8aU=0SgD5M:B1CMK=6C4661;V@,<f:DS(+
Nf:HA.C,6H[c9O/?TT._5<V8IZ@7b@,?,N9SYY0eI(P_aeLfLS&CegF54\8O+=75
e9.eV]#JFfPIF&2H\FfPCKY.?L\Z/)Y45(YV4N9aRP4K,cM/-/_J+LE30A^N8F0N
]JRD<B?6;JC;<0A6IT,^ae+dNd9&OB;57e2bYT[K>]<1IF#157<f[47X6Bf>WV?W
d(:9<O@(EBgO]24#>0=NQ)3S#KR;gSdJd9^.<9T9[YV;#5P/8XTPN?QCPgYJ28H?
K7DGP#=^HGea_g^FFOeEKD&IH8&RYS0:-Z.f,158Af<WN361S@L03[C/^-[JaI[:
4=HFX8K2C3,fgY31)G=,GCWOE^42OUf3Z>@#[g^O>G?:Og9&^a@]6II]^X&ASK<<
070>>/d>gOb&0C46[=Z;49\?Y+RK4e5RM+3U/5,QDTNAS3I@:EJaKK6S]S3M02:I
06SfBGZN==HY)W5[7bW@20BB+QJLeD_Q&IOPM8(WR64Q^FV[HKPP/&-9E(P1)S75
P\5W79Lag/VYWdL22f)+:FJ;5;K<P:CNC(USI45bARIB8<GV(gN#g>I8U.E@0(/6
O-^D67-c8,&(c^>+]OcLSQ__(G=gHS5)POaA/&]U<@U/g&@^Tb@75O<>AE@^XS;\
@75@GV0+2ILUd^?QKY1aZ,)];7E4]D&4^?.1\#G5-0UAM3gC/G+(M&TRNQMK;TWb
UI-2GIL4W[5X\<-6F8@(8.HL/&]/\]1O6VfO]1I6S9JR,->JZ5K>Q@YX_M[Y&1-+
EA]M:f>3fP?Q_?\fFg\aaSXc,M_E^IWb_@J;F8IM:.2^P#B25?&5(eQV9^H)OgQ,
:Xb@-^W<RcCcSQXRdAWC><gRH2=B@_]D8bQDXFI9gFDbFDL-S1O=aB@B_]_CQ:f7
<]M,_75XN/Dg(6T&-+B7S<<WCLM9I_Q[MD:^LW2-<KC:>N;N7F9A.GGRTS1U^K:5
(U[L(ZfHLR<_GF,<C+-GI&PP3^3P2YAZVIZJ5[/I9HWPFU0>Q>cUGULD3W\KeC,6
MJ7:TaN?G/XG)+L&6Y5XN^2cXg=8-fZdBK5c;C#QKe-JcU82N/0KAHe-6>GOSc:d
O/e+3&O#]7ELg.7Z+Q_g\(=3NI)E3JO3HM0]7SQV,?G(H07P4f1ZA-e]_S6O_OSV
0N8^6FNM/?ET<M^PVB^:,ZMVLFfZ9-7I)H_DAY15ML##G:I=/>B7)^-VIR?WF;f[
C<VT.6aY;-34_BQ<CW]cJSY3KN?F7BLX:A-44)P,I]c@>7XEeWB.WY70NR(ZOCd/
8U)\+L]IR(d11Q\Be35Z@aaFC^W?,S]B;#.NEIQ]_\7:Y]BO_bBbGa:JYD]IN/Zf
V<JUEIC#_cUXMW;=[Z#4W3UPG()c=L?fE=Jb9?(#eD52+O8aOLC2RWTR@>1E[F98
b<NI[)BGC8U60Q8BH+7AF)R)R&F_84&13O8H(GP-QF1>0B;OF<K2+\OS_cPFcGaG
QG:7VH1U([gX7:eF4@aecdW5bIf8M8KEH?:aeN5N]4IKQMKIPKa,?fMDLVFHPL6A
ZQP_eA40WST0IW.Y23UT&e&>=5=S+#a>UNQ=9;XK&3b.?1#e]d3g-5S8?B5XQIH@
Q6#:W;ZIT2GS?YV_.@2J+bY&<,9^5-3g:U3U2#Ad7#5RMK_PDKWXd[]XC.5.3YEF
XRYH\/23>=F6AaP+7Y,8N;Y\AZASY<IP17BA4Q8]fe-gO3G>8C^5gM4@FMQ0=OST
CVaN[\Q/8O,@;g^BfaBF?:WX(LNd11b1P@W-)B\GgHRY>4VJ<^K7<RV4Dg6V7>@=
037ca5475&\G4aD6cN&W2Xaf&;>D@+&8U,CHa/4:L,(QUK2Te>&6bBEb_;#fYQIA
1<Ef3QT^^W2bG.6SfO6<I9?@@H,4.QN0B^X+0\7[?c);(A4(XPQI37W\_BEBD<U8
Te=3JK4[HP6]3fUFf\>T;Q_,W3J,DQ>+6T_X(b33&:@T7\2\9#V6XI_6SGbDQg?@
XH_L3DW<WDb-^;1cW-4d@+G2H0L>0:[CP0E/^(,-4)(TU4NJ.68I/(]8(bc>/FG:
MK7?E-KP8W7THZcQ@g@PE-d#R<T7?#bdf;:ZMJYcBF9O@YM1F56a(7NL<3@^eAYU
ge.,Z,cJNV=CJEI]N)d>=EFY.BN7L&P4gBfgB:](/[U/Ub]A:>1)FS4>#I:/6ZM3
EYA3=DXZ@Eb\a8AW@F3He]()J><L1NX7STQZ/7SfB^Jf)?WfY.]E5Q6MKfRYUO<a
3g>6dGTM]c#S?T6>4S8E0DJc[eX:N#[gc9IMAVK#4XCA\;YNV&IDa&^6?C8f+^)&
3.^G#F//0=a5X)V<JY]fQ]DE>[-#-G#\EfDg4>Z7Bb:g3R9J&e(c:dUCE/\d@dY(
LZcB57);)?cC_5[5-aKRP=/SXdF=_(fLE1=6J-]PVMe0&g:9UY-I3O86J8cdKK_/
&,#E2?#ME:>dbI-AF2/6d&_>[YM]:;+6?XI/E_c+\^3IEE=Xf<TWeVSK6MG?V>d_
cTKT7-A_;?#PE41b4C@M-M<80KRDD)e(LJU;6H]fg16Q\J+F>VQ;dF=d>[J5@(32
LL#cBbaD7=D:dM.G1:I3LC9Y^C,Q&[YP8801#L6L:dEXWcSb8A8ab#>>?cQQdN1J
1L9]cN[LJ@.=ZY45K7D]+AD/_-@N[,@)D>SNN8b\;DF?\=_eJTa#>\C1BDHae]X+
&;S2<Ef#K>C(/J^]R<F06D<<0:WU#e\)J52aZ?0>4a5H4<J9L8#C,8@/>dHI,#2U
_(]IR,.]]YP<&/,5NTXUX8fYEWL@BI<UJ-c\S&QQ+Z:Ic]M.(8>\_GXTe@/ROYQ8
E6+d4?]FY\FD+FM>:Wb=G#He<B>T&.,J4UH1NC3Pa0bS,Oc:9a#<78.>UAKX<#BD
GW;6OM4C(9U88D3-@9^P+U\;:IC7dT/MZG_[^JT31;S..T,/Wb(;76e\#S\O5G,+
LYZ8a1?d^&IS?d54XU1K8CT5ZCV9)Fbbe,g=VRJPPb^G_DH#U,bcf3(@X@e@\YCU
ZF9G.23He.WBOR;TGD3P:-WL\/41.I.]f17af^<E27,fK3&N83J)UeFQ#gHeNI1:
W1d([RK;3&USETS1e@IYV-:C&SA>MJML2M^65&\L7:Ye9MM4[:-J/4Q14B;@VMIQ
<VPeT+A.ZJ-5^UK7<JXHXT3:8+#<_A5]eUT2<4C,R?>B[UJ\UG##e7MJ.C<>VU.L
JEfBACc4ZR\7#Le6184]]OY#ffO9Q\9.>7a[R];?)EJ:H79/O@2gA8DXC>WW^@5V
cVG+2eN9);YVB+_TG?3/)ag)F?4#VfWgU\W06JN?_MbB-Zf74#c66)dZ;JXd)CGc
&KCJ]L0>3;N;XWN1&UF2>9c>eNBYPU6P,SU?^YXON=2?.FV@aKf?Tef;3,=gPB2E
7WaBW:6TGWPaBZa+BG,MEFOS7GT.^>G)?@RSG_]B(#S:EX1UM?KCOW;P/Y#f3BW[
54aL-fIf8<eOUV>A3A&CUK8G,O1BMg16+OGP0/5R,L>a-M0G;6TD2;U/;BH8I(_9
dV2D(V50F^U5XGb=-\UR@O:F]7KA<LF6eJG.-PVb)4Z0#0@fWV&fbG9#O3S8]_91
\<5#S553Z^#U1)^/W@3gE1g5d)H@;?565921:2D602<O1(&-;e5;5?&]_cQVB@>G
9eB;?ID34#YL?bO&H+S+[19[1Wb[M+4+BDPfb&9N4B/5Jea.<-(W06NX8H0c98<[
URN^,(C:>2S:aN(=A&7c+#41_P-V23c[E5+a;ZA).R65[B:g]R6:/\@V<D^Db.@)
cGEJdQc0X:#c(\HRdRMH>BB4LZ&]+P[46_L-P)];:b/U->e#@+:c(3&_1_,)>Y6g
39O2(/\AbBG932^OH==-F_<Gc,RS/G1^Ub3Q?c_B^ScMIO8JZ]f77-NWEY5CJ=J-
0/B--I@NR@OM;:bPd^RA.=?g+5T;::JN&;]d8g@6Wg[=@aY#_/UE=A^]_#5a\,ZS
6;3/W.NV-T?#FT<R(<K3CW[&OK4LONL?+]_U)I&?X(C#R\20Ng3XgJF2::e_7;AT
LaGf1IDMX-8N6>PfMF[ZP@_?\O1Q3)-6dT?&##J6C9E-,WLe.2BSTC,ZT,_5Ba]F
@Ff]K?T5:bFX7gbFG>Jc#<_?4$
`endprotected


`endif
