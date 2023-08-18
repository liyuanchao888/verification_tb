
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`protected
&;5/>71JOEaYL5,_,#^^K.U2<B@0a^Zc=V+JQKNc>^UA4@bPc_7&()W?NGO4\=Ta
4.#WO0C8]:SGW3Lg@+3a7b^-S038C2I(845-9P8&[FSZg6D#=I-1OK7M+1NDN;X#
:6UA3U,SP1gM>MZP<eRK@24>Y-40KB-AG_HaVfY6dbBb9+((\7Gf5=Ec4IQRCZ:\
-GATc1a75/E^E51@@(WOY#@4?Ie0H#+\]G6PWb>SMH/a9A?0.<@d>I9IASfN^6_H
)@28)>X4BIPV76-(NO?/7Eg[YH0.gS3g59I2c2K:d3=;:P9++4U>#5(05[SHM8UC
CX6=#J#43dPKVE<-18=H]=261fQ;Hb68gSM05)4J,>0(IL<YLaSMM[/0_]>RbcBV
bY;ZGRT5ACF5,[fLY=b25gFOAYRcG<(9FD#6.CHF.#E5BX[:QV9Qge:F.cedJ8TS
P10(8a2HEL<.AP_gCD6@ZG^3C)7f3b2<(XMIV0X3X97:V.8\aF#W\5EJ5K:1ZIRa
XA7A5QN<?d?\g4=BIgf\;UE._V^N2#Rc9\2\X0)f7=3J;e;\dVQ(LIEJN$
`endprotected


// =============================================================================
/**
 * This callback class is used to generate AHB Transaction summary information
 * relative to the svt_ahb_slave_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_ahb_slave_monitor_transaction_report_callback extends svt_ahb_slave_monitor_callback;
    
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** The system AHB Transaction report object that we are contributing to. */
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
   * Creates a new instance of this class, with a reference to the AHB Transaction report.
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
   * Creates a new instance of this class, with a reference to the AHB Transaction report.
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
                      string name = "svt_ahb_slave_monitor_transaction_report_callback");
`endif
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on AHB Transaction activity */
  extern virtual function void transaction_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of AHB Transaction. */
  extern virtual function void report_xact(svt_ahb_slave_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_ahb_transaction xact);

endclass

// =============================================================================

`protected
bY4\,Ac>>P9.N,5TGf+a-O_d,_WFU3@4LI_[VT4FaMZVKVXfZ2I+0)#>cS^AGLD7
f4&4Sa1_07SZ9(5-N..15ONT\CT6GM/O:;R-+1-2_^IG8>=K3OAGFD(@?)f+G/FG
O0IL?L-NPD5&/?TBD1]dY55[7J>8&.@EF^8PQ\IA.99TH+,O0FNIFJb/GP?Qc:e,
43+4\CC0N@P-9#b9cB@SX@B>e\&EHZ.0,93Y+(MKX=DQY8Kd)\MMP<O6+g+)Z3EM
XaU5=>L0S,aa=N)F:XH3@NZJ)cD;.RCB##,D89]Ub\2SdVVDOMUR7&9^MfdaOJMQ
cf+;aWD/,D0++d27&8b/&>5YJb6W44C+G+0=Ua=<=FONGS6<.9-&fG+^68RbFN0T
XPf4<(KHV=g2<Xff_a6+Hb5B32G\DKURS3[TI_e61VC;GXZW&=#=R.Hd)7@29XGZ
8/#C()Ia4#>.<A5N@cS0-EV:MS+Sc<9XSY>[,9#cZGMa#I3O9G[>0c7S@F39c4@f
=MC(_45EHbN\IaS+0/]8-?+R+Y[^cOF&3F,f^Ae/b??8gc0-5_XV-FBE7&,5(K?4
[3?YHO+/Q^g,3/D]\e=4fZ\IZI=K1aa[^PXX7dC(bWG;<Y6Xc^P]ZVA9J4)(GTHG
((c73=Q5[6V=d4e#F[]K>bD^g0K7,U5\WNK8M5(cX^cg47LOHSWe3F[GGR[DN&2J
eYSS@/KYED1#M72)bQ/A<)>=Eb&+N7L1_.&KTg4I[.\YQ6VRg79?_8]INV9.4a2E
8X-?a5#(@eOUG-+\(^9eBEOAQKRBe7ZG>)a/I]V-?]017ZBN:;?UeGF&aKNGSA7K
^gBC50LW]1^&L_5X)b[,S]KacJ+@M364CdAbLHfb#6gc[P-M5E6[(HH9UaaJ,NC=
;/dFS\WdZ]a,f>@9KW>51-3bP8S[;-gJ55I(7Wd=2=#Q4ZVd=Y3?STZ6Ye/]J,EV
1(V#cE(4_WNV6(MaN+(&?JT:SPKB\#^e8:g1;O(5NBW8HK_GU,R#W7WC6D1B4Q#?
KVF/)Y)Xcb:^AWA]4WC;6cN9)[7(5KSfV>Z-X1]-[#U3.2]K&Y/6Qb_0\(9aF/X-
?4#(Y2V8EJ/d2Ub#N2-URG(d+0\4+R]70EL_F\I;b1C@H2;bc4cM+(T8YS-=K9;(
gY0cAf#aL,aOcC^+H@3g;_4QHO&)aT8g--\Ab]daU/>NPgJD3^J>fK+#819AD:G0
K5(\@<M2954-;2,P+8N2.gRZHYJH]4<A<U-SA>fWSG334.=ROTYRU,1K&JODd1]7
JJ3N0_9JU(5E+]@]7V-4OV84Z517WJ4(>fUYE(YM\GM#d[WV\a#.]D:MOO+,B],S
NeTVVK_aSKOI\UE2H)],WCF5;(dZO20^&KO4#];PBZ\0-,2gV03^V;\VZg:5bD6&
CHA_)A2T3[+5VHH/&Ld3?Z-E;7@N]f4U]7=P]-^Sc;J,b<Z+;CDEO<AU6,U=XgN5
D1@#+P=;V6=^4ZY]GTFBE(W?]&gbYR,T9[[D7V08GF,(HAOR6NGRg0:O3,NXAfXS
.JB,TA569.Fc,Xf1H@CDQ[MRb^e@Z2FYR=bDMW:XM?[?DO6J&cd/e5;XY-6fZ3Ze
W\F;f4(WBE]4#:1X]-JfPHO=+O\eEeO<NZ56,>Q,W_X8M3_/bP1G<7bPA[MY:T-G
>UK/ZIf4TQ,+8&,AED9VD>(-X]\QME48JT_;Y8/H+.R]JN=/,<OC&UBUB9F3P407
VP,#c4BTP8fM@O<Q)-/L.]XSP[gH,[CNaZ,E,:Yd-.EBMY,@LbTBTbOe:;GgdL)L
93WUW2-^9Q.5G-7LeM(V3O5c5X82[b:cP1QNASB[:_/&.#eag?,F[5+U3N[2E&KF
&CU6aY4-YV1(TDX)TQS(91A?L(0JN@/JKQ.CAR<:3g/@;32N-ME+U8\8D^g-A-0Z
7^N/8ZQ;_//=-1fR6NM3F:gcPg2b@Ne7GHD1NZ=G?<I_c0NMX,B(XJGe/S->Z_Fc
=4(XNd;fQ,dCAJL967]?g\8E,N1bJ;7JD3_Jg<L@BE,bdbO_T?O,g0,MEDF5?#8V
]24HP05]d#FC^7@7QgQD,3fdNM9\:EHUd&5Gf]T\C_CJJGgIX)4A?P^IBP:5,?WG
BfaId(5c86gI&DeWZLMfT(?RUWCZ50bG#@/(SefYb.b=CH964F#FbaTZ9HMDEA[M
LNTPVMcQ(<g#)a5g1e/.^O])Mb.39NK^/./#,fa08X^:+BA++A;]<6+O+O=8)(F)
_?CJ7ESV37J\@gC)U>C,?\+G8+B\GH4_4Zba^.BF)JMd,0>\KZeI_YJ_U:GM6\X-
-gg]#DTg-+QKUV[2[GOXgWA,^+AdDATaVO;XC9Le]dc8bPbC0?]F242FYGT^#TCJ
U]XD04P73a_3e=4TI94W\;Ob=Sc@VGIY^ST[dJaY@<HC)\&(J/H2W+G/Pf]_;K(K
(U[O=]ZWH-#IVZ](B[GY]VMTDEPgOYcOOcF&d4YRgV@CfI,JC+Z,.V6)4+(-G[c<
-J5454<;NC?f]5acWa]f8T1Se\-/);_1M9NR@VJg.<IRJ=Q>4EH[a6WeTY=I@G7^
48Rd1FfHc6(=6.]TS/INS_RPfbCCd<UH45OS[3LQTOF?]<,_];2JHfc1QMe6cBJX
P>GRPJb-8-L,4McZO8.&;7b5c1829+^V979-]a7J)+-+NJJdN7S@f+QMDM<(X5>]
Rc4NV>2RB\)a]WG^d0W.:O8E-?de7.#(G2bE9_<]=gcJCCY6AG)VGX(99\I>E-9-
1a[]7D\M>X.1CH1Y9O&d&^Xb;[35W;Z,CebC^?F_N(8:gU<WN:EHf1NT^/?gQS)b
g9ZVY6#[7f35R\:G9C(;Xa,P<a\Y>,bIP4)S^aF?YLL<;T==H(c(DAW5_:XS0<OK
#VEE\3FB+PUXFa7?6@+;&#deV9&DQ?a76^K5?@GV]LAB8&b::>=SE]bLUC]<&G73
a5.Q/O<GB)71A^-1\\<H4RfcR-Xgb0Oc)1=;]b#,ZCL6><dG7C;[bA1&,H;/P:fB
H&3?U_HPQ.4\]&SZ>UbK2,Sb7<PE@)F:-I7;gXWIb-]?2QOV:UaPAdX2bOG^XK^)
2Z0-P>9-9M\WFdeQWd@S;6g4;SHRT@AOWP^IC3Zb1dS7])6NaddTZ19JSPKZPbJP
?+TAP=8KLH-?,KafPTbUM24^4YYBW5:9CHPC97E2</_O2c<fXH:[f.^--0_2^B12
7G2L=T@G.2\fWK.II66GAA3@DMNafW/H4.&Maa+@UO(5_#4,GN_.6#?=R4-(.eLQ
<d5<_[VKS.??0cAAbYD&4X5<=<PM@&LQdO?=5ACU#DbP=\EeV462HGNdONa4,WA5
9V=7M#;1P:&dPUB&CO=Q&92DEFL+:HOe3gc3[Q5#6?7KZD>dfF.O1UgVG]BOTQe1
I/DL]HHIZ[JRX@D2dfG1LQZT:82W\)+W97aQC/(fFAW)T4H3g1P_Z#e6Y_&d)<:B
X=]-bI4d;R-gIBCa-U0_H;+&R:9^e2V-e5cN#,MTIf3:&5B@5IWVPfEP+CEEXF.N
_TK\ZbJd4UZ#1GJHd>G)\3Z2#YJDFI>gX3.7)87=XV##,eQdR0KEG3C[0:[GEY@A
XbEQgbgP_#LOQKUBA54.A/(ad?#=eTeCO88c(+@)9EU.4LV:/c9.M)WBdfbfWYL2
<\B?#d2Rb1D4dEJ-+0Bf?<Y1_E,[-;(IW3#0a7U)PE181LUCR7,^JD=0f(_EeTN#
9>=_C_A=aZP58gV;CYK1.SY6c<].I8([P8:0?H\IAf<RB@N<R[L96NKN#XJ#QDD#
>M/(IK:-Y8A5)a=W+#F<UL_a@N>)LaW<cZ@RE][TM:5RH$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
