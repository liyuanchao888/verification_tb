
`ifndef GUARD_SVT_APB_SLAVE_COMMON_SV
`define GUARD_SVT_APB_SLAVE_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_slave_monitor;

class svt_apb_slave_common#(type MONITOR_MP = virtual svt_apb_slave_if.svt_apb_monitor_modport,
                            type DEBUG_MP = virtual svt_apb_slave_if.svt_apb_debug_modport)
  extends svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_apb_slave_monitor slave_monitor;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Slave VIP modport */
  protected MONITOR_MP monitor_mp;
  protected DEBUG_MP debug_mp;

  /** Reference to the system configuration */
  protected svt_apb_slave_configuration cfg;

  /** Reference to the active transaction */
  protected svt_apb_slave_transaction active_xact;

/** @cond PRIVATE */

  // Events/Notifications
  // ****************************************************************************
  /**
   * Event triggers when slave has driven the valid signal on the port interface.
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when slave has completed transaction i.e. for WRITE 
   * transaction this events triggers once slave receives the write response and 
   * for READ transaction  this event triggers when slave has received all
   * data. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

/** @endcond */

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_apb_slave_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter used for messaging using the common report object
   */
  extern function new (svt_apb_slave_configuration cfg, `SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();
  
  /** Triggers an event when the clock edge is detected */
  extern virtual task synchronize_to_pclk();

  /** Monitor the signals which signify a new request */
  extern virtual task sample_setup_phase_signals();

  /** Returns a partially completed transaction with request information */
  extern virtual task wait_for_request(output svt_apb_transaction xact);

/** @cond PRIVATE */

  /** Executes the penable_after_psel check */
  extern protected task check_penable_after_psel();

  /** Executes the pstrb_low_for_read check */
  extern protected task check_pstrb_low_for_read();

  /** Executes the initial_bus_state_after_reset  check */
  extern protected task check_initial_bus_state_after_reset();

  /** Executes the bus_in_enable_state_for_one_clock check for APB2 */
  extern protected task check_bus_in_enable_state_for_one_clock();

  /** Executes the signal consistency during transfer checks */
  extern protected task check_signal_consistency( logic[`SVT_APB_MAX_NUM_SLAVES-1:0]       observed_psel,
                                                  logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]          observed_paddr,
                                                  logic                                    observed_pwrite,
                                                  logic                                    observed_penable,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_pwdata,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_prdata,
                                                  logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  observed_pstrb,
                                                  logic [2:0]                              observed_pprot
                                                );
  
   /** Creates the transaction inactivity timer */
   extern virtual function svt_timer create_xact_inactivity_timer();
 
   /** Tracks transaction inactivity */
   extern virtual task track_transaction_inactivity_timeout(svt_apb_transaction xact);

/** @endcond */

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
7Ve]Q7)S#)=6]S[)TdD^LMaDL+<1P/b18M#@XSOgM5L+&)2\ecK<))3aMg/>=\T6
Q@D,EWTa?A1G)Y=O.T8b]B]TG^M2W7-(bY)-61+))aIR;Ca&P1QVDS-g2ARUcYb6
CI8]H4TH6_@KdNRHG>-H-F(g=.9;d)U[1RLaV8fd@UR<3<7X=@9(ANDV^BCS?IC.
A>f4f0@,_<+W.O1RM,?32c\Pd,8XMTXO;db-@E)4N^DIA-^7#gDba8JeGO;0L3]:
0^(:9X=WcD8QKZ4>.:/PFZ;,8c)S.5#I7GgE8OFI\Z#\5\P.bNX32[H)FJMP_MZ?
E[.X0TVQTMcR5VJB4/,F-NVOb?U02>Nb5I@[#eZ;dYUg:a_4:RbN0UCU/F.f,VF;
<_8G_CM/>;W&RPdNc5YQAfX52BFcLR&13\d\OagSA<<TL.PDVdO;Rd(8G2/fJ&NF
>,RB>\SZ_f3bB-)]NbB].=U,@ObeGM))OD)Q95/A:L(N4Z;NPEd^ac\XQ..1/g,9
&X)W[C^54T#>O,SS[EFCTZcbWW&XHE/4#H2K<C2c=1^M65]cWS==FD6_-J5CEH9_
dBID+X=&2d#Q1ILf3)&CV,)X6PXK>CK&(BT6#[fa>OI;1-Y(].8J]<dg5EH6]2@D
,_OA<EID)ba#.AX[VE_2<2?)XNC0V](HZDV(P\>:1e.9@_GKH5Q)NI#R(GH=+84G
b?e9?7LOEL&.?;T9;aS3PIa4S,?TQX00X&VZXW7:>J]dd&BfA>QR=cQ<YG\adAc8
J0(DHL2@3]O=9Z/T=Vg^a:[ZM<K0\c;)Te:A\M4>H6+W_b9I-F2fId,DXc9]5Df)
G3gZI^S]DUZFe7;e_<+J-7HgDS9K3<H2[Ad5IXe(N6TCOQ(&#.P&e?@4RbL29=99
dXU?b5_2RB@Rg89]E&7>YXIfNK@Ra5.bEE@Sb@fLI:c\Cf8_c4/(BH0>A&T[NA5g
P:E@?0W0.LKKZ7>,W665S6VA?XIHET)^/#Ia@BIc3Hf[RV2?&NCI>acI_L&<&Fd6
a4c<b@Z1@/\/&U3M>I_QVZSTMUO4>J?BSD=AS_JQ_BFQSH^B=:b#QC5-C8S&FC;O
SYDd\H0aN?II:a6R/ZaGN7,7\M:@6O,?MR23)O\e)_X&S@1&I@MQ?GV9_8?X#-OE
I:=+QCUWeQd-J:TaG-ZRXF]3PKJ[B+:bF0=66c+Pd=Ya-RaXO9;4?CV9J$
`endprotected


//vcs_lic_vip_protect
  `protected
@T@;V;S/\Y1<V^.af\:@SDEK8)7+b.55=(4<6=(gEKNXPI5^PYV;3(b,&UV>F,1[
+2TV2&f/L]1SE0PWL[9V7KNAARG_[a&(Y7W@E_F/aNEXeae7J^X):=d<H[_MN6P2
CZ01[O+K)gM0dP)FK(&H:eU5a/A8=+,QA-Y.&TY8/S3Da#P\f;D[EVfM;^eQ^WM,
>N.[fd/ABVPRWZR#R=DCO@/(@e>Q<D++,=a[QQK369S457a.C?Kd1b-9OF6-1d57
]+5.OR10U9TB8?aMTD<6_DJXS0.B>13BfVD<b=U,Ld^ZYB@^J]E+S=bND-aS;SC2
5FMZ<@V#=d>(CJW:)@Y=[FY2D&>(M/A.dURMYCe0UWP#S7009d&?V>&N<4-CfRg+
g^dT6e>Babf\O[S5bZ&JTdQG@XTUYM(@91Le?Qa>EDT1V_2+_-Y19gZdP;Q36O5N
,Z:\J>JfIX-Y9-20H_EPab>9Pb.,V,Z]fNC]8e9Aga0Z[;>S:.@4,1+49=VUU+-,
.#/N[W=1.J[\/7S]XRAVA)c,Z1=\P:aaL@BA+Y)A.AF.FU,3?H@T>CTe@2PA36\R
Uc8BP=(VS2WJE1TUD[FL6SB(Z_]/856_:UI&8d9,MO/8(+>&.egO<NM#6>/6Z)cR
(HT\)DBA2F]3@7)0>c=0^aXYI<eZQV^/B(=Af+EL+@P&)N,M=.V2ID7HT)DZJKAd
+IfL^YZZKX=gL0da#0C#/e,MXGN,+b#5+Z6cMbT=,J&f0@R#DSN8dgI<_a-L)\3^
4U@75WJFeUB\V(DM.Y[>6^HOG6EF?PgFg-^?@G^_:KIXXX],cPJM\J5d-/FNG^CT
Wf#/.cG07_]5aPbM0?:eJV/9OEg2>\5e-7F>b[KW8YAV8Y2YA.H;g9fX6;@W.,3V
cQZTgd6-7dST,NNN>\+@5&\A0;A];@C<K?\/O1[MFEJ=R1b<HAgG/LSZ;AAQ8XM_
Q2@O2IXT&TbDeKM/7OGDK8[S/?+gE\C+_@NRF6G=_BWgaEM4\6;G,^a=:[C7LGAN
7P76_UC+aZ3?9:Wg^295ZID3;a295RFE(NJFBS4=@O8NKV2]N62K)e721MOFb.Nf
K2>&JI[=Tg5)67>AAd>=ND^<<3QJ0V+,E?^S>L8VN9EFCV.D8GW7.])_DUIf?O<?
<SWX_/GRVTFDB]adYDA[^7.CP5\,T;#-&EB^OaPFcS3b=MPTY;DBN/Zc;>5eY-?0
PM>^7XWR#2>?eO21<4H5dGQEJc2:A<PE8#Lb\HWO:-\>^LRb_1Z]JE?G]IOG@M4L
g5A)A0Q<U)&.3.=e#H:C61&WT,YW:cf.^OFYKI@bE-:1bEF(4MH&<B:VR)L8Q7N5
aNX+d5J5A]O0@EMJMG7W<8#BS:MFA:<=1#]US[Y_1X9?0(=-VUP6[4D#?A#b]_7S
YAZ+MX[RL4SCO90X=QDJ@8<LNdZ5<3E(&BQQQ5T4+R/NYKTC+<+gSdNW2Qf_SdVN
Ldc:\OSW+D/.?.P#^736I=0VNYgGZ+6OT9^\5P[NI7&gI])ACR5>T4/LdH9@5<H;
[(;N]U6eCFec&9C>dC6XY5A^>B;V-QOe+4NUIOH7+MG,1Fb>NaWVLKYe+e;bf&d.
dT@1b-[71:5^QP()F//Q?/.HL5PK<bW&cVc;4IVGQ7_,/H-EIN(IY(@\2(4S0MP)
T&YX:1A>#9=^Z=D>d)(^<-g5\Y46.XW^9DO?6[J7##NLNPCOg_dK)b@\O$
`endprotected
      
`protected
5RA=664)bFgA32M@B0/N:_44.CU8-AH2YD4_?[8(KM)0R79VC@=17)F71MN?[3EJ
C6U&U/-4DZ-1J?XQ(5V7B_H20Z]-V]32=$
`endprotected

//vcs_lic_vip_protect
  `protected
-d,A-7-0ZR>a2NG1]N-g&YSF=4G\c^S9=.8#HDD<Zfd&2eA2@X&M1(UM(d<Q/b,;
Q#KY\W/]Rb0<Ie8f9c<QMIOV6aaNAQ2g4L8<VP[;D^L5LOc\K>+64KN,VPV:4M.Y
U=H_(:8+\R,QFUIN^WJ3[04RY;#H;ZL._U3E)0YP2];#-Q3DCZ\^#/V:](&&TZY)
P)S,D/@H+W#b@^MZ+-E?H&I?=Kb5_#Z2[bZJ6LbLbU[aA/9OLR+6S28VF>XI/463
9U9K2EOec8g#BM#IA82EPMg^ZZXe+GPCOdGMR29</EdJUG8&UbB>N-Nb75VLT0_J
,^CI9/+e9MA@](5S6[#V=]B=,85^.N7Z.GF=H)5e>f)5)3_5e\aDXD1D_N)\M,,0
5+SH(@\g><X+c5&Hc&GCW[V2YO<KW:d2\9-X4SM.F>-PK2KYD3b+d7K]?TCcaWC6
&I3D#,>7dLE_V53(NP.E:;Z1FG2\MKF]NDg7cg.A,Hc=Qg64QIP2=&H^S\BZU^[f
PDN\AMeK<;\#S232IYf5faI<b)OQLZ8g9LHO&.A]<BU72-:b60L(gIEU>P3R,VK,
]f)/c@=@4(dfWV+YNW3I^[TRG<4/(0[HNC9;O6DDC@aE4DQbESB5:I#KS?(U0.dd
5H:c\Te&5]R=F;D8gGbOS/+aU[9b2+IJcV:RfG:_8\<gQW/K1cE#6NG+B.A+^1<>
B<7aaB@XI<,.9\89MSb2d.\?OEYH?1NB6]#(T=[b4[Y-?^CIUNL\(/J5-(gHDDRc
bg\4#BE\8:@+gJE@O=0Q(3fL.746+@M/;IM,,F,cgE_-Y0W4T)>b[N3)Y7DJ&[.Z
PNP0eKa\YQb_L4Rdc3gf]]Da+c]O=P;a9]^ZLf>M2gU/26&cg9W[TUFG6.A2(HT4
:N>c.6NV?006\Ug,VR&3X+X]/X-D\2P^@0aLA;8)H6F=SIf7TWU7,\aHQ&PYeRVU
J3=dUE@,S-^-<d0G[:VC?V[+>U-J]dH)UPN7?BE-gU<;J&[C_)e\7J]=d/IFBLgE
dQU9U&4DMQ):6aA4C5HccTLTBY>:5,P?YMd5?5\E20gZ9^&f:CWC3=<K@3&XT[/F
CKQgc^):NKf[Vf_EVV]6ddI[g+08\A3WY[#JL8K</A)2g1EAEAd#M@TWLIfR&_#O
a/+MY?FA?(a[Qb=OJNLB78#YM[GL7(,8)9QFdL3>B.&R?Va04fW-V#B28gT7M1f+
=3T,:Sg>V7ATH,V^F[af5OfMNVZH184P?F[1?RZ3FRZ5CV5?f+&gc<<,P,6RW=EJ
-aJ^][I9#>BJe(^02R<G_CN7[(.#O0#g_)SaSISEO>HU8G)?(RIQD7PO@)U(-7\6
>aL,Pf4680&f8,bH?IY#QH#RH>RgXa_Mb[,:[fNT23N+_YL4IAHS<G0>DV@B>::]
4gcD)TE@1^9]fPAc-43W4Cc0BT7agE&#e-ZL]gIC/4_2LR\:KNM;YUNf):R^7N6L
\Z=#YR:()#3J(N=-,;DJ;1K&^]aAQ>4/d7BMD8KT?_X1(Z;Rf;_M/f,^PbAI:#B@
QV_]Se\J2<5ME?D4@T0=R9/N)]V-V?WCD#<PT<E\4/:ZZLYX=BbXDR]--.F6e=,W
eT-V=BUIW&=:S)@\=,R>_+Y5IJIPPW+@D4I;.THU12AIPB;=>2ZW>,6:&KPJ-CQ;
O,G=RTP5NJbO6a\75M-42G+LW^6\42^?d;OaK@MFYdZDeR>KB(8<43SOO;G]-DbE
9RR\K<W.T:F;PJ5K)gCf:LY(U)O@B(8VJ+SSA,]6a/G\(O4Of<+XQ&LAW.)PIM?/
^Aa6&FHXG&YD=06=4_CL:K<+e6C\EXWF+cL#4]Wd8U<D+_V,CDc2YLdTf#@(cR]P
4#?O53T&2>F)bN<-8I-b:V3&aeY\REV;LOPH>0#gCJ_[3cf&=_AB>P)L/BZ)Q4OY
1K;M@FXFEP6F]1cK-2-+Q(WH7U(T:^76W2_3<d<GBX0V#74A_DON.T5VXE,76-D]
-f^ABdJeeW^5<b.&0](\NI[c9TBB;LcL?F<\6d.Wga)a2)A,9&KfeEg;A.>J7>,)
g?B#D>&=BM22=)[-/BGUa,:Y_>X[V-;HC+?2RMe>NL,R_C7+K^Q:UND:Ff,7-.#U
UG>:7>#G\TG,KSW@2/4VW]FC+)&G^19fQ@KA4f-BFI@H_)U;]Q8;&L8EAIeRB=-=
L&3-IGQg(Qe0\Y^-V.\V]c8)L,3F1=3[K,:NNeX]X(QMe3J)G2DW@.6640M9-O1B
Od>f,#HXG7g?7=:AWRY;+LID0)ISYL1VWd9#<OC(0b4PKXg3PE1ABg5S39B)?E=\
,0)@(/&WNLfS<1GXe21S6OJW;9eK&/WIYATC]N<U68FL]^PU1d5M@DSV]CR>>\BI
FYIUTI+Z_HTd3A?E.W;dJP1cXc=-RX+[E:.9:?7Cf27V&P+H#02<<70;#<_F->_8
bB<:HI1>F)WI.G8QBafNULZGgSP.<L\1TRZAX=\VbD8W@)TW,0YU879,F380V-P)
#CK:_K3,([(Z,C[.X[)#>@ef.EBLZPgYT4bON-PIO>5.XJ6F8IeE398^[S_:cX7J
_e-Bf_U7T:(02105:U9DSg/b6P-C]IS&])RN5,1VD[,O8e]a2]GYVF#RBEC\93Qg
P[PSC)2Y@>FB:WaUb>[+)/@SO^-?STg8B466S_-\++F9H3a7@XZ4C..Tb/_NVI<a
L-f5M@F9QA7\fH_aR18/EY#e\1-M?LSTWMgF__HSa:^_Ie_2fA7FPJ>L5e\9?2b^
_H,PCgQ\.&^gH9UJY[]XX;UcR][.-_5IB[cIY_TCR:S9eF&4_0)\L(&@E8eLVU(F
[L(fVP:e@I1EN)D,c@9\_^6Y&L#FOHW/]E?AL,Je9/ZP:;\=G-R-FbO(5cc&f78(
4J4aBf1HbPc=J7+1ab<0DLU)(]9-d=aIb)>3[f6+SKSL#QHM]bM4J)PH>&Y1Z_]Q
-3^;J/gP^dBb>4@=c-4gWbOK(7JDF_6=\:#I_Q7gMFdLQL\L<\3)RAe3VHBQR#5=
TF_G5Y[YA)=;U@U?:#S=J4G)cVV#A+B_#_00d,CZG^[WHLE@/1=6G-L[E^HNJb#O
Ua\H=?:E8+A_V(KT,6I=FQA)@AGLW68dMPJF[_LH=\A(\UI#HHU5.J\WP/7XUC0@
c=A4RG?0Pa3B0D<9cLBD^F+0W#??Xg+7gCP5YDW<(W)Z?X)f[:?XB:9I[FLPZ8?,
8E4LegVNZW0BIf@WLCR>A7T^Z6:.-Vf=aeQ0>Q02;4e1EPT0A@JBZc4?Y7(Na^UL
EI:8(^X@:R)XA6fXF>DAY1K4^/[Q/E-a,L0FQ4,R0\OOW[WQ98_7.g#D[Z8W+]^-
>e77dSN(0<]V8f4EA2/L-gGB3VI7g2.TXfVe)e6be::HKF[d_4NUG2Q2SbY:GO0e
8/<g9cZ\[DDJG.11<&F6EU_82/.Zc&]0U;K\[-Y1Y(Q[b]]1A2:5S+<YO:<^dZ,+
4#SO&(MHdNPZ(P9EBfXMZMJ]SPgLUPFT8:1J8H+P6[R;[KLW:9ZFZ#Y[9A,fCI@:
EITa-)LQSPe7M<W3V1R<)=^SP.,M]^:[==64?5(?7?UFJN6(1N-F-]B[S=FcKYdV
]=4_<6O#T,bdJ-JM:?^4GfZd9/UVN32T<N/N@aXB1.P-]SdG=X?B^deI.2TMR&IS
Y?TK<2QS>>49f<7X,CGT(=d2Wd8ddJSCae2IJ=01Q8G0Wg^<UbHTcXg^2?IW53<J
B#&&S6()62Q-FFUR_#AO)_TI+H)G4\>f@LOI_54VQa22:TTEUS)CKBG(,DQBYL;5
9Zce[U&X7MI/O55(1\G-(EP<bOaUG-/.#;6NU35;P=F:JM)8;FQEfe;9=/dHB1-R
J0S-37fLJES?dAVKJX?cCOc_@daSAcbB@(IdbVd&gc]Xeg\KC829eSQR;X+D?AWD
[I5[-c^11aPK+d#(f]7.52ANNK0gfX^^\EGD6=?4&f1(@ge&O8>M3X=&@FEXL)\L
?2/A,b0)cX6AN0\[;-MgMBM6FgMCdLeZ^KI0P&3YJVdMZBUa3+_1GKCZ34YMCLD0
/ZIa)Q^DQ@Sf=XDC_Yg]\_7:-)&-)Y@FJe,H3HT]]OJH0aL)8Y((e/09eGA)fXA.
R[G,^SJF0#^<\eIX#-DA6?.-F@U[&\aN0b8Jf^RgLH+Ng;0CH>,,,D,?:R/MHd)#
U07SB^ccE>1(-0Z1(+cEUbBO4:3WX^H3;>43/cg92)KabCR+DX5,dedfM0G<bPE9
_:L@ESUY0fK>9YLK7;CZ]QXE#QR:+\@cd.,-bIT(40&[fRA^;?_O6W4>J10C-&D@
Z[^J7)C5OK1+16HV#aV6f5B1QY=3d+#Y0\Fa/W13S)@Q-;Y39FF;UG&)9V=G=CB3
OaK5@P9@9bH6UW]#M9Y=1Z<f]SPfC98]M#-<96ETcN7J68FB/0VU3-DNF,+X&BY+
8YFd/\D,?&Q8:\(7EBgW9@EJ:9/FKIf95?CYgDDX-SccIE2Lb23Za(]079ZgTX>b
7R\G@;PUdLgdCQeeK#ZY[e8#&./TQgV,N7+]MG#<4OXC>JU+HNR:5Z,8?IYeeG8E
385RH:&5(5bVe.U?KWdUFg3LY<R#OV(e>f>T09Z-/8-.5Z,S\V\Y0&TK31^SRcd;
HQc-gU+LX/S+B)2NY[VdO9cQEVLV^:@]FX\K=>X[9R0S@#aYfGCB@5?,-J8gG,=2
B)\T#fSE5Y,(.VZY_(CdJ.fG/cHZY)>,Z?HM^&.Z0SaA6gbBb3]9O,J-O.U_K?)Q
E:72T8>3I>e[&2c]Tc/EMG9<E1WP4)<?LWCe\&C8+HI+cL5YQ1-7#94G0D:H4BTb
UK;4Z6U]bHMSLP7c)+ADI6f43PW-B>da>_\A9,<@2DSGOOE9EHE>&)Z(_gME2>-W
EJJCR#+Oe+0HP-S>4,:>]L,V-9UM#D/E7CFf-LaaU@-dX9_CceJ>cYB^BBF],ZP5
HD:GXd;\Ia/M@QQHf/]=fL.3+/FOP(dMNWgJ@Rg@92@EXD[AEY4J-0DI>9=BH.+V
Dc=c()YgcUS8RLL,d=a>2JIXV+PNNd670<&?/22Xf.Nc?T77>2JS]>8J5cM)@DWY
DIf1c7.-=]AcJ2RZT5BYFIdB_RG_XW8^JY3F=L&]RfK6BaecYW\B^_S2Z94]2Z4Q
M:1QK_50/-UW,0e:3:5H>f1=M-8U]MMV</BZB^.HADd2,:]G@ASD-?@#-4a)<--N
JRSDY4^&(@]H8ZbP95O&Bab4XZ^6ICIG]-7CR5f:>IK[,._U6Z#?-^^_YJcHR-]d
D;1A_\eWQT&\20T)K[a77ZGL/8Q/&09bdW+^,ES[5H930_UK&)A4DW-:&+IIU.,-
A6=U@4c<G&bD=B\AK8N^,\JTY)0<D930B5Q>_dE?0<.@]<6SA=K)#R?&4MD3QHJe
C0RR^&J4>[G&:Y>ZQ)A:cW3YM,39?4RALV@XCQG3N]?1fH(=NL^HG7P#RZ&F0DO=
A?IO4@0cL)0W=&Gf2f/]<=6fIXM<bb<\@(=Z;,RG>[OI?2)ZUcXI7/=MXATf1R(>
N-b)a&7#N<@>H?bLK]L_S&<#]B+1b@a#(c7,U;<;K6_3_O6e//T?6?+(@)g1:0AX
Y_J0bBR1&L2GeL8?g@/U2=Z2fJP_?:CO1D\17WJU>;#I0b6c.G31A9G:7X.-]R\7
@0:EB9Z6T[F^eWfd^=aUI5M7NK7M;ga<5;F2=LAU#2W=ZFF3+6fW\DEdA>,gC(E4
T;RJABISLH?ZT6PAC1W:LN1e4fB?WQ4+Cg>+M&FNW07,5-=<D=OS?ERKN+P;&WGc
BP)&S37VLVa4FT]VDEIS[W2ME+9JU2V>W#[Z#f#P=#TY\7VB3CKb,JVICV?b1bEV
=KF[\IXdO<6WR:3_.7.LZ):QBVGaZcM#JcBU7c0HU7,OKS8WR8/&,KaeF=[D(8E=
Q-G#8T8<@BDbZ2V-&_-JaX3FbOLeE7VT/b/7^MBAB&/2Q5)a85XUPHH#V,b/&?EH
JV(#dBD]?Pf0GM(F;^&;Ca+N\W[XIC3[/;]DND^.J>gCV.M_I_GL83D5>C;IBf@c
)b;C]K+L:d=@O4Eb2d,T+/4T&S3V^.4cc45FA(G/#]NC4I&X.gFRQ87e_MJU@,_8
#&eWP<dM@O&PF]H/ALcVK.V9MDDF9f,,J(A0Kd9f6O#/da)-_b^,)[(VJR>EX(Z2
70,;@2O4W0O3B]U5CF_[]Z(HZSV)G):7d3>:S:(dc2.)K(W^;[DQZ>Y-GT(9&QFO
)>E.Wa]b,Gf(G,Z(f1\3MNPR/W/.a+/e\:>(]a4-^H9#<K7XDcE&STJB#2QH(G8=
U1LL4-JIVe:VAL27L26,^db=#85K68-fCNCW<:b<;31W#f^-<+1V5Ee1be?+LMMa
33:TT87BAQa6?X17O0/d(U24bb.I+gG/0/g+#CbL<fg)&1>QG67B9E+0L;+K#S>d
Cc8ALJT:V\XDDg56FK\XMR#[KKTP;H/)SD-HHg?ASA(OCOX)b<GV-\FAO5bgCKb?
B&BILK[V;_QV)B#+9bI&eMJ.2+gaE]W(/.H;,F]M9cI;0?bSH)ZB+JI_)(Z[Z>S/
7H>-G_-_O4gYX5E+JWWH>ZO9@ZB7bg&E)Fd(,13d?La=3TD0f,_GfVMdX?GK[7QB
66>,J=HMY-.a0)CAeHBYR.fZF?46gaXAb.N928G5NNAN5e8[PF\-7E<F\Gd(Y,+A
N(,(HF4B\_<:/\C5DDUV-FDH^KCF(9X[eGdT5(,SDU:\F+FT14fcD2EZ@-6YG<Vg
KeXFW5ZVLP,c;3FL?-56QaZ#Dae36?A&d5&LMX(a+E=T/R/D;R[ZCM_?[<^G).B>
)\.bX=02IAeS[#63De@GB(_]]agV=I<S6:F<d]FLT5+=/G_F_U&97K3W?KQ\-[<0
DQa/23;O,6G]-b?EMZ,=6@+1E:#=N)CCRNDQ)fg_RJ/ZfB9A.2;D8]9P+G;K=b::
ZYd;W4@PN043RD3M)R2fRO78(adV7K+)dYaU+5@_^KQ05H^)c,97D(VOe[-9;S\3
9>4J+R>.]_)F46=<4ZBf?Ug:G+dTW#@gb.WA7DF:-XX8B=3[G(<7(9AQdOETfH&5
;\(#OE0eIQ00OMJ0NRG+KO5_LH7DKXfO;0,ON>>M\Q,).NUfSMaDQgRLC#<6GLfM
VX:SBE.Id)MLbTDY[[-#;eTIF#.7(1TC1KP+L>SM17F^^Rc1,ZTK/9)fO+eBWH&Y
A<@E0)HI[)-?L#aW]^5H(c(EQ1DFOId&/0Cc+A8VPYFK#;E^A=,;QF=-DK6S20^_
b6X??g?^Z#c/0BF?_Na,0C+XO/OMa+-(UXM29P_+<@=)8S><E1:\Xd7N,NL_]_#D
)#O7U[96M^aO>EP05g<JM8@ANeBMGPHS&^ca(Y&bW0/:BT.:;Ab:-<HM<A#6D#8_
/>H+79d1Ed)9E0ae7TP<L69,-(35Q28;)G7\15(UB7^RVW)N1DNPaHW,daNLWZ7U
7E/,2.5#QY7bU[Z@,[-(b4_3fAKYd@9\gb7f/2_fM^;JaPcT5DJPI.gDO7MOZ4XF
[X:<K69ABPT6U#H4D\0^_M:42TQ?S6D[OL4WG+]9.6^-[g)G16UbeQS-32F-/.Z#
Q8V,LDc)Z;YB:QY8LFJd.aRa53cfQ97R5Sf9fN>@JITP]<G3Z]OA304;J_G:OK71
c.XY1)U+^I[#RUEdJ#:#=<Tg2(\fMUa8eI,3C.C<SGV9WBHN4CKSOWWH15]aN?Y<
F0Q8V0[-[e+U/fGH6\2?,N(0IgRLOR</43GJ]cTe4-aP7FEGQ[[>0aL\2N^8U@Rf
)=[dDNMN9YVQT;cb1CBPZU6CY7#<FU2c3)FVeLbP4VZ0:I0K8>]OH2gaUMUM/.NG
,;-]b2]Z5-?TGH:VJfE^E7D6,?;Aa=6/eQdJdeA4T90&=VBOfB?+0W#L(S14/L9M
;^e1(DP@ac1FP-\fW/[QX5;J#:UTM[Z,&7\GT[OcE+XK6<NbRb=dRF7CR,NXI3?e
Jb9M3OHBc3[1JR\97[Nf:.<a66O_bIMV;.?Z^?dCV9-:X?1+_F6NCUEZd94+OKA>
d,6_g,V-023TS-84Vce(;HE>X=TR_]7N(:-/]VGLI(K2@d_KVMS@V^@[^1g[<:EP
S7fECPM_O_AOM4T<A+cCAaVC\9c</b.+5:+QU-JER8UbK;f[@(C7cJDY@P0<?7QM
([<)DUO(6?aQbIIeEeU1UO+bS;-+9+R?HEK[8TbC>;FZb2]>T5S;;)b3(E45[;U:
f(T4Gd=RO71?)P^O[=(DQW0bdAQ/KdC8/PWR@[)7@WQX;eR=[aT?N>BAZgGD5QY^
L@cQbcH#<Z^J))53G-0^PEL?)P<Tf/S/FVB2W#ea-LBbb/VP-Qd\Ga864;0^MTg?
A-4(eD)L@fFPPL&T(a>J#UF-PF&g8C-(W0:&W+@[H?\bge)7W\\g;E__bL(KREL9
K98W4)N9ZV.T(D57P3FFB<F4M+cIL?]=]F@2gG+6MJb=(\Y&S1gAR\#UTUQ:RNQ;
]8dNW@#L-=A/-bBBO43]7I^BU:(I?6Hd?2CV;]g9TW_)EN+(2(6gH\O^X/8HaPM:
4+YJV-;K8bHVC&G_?D5Hc23D^0&)MR#RR@<,SPbT282O@CP#;RVAM^.9/0(K0I?]
LTJS,13\]2B??PB0eP.@@?Y;.+RVA^K0?e_T;VM?(..3NVUD0e3HHZ]KFCXb7.DS
])<KcK,2?J:\[bb>(E&;N&YS0aNdE5Ve>b0W[82O_^A5[WbJ4SfGH:@c3G-7aadd
)ZY^d]#&(34I(W-@SAa9]f3#2X3&0aCJPER,^W(T4KI(K7@O@TBYc537EY3Y[<V4
\<DA?MJX#=EV(-46>,C,H]EG^-460A7]\H0Cd\gd8DYI3\a,:GFQf^(8.);/TdCY
[b=KfbEH38[>A96(G1]P9+OVa=9fW._J,;[./-G)]W\dMQR0/3cJ<g1I4H&Z]4@H
6ZQHbI1CQ7C,<570<PQg0T7#EGe3\?7-G\@M^d((OII)F70_daO[.F:P(P#FTK.\
e8dBeffDD1L)\B\U95g7\\:b=;gca-+:E#+:cdeO]b51L00]MQ4=R0/I5?AQ6d,Q
DK72MHd9c3CKRQ6U16b3,\]9WJ?DI_b93Zf/eXe5=QD#WK70FR.C;T@b1J^-eTfg
K5),<d6O;D=]QY_HXXf-73A(dcd>abRV8d<WN6/d]P]04Y[e>N3f/a[,aL/,1O[1
cRfMHBAaT?ZdORZS6\JD39^P_(/BbMDZ_88]F:JdWd5D1VZ4]XCb)L<\IK:b#aEZ
=/Va0@TMX>b.>5Q)[\#XcKCLe>@@]-NPWW@-b^VbEWDH2&>=&I_RNT/;R<7fR6&2
@8?3LRI]C><JJ\-:DAH]PW@;&MQ9XKJ-KXB7c2<1_C[cZD#eYETNWKA[+X[CSH9L
:0fG@5M3__YJ]^SG8Cd<HD;T,),;g[VPV0X[DYRW@e=cd>BZHVdAODNY4G1^6d6N
LUPRT,gM0g.((#6G:c<.2:NBOaS(O63H,0]ODP7O)M+0]VQ)7I,C,[P+IW=D1V?M
99eV+CBedUL[PKW+R_-3B/<b4<E]Fa0^98+TWR:4NI:90(X;<[VAG<BFd0AY)BPC
@cQ3PC=\<,bM?MOH:)c;W6.O)T>V)4ZgHc7S<bIgcBT;+=O^Ucg[bJd]&F?ecd01
8F.W_ZYK6IQ.D)[9f067bb8MS[^0bD2@bR(RMFF^Q0Ff5J]<GC92Tc_#1G18[d#2
9\MM5C6B8S8@S9UTd=+dZ_\Vgf5H>dbN9QJ5K,13BY)XU>=R=\^9=5TPbgaKd4,b
ZR8:]I1^-?V+8U,dbL6=NaS#NDfK2+MD=04)3HfJ2==Ue:LWRcg-9ICRDGd/QD.&
F9I2S+Mb)F@SD+,<N]^7:#4X_;8JW0+X_)TWK,ELE328))=\V3TN_NQeR)@O9LF;
KQQ6[5VKUJ.C6f>FaIA.#]77YH^+=DE8BR+d1fUe(P<EaY10UT^?YTU1PG(X]S1b
a7L[3052[NLY#O1gV;51R:gHU6HeFP.\(e)><O4)HW>@BQOH,HB39X>?W?@.6U01
QR?J8dCaK]#]C1Y\>4MIB7:FGE9H6MNW7dc^AbP,cO\UcZCURW+R,g8#H0e<L1<C
0)5T/);)=b^C^(14P?]-1[9F,((>=egO.TNP)/U>A0+O&2ZXY5XK1SZUPC9UM-KN
I2^B9LZ@-gT>RR+DS6K8H4#LQGe:N(QP=^a[+2b.-ONK5W>JMIC#UgGQ8<Y-dKTU
,1IZVT)#XTG=b>[AWCU-b@e?.>SPB-1LVC2(eZ),/2-ZO4a^cWNUg/NZ5T<3/eY(
:\H684^[FfNLK_#2@62^YGbYGA8VE?Ie<cX.]aE(EeJ&T-cPOb=NaCd8-NHf2Z#K
H9KafPX.<S2NWbcgC:A7Dg<W<@8K8ecXDeP:eEXSd3XB[6N]B/Q<(.,4,AL,T5^F
\6b+M5(:QGLHO\P^QUJI^Bb03OdMb/DPYW/,9;5]P#V8P+Z)LX2YS<KDH,QBA9#c
cBfc+Y^FUY;M4&#HSZdD5:[S]S->XdPI>fMSbO_eDUfJTE;Q+T2[gUgPH^5A\g+e
,X6Jc(W)b0X/:P8,A\@>\GA\K6TNCaJQ9(BWJ8Mg6cDE&EKFbfXC\,8^4&ZN<Z6T
S[^^RAg7b[=&00U\<#V;1:5C>1A/0>U_Z^6,[N6f?0ODV()&d3Y]WL#4-<.:1AWB
]3US><aJ2W<8S-?<SF/E5)FX6_UT0<BRRC6@3\@6<cTb8dN:,0Qa7J=B?Z#Q@a+0
.b><INc+R^)]3NI)@>C-T&#=C:J7,PDIIQMP6+HTY?/IO5U=fdC^P3AA:;R3:1Z2
Ica+F-=6gS9d2]1<71M4&I(R][Tb5-g0#]OAX#cJ?;f/#Eg[e,BBM/;/#SRP2&_A
T5?&UMQF&0UU6H?b2+eZa&H_TKP]R44J7)TE#OI.;-:fZ/ELF-;#>\S#K?7T^PR1
#=Yf)FQ49[)2N70+2ZV[MQL.)H:42,XccMLL+CJSA>2dM+VP;YLC(Q=b^5Ff21F=
FWMP63@UMQZVGb0(0__>RG+,Tc&^HZE;YH0Hg6;aM7IZ5a)\<eHfSA^>HWAC]];P
17\JQOEJ.M(9Y910AcGOcP7DHHF0ePSB(.(P1egbgQPU(,C,F#7cP6RP9N(Y>b&Y
.^X@gc)4eWTT2GBGB.>]AOB]^O,K99gee0(M&ZU-K\4NMOI=Zf<gC.NDELF/f@\f
D,K,I1:8HJGFWLL@?0#CNHZS?XgeZX?BR&3M6VMPAV-EU@1bL)U3=Tf:(^RP06bE
Z,^N7@1_4.\-d9#0B:dGW[GNDV_5=J)DM3FI=]:EK]-C9CIJ9YUH4&##-24Z<b]8
N+[[H=9_N45D>JQe065==#NT@3N05YHFL]CdY<QB8,7A_\X\W^+IB+-[T^dV&aN3
=MYXJ#;GVGI4;G/f5\Y^1a4CeX9.::&>ZeG8VeF=.JV;,aI,N756e),92.RIV\::
Z62FMVR.;JTQO-JcI8@F,=9a^9e#0R.[L<B;fB7daaL0CH)OaV-,+fM_\KG^QJ?I
@bMVR5P<@b8N,;e<G;+RSXN9&Y/SIB^>14(2X<)=84R7D]T3>-TW#MLY32[#O<-W
Q3VfB:_KR.C5OV,19G-/6I-LV4UVR>NOD,V6/S[ABO?-;ZUC1XD7cS<_T:HT5TFL
GDK/eTcH#D[L6OSIBYZeM6CVVW>J2IE8a4?b=^]4cN<TCK&\2N5LYT2EJ-7CX\-A
N,O,f[[66IFKG<a^?N8QW?E-2.P570I)P^>YX/A6/S>R@\)_U,9WII6cf=dU&LEF
S^Q]M/M;R6fNaNQI#TBIG-98@DgX2>B0f@AdeR/EJ+9.42&1O)_)aXH4[:OJT6L=
@aA-?\K>f,\(?&(c34-/f=Ub(NdX,_WCLFW?I.:R:OQ3a1e]\MV2=\5eP1]@-^,X
&a2>J1V14-,d8_ESH5;gEFWb)<KV^(OH@.>J\RNg;Ng4P3JNM:/_2A<R,W;1^8>O
deSI<XfaJ.+GXceU3MJ3XQFF88UC+(f/>T\0WJQSI7LVQ-PRCYL^@J;]-PD3Mea_
?5aQ=O-d-W@5^8R?(-NXA7bD94MHD[e//&S05WS(FXWF5&<Aa-LbM5ZJ&.,(7YXX
YSbK-Xe5FPD32\ANE,J.6dTY,0</,7\KJ9JEe_?#/&73dc805S9e1@;;7;J@bM3,
cfI5+HWL_?+a99(U3LA5fgCF;OJ]_50A9[gf3MT\\G@YGZ&I:1##fAY[M67AZ^c8
4_^S5UZBg)YMc^#@0/#Jb6@,)aI#?.+g+@?c?1DDNQH,=cQVE(F#K5JIER=ea.V:
MXVfUfAV9#gAg@XgOJXUaO@=,/3/OEX+\)A:)0L2+\9TI8=K(HGJKbYL)AaVV:JP
\M)M.aVLf1dWd1370aQZNd3EOMKB5@V:8OJg:0_VBKIe5f1BN256YQE-?5d^NV;D
26:7A4OgC>&W]N?afV[\]9YI#J9TBHb?4@:cPI]&D1TAe_40Zc7e1&<PW<Z&R,d2
[N@YY/c0-I)_:QH.=V?&3;.:A+FG62SCf6&C(Q:@F<g93<<+LV>5>&]XZHD+:[[)
D,)4b]+b1@R7LD44YIVE9c-DHS8U&Fd-)C=,-Ib-+4UU__ac+a<]=Vb?UEF<I418
EU]:&,LZ(>]U3=@-8X7LgEeH_;ca>_ROJ)5WHdS:1;..,HAF/DZT71<KN[2KIg8S
NQJHEI6=Sd]T=(P60gHJbR3?/;UZG8)B227EJ]GFeCLFgcc?RW#RXS^>XN3[70bB
S@_ffV>eW8d<^E(ZR(-TfdEEC^2>a>cY@Q6DMQd/ZSB;<LHfOf(J6H_I8B+K&LN\
+)_Ff,1#;_^Z/:1aJ43N1YU/JRbE?LZ0UX84H73=-;UGW0@4P)ReXH+^R4Y_8N;4
TEHfJ^2;->?8O-08faC[;_#],-S-P9?&?/_/-&._M8YSfc,4OB\BMT\g(gQ=90dZ
890OM;K^N(UN&V+>.0+0GJTE7;Q:,>ZW_73E44ULDc\ff[0O7HD_Q][)H4AD3,NL
8(#=JT);-C+?Y@g:A&D:_KMg&ESU3-\0#.UJ@UE,1\c5TYLOg=IIe<EgFd/_&?-@
eV2O<,\<AfI03LB[_A7^:F3QQ72#+c,b:0^M>UD^U42;/^A\A4GWbLPcWCR,\>-J
9Y9F=EP_,dQ6_]Q4G;X\FH+CYQ>8O+MJB(K31GW+c@JYTV&gaTC8.E>d-.N@&cg9
VFC\5Z#7_8MDZcB1gWWO@YB1V0eKU]^.@g@,A&EfDN<;][C>G0a-DcPH^434XF_Z
Y:6Z#B);\T/6&9?6R7.gBG#U2R]EeJ_JG@:R5Ac>,N6_\REG;?2EQ(U@T\gFDG^5
=c1B.M35DN@4UU>FXGfB9M.FgM)\Ib1N6N>Y:FJ]3V4RK,F)W&H\We/;EF<;7d<0
RIa;QFPc:\X\0G:BMeL>)T2/;,:+&5EIO^GECQ[0R(&VLRZL4eIZX&US>,-D[M4J
D=?821[<N2GE8GF^+7gJ5WFae2dR,E]G,8:O(],D)9T)I?e#WY?gYD6S+fEJ1#3)
@48-58J^?Y(+_NU)cK3Md1c7bO>-5(g5GJ[D5=_Af=1L?]IDQ=<FL[\PbIBbY2,#
1Q#U5QB,DG.&WZPJSS&^1KGbX(>WH63f[dO+O-6CA2/;--c_:>Z0ULF?&WNUHQ6f
Dda-X31GD,=g^/KLO_4=W16c3Y75=P5IM1M3.RYXFVPKJ7B+IW6GSK2E_Z0cL(3Q
__bgP?JU_G5PW^A#8R-L^e=\>WbD?&GR>5@RLRDfcB4030>MJH:<_.BZ3TZ,MU<B
I1/<B;.6f:#C^e0?DNMcW=)^1XLPVG_Q\SRDU83S95JQd>#7J^cb#T(0#&@b?A>a
bKJJePI/M8c;>/-LFQaK-TP;1,a<IZ9=4?:&SP+eYg&VM=+K;WeA]:)FfL6W.M04
@1<I\A-HS+M35MT6V2GZg+=_d_S>OBHY[L>HB,5FT@JbXC@[E=AHWP_Bf@)c?\A^
U+bgc:J@/N>KRC,7I?I9:^JNd3\bYZSHLB&ZJ(E.aY8(6P=6ODZ.TdO[eHU>4B>?
6H:40/41bbD;B<=B+I^RX4M])YBM@#^<MbgcaX1ANF5=W_3IH_-\fbJJP6)g966R
-6RBYVRW>B3R^bS/Y]_bXL.@Ff3>WD7aH2H^L<131&;T@\[A<ZT-IB=1]HdEVXBN
\fB77JT;aU^5,1G)eCU@C;b<Q)=2[DC4-0PafO&?_?fA-e2N,X/PF8\==]UeKa79
)R4d6aZNWU7T>S\:4B[R^MW(YUc\c;B<g)LHJ_ENLV09AA6,+9+V2Y,[fcMYP/0R
2E#/WYK8Of+V_.^,EJI@Sfbg(S13VWaRN,-KMNB._##.B7:,^].8\ZLeG>V&/=-6
O=;KK[=J7Xgb)#RU3;f-_ZV\J4dC0>(ebF<H[B2B,I,Y>fO^D[g2I_HdE^3+]dJd
3e]MDa;4;N2TK\-ePWN37^e+0OEDQB9O..4\<S.CTXTa@<_LP<?XR9AZ),L1M4=N
Z<4;T@FPRLJ^I+CPR5YgP-E:Hgg6D[GE.9^#HB?-G?eg=84@eBN06:X,@1/./&#.
:G6OKJ6KaWT2R<S3EA1a1V=1=g)@85#Df;NZTb,27BIL?Y,Y_\])(8IJD[VH#XX;
f]L3HKJK;5eJf=54Q2J2+gE84--,#)9XP?P&Z?=K^=:,ZO@;&SK\fW1fAg((TaER
Hg:#C];>_D49(VYe=T+JB7Rc(DdWgU\27^K@&?J-;W2E@Sb;/ZH4dL9Gd#3O0C&O
)H2\1bIC4Z75S<Y((NV4^?A^-QAN2]U4)4-f+_&f8U3Q\gNESS-aN)ER5Tg-DN1,
-E,@:IcQ?_af;3BAd-Hcf9)TLYA6J9P1KH(a#[NDMb#acICS58S3,A&cKdF8E0DQ
R7:=G/<QKA+=&>bX0[M0C8,?d(4EL\U@/+P3;O8SZX1g167IKeH;,/NN-Lb7@O_C
DdeE;A&0[=AP9RHIQTTW4+:6FA[aFU;^-.3]?dD]>GGbIKbZY=4..eVg04@0T_cY
VBb(>4J62KE@/g+L\bQTLJMU0.XQBBd+#^6gdG;7^Z<0U7UZcDWc);=O5KbX[5KR
9=_MWI&3-;+Gf)P/91g>(2cWK07-;Ba,]IWL>.4<</036X?1&W#;OOLU9T_+P]cc
?7DC&\B1+#e.@[1FSF-ACI?D+XWe>#UZ)QccMI84(<b:WTe<<NQ8AbC+H+JVTVFX
(X#c0aPS2/4)PbHR>,&W;\B5BXJ:d8S@;GE)R=SegS5M7TAS09AM>C/.;(^7XRD[
DLT.RW+_b:>7RY[2\TUH>F(eP8,(ZcQaS1&5.NG>^ZK273O.ORCbBUP\BA.27)JW
?ae[FN/BS/#MV:UNNJ,cTI+[C=REcJF0-A;\6EA,(I51#9)W4d@]bI^E/(-B6HZK
.72,K[2CY(ddD(>P?VU(0Y;.g;cYH6VbILJdf3V((+R-_)[2,)++93_HaB.:^W=M
&\:O&X^K8M./&??O=QG)HG?-XD7@?;&_-:NAQL&2QH(8C(X&+G&M8DGeSBb\G>UM
\J2Z.C[T,B-^gC/)\O(E1Y+=W9QXMOaO;&eF/X-,Ma@/)]QT::78@N^=A+6>S7&c
-Q??f+D#LRP8=7U6aP+[EB<JD=PPOUC#QX9b?C?:?gG0[DZSe]),F3_VRWGA@=U,
2Ige2]L1M]e3Q&JF_4b)?5fI[,0E<6T[J:eU(4X>H;aH>^4)A:N<=;^DD?KI\I1.
04NV6V#UCdI?(MEX\I@U<1aX3HLZWd?;,cDNU\DA4A,G2G>eU2e>]<YWJHWV?8S\
1dDO?cP5gfDbYgZSASSMOST#fHG7/D4dJ(3T=;7QQTMKd@WEfU<>CgB>?;>UN-JC
dc=LNJ?W:(ETQP.Q,Y9G>)CCU\#/G\O-ef(bO#3fU+\X+>4PdbM-PSEWNeVaSFYR
MTR1MJ>QFK9(2+](6d,4O>38;>RR>VQM[7[\U/[<g/N#3YI@E1\(2<[RLd[E3DVY
;ggWLJ3H1;[c[>/9LBRF@85N4XW>)3W4cD<4edX4\]XAU-[ccV=-PW1<aJ?;9;FE
=Q8;;GTMM&#0X5aT0dKLN=X0WHI#JbaQ<VA89IbA?+dM]J<VW:ac8<SdWDT#0-\b
^5,R6-/gGL?CNJ,^I=:32:I(XRI_Z\&BA/dY#\Q-AU5P-bW3dA/94bD3JRNa=E#=
=^CC07-fDH:11b\<^]1.?VM?X:DU0AA>00/A(>O#3XDX.?0BDN0VeJ==K3YQ2.<6
301;;ZQ4^_EV?^f0<9=VBWD5-d+)<LL]_VD?NV[&SNWW0A]B_PceI26-:Pe7e\01
d0I/]L2SQV[+BNIH\>]A9aFIZ4=a8^4aG9_:f>[-cX&]MdCb>(0;7D].@=UWc[/4
L-7Q##3d:A4;:HWAX5N,;/;a2BZ@V4Y0Qc5d-[#bbA2Z,<c(-I0:VgV,:/,K@Q74
W8MDVc90TbNGD.+5,Bf5MYVDI8@7@0L4ZL3W-E3KS5NV^>M#PDKg^L-NIG)2b>=A
JZ7cI0=N_adaN_c#51RS56HgAPf-WKL,R/):F-^._2T(U9UHY9[G[4()X(LUbEEK
OQ6@_2WUVLHNHV9Pc/&E]EE38PL/M?e>68UBX_:X)0BQPaCCSI7W3<\_P31+??J_
T<M.f4/I6Q;d^Y)1cR4+NM>K#c16_7J:@7]X@]=.\<_b[1_F0fX_Q-H\..[.TeSM
NWOXDg#]eNY0BO=G\.,49P]d)E2IUJ,P^Sb\3@\S=CP6cPETYFG9H^1DIA.Sa/fG
g4;a&0)O\9A^>ZAI?gYH5PBeg-RJJ7Wa&[1VgX1LgRY0_JJ8ZeGM=3=d5663Z>AC
aacH5?2(V3T_c6[I+SGRfbgd>ELY<f;M-LYU#A_O52ES^FO\QNYM,@1)SHM?3VG=
H#(;4PgY9;A6^0aK^cJ[)D&g37Y\D#_]eT.^T^2b:+?>@84_a<7Qec4UAB-Yc8_P
9I,G3(90Ba/7RbV8KE6ED6=NHTW?^^0B^Q2g+ZL;.>P<-fL;5\2J73V1NV9&2O=a
L6(9B/R/d/INA<@0MAbOdee[e-gUPF)U3,Y:LZBfeEJ?S=+dVU)V]R/Gf+GTLN17
^?1H4@YAMc8Z_RfX.fcD43eBd+dJg^+^_\5.S.UVU4?LGY&PH17J7Z+bZZ_V/MN9
+:HFI:@QOWNT<=_0eR\/YPP4QRJXg5=NS]BX(K0bEE[QL?HI1E0;>CMWU/Z/0;_)
A:7K8V/&cZ)DPcH/@)2F:\B-7Z]e64QReP6+ea18>RfUNJH0;XAbHWY&MR]GZ]Ld
b((-g8ICeR3eb0RAGWCfOe6)]A26YNfZF/-G:>A]I-=<_RXOKI#04+[8UO5Q:+D<
b6IM9Jb6CATFGTeW<X[HcU#Ed_+.^V>Z_FV;Z/bgJ-;7Z8Zd#FSgS>Bag?\a)>cB
I/3]TbC53N]XE4>+44_deS-G-T5#P:.G5:LLe\.&(&9&b)S4H&FH[g:])G@/NZSL
(&X=ZD<FDaYSR7[e-Jaa0bALGH(Vc.TI9;)-^-SfP79#/a8Ka\2dZb9=M2bG[]&#
<VM2AfR0e?K@D8^K,&VIgW>NA8ZYQ&16#&HR#N+_R&>-IF9=-S1H#]_:RSVB4R_R
D&)(c.ILN;g9,.1YU)/)3^P9&8#TD-N8B:>.1L<>7YJ4A2fJ5/\H_MV]7c=(_;A5
7EZ7AYX^DD?#2P)d)f&UPCM>faYd,OT4R6JGV_3I;:F+UT;[F=^VI0D45Qb&XLP(
APE#BG.,/6AMNUS&.\9CXX)<_-(cI.XeJ1XT5<[7F,J),XOSU[,&O2\M263YKM(>
J30A)bB89LU85,bc\:OAfB5gMS?7IaWWE,RZ3c9[:FA[ROM(ALcZPd^P.-/CX:>X
0E?E9IVIQ1+fR&b1\<^MfKRbV^DgD<KC/03T&=/-E4+37P+[YEX@[&,-\NOdEI_E
(=RgN2<PUf57G9b6Z2#+)ML\15X)(]WSK^1#_a,cTO5fXa:T5P6^H(A.^E;1acJ6
MR[,/S)Y5d/_T<AU]92/K&,?Z.B)?>-+5Z18[+GHGCBFP.J8O.T=7-._EVC5AI6?
R8<c3>AT^2Uf)(cZL;cO6KVZ-HV.>-]:19(&33>S+QSO_Q2D6SP71L6X3U]E&gN(
<QX8EJ:IFLgYAMH>]]]T:/I@KK<0<4X.SMgNEI,N(S0^3G3dB2cB,9d5M_9A1G<&
V8?O=SfP1TDa@9Q9>EafW8VI>8@FGdUT.LV5N9A&/gD=QKPHd7Y>]+MD<1(98aVA
)]UPFG7eD<K7:TH\SMGY;(5^bL1f6ZZI^#I2fS[I[YVLa?;7CbWd;YFNH&[2^GMd
?NN:>\6V0Q)g>bQ>ec,e?T2:EQ+5=>\N3>c8W7I8Hg3:##Z9R2dY6TFf,3GMW\(H
c4E]]00^V?IFP1770+O0V)X-7cCR@OC483c6Qbf+&Lb58(ZP2M1@>]a=dKW:U+d#
eRa9RCPgEef/(Z@QA_X)EfQYQ6LPCPgU5_&TP^H<^d7ga3SbRHLS9R-Be>]5g:;3
VSR1UVE3V<M0<<\V-OQ_>+0&8d]cO).Z)FMb)-.V+ONKDA..Pc,f#N)deGQ556+O
OO2ODJaL0c#CHD&PS&>ODKW(FWTQAQeM(?6gVDc;D2Q+C]-2E#ZL,SY4D_0XfV.R
P^e0Z)\67bNR18@;HTWEPGHfLYH^.P[9WLMKG7[C&H,>01>G)J:R&D>39Yff;Nc6
@]f.)R<9_&Yc7&YN=fJRXH]A/I-Y6GYe8P1OT<24BQ[a95@6K^?7Yga&]6POaI7K
SRVX#\.@V-[cJVcDXJEV7SSI:]8f5\LL]LVQZ/g(F,Zf5PNaU:,Ga@aed898+c@2
2N.GGRMVUKY7Yf]6D=MfB]-L(\IDd9>;E\8I=6HF&G-e)(/IUfZ<6ITRRLHLEE.<
PaYJSTD+GCS9+gR^L@)R?gA/M3+.Wbca]aGY6R/4b<PNJV6bQ4d6;Z.IR>dPaY.@
;?^_543HZQX#G@b30=RN4O?b/afc7I^,G:a]6922>9Q[Jf2.b5Y&T@H]-4KE&1;D
.V87c&/PbaU0NS09XN_7I[U-&P=O\48HOAEXNd)E72bF/.T>a.e;FRNR<^[LC8=T
c.)5#[1K2e4PX[&I3E:@@<41RHY40FT)-4L8LE1.&^WgdfTQ79e8e2e5([A@>IV7
TIe@K4R0Y>,E;4BG@=4:H@Mg1OaX+:>EKZ:#MU6;6>e];82O/]2fcfP;D9]8T<#;
31e.>UbU,@aLS3=U=c?=OMU3^#CKd1]d0#M<NEF58E6J74-6_gbX14c09#Dd(&Qc
>IX>SSQcPANN/BY0eXR>LC#,O@BI0NdZ;T@3-gNBEVLE8(MB5F/81/f+4Se893BX
dM]Y)_,Z\eQM<dN8RBaFb(1S-\)[XO=QJ^S+FELJb5/gY.G[H.Qd34geRN=aNS.b
c?AJc]:5VJX3+23/_RcN:B5[U#aN2M:5E2C]L^Hd#J(G]6:DYIS2:?[:QEF9cWQX
8D[.(9^;8#+-b63&#(S+IOPJbeE-cE5[)NKf8TL-Q7c[XDR7HC.M;2b(fW.KCXO7
FK0#-:c)e->@GSe/KUVI^4:3M1UV#d>Y-&AX(=YGVR#>(F1ebf9-aO7#BZ:[Z3EJ
<aY(O;CNEe8g#BXB<=\U@SM5=]IX=U3I9]6ADVNB9CZ.Q4L+)DOYJD4NG+(M<3=e
<YBQcWD55ZQ\B-&^BALYD7_[7M2U\7X9;O=\2+86-38Ie)WWBW544OJPH/=U\CYg
03/BA5UOXF@&N?4RVC4[QbB:N7PVDNX>01JXe25edP3ID9SDHZ78d]KRP2I0@4RF
9R8fU^W&W-Q66]fNW\VKf&&K8,BM6=F41dZ&Lg3YHg1HVH1(@T=?aL.H(&UW6\7+
9B/I4NKV1@edU3@f1[_bX#K.e9,P)A4N#7CcR0IN^_XEVNY_EHF7<E-:)OLTW&Od
:YFM6c_Q83K#HOXaba5X,5<_.I@=AGGP&<=^I&4?OM3bL@VHE#JL8RF2V-QEPgY<
;,_0W\ZOI#>eIKK(<.EA6=C]>L-]2KP77=4ECKHNG-RFYS;WH9,Z,OL1gZLcP<(R
B=1\3MNe3-A[Xb4ENd2C3(XJ_NYK.SbPDMVHOeU5^++LEBH8b?[P\<7Q&^ST](;A
_:GP.?0I4fP+3KgN-;K@B81(4;SM]KS]0+HQcL8V,eY^YFP>;&?\^;/1cSZ^(dR?
&NS[)7^ZE(D<&-57ZZ@K@IT,3]db+;HOH3RBH&/c]C=K,51GOH#5)+#g]98TB0N<
HBO]BgHVTe+dW:&].N&-F?&.b&2)GS8)+/YPAKSdVf]cOYS:8WO#I;XD:3AM)C4=
YV^(:@L5OXEdL)d-a/NI4SQc^^V\<eS]K[21H1?9E3M[)e]:26J&Uc#f82&H]RU1
5L(C:?D04K-,]J(2aWCg1&#9_E.M]+3@:IR:\c=Z.6OTU^]SYXa[@7A0XHMfQg<;
E0P=+ENIXLW4&?6201-8XTgROFI)3-gO>MIeYH^]cF_-PJ.b,=Mc+;]-?3P4,N:0
,baFC3E.6]&3T5C+0:2-Hg=D>2V??H.35[K;,\GO[M7_H=[BW[;^[g3M\a2X(.V6
BYW)\4VO9eK#d^c[&AAS)gW:J1TdEc9HR2OT&&-31ZU)-2Ud:<Ec6fV(8TNHcg))
<63D+5e0d#6R;RJ[HN7A@-f?S94T[\g&gO##G:G-g)IX_[-_V.+SFFb0LBG/W?CB
0N&U5Gc7&YVWN5VY5G)WD;<+:I-+e7,Wd327BT)3?b7\IJSD&=:cP2ZBG&(K<_VZ
\7N:K)d1@YGRFMNY9H;KJ4DNJ3#LP_LgK[c7J)4+)G3IRFa,V.J8&4.NKbX[3F>#
,KFN1BI=#E3ZT\b\>Y&)\fMRH+&GT\f53a/I_]6ML_;5C=Q]\:593XC+N]0>:f2.
E)_R5JU:K,))g2)J+X/CWEcV[=:BYfgTc_N7G?38CCQ]>.26d2S]6Q&WIUY#egSM
[YcebK\\d/<:fTeC:#9g5+^O;c7#1<7>3^\?E50J>c3LS8)(-3GE<\?:ac8/UV5/
b,T@B?.32NTI(&U:]6[T4gdXdfDfYSbB([_7ZP=7gZ8MaGc&?[NIF5,@:2b<\cZ/
g\/?)XcT[2RbeOXFc]EW6P^T&C2=+gNG5]c;@@5(?Ab<K];E(R:1WQ)M9,R+VbQJ
.2,A^bNB-8=^54Z]@-Y_EHCed_[84g,2II5(]7)-A;EIbT>0]>-7FJU/+@DRBdaW
>V,<]LWKFC.0bZO<S1&b3A33WKcCGfc4ddKe)G#S]=_A)c209GBP=Ea&NF)ZK:Rd
T0Z/(b[\DH]M2T9G^P]dd-:DO_cH4>AZ:YdBZK9A<G]3#H:g\RURf\4d2((MGKX6
^D_AfBD@9Id&A_f76_W_Q=/gA6I[I.1F;@S1\ZCf-#CN7G#4@>#O4e#235Z/=cS5
AX9.aMaEdT->T4.[21YS&YD5C:eC)Fc&(a4^5M4,?TZI#--&E@Q4FA)H8TLO/&cZ
f9;R3_G2e(e[-Ig#\PO4\X+Rc,R0U+.Fg4(BD603B6S7>ZZ(WWF,g(/9_08dZ:[=
69eUH;-JL6V/D5IOZL2]gP1K?\OL-cUEFYG5]5DTaDF@&[)XH/A(8CN0QKe+9H;&
ZX9eE)#WB..gg?a6J3<[c3OXJH+OJWJMT:c07>=IT.&-gW&M;H-G_.5bcaO=\;6O
@?UBNaOda)[OJX_75H-UQ((Y2+->eTZZ]JUWM7?0+fb0#?7N^3S.S4g\D4>2=\LK
#XTJ[Da.fY-=7<S1@1R=,/ZfZ#:b@GQ/]UB3]RN/49(6BY4eZ>G(XN9XHFNG]NJ2
^J>C8M6ZdDWX2/A(6cCeUP6W:GOWH<HNIFFIF+9C5R8KFY/=;OS^agd/K\+\N00:
&^\#fc>J+9^@=)a(e1^&gfc]=gQNb5<D^S0gLL/3[1b3L+<fO,Ee?dg^Zf)IRZ<-
1M;2]RaaW2.,K.e(^;VB])\XB#G@Z@&J2\#M9g_.QS6Z(E])fL4_?)fE1Ud@,TVB
AIbcVRg=.d;>T\C1A@O==a@_D]B8CDbIG3>d&^/a+cGc>#&K5;;gC<1FW]#V.KBG
]IW-QU&RL6&@+INb;N_;K7[YB=74B,46-<:)_D7]G@.6^B+/0(Ffd[PEY-]PUP^E
?g)W,IAXWE4@BC\fAN24,_-c<G#+6(QR0_=S:_&E#;<QfEIB&eMeM/GT,+U[.0\W
8TKG<))DcWOde>e@2X0GW[,.=B<H40]R-JJc#G()Z.1c-90-(b#OfD<d_W=IeT^M
VQFK@E7fEIARU7G/9E2J-U-aC@E+V.C)/K^#?2XD-\ZR85DH^W)S6_1PVe(7,(RJ
\MaJ_6F3cF,[34)1(RY1dHBUC<SEI_^^NT]=G+TG/Wad8S,SXGe59<OQL]]I)E=A
2YA@7PQC>_d-=]M6M?C?;J@\fQN;MC<L^WacMSc4Y.X]@]_0GH@caZ>YfWY@^:GG
UIOY]6-[^b&/eEC3LK]:T-1F(CC2,+[9Ng-MaOXCfE@)ZWS]P?[[^2XBd=8e<>[e
19:\0fRW4U_:4bT&:O&/2_#NJJ8#,2TU;EH<19T9Keg;?ZGM&[I0XYLZK62XfZ/)
-]<1<F,W0\RP>-U_e8_D#DT>P:^9TgJ8;_Vg1)]gVE4geIDA/:+QP1H]AFW;[&-\
,W-X-3.eFDbC>\2VZI\e?Me7gdO:DY\YSd,HI?-]^X^YK+J,H>4;X?H;VL=M@<D=
1Ed&Veef6UHCdQ(;09VN7_4L@+2?FW#3]7<IJO.IA0>_])Ba+#Sc=>?d3_ef<@\A
8e84WQZ2^TS/BWESU(7e5DBAEAHG6WQ@GHT/MSB6d-2Q-+/I4AJN0&cbgJ+X;@(,
T=.XEb8-e,fPZe9AA-5cRV7,-5#PSe(RbNC\RYJCSXSFW9X#Bg@OBRD5QH&4C8L9
H(NY@CL1LM8A78#E&TS=]C__+fN:#MH@AT])/Bf;XM[#I>B[>TF,Y3:Q50][G;6/
469^OIMY_),:(?3W+E>-^7]71X\IdY4-_7<[[E/&W9>FIXH@>R-+^-W3]S0TU.]&
FCDLX2YX-?W1S[07[7cNAf@^TRH>gL@BOWdWT562a<DMCI809#@1Kf^9HNATJQDB
7@[]/V:90aSQ)Y:)Aa>]I=\J;/,CQ48M<UEbY;Z2K&Z:DF4[KK/M\Z4+8_KDSC:g
YFL6\CJ,OD,L@3RS2WLeL^^;Q@#&-]-JR-]PLb&+<Q?CQ+L?RbcfB7\-N):]KXFd
@AUZRGI.;[[0?&H8\0Kb^;0RYF5RW^^>?&gN3QX1,UR/7S,<[C0+<+MgK(^Q5V)S
9@8L3#]<NCT.>JG#dgAW&5H.4BK[.+Z2YHd]:[K:/e@3/#\@4bM98EQQ.1Z=cd8J
aAd0GKWEaa&<_,H5A)LT]WIY_]XEE?.W5Y)@B1N33O=F(a3_G^#89MGH.4G])aV\
O<,4A&SDGS\4S60fLB/Uee>5/K:=5X\O[KLW?23LY&[M7S47QJ5]H/8^H6\Vd;^)
,5]3RH_,CFDII0^^?_+AHRP:f<S9JEW[3]<KTCEZ6=gK,>:L@aR.+5T+bScC,Df7
=SYX8UYR&CCK#O_U7)WS3I41\=)EaFNa/KSQ9K9-eXBR-A(C-E2&T5-KJ<NYZ\2=
>AMX-MLHHYNa]c@F/A.Q[fSPH1[9.E;>f#OPJV4)E/H8;:5Ha[daGOI;WNFRc=+^
Z#g;S/+6H0>Dag24bI&/O&fB>30T@R)^,0SW^YKT^bD4>[+WBY3c.^U=7D4Jbad_
Kd(RO5#:LSHR3538(-(.J>&4TVdFF[G/41,^&7^?d#50Ueb]4dPKA1gSBG&X:1KU
_C>U2^7:H;[9QcX,;Z?(aY&gcGQ4E?V;J+F:UYA8-_Y&LYUA+V4A-5L&O,f7d\.e
H#M0Md38HNaW=WFB)=^fdXSILW]1[17-3dL+b4G?cYggHM3XH@c;g15gc-#.e9a+
W80RKg&K0Q;C.@C9C)#cLX2IE,?ZfH@]gI7GXRaeM?Y0RX?ARC2#42+AAP9^,[a_
5U^_Z0I>91dTQb<6Pb^Rcdf]X)D-R[?f-O&8J3M6<_Z@40[@c\.ZU+KZ-[S@;H?Q
5C<.-IT+fI=@2;0-<[ALR),>ZLESd[<T:PC)O4IcM+BI/HG.QV,>N>M0A,EN[V9S
^R>[=\=8+L3?U6CbKfN7;Z4LQGPGa_@\X^PQ_aR7S-[/<UI5VN5<8_W123[aUT&O
>W<EL-bMe^RO;TH0SBKY+XN8=H7HXWWO=AC8=7FCg0-+VD[/+T9=#+P4P;^FZ_&E
Z(;+TFQK(7E\9c1(8L6S1I^,K_^bK+BS3UaF9)=gAF_TRVJT8Wd?UdFKaNE&GH89
7-=2U[M)JV1BJbCc8RE&<UAF(5J=3T>7@)A&6@)M6J>c<U1ZE_SDU4NCH4]QWL5&
3B3J1&>3;dcN>V22[JZSf61K<_=aE?=gMKSU=(N7NM-5]IGR?X1aUSdW]J,VNOPX
(aS2<CK_MBGgLW(1.@(;(EdXI452:fWMfETD6DT]#[KNL.c)MC5;=J)ZG<X.R9=Z
be/J:4_LN48.^5GA&?#&.H[XOIHOBEFRO@DN,HI,,&(ZE^JD\@W2@X=E9ZKX0f>\
aC,GcfgUFM9gKWZd[^,BG._?K^S4=W^d7W>M)fa>-GgdOaC?,E#3C;1e9#gS)8@)
,c[BP+(K-&c#C1dB8ICK\ML\02[,2NG1LLFTGKaXe468WB/F6I+b75AFR7bUXg@H
Mec^dTZ:[<&Y9)Y.?>42,[#/>\2;5E9VHGA4EE,ef2c]S,7-a1)E9dfDYC&04JY0
3NEPdAS<TJRY&WdZ;][WU[\B,0a^;./X-HWT)]?.0e@d_.Q-g#X@bd:6@18@<4R[
@]T3e6]YMc3_ISV,A0]([TgT#&a:#/YL+dEf;=3LI?0M7DaL:<.HQRANdNe^X[I)
1==Vf+Z)9+c]1?\0>K(Y,DUU/b+D-1331(L6DPYVe,,##\ZCD^:FSV#U<Eg;(5ET
MM-K.5D\ScT.&Ka7L[/1\WN&IF>d#4RN#&AP]&8cDW@78EgVgWV;W7Ic1LW;ZL_T
#aD_?eDdJbZPTf.]f6R0HAN9]:,\@H9HEHTcNV(@LgZI?)&cA\QdV74a62a;NO+G
9V?eCH?L(=H]0BSH2gS72bVYgQ(]bVKSRJ/]11>_IfK<<ef5gUNW[aHRa=XS2GPV
>=U^^3ff&6T.de,]UT\>.#\0=9YKE4,W/.7F5J]4bK47>G;;Yf8[P:TZ(T(0\R8@
d0]]@E#^LR,X]>S4[3_DbL6E5@dXO0<T4db^X>/9U,)2W>2E:_>+beR)Yg8=[a^B
0R:R4)cFf@Se-ANP]Q-K7H+^Uf.J]Q;=Ycf+=a<FXOL/SM\E^7]+&E<dQ1aD//8B
FB]@dG@O[6Ac@?N3,RS]R66E(g:-6I1B+V2<,M8MO5S7KLLWAG0XY:gWITMT;:cW
0F95S[&4V3631_cVF2Yb3L<]XP8MbTI\DdQ)@=(Re@3dPJ.H2@0D5efK8(fVaX_9
1(7E0_):I7[/YLSY>O2I[-M3&/E:9X8dgWKC&^WN:Fb_5<A7H,Z4Og,+/gPYN^Ag
L_XKKNYa9\=MH5AY=J73Vf@NIPUF0(=7@]9gaM&J5X0;:&dRF@IY4>Nd1MAZ<03A
@#J0N)(MbfYT)\A@aPS6\BGXO7b2TEcb#N[O88U82g7C.gDSJM6<Xd:>(&9(RdfZ
H1]&88IAOd,f[2T\eZ0794_gQ;SB;#?()?[51XF#TT0N=?-3XP7?50cc_f-M_+De
N686ZD)+2(UN@J/>E3\KfEU4F@MSRe91_Eg<(eSE:7D.9ESKcTXIDc.a\G+6CN^P
g6NW[ERa+#PM.HDd]#TJVI^ZE-HQ(-7K8?g/Z#0-&<V<M_&gI=PTC:\9M;J2J.Ca
972BAaI=O7OUg6[<UeX[=e5,AHd\72SCaYMK<Je_eYd)2,_@IFV_E]ZVeLN>EZ?S
JW(P:ZVfdSR@(\eD0O9+)@-\#9Z6.8G9FSRJ@AgdS.UCCU1ZOVaJ]\N)g._a=94H
LX8:3I_XC6aT4HR#dM4E1.TOK2P<TD0HR>6MQTG9TX@_J]LaM2J&2)XGZf5M.,bH
G7,=;ccW2PRe4N5D;<:1d5D(#Pe?#4=EYQ@KFWUB#G\37GgU(Gc3GGdI8XNCVf+?
=C4cR-GdOa773J;--:N--;UI:fLH4>:SPU]7I:_)a38)gL1R+bQ]]0/A-/KX1+AZ
BD?(5);22Gd_IIa#:g/)6W<F6)]K9JV@_Qg,?]KI2XSf)HgK5/DK^I)BQWR:a+TD
^7E5&=7\WTJ0&^MY+?Sg(.c]B3^FZS/89_&-3&;Mb5,7TG7\GQ6T]@3)I5I&_AS5
3Y@;R@.B97GLDe71gBQ2^aS9T]Q/UKMUV6)+:Qa1JWM>VFTVb879X@a8b4U)X\g3
L?a;&^;^QgTE_4cWEM.LK25NBW>]KI?Gg<]</=ECU>X:U7VP4\0eMB/bHd?+UUJV
)K]F4==\L(3L&b@G:<)V6P=g/)]g(J^d]ae:]YFZ+.#bAJ<FK[2[2+KQV4C/CCc-
0=W.aLDFHVD]:2T_K)5N\22b,K[BO^^Jg>fEO1bf+1P[8QVCMB,ET_19_-8#:FAC
Z)X]^\.QUWP#F:dQI0Q6Y/E@;?VcMMHF+G?OCY_,W+;(CQ2JO\MS;=7ZO;S7_?-7
6TV)=YGD[#D[YQ==5,ac?CP3HH32NW.9OgU8D_NUO4)F6<>JZIVL8/]O2)N&aIQA
PdfN9]E:N/#R>7B(faI:I[dI_LPa.GINOSS+72=&]AS=eA&abbUU.,Z64;V-JY-a
83XZ:97cJ[g7L28dL,;#TV:0ASa[7TaOU?TR37Sa5,TR[?Z]\+0c4;07ZeCME7J^
I39faCZZ4A:AfNA#R:6_X+=1W)J/Z:ELN14Z_1?2W\6a/@&F3K.ZMZ?<WZ?3+C]d
B&<ESC:9-AN:0H95b-92ED(Ce\<186M704U:H@Hc-.PKEe=S@GX-XfdZ-30Xa?;2
QI&CcSbVfV,1f-UJ^]G+aZ-3G^2F55gK]<WY.4#J2P4B.J<S0BBS180QKU-E]NXF
[&+eXM0OYd,^:OB;3_E]>.c(SV&^FKH.c1F4CI:gJbA#?e[#ZVM)aW-gIY8L/WdN
04:VcZcfBDBTfU9A5DV+3b?M?DAbX0MM[/,d7OgbG_W<FS=RFRN7RQ5X9?TW]S>,
^KN,;8b].[IT:eUC,aBT@_,#<L:4X)Y0N,.C)E]M;G&0VRB)a1a^&0.7@-b_\_cP
/W7N/Z2ZSX?ET2]F-0KUK8Vc@(+2eFX?_6=QDZ^<L+34EHN;10HSEP>(AU@>L->>
6^d3O/JQYCI_^(^]Ua:a?bf+-T@J.R<9cce458V6b/7,Wa4LdJf-3Kc:W#=GYU>O
1A6FSOdf#U]_.;?KI4,\@T+d8+W[XVFbgP+QF4/cadHfSLI2<HWP:0cJFU8#Bf50
,+62.D?RBG,BOg)=a1P05QF8[9[4)(&aIcXJ,E2a(4:T5^5D6)^LY__<;.YS?H(N
:e>2=#R?VT3Y\VD7X0Y,a=8TXL4gR#HPBQ=NIeEe::-Z^O+WC1F0bV;#&+RbT+(d
Re?)NE<<NO=67_42#/\E4PEU4^YS]g,W8^[&L\U1+NK_2-ZUA-5Wg+HeHD=N]WDR
G2@M?f9?6F3&]K64VfQGaaF_Nb-FSOXL.2#YCg@dL7RcZ:DIT:0Ef=UdT-7B-<Oa
(DHEeg+,X0>-X.JU(27\Z[;45UXX(c;K\CfE+ZB(Tb?\+R/Dc2MIZOEZH1R)U&NB
.#cAcB41)H;/.?55#/@/CEKO_SKT)b_I5\0I+5.&G)4B4dC@U2#7e\a[DH6PG(/d
QEEI)F^#X8@F7^TJe)&1)1+O5:=B1DQCb0VOcBed1\+b]ZY4BMP6;PB.,<)cN[b4
SXC7b&B(C/Kb_A=Z>GVJVgLR[g.@WAFO^Web&]LA=8\;K1e&-#C]WE[D,TK<75?;
Y)Lc-)1BccedD1U7b+f8+:]Sb=;<98bg>8,D?AeOPT^O=KAPTPO0^A67g&c,36Z9
6]\Q-Lc&<dST.\g&?:N3E-TLeZ4)DSE\W+U9GTEEeY#4T8+;/##(7]>)^;T:@^Ka
1TA=O:_T(<LW4Y);5U8-<V++DUK\FY/RNLR>?2<7O8=fIgA,?6G\,gLW63W&LbX[
.VAC<fMR:H18U.1-bV77,=N-ELO7>^Y+DB:S,.[Y.fbKaHcE&M#45LH7?6WS8X+\
KQQ:>M#5b-_.bL2SIZCbVPS=7=A#M)A-#Zf8ZQ5_TD4c-XD>6VYdI>G&f7C20<gK
aRKLDPf4SBSVNCC[44g5-c2\RL.C_\Y5.b+4_PUVT>d)=bA@#H#_OC5eNMIJeX9R
?d=7IebKMJZb)N2HD)&LY]F]MN:5K1Z(ZA^(e8gA4ZM(#bJ=(0d3R.R(S[VHOA[M
b<CbR:[HW978,g6c^OZ\2>O^98D1Pa^B>].83?1L2g2P4SbfU?bRC:e6GMa9#<WZ
7Lcd<1c(3V[2aRX#J>HRRcd[3)3\VS7FO^]&3<<FK-?)Of7;D-M?KTUND/^Y@Qb9
6TZUU2==>D9d,.2M>\Z9.-H;f-cW44USJ\gRGSL#QTK6T@C.NX,1Ed7R&BKa<a;:
7;aLWK0OebRRNd.B/Za?02[B.5,^_?ZHLZCc\X&:g&ab>;8<N]15FY,-YcBcCCBW
6\Q6JMXN5HRa-RLc5J4Zb_9\(BdG+SccH_N6CNQG@:2dg9BdGX(M??6-CS60\Q<e
Ac_e6a?><D1@c:)U&&>cE:JRb3^/[=FaaTY2R@4IfP^O4BD,FYTf#O)E)N:RB4e8
KK3cJdIPBN\#dING/L:9C[EQO)#-e=Z5<U#Ic.Z;bV>9^<7CQV,N]EIG+YGF22Cf
#QLT\gPB,AX+M4+&dQAd8QeG?>N98-1T<?):T#eR3a\[(:_6bb72D\+^-68GE(5V
gcF\,_60I-&\#VR_/HCBf),f1&H&_<X5XMc@Y<K-I<PV-:/Rg.G]>9&><GF:Feg.
2Y,Ob,3P8TVb<WB,W-(dQ;MB4INOOURHQc)\T9)6\SO,M,?\S.C8--VdGQa(VDZe
Ae3/TaLFH7&EP&R_LVEf)dG2XGF,c92b2;^6?:[DHZPH3XTGf7#Z5[=5gW,<B?W,
+=,2KT3OX[e0(E&(bc3((Q\+,ESPAP]4I@dN&gLf3-g60QX3V;P@dc/a=H3>c4>J
da9^We@T4BDH@M1bF#<TJKYLIRTg\K_/#YHX1CKg\A,)>##,?RF(HPdf?Y4XJ@,;
QaB?\NSA7C7T8AJ;\c-9][-dR_H)BPa)M2NgF7)-\JEd>J&H=(VMFNd=4g>O(CC<
UTR>E70@>2(=]KI53R>YL_YQETE>>Ra0.9CPMeJWZ36(e.E)dZ]]cQ9A]d9V-bEI
(R#EUA,81Z_3,VAPIO=LYRT3^c>FI9gXUdB5(1VH+Q1PE0g<TZ<\SHD<?<]SI_.)
Dd:GXZJ>,^?EgO@CEXdZ:^;J?5D;+dL7T=O]>+fA?/WCb2T0HZ.PEbbY5Gf?E=L6
LaHV:#/+Z9g[\YVC\ZOLZ(90#.#/.X_F/XDD(;27]:&]2,XF_&52SEL96Ke9f9GJ
QK=GL?eb[)D3:4C.WSAG4g>2UX06Y,[W3CO&<=([&N8R,RV0ZBYUO>Q^N64=b#ec
1K.gVVCf/6N+.UY_NAcW_UHIR0(b7TID7)9eggD&beMKVAgU-Zb1G-ZBT].B&=@:
C?d=/B^/,UIR+&d33RII,K1JB5I&EfEXc1_X5e7GOWZg&AX6CB4dQC55JEL#:N3.
8e^,T8,890LG?gVf>/CI]/aO8P8ANS0-#,-)4Z>AE7eeK?]B_dU@-2#WaLcN#F^5
]<@;LAd#N/7O=f,5]Lgfd5gH[OZ@SeW6_#&D)4eCPfY:/3fg(TX2\_5S>)C_/NPH
b(OLgS,L#fHN\b0-K:U]RLcQWe9]@GPb#bfK(6C@:V6GMPIfH;A>+#,O0<JVaRXK
0T1^UJdTOb9R<_]&;T>1VK-HIfYR@);81#=N9dS]M2FNK&2JIB6Y1cGFZfgZ1L/a
e;-<b3)4XaQHN&fGgBOZ[I^#>NNKOT1TfFd#VY?B.]W6JH3VUU]JZ_dWIC=&+P3A
eNc)YFHGF3e:>Sb<@Q;BR>gI,Q>H80^E37=/6R?P/fA9PEMQcDB-7&CMWB0#WIf+
ZUFdcE05^+(^^Dba),H&RY?^Z-3Q@2/)e+EZET9N2A.,cQF=+/MWb61\+_a)MJgL
K7O2e1QP=1a5MLSNe^95H2d(](UbMcgG(4R]_P9A)Ea.;VRJZ?;VE2MX(379)eba
A6+L&6PW\aFgACcEfACMYXg)afR&H.^a9+YbMYE-<(Y7JST7;RXDRIe(=:.XVV72
^M=g6fJJD;c=N1E22PV_eO\RKJa4PKba;dAbWDg4=a[,RcXROQAE;]Y/L:a.bH2/
dHZ/7?51LRP3&ZX+\\dU]C0_KV2.I=LTbB83FVJOU^I<-b3Hd?af].G6(N]W2Ed8
7Q,Z]UG^Y/cBWW@,3c,_B39Q,aMD[#7@=-gB:U=Dd2[A(IeEdT2e#cZIRAXI:?R#
LU3e&-dS/CRb_IHV6@X<fO\N/;EN<=(6N_V-6\c;O]1>/1<NDO-d;-IQBYL,B<7U
d);1/#cRGTTgBa=gcUS:&.dUD+1G8\Ye5ZGgFWZ]Q4?22IL9O&4+gQM_F.S@;X3V
P5F9T2BJYN8K_,PY2N;(D=+4g<1HPU<<Jb@XD>T-EaG^aOU]8,&XgNTTANW.fZ=P
]BW1Q#Y2;R><9O7IL16C#9^fXMSDfC]1#9-LgPRSIa24T[ZgF1T1^#6>RNKJES2^
(7MTa\.eU2+OB1;;eS(OOK4?\ZBg2V^4VYZ4\.cM[LNT_Ud=8/07#8\VN8<X;ROSS$
`endprotected


`endif
