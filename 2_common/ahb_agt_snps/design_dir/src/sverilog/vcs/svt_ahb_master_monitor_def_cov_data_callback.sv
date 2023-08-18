
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV

`include "svt_ahb_defines.svi"

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_ahb_master_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_ahb_master_configuration handle as an argument, which is used
 * for shaping the coverage.
 */
class svt_ahb_master_monitor_def_cov_data_callback extends svt_ahb_master_monitor_callback;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Configuration object for shaping the coverage. */
  svt_ahb_master_configuration cfg;

  /** Virtual interface to use */
  typedef virtual svt_ahb_master_if.svt_ahb_monitor_modport AHB_MASTER_IF_MP;
  protected AHB_MASTER_IF_MP ahb_monitor_mp;

  /** Event used to trigger the covergroups for sampling. */
  event cov_sample_event;

  /** Event used to trigger trans_cross_ahb_hburst_hresp covergroup. */
  event cov_sample_response_event;

  /** Event used to trigger trans_ahb_idle_to_nseq_hready_low covergroup. */
  event cov_htrans_idle_to_nseq_hready_low;
  
  /** Event used to trigger trans_cross_ahb_num_busy_cycles covergroup. */
  event cov_num_busy_cycles_sample_event;
  
  /** Event used to trigger trans_cross_ahb_num_wait_cycles covergroup. */
  event cov_num_wait_cycles_sample_event;

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
  protected svt_ahb_master_transaction cov_xact;

  /** Coverpoint variable used to hold response per beat of a transaction. */
  protected svt_ahb_transaction::response_type_enum cov_response_type;

  /** Coverpoint variable used to hold number of busy cycles per beat of
   * a transaction. */
  protected int cov_num_busy_cycles_per_beat;
  
  /** Coverpoint variable used to hold number of wait cycles per beat of
   * a transaction. */
  protected int cov_num_wait_cycles_per_beat;

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

  /** Coverpoint variable used to hold trans_type per beat of a transaction. */
  protected svt_ahb_transaction::trans_type_enum cov_htrans_type;
  
  /** Coverpoint variable used to hold trans_type. */ 
  protected svt_ahb_transaction::trans_type_enum cov_htrans_transistion;

`ifdef SVT_VMM_TECHNOLOGY
  /** vmm_log instance */
  vmm_log log;
`endif
  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the AHB Master Configuration instance.
   * @param log A referece to vmm_log.
   */
  extern function new(svt_ahb_master_configuration cfg, vmm_log log = null);
`else
  /**
   * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the AHB Master Configuration instance.
   */
  extern function new(svt_ahb_master_configuration cfg = null, string name = "svt_ahb_master_monitor_def_cov_data_callback");
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
   * @param xact A reference to the svt_ahb_master_transaction.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void observed_port_cov(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void beat_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when htrans changes during hready being low.
   *
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void htrans_changed_with_hready_low(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);


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
  extern virtual function void beat_started(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  
  //----------------------------------------------------------------------------
  /**
   * Called when a transaction is ended.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void transaction_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

endclass

`protected
XXP8HcB4GUI^15+3bX=.8eWRdVC:cJU-W;P?I/H;W3LTU71FFg)K4)@F./1[W4-I
<H6aHg/O21F7JJ_LEO4WJ<3(<6GANH)HefUF]1g,6ObA(A.RY8^<C=FYc=I/A1BF
bKKEGCdGZ8b7]aK8gg5W4U#.2J=?a(0^#6,?dK+HK#<UX-HO_8<D+=aC,Ac>7NAL
;V-g;/g9XNA.B1&UfH-=H/L>CBOf<PGU)E=J\@4(,5N4[2=_eIe+7GZNfdWUMGb?
QSb-gY=49#&:\_I7H@-J+6STb1G[=>D6agJ=;A?3U4YbLHX@.@8U0F\R@F&6)VPd
5W(_\7/F#K?68E<#.b>F1?;GFdJP&V@:D4K>W4TW4WP/2__DHI9IS@bUAAPbG17J
UR43?;QVKg^U-gV+:]@&JZ-dLZ=F9\,ZI@@C6gKU8?f33f2+P=#T[2SI.97A/VPD
Ld7cM+FQ;[F9#gGUN.]+Pf]PWLS#-I=#/?FM4T3Y/\-6KcMe0G/0IQ7+Md27S9_P
)b+]=MB8<?>5Ye0e?[fCZeDaZEa]edC>\8UF&aWgKBT-+BeX>H9?Ge<g,6P,[d\]
e)QZ^4P9.df;M.:C,#\<L3+H557)M3IZe]S,Y@H4@NbCYT+/(HTY1RXK><[G29YQ
))=@SW#<f_dMb?Sde.OD90Cd@RNMS5Y?5PN0)VJ_0JR-;dQ[F:cJZ-X2IN=.U5X4
fO@^Bc)83U)123A&;-0LYAeUbB1SJcT5(_)&E>7\(D]I8V<.=+#HXBWJ&I/+OHG&
OZ^E2YJ,0CK&+_<W#ae>OZE3L2W@H#1b5Ga6(TDF=II/^+Dc-WL?97[BUc(_Z@@Y
/XeFUP2D@fIU:ZB._QBJJMaU/6a&)T\-M1g7323AG[7;Rd/NPH[XKa_[QU03[][@
S)cO-dY+8]IgBVYKKaOd)GV=/Y&E#?dG.98_]YEMMXPc,fYM;.b@W+LGG4^7WTEa
?,PV6A;&eX>Z__6B\_LafTEJ@,1G]Xg2PC+&.-0g;0>2J=I,6&Z.;VO[>272J[Z#
?5cGfL\LYXC0Se.[F:.BR>)BZ&-G.0]&E)8)&[a@V_0FK.#>)14RM4W=2X=@P,HU
\VF8b/9E56[BRFK]Z:7(BgA_Edf6_QS]HQPPE)Y1KTCC-gT5S1,,&J5YX\(:OQeZ
[SD\7\A6FI)8Nb/)0RQ_ZJ1:D&XJM+4Pg:K@gK]O?dL7I?;&TUZ5P@2Ic0?6S]30
^cA22=SW+S.W)X)BG7(JOg>D^8A4Dc60S^bK6dP<I)c0fgd)[7b[:aY\=0e8g^<_
EIX+,=.7[6TD1LfT>e\d/VA[eA.]6-#=d<,;9F1,,>GH+MIe;99I:R/)=PA0&KeE
2H#:8Y:d4Q7+IB?bWe()<\V1]-2@>1\O.S)J5_4_]YB5+ZY_c@YV_VDgOLMFdOHK
5_DX6/XXIT.IH_9PfEW].a,VAM/dX[S4MbCZ=62+b&_Y8/T+/XX>?;[UCUS00<DA
S&Y,LG\&+77Lg7U;-_W9+\,0RJHBg[^,V_CYXM&0DFPe9U06U3N),5D]ET,1OO:.
QVFIBBSN/H(A,86KaA@Z4Q@@CROHX+deLEG]XRL.Z)0IcN&7;2Xa?D]Tba9_?-Ob
[N-N+:H)P9YQB?;JJ\#]BT2NN5(5Q:;d,EgM/N5U2)R2e3)cE8?3Q0PVC?KO_5a6
feB=\G&DXIA;6SQC27B,+.2SGAVS=/NYQDYL0Ab/,?e\f&GQP<_ecUHL)Ye\D9AQ
A4L15/6Jb6R7O@4PUX17f[+E]eW59a/E\YN\\N@bDAZcOJOOAFFg,,fg^KI7W.Ba
e815^U)R;^_N:S=g2Yc]M85,\TC\&/[.TZE8X?^Hd8#d:&NQ?PCOEJaR^fA4FA[e
;K_E2S/@YG0HHZ-<QRZ68+AWDV?I4K\:O8Ea1DGWKC3H^F[V]e)XUc,.5F]O-g#a
:a(F75[];(#W8_d]O+_7L\.efFQK#_:#:<&0g&#d_XGCJBY.1:-LgY6#MEH-O1>4
U+CC.>5e7/W/)ZE:L#b)@J3O71_,(:SD>ZT8N<#_[gUdU0MNB=4X^L4>&27(K]MZ
0WUdUcKUL4W]P<85g363-aM3Q+;c[dUf_L<6C2b?R6e:@S0b(LYP[7T_9MQ.cB@#
Za9CEAOY)M^781SH[NNQ/SW6#T2b6>)Qe(ML.K+D64gS<G2@3F3M7A&b?9dXFC,)
_dM3F:9gJ5WM5V(P^^VH.2-A._:DBW^8T.gAR7+,\KIUe-@fDX1]+&fU26)?@\dL
7YDJS0a1DV5YdS.gD7L_U>dbTPX2d3AGfKRXgcH84-dbD;OCcd0<:#DP-QN5)@BY
>G3XT=G_g>b-UOD-2\;@-,cK#LE/QIA]@2>I0K#@C@bP]L],1>W+V1[K63=-7:Y4
fWf7H;23a\_/(\aZE37UUCYU03fF+YWV14E8O]TB+@dS9fJG>@TAG,B,4LeJ?7,b
?&4d3_?+CB7OK=X;(CJMW)SR>>ZcE0,&(ZAUUN=)A_.\TTL14aJ,Q>C016YRf,=&
W1_b[-@<Q9_>,3AR_.aKT=g&Ua-&Fd409)bW<:K[U+2f8<S<);JQT#Q,7GcDcM]c
8^X(,A.MH<NB]/DYQ,Z(Z:PJN&1996Hc<HZF6>VG@GQ)&8VfQFVJbGXa7-G4.#[_
+8;O<QMOI;YNN>eIZF?1@HF_Beb[&S=_T9QD1&WGI75RR2YN@<-=JF/L\efLI32[
cO)90dGRcH480-0(Z+PPg9:CfGHG0@N&(#MZXIJ&aZb_\@?PdCQ2L6a0I(Y(+G@S
#R9a<^L6+c2:;[g^L5YPT:5UebfG#,.EQ^J\0GB-(K)I#Q]dJ,JO@dFfMH)1RY\D
OLGafP(;-)ab&f/XTP:IF35R(F3:YcS>?QFgZGKB:7(8.LWcOI0I7VPP[Hc>fDBA
@/?fJ7Q>#c92g:/B)Y#@0OU@?0H5MBRKOTQ>4421G,MM#CfNT9UH09?@f/A3MU9&
^P/^G97e40A(1#>-7WH&Sd<X(A]+)^F,GV^5<PO\C:D?-B@&RV&VNbLC^^Q#[5)E
cBC]bT,)0A1,K>T#7dIKQ._#ID,.S-[SX9/EN91U((UU/cS\.AAOGD,&/2(-E-g?
>^>LPI7,MI>.B_KA8H-g\c#,H/+J9(IeBX5,7)fMDB,@c;&AZ79GG(b:[\YVI@6@
^d37IFN4(IS]SB:S&LWQ^7W58f02TWCE#HY:@dZLd=VRX1FS.N>\S/c+UQOGA64_
8UPV\Bc\PKcS8F4.D@@ScWGZA:<[3Zf@[\XQNgK_;5@de4&OP0CQR9db.SW>cX13
<42YKI-f47+N#(<#P(H(-e:,P^#YTVWD_?C<355J^STf-DOZS;>0J,b4Ige[#_ON
^f[ZUg:3#eUg.QP)7@OTJT&MB,J9WI4A_-Z17KXX]=/f+A)C?+EC,ePTCF,X+5VW
UGT^RW(=55(fD=PID#A/,9OUH#K9L:?:NET01f=Hg5bA>Da8-9NW=(,4BFb@XCP=
031Q>aWgD4d]#dC.2]\13S4HE7>U)/[J2FYc@5]90&f:]9)2.3L5#:6DVW+R&G_>
BX,[/L5-0IVV2>]#<.b&bIUEKX:N12?IL9@&(CNeaB4=:Xfa-R1_&EJ@R&,&XeC_
K0L;Y5F0_RG_;(H70WeXKX-N1V:9.<Z5BRU=CU]6<Ce39JU#(M45DC0:M:;e?9cH
/c0V3@;7d;f/DbV5d66OL8EDI0e0b&N+FM[5C&MLg_:Q@LWT/LIU7Mb7\M@NN3F>
#0JdZ>12(L&a+T3g^\0aACaEE0b.Y=-XJR_U/ZedYDfCW5J<<?O]JXY<I3L5K1Ea
\3Z<#SUKMCIg25;I0b5?aQV]R:4VN/33FA7Cf(\HL5Y?[GOG@-S[Ke24NM1CI:Lf
g-Z)1?BG+RMA4UWW/8BE9ZP(aY[\@Yb(;OcAc8_U5+R5-4/FMO9g=F<?Zb6I7bD?
_V,5K3GR]#:dP_TG)aFfTgdYTW4c:/7\;b<W(UX?=/:O39/XMC+ZD@L0CL^<Q#ag
]f>fI8REQF0TXZQA\LN9Q49X4gc4F[(=RIC[d?QDe#d)R-<D:NNRR#XPML^/#c3C
&cD18SM:7/>UfAMPbXRe_LAZP>.>ZcRS<F,Dg\8DKP&57DVS5-J_C)>f8e@d-/MA
D>d@,<MPCQ)6b1FW^BJc0S25&-/8#dG0dWBUE(C9+g;fJY]J)VU0fK<UPIQNC\/.
(Jb=Z6Zc9ccI_S19;H;R7g29J<&.L@Ua3a&T<(7PX7A9G_7BJ].aIaT,OZKE0N8c
UJJ^<,Kd=/S^1-2c,b<O.-5RVR1=6#FEW3/NBTYXL;2_I,#&OTTUM&G+5>8fI&S,
&3EQ((d[)EIdYf9<K<gVMT<P[A##)N?QTA;>O9N11=e6=KB.1AWVP0.9_TX_HELJ
MUB,RU>EV?ENf=3?fXFTg5+GDc_Z:7M_9D/E;BFgVK.]3SC/C:I>0O&:IV1>MN8^
M1S45_5K9>;4T[X,^B2aV;f&64]Jcf;eTMfT2OR0HYd)JS-HF0b5I)09[WN9/eTV
[O?K6:[C=G00O.?eVfHb@-=dfOHQbD:Cg23&6F<J6;H[><eG@BK-953)bB3&>S_B
.f39\.dG-U2fWZBJdAe,Sd3Z\]fCKD^4,D1K^dL9gKe:N@Pe;0Rb2X&gVG/J=T1G
SOBU#P^IC=0MK4^;e0@d-WCbX0;1XZ0U^ZHS+#.:T(^Cf&c+cX\9.;&XL70QLSMc
S(+M<fL3)6,=YK#.B6C]9?=<)3IWe#M;>3Q//KG)8D8-=aK>[-IU#TCf,/g?8Rd.
dJI3<=.)AP/99OM)@F)Z,42?^#.F_&&]#4SF(GMO;^06ag\0G3X6YV/dMg,[V428
F_/VH2F:QH##fL/,L3eE:\;c^Cd2Zg-f2bf=#A22HJJR5TY>L9TDDTZfHG_6d0KG
EP,/@R_T8R1;NC-#ZAKCN(JIFVE\(([X+LZ_D@G_X(>DD=?T.X54+HJLXT6P<:X(
gU@,.EY]DJ8.b;O?.;Z?FQ_TJ+0@;B.1S_NHSTMR2OGF[WG.ca6&L2f44=-1EXcZ
C.#bQbJ(@:X38+6?\P1Z?9J8[(4]=Ef/&3QC:0d(aXA;(1O7GbCTW@Kd;+]BPR9J
bBBWeRB8<f6+?eYUNA@Y0S)/AIT=IQd(ZbPO@+#02cacIcF:V2&-E:<Kc+_b()@X
_I_5>gCJ_:@FJ9@OVPH3F3X&X/26PFR9B\,IO>b]C&Uf:@SgD,f[W/3V--bO22V:
ZWY&_Gf#&.cA;ON1BR:?(8&J&N@5:8]LC1Ec58aKIF+da.==0JS3OSA[:0Ig4/WN
Ve][YIZQI>6GMf\<NQ4KPAF8C2U+=I/eHI4S;F@.&61H;>1.GP9Xf^TH^6<JcT1F
R7]97]b_9MG,PM9T/VVES4E:;:fB3ObP8\Q7>decK/DMT1?<]9AVM0K#I0TGf\._
2#2,;ALGI=G&<<&fK?29JK&Z2dHYA.+F/\+3PGE?N@b6/L-)=7U=[e+Mb&/[L9Y0
dWaMT3;C5LB3KXa8a;@X7=/g7X8&.f3>]T=5LA#CUgCQ;(;+]]e#A.c,CJVL)cHJ
TT081CXI9N247J]6bff;YN/FESDQ^^c7L<E.94:\THT\&JEPQ\Tf0X,-bG<BUP[X
3O(Y]LL\N58RB3^8.2]G1+8&LINU9V6HCRbV\I1S00#U]cX4<)+Cg:7SL^ATb)eY
[1FOWAW4BAb\9FRD)E0+HE=ZI)R:>ERU:25:<J#(]7D/aP1HJO]9.C9<86QCcIM1
U8]E,/<Df?2Ec6\A/R=:ZDW-TC#.OaO?6?Y_7gadCN..H;?_&_[5(+CZXB90FM&4
/cTe:^NLCL,_MQJL;Tbb=N?A6\^@[^,-52Y.1C_9::/5I_7JN\bT@abT[fIJ8cUS
->:R1=/20+,\g=_?NJ)RdY&TOU2cg:.)WWH+(TVP<AELP)5QEMSIK0Nb\_C+H()I
83Hc,))8T:eE&;F8#)_=>Ug)VfKe6ceJ-@NV5?N[F;5VHL:TZ,X(XOVWV1&SW3Ya
7Y&bWFN04Q)B=OE/V@<8CYM_08]H+,+6eTDgS,fV<B&R1UM@6LMD9..bN/4+=Y8.
E#[&fR;agNZc\3ZKE<DcDZZVJ6>D/&A;6eDBQ^J)cP-RfO\c?d=BaODd2EOI_3]P
+[M6>WA9980\+0PdM0M7d,4K#IK.41Hde0M0_80R+eT7]4_LR\+eDfK?-[DKSA0[
>eN&LgfDYLAYNPF(/;CX^,\4g49X@8A20JO&=EM-;YO1W?gd_>B>cZDfYV/ZfdDC
fM]&AKQ]7Yb\.S:-]50D3e&++IZ9=K+HK7U7X:.T_AA4FH6_)-+Jd)(IRbJ9IgN6
W+5N@/J4\EFUJCZV#[2a=#+2<YL[I91NS3G#WOT5L,I(0N>^ZeKQHE]WHG2A?F@@
gT#e]4#FPg]#7e2J)Y-c],NQ]/dIQe(I951Ad(7MLZRY1G-ZfTRKHSU#c>9YW@ZX
5b)9F-^U\ed2gG)0Y+2;<M1NfaN\(CBCPG&\T<,Bg]+<3MH156X)NUJT-9g3ER-Y
/0DRUBRb;;aX/3JcMBHINE2>9+UP/4=0&^\Q2BTHQQ]0gF-(D-A\P23&)M9.2Q;<
\)Y-__>Eg6f5^>^Sg^DIDbg7K:.##?9N(3eBM5SbYT(H<0TKEP(,,=_2F>W:\]2&
59P0;L,?ORGN/6HWT@;P]:FG445J8;eA_GXGeC++Q.=.T>eB,DGM:-fK&82@F_T\
H^BSS62<(f4+I:C(@IZY@GAU;S/NV^@G=P.U93U6Vcf1]#YX<&PU4^?;@)EHU4),
RDPT-T3_6FaAcM:W8G2=^?958>fD-]6eT]eI;bK/e2WWaF;W4GFY)Y(ZYWZ1P0AO
PT329d;CL&<A9]eM/Sgd&&0f4UVM8JS&_E,5=_Z&8J2\#cRJ(_=[e2Z.deO#=g4.
TY&^_D;DMLZ1Z5XIW37Ed.N>Cb>\>A5\6904Z7O6b0G+MM^LHTE6CfKf[1(F\NXK
K^Q(ON3-?^6g\dT6>9e)d<c=,AV36TRCPO1Q7[N0.\Ye0C1VDNWRIZg7G-ZGUTfH
I4@V]UT78gT-/2M:Lf+TU<FB.G6bT67YN@5L_DaW:=A3R5T_,F:+_0_]:K\(U7QI
3-/_.&/]Q7[DTW;EOU(8Y\@IA0UOgQc<03C?AWb7@B\K#[DDW=I[JO<U7A4b#5[5
E.@NQ0R77e]+)b(O=1L\bU):b)NY;4P;]XI,CIOe]SP:9IRHULL(a,U.\6DBAS/7
7fG2W]fc6[?E(6+[^XMVM)\Hc,I(JSD9PR\=\HQ2KXH<3K&2\AFI?(6IM\gfg8dK
[PggS5YX4Z._J??QJPTJ[XCZ[I=^Tc/1U4&S2M#SO.&+D#-=WOCaQ>=^5;#.VS3<
b@C&##,H4.W):U<<-X<8P8.6+JZZcN2e-X.)M1-E+>AHUJH16R2J7f3QIMB-4,C<
5I<fI8gc:16-_>H9O,VbK(]K4a;g?g1N[))XfQ7NgJR:VZ\U1;46CI7=5>+&<[5N
IW)2f>T\:>OO<HA0B^<\Z[fX@Y<TP^cYX[>\OF0)&2B32X\W>[]G9LG^UgNXR3MY
@V0HL,2D02fLFS<8GS/7[5U81g&JX-]g9&V@dc7W4VD0,KR7UP;fReW<Vb?&Jd+=
MXc9X2IHW)BfM6KDZ6WVCE:=IKO:egCD>P10Mc>@GYNK?8:/AO<K?(W9C>TWZ99C
:AA8\A([Ngc+AG8T<L?6#J(KRKgP;cMQeH,C54#4/(+#T3AR]L5]Z2EAJ?[DC#M-
(cc_L,OW1M&(ffUIUdf@NY&9)RVSGe5L3=3d^@PNW4Y_dZ?GaJ[&@X4b,GI_79N.
475JWC0Z;A6(,/E92#WI5KdZ/WR9&1:BPSO\0?B),#YROeTK@RS=C;C_=]6g3aMO
&(H4.7?0-;UY,@Vd:XcBYYT&9:1ZO1e4;(c[_G8>I\:TNa?=\;UbX?T^=N)ZHFX-
+HVQ)99[TTEe6<eZ@7W+^[I--5/-45f#SO5>Kg(HddI(CAZI;QW2W5K=JK((FbC&
FXS5J.G4(bWEVLZ]e#-9W3GSd,REc]IG?+9M\Tg&LG\2[UFaR.[YO[3(.gX#KXUK
F=cAG>DDgP4dC#J&bK_)(C(-A?Zg5)H[<6eGX-U.X^#3;QFHC&e:F_)Fg)Rb7:Id
0N]91T=J8Sc:6SaE.<N#D,&Y+([,S(JO\W8GFcb4\,eSAT^]J/V-BaON8V69H5DW
&20(4a490B5U^@(345IUd-7[LY021D.-E[J9Ad4e(-X&d.05(#KMgd[UJ\J[5D0?
1#Kf5<X#O<K\EH;d.TOHO-PPZ86P:_[C6P,7]34[Z7WBeEJBe:0I:>Mf2^#_S@cL
5VY/a10[+bXg9LDBeEaJ.?2#CAJIAGc+0dPR5;.#,?@W72-aA9daSUQ/3_JR,R72
;fPY1DHHF(Q:0MW[(I4A(>BN<OUN:(WdJbM:[X8-PR#((Z_DB52NJ=1WNgXI-HQV
Lb]9BOd3X+BcC\,]NWV<bae/Ra[gU)OJ8IeOKS9;[MHS3>\Z#_cFBXS&4<2KN891
E12M;\4CO16b(adRVS_Y1gRAH\W.c3F5>DV(P(X,#Gg7_0M_2:_XX^^)[TJ7-09R
7OGD>8f8DLK+BVMLDY0E452EQZ9@TU@e+NZ1]IJ4=TW<31/d4.U<=MeMe2F@EX05
V/g)5.S#F]RET+:aeB-)gBfI>Rd15>;&<ZVMD(2NH7V@G2b@KKf8:@?59//fNDPO
dN&D@g9Z_/D4&g2&;g^JAV4KP41T5I0ZdgT7L4VR0(;A0EQML/Je-+gVXY06J,@=
ba/)]R_0RL:6SFNHH\W#.c:^-:)E\B?TP<324Xcf@2KW2A.Ka]U+U7gccNV+HUS;
3f#?_#(N?Lc=JLOD^f-cB+b<a3(<C3<?\GLVQM7Kc)X7PY<H2=CKW.VHE8S.3HK\
4>\JTC+beVT42T9BBNE;2JKXa:^DWO)D=;V3?LPV#(b,0bDY=>TGggUI>3R.bU<]
]\SD6GVEL1H^g78^;Y)5?9f4,ZPb26\H\MJ?:,60E#fD.CJd/La3Y;Y2W/XRF[SQ
_3QaYa6S#16_JX)Z\g/J82K#-CZLNIC+>/^b3L\d.5@Hb8\W^8);4(/?g51cNd;:
AfV2>9=PW/HECgLe>-4:+S_C&;7LL7<EN4,E\eVg(c]L?Y?K81)BBAd0<X62=:HZ
,EC&1U><:+HP(W3L_b)_.b)8V?RC]c^g;e[SK]IR><P@Y0X:f=PSf^)\:R+ZQM:+
,#:bdTEBRdP),0>QDZDA:2a?:E70B8agZ?E\\Qb9M;9J3B/R[K)0^\>:[C>\XKBg
BH?JGUg#[5JB:Sb1961MGO)ffB/SUT4]-UPG6DFPQe5F4A@+B]Y1T;]b,(F9\cdf
NF-e/XG9?0,Og^H<^O(+g4P1>Jfe/9aU<JcDF(?)]J>^#ebURBG4Nb>cTE4T;9@=
W&g4;WFS=ODCY4\>54@=62MZ5(cbN\^_LB#_(\/.YX_F1UCZ+T..9ZIe4DF<]O]<
<K2;?4)K1^14]C)1Va5W/48SJ9cUMHY<BZN@6M4A:Kb9dUIXTJ\F445E(>+NBL+(
>>G(NDL>]HK>f_5e([#0c<9#,8U@6<6;\&0N^cK>+:)5F(+a9LQdb,1@4^&ZTE#X
<]gN,JY&RSE7S5X,;e:Rc\/JEKg=H5Ze?3S^+[NG9f5c:=aQBPOI?5@D=IHRMg\M
=c7c3OX^BIQeR)eI5.4>N9P4AZIIJTH4V)f2Q1\\HJ^22F[3=P+VIX>U?.5\<EcH
F;/P-f7<V:\fVba>I4,P2)7^_6?f7bIZI^N)cd98Og=9[8:[fB;A,+RJEc\FT@@f
#Y9EX^_WNC;+3UZ0G54R)Y=fdYe>JVR=:A;?g\,Q2_9,_1CXTB7322VY=dP\4Jg;
2)/IO3WU,0[#3\YP-\1(V,<e]:11PK0N6fI&C24PHRCVI+a@=L==BgAY0aeZ?3^;
8FL\W=,Og]fQ5<XER,((;H7>,5CgFD]BXCGGS4/ICM\I1+3-BISB8ebg<^5HF?+4
3P0QXWX4;\,)W,9(GIBf(Q5_3FO>_E.^BBNI/:0.FY]K>K^Z1SQ4;8HG2TB&)H++
ZIa?^SM93bAI?MeQb_I5?6V]\YR[#(K2^de1)@Of;N-/RGZT)0LTFB)Z&HgGgHA9
OTJN^]2N<?):?8CbcgFHeS:)EKUJJSH=WYc2d+:F;2L+3Y&5>I2QZd/SGUH-d]FR
TN:@1W=WLc13\Q[eM=B+6O9J6[BcQc1IV-\,73&U87Wb(E@H90EDF,/A]/YN_<][
72LIFU[#I4=.Q:V4C<2EF_g]3(:5QFKeV#^4G1\C?UM&J_(<)^Q6)Aa&BB]NSN.L
5,LC9fa]0^Se+40]IE?16&gJKcF-XbUeOb&G#]=U7FACD1?0;I&+:?OICYKd2YHW
.[E0DQ-d#G?-Hc4]#@.6WHM,KS/Y@&;884=S/F(Y9DXFT:M;^YIVYQ&[eOQ;AgYb
XPUbUKR61]cY:XUEPX+Xe/bPFYJ^=;KacA#WT8DXEg>PJ0FC\IU]9(b5_>gYE7@J
2O#dZdbJ8\79;6DBMIA)4ePG.?V--PH\I(\)]^ZUFC:O#gB.-Ee/CZfO+>9Pe)Td
739OJXD6.4]WT<C-WS@+Qbb1gBdTB_<NgGB?Z;&FOA>Z>?#:84+G8[L03(H2d(]5
1Oa8-N2<XJ3HNYLQ+U\M=>Qg5FaEPH;:bZB@CY8CS@,0HM-6T0KMIF]@Y/\WE_47
>K;WV&##_?KU^^51Fd=BZ.2<X]afC705La40Y#NG52I@4=-e@E5C4=?C,KS5=Had
ZPZ/MTd4cK[A,>/Y([a3X\.WJ5f,MNF?C])LO;JX<;#b-c-(N[+EQKC-U-[FI=7M
:D1Ae7;QF^bg<c6C<,Z4,Y;UKIV5,YKJP,eNQDV>?IGZP<C3KKGYZ:Yb+LLBBEMI
;3VEQ5V,+-Q5ROeRZ.O@_b>De/#Q]<b0D#J.]P.EV7@<F\f:RAN5dD.=P.^V?/<g
RAYgMW:dUb3U]SfW\V.P2#e52TUT#[TAVY;3fdM[3QZQ>7de3SKGWObbEEd\DaO2
A;c>&e4+,,5ZP31/eTIf00f^4>-a&NSF3OcbGP3e+=_XWOD9:1?gfG[W=R76^>6U
Q@\\IVJIU_CJUKGETW9H+J)X+P\_?Tg6FLOP-[K3RT:U171&f\M7GF8LDD6O?<gI
]aM3A(HFbT[aPdgT,_,1AcM2J(-A=QW&&M1;@E[,M@fM7V,P+?AY05d2D;Ye8B3B
FLCB:5/\+3c=&AYOBH\IRLY\\BQ0a+6F8-Ce(8Sc,W^G#X<S]5&V41/RDN+N>4HB
A#G[&c[HU[D+3gU<GM[b55XGRdY^3PC?ce.F?P[RD)ag(2IQB&E3,+LK1Rd(>@QL
]fYd@ZB-@KaLadFQ0=9NJQPZJSK#eC#&)T[YU&5gC@]ZKE:DWc)IA>@ePcN(942T
bMTe&RR>)d7WDDE&,)YL12+@#_]EYg+[82S(QE7-+9?54?428O[WWZb@aD[O]+eI
K+WY],>W,N.LC3b#QTKMUU<+^RKL)dLBga<f10B:\._K9PX/9GDSO<8X7GaM6_(?
EcaZV:[@5[e1SBW2d^9[585H/7L/U1TCJc;KK/>1G?U,)@?9bWg9/Mb#OX0,^YVX
cD;,/cf.#B1#7S;P<,U=K-112(3I(N8WV?fR)f(e@E-AgQ/Q\bAPfOb_/aHB4[_X
93,&]O&dO+OH4:4aRXPW0FeNeY:32J>1X3+MgV_g0D&)+GLdgfX&V0,\0CMP#I+B
-38QGD)1+H-2[6=<bU.P?9E@,<Fd-7[XbeVNH6&P@(aR4IZ1Ocb1)]=\>E4919I,
41#R^cR^(eE<=0EbDC/T&D>T=(bRW&AFJ7&<c]&)K>_XZC]@.:gVfT^a_&0]RA)/
FeLN,f1:G<g&]H,AR]P5eF@aCGfHGLf/T#(TO\W=\=N/bE3Q/XXTaW]]&cg@ZfA\
T-[=[D6^]QY0Y5a?7G=AC6CP&2^HeV?H&2@BN_a8,X^3_\gMI2CNa_)P#Y8M@.0N
6b\\E&e_^=.d]6HBcWT:-C?g\O.aPU2OUS2RD=a1_#;[bS8ZPNITcb;2IE)Q/\df
ReJJVI?9),DLB1B2OWN7HO86__=Id&=2&Sf,Dg+>_U]M/g&/Z3EQbRHD+;a-#1f.
0PA/C+-7f67SNCC068^-3b7_/F9Tf,W4NT9X:HR&8PI[1HV@WU)SfLc..3U6gITP
0II\A[TBX:dJ8?HHE44LC0O?;RT0_\]5efB(Q.SaDDS033I&0.M\;TS)-dE?+<bN
@a,S&A(RG86bKLX.\ODD3L4Y\WU:M=1+28WS<dLaeF]HHNNGK3F#=S^KC^^AH9b_
4AT+O9MNMbfee4?GG@+[NHIO_/7fP::Og6@CQR?A1-LXc<)AJ.]MbKGUH5XcUFaS
cAF6>LPD\CFUN>^Ld?JVNPgaBd44eS;7M0THEMP-0dT9A,70A3f=GD1<>K)YOH5?
V]e@[I5&-YFd_DF=]W:Y_U/R#be3.?LFPgaaD2e30FRR,@?[NV?MI2@_\1S4;A[,
L99S9Wb#G1f?J2O/IDfY+B#4MC[/Z@9+/CWC=Y5:R#;Oc2OM>U]b2(\)_3(a;?Y/
/12,d@:7bBcA3NBd&/OTbQ1K#,f+&3c7dcO@7eG(Ff_S>Q1;J@+AePXJ3fYbOA.b
X68.&e8+GS,I/Q]aL=Q>O6[EF8>@cX<80@00?XP29RY4OR,HbAa5=Q9Eg@@eANJ3
Q#KEgG.YG2??D-W7H>eM?KMa(LNUUUcEP=Ifa/4.aC((,cfUBYab<;@UgTB>A:]7
P(PWFV1[XGCK>ZCg(])<@EWHL&9757H+/MO7N0Y_8Ff>_GegF1)7T]aV_-&9IfHZ
XUg+NI:?d,8;<.4@Y<DS@/P4ZN9N+E8.^HZFeEF8f05C7X@&>BGSEH(5PSaGM1R7
XK]HY@/_SCLW[O+Y_SZfZB[g9aJ<)K[I/9D3@Za8;XF#)gT^)3@QgH/22YYf[HC\
.QQ2X-=R:0Ca&KG3.:6&&NCbfG5AbeN.A0-HK,[+Mf@/Lb9VD&<\)c6@<bYRA<IA
H^0cgZC:\0M^X&c7VL5,IB0..[Vf3/9):5A(OAEU_/9]2-81?BOg+P=23Dd==;GH
d(W4EZa@,8I3>SdW17aJHG8MDg<5,cIY]KPU6IUHQT4PVdRYcC-IXD@Y8^5C:/8=
d&)[[Qb7@I-^WR,;M(Q5_8:eGK=4V>E6G(ad&e@<f/]JKZc/1.V2a6?e+9U^?)<=
J92bF\<7XPQT-U]P&<AP19&BJ@bAUd:Tf9PG7F##JNSI__DX?\EZK+QZ-3Z.UV2b
&I51&gB/<M-(-]d+8]GR]cZ#9KeV]b-UPJ^G.W5YC/-P#;I7If-_ZPJKRFFSV/U+
ZKC[]>397Y@011RPBL6\gQ5?6g62,VH5_8]beGPc)9I=M<@6+I8NJQJKP$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV
