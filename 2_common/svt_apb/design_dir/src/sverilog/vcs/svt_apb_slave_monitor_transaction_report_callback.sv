
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`protected
\H\He/^1M)HS7)H=^0c114J)H)+R:/3bE_YIUISE0X)^.(2]F7ad2)c9JE+3PN6V
B;^V.;,75KZf@WSY^8J[P7_b\[_G3,.@PZ5)&9BagPVMPNLX_U0ZF.F[Q(e/f00U
S2X\+NWg=LG[URH:Q+/+T0b_@CJd4/Z^6J]9U5:fJA6X)1U6Q+c6B++H983U->PE
@FS2&X9a=/I08Ge0AD,0QFEfMdOEV@\^+_+S3VK&;K:]&O8Q]N]?1L7>&VB4f>G5
QBgE&[g@?cIVaR)-8?/R1@72+<a;P8,G0:Ne-YgKKS/O9V])^/7OVa:C9UOX@a;I
2fgG)=ecE,6Z<H8[eJS1&Z@cgL+)QcGNQ-P\3DGK.2C5e-aF-20Tb3Q#WJ8Md&MI
8.R#\[//-gSFdON\ZL>IIIB=b(8UX__0W6]IV<K0^3L4[Af/-XC>[5<CAGCTY0K>
2BK5<X;(Vbf1^O=]9HD^1AG)FVJFIIT###7c<Q9&HcDd42VU)6(W_QPF0cP<5-1H
C1;EQFZ(8g/LDQ]IW?1R9DbC6O:UHZ?H+<_<DCEHac,(N<f&^SFN/dPFN$
`endprotected


// =============================================================================
/**
 * This callback class is used to generate APB Transaction summary information
 * relative to the svt_apb_slave_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_apb_slave_monitor_transaction_report_callback extends svt_apb_slave_monitor_callback;
    
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** The system APB Transaction report object that we are contributing to. */
  `SVT_TRANSACTION_REPORT_TYPE sys_xact_report;

  /** The localized report object that we optionally contribute to. */
  `SVT_TRANSACTION_REPORT_TYPE local_xact_report;

  /** Indicates whether reporting to the log is enabled */
  local bit enable_log_report = 1;

  /** Indicates whether reporting to file is enabled */
  local bit enable_file_report = 1;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Creates a new instance of this class, with a reference to the APB Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1);
`else
  /**
   * Creates a new instance of this class, with a reference to the APB Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   * @param name Instance name.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1,
                      string name = "svt_apb_slave_monitor_transaction_report_callback");
`endif
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on APB Transaction activity */
  extern virtual function void output_port_cov(svt_apb_slave_monitor monitor, svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of APB Transaction. */
  extern virtual function void report_xact(svt_apb_slave_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_apb_transaction xact);

endclass

// =============================================================================

`protected
GdJ>D5eT6dBULSU@Q/D53]LWbF+QW63L5GPN1R6\B?:<\0PH,g>a6)b8&.&T9;_9
PAT#VA0f(d2-;]8gY0+AY?T-4&4DHJ=^52JUX5f3AQ)8Xg.Z4,RHKfP2)@BR>@J<
#b5F+N<Q3&F&?Rf(2cH&FI\cNT1;(LCECZJQfKc.C/NWHO;A&M&-U3+_Se(NR.U\
>@@TD8dadc(+fRBJO91c7aA@_>O4?&=1^0C##V]-;\bGH5,2?[MG_20#AE4](,&b
12fI0gM.>F.9^.VNSfX=Z.PFS[-:0SX3^UgZ1R<GZ8?DEd;L(.GHWX]]BH(N>OPQ
Bd:3+e(+:(C;V@Ka-@?DT\14cE&OUFK]KC_Og212.+f?Veg))DAfV)U3eTL>=([N
SPa3)D9MdT_OY.P=4S=eKC0;553WP;@\WPFNI,fXKc<3/G-SfcT(A+^78S([4EUT
@1=9CF\HENGeS+RQW)Q15H]Zc,V;4MX@K4-:<FZR5fM\<L369XdbF1g6J-,IP;^8
Ma<Y3ML>XEdA+g8Z0Nb?GE4gG\&-@LUIG6C#X84&=M,J&d7MY[?f&BR(<J#3=M7c
VU7/3FNJ:A(^6cS.b:DYEe)61--cHZXdTYHG3SA(#c5#ZT]XN1U6P,_/Q:G2^_Q2
_YEOScNg&<WROY9eA;_A]ZCO)2=CCa>S3]MH9b/OUNQRN1#1FGJ?.[;GDA#V8dHD
],gHV-<71FMgda/RPa(>SKJ;1C0])-?Sg>M<>L(U5L@RBM[7f\Aggb-=C>TU/I@S
9.,V5/DEP>3L7V+CU?B6(9:8((>ge3Rg5WU&OUAUEA73LNTQf/YRYLJ.8BeQ#Z0>
8Ca0T;L+EddeS_NQD0dBGT0H4Wc71Hfa][8PMA_,#(NZJZd3ZV]f?GdM:fC]2\[>
f4BDWgFFLZZRK):[ML]8-R7VOEH.b1&X,RMUNd#[/f-;(:7.=.:;5_H/ZQ^eXZ7P
gF_5?TBVaE#-_G8[A[WDL&5:(gW2ae[PD_MX5M4U04LcP[@IDUf9H_b(GAYea?_b
@].7>/_3@ESHb&\<9e/(9QPJU+R=K#4=6V:QGeXg3WHQ?CTZ[9S,^]P12;\X:g7O
5_YBO\?C4)<)OF_5@b-Ac01T>:\Ge0=-gW<;22YCd^T-#_>BVD,YQ9FS?4Y0]bHR
?:[L.aYC2;Vg27GONX(M\IMN]&H8C@(EU;I1I<]N3,83WEW/RXOecGSGT6UN/#b(
-fYLUW=LMC,[2G2b.MY#B/90YHb8Tc2I[XK0F[b>&\Re,GQK8;,B,:A9?AO<FUeK
?OT,22=8C-V#bA7M\/)ZE3cIbdLX/(@:YU1Aa#SZM2#+gLIcOG+6aN0.N02EKGV=
@W[E<KL1U_)D_eLRg/,@=#20E7,AIWODfXW)8M/9fY#?K;)94I:,00Ie.AZA_K(?
ec6]O+#EX(,(UXW/[-NYMWE<GL01.JXC9Xe3(:5dJ<9:UO)A1@C+<R=3L_C@:)@J
?3VTYZ3,Z-/^2/\_;65HHT_@.=bfRf9FOI\V,V9C_),@G+3cbQY&ZZPfX?HPD<\W
-@19J;4ODdHY7-21?ScYRg;:=G&?KG.YPIVgfK)_04PBE2H,0TF9)<K[VG_bJAG6
Zb)YQYXdA@62>7I?GJ;Z#Q-5RWRZd#GbYB_<V5+Cf9:cI^RE+[<:A3PC_7OVBaOC
542V(ed5V\3,T]2.CDYUaWO<eg.&LK46?<e9:\_1Cf(K[UE(AV,b6aJUJ-LD/R2M
(\cUb446:G\>/[KTR^#g_YOMLNLfH(/UB-/.O<A:8GNc^^PaKVFMP.2SH[&D46QO
(e_R<4fC])fBaSA[#+e#TM9]\HRYR7.A=W8S=BM8U8/7b4bdWAD;\B)X[OTA/QfT
89cA8MZ+BF6Qf_GADg9bBMS+BA,=(OXK6)T9eF^7C.WICXd#Y#bPWL,\H>I+&D9#
8gV-I4dT&G:gXJB&Sd3TeMQb8cSZ\H#&^5]S1[1^]D;ebbf)(^=96P^0R)ZLb+4K
1B:33F+FR0^1T:e]1_G5DRN/7,5\SA9.K.08@E+T+Z9Z9eP?>-Ec88HbNL61P-Ob
4Q68UT1E.,QcXLKUK3a6P6ZO/PCgLL?PIa9d_]Ec&JG_bM37BdK3;O<L=QTH5\^C
8bZ1P:+VaK1F1/5fZUg]aT[a.+NL3I)5M3D[Ue(G,G/@<KY#S.g?(Z:H-a5]g#Sc
^EOV<O6cfE_?424D&SeEKf-M#N_g(^[XF732(71\6DOJY#^1;S@O^:[4=5J\MEfW
J:6XTKbJ<BfD^/=.I>ENM&5Ae2Z^P6OUKA:&75JaF.M@\U<(?SEV@CN2:E<U?V]#
F<4E^?D7?:-U.;+W7#9U1def@2M;;)H\-X<VIL)g498Jae>.V2>IV@RPX6?1cGTX
KI+;GAZaSQIbF[QFE(1dfaG7@HS)b0X61U8c\#.4;XOWL3gUASK?H,[gGM7NN4^e
,.XN8f^REI3X1/Q[b@_WH1;4FUBEEfDQU6FRZ1e#EfT5fFI\X8_PSL[feW;1CY>X
d>d]/96bfN[Rc7AS&b._.4eD;[O&FGO1]TJOK37+N@FJg#2aGQE;KOK&MD=5ISB4
LI=\^e7+==4(3L/9@4dO[2WDL)/II3_a-MA74)R>++MT--&L8O1C:#BdGHVWC1M/
^5@8]IV.YZ5cUPQ-fg,OFW=.BTD(:,a\8:dM5W(H\gfD^_]&e2f:Y@M^<\81L^^L
d]Ia+E9TBF0R0KQ_NO;1H1W()\8\TE;-A#aP7>NZ?V/H(6)g@NYM/H=eD.ZN>@[/
d\@##L[0_JZ9/.CT@LIc+5Z&/2aXJ>X\bG9<=a^T\R_KR#1dP3PWW&(R)d6^T9^J
-6:WLbEZTa@K3,R9\.L28&e-ZFH@E.AYHab>(>-I::JWb&GUB.@=0Hd0aXZg]bGS
LM-WUF?feF?][g0T?HGC97_1RS7NOdObN:B.]HRJUMJ5;3Z+K1LeC:+^D)LE73XR
0&,ATM.#6PN).S-1(P-?:_F4?59:0=KF^C.=cR2__fJ5+69GP5\^>6DU\2&bV)37
<,0Y=N;09SH;RNX80]^O)X[/J1SP>6U,OKE^OP(7P1C0MBf#8_O]JH0_/[G^VNXT
a_AJOVU,IA-6<2VPIfSVS=;)O6?-ce]E/6IEaZ[dfMfWgOW1:@0(+aLCO?NM7I#+
/LXIQJ1Y]K+4/W7IVP)BMd?Cb/e)H:dG8>BZ5E(L4dT#784^M^BI],#cKUEDB((&
4G5gGX]@TP+?>9/Y[X()ROe+?U?;_KH_DI&:[OgI<:[W]K0?EZc:e1=Q]bQE3)O&
-d;\@Jd9R#aSDSB\C[=+Kb)PC=W5EXR[C-=+_N-JOTf]K0D(d>T<+>B8UW=,]FS,
>.d&^YA6Y3Y^KJ;^I)+F=fP?QZND@)YF+]1A3>WT.bPacKcbT-?;Q<AaGJ[@Y\-I
])<NDf9[/3VDK[CFc]6#\.DW1W.N.7W<@I@0B^f&>.aQ[(64<T>_C#EVEcObeT84
N_a&>UNZ>g2U-WM?D][(S9LWeMd=#NUB/GRO[W\U]:G6XFX@2.JYD.#X,-=<&>B&
bN^6?_1?Cc>Z3V=:O\=X(?@gL[WET\[1)@(F8MP-8S36JF&<5Mf4R7+/gFeKCfY,
/LK@A66NG>[5LO)M.Na3AX(,\>LSFP+EcM/DGG;Z+_W)C546SU1+0,0NM<AaKB@O
PK3f:J7=XG7]&gIJQ?8P3&OMec&9#GA02HfD&&US80;O/5I0:PX)\]2BO(ZV<XfK
EZ]?S6V;D@)G\a;XP9MOCFd2X7eUEP<(QaT\JYW[fE9dB/7;X]SA6,14G1UT+BfO
Ld/.DEMa0W?E#R?XVb6U)HP,H30gERK\@$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
