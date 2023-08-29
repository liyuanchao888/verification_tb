
`ifndef GUARD_SVT_APB_MASTER_COMMON_SV
`define GUARD_SVT_APB_MASTER_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_master_monitor;
`ifdef SVT_VMM_TECHNOLOGY
typedef class svt_apb_master_group;
`else
typedef class svt_apb_master_agent;
`endif

class svt_apb_master_common#(type MONITOR_MP = virtual svt_apb_if.svt_apb_monitor_modport,
                             type DEBUG_MP = virtual svt_apb_if.svt_apb_debug_modport)
  extends svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_apb_master_monitor master_monitor;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Monitor VIP modport */
  protected MONITOR_MP monitor_mp;

  /** Debug VIP modport */
  protected DEBUG_MP debug_mp;

  /** Reference to the system configuration */
  protected svt_apb_system_configuration cfg;

  /** Reference to the active transaction */
  protected svt_apb_master_transaction active_xact;
/** @cond PRIVATE */

  // Events/Notifications
  // ****************************************************************************
  /**
   * Event triggers when master has driven the valid signal on the port interface.
   * The event can be used after the start of build phase.  
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when master has completed transaction i.e. for WRITE 
   * transaction this events triggers once master receives the write response and 
   * for READ transaction  this event triggers when master has received all
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
  extern function new (svt_apb_system_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter used for messaging using the common report object
   */
  extern function new (svt_apb_system_configuration cfg, `SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();
 
  /** Triggers an event when the clock edge is detected */
  extern virtual task synchronize_to_pclk();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /**
   * Creates the transaction inactivity timer
   */
  extern virtual function svt_timer create_xact_inactivity_timer();
 
 
  /** Tracks transaction inactivity */
  extern virtual task track_transaction_inactivity_timeout(svt_apb_transaction xact);


  /** Tracks pready timeout */
   extern virtual task  track_pready_timeout(svt_apb_master_transaction active_xact);

  /** Executes signal consistency during transfer checks */
  extern protected task check_signal_consistency( logic[`SVT_APB_MAX_NUM_SLAVES-1:0]       observed_psel,
                                                  logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]          observed_paddr,
                                                  logic                                    observed_pwrite,
                                                  logic                                    observed_penable,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_pwdata,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_prdata,
                                                  logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  observed_pstrb,
                                                  logic [2:0]                              observed_pprot,
                                                  int                                      slave_id  
                                                );
  
  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
N-Na)]V]cM(@a6b^cY.-_Wa6\G7:NFN12]AX_Z&/9d@gSO/g-De)3)V:1QG@YV79
@,S)aPgT43NKDM9R/.e9,_,FCe]QBXC.cIBEAX>\9=cX.PAA+LZ#;1I^VVUGC^>a
^8dTa7YgKAa&.PN2VM@CP2F-[;DP;M1I5_UZ+<]X1B3WNfaT=QZ7,0S14G3)GfYI
0DR7E+AM[#)#H>6@M,26ZGIZ>?]afIQT>a:]@N4eC_MRP.K&5LL??a40KRI#c[+(
d/gV8-+3H)Y#Ze89Lce8C=dKa]TU^H@U&A9f<ZF;1+?-D[Nff2dF^4g7M01R._gY
:DeM@1]B0bM,33>RS#M7S.B@72Y94O?82\3>F7^FQbK__CTP\@]3)A)K4L2N(@>(
47J5LZI5,(:,^LZVbdTPANc?W&:9\:/H\Y.W.GLV>A1)XAT;BZH(SO=E1?JXH;&d
0O;7SW@JQHF@fT2^Z/8e_WbJbYJ_eYcI-YPP/Q2eONUR<LN+A<@DS(><@NK>YIDe
C>JZ4#H3d/HS]G0XcQVS0&14_Y;:HL:a[?PMZ6#N/VN\5D5DESK4[:JWBR/?:UZ:
FBKO;C<-:6bNE4(F/RJY7.0M-A<-WO+#:.fX)]Q5-,IaE7-7\UK.G(aTggJ<\27(
N^d+,6QY<N1ROR:]8:#RMA@B(3\bJa>ZDg6W7&;a66f?<f)-4H\[2;+UFJG9D^+S
KZeYA>8;X?SZ<OKA_HGPHYJ,2>ZYA0\NZS;<P:\,G+XFaaE:KbGPW)87YcYI=HJN
:J<8?X5?<c9SR5K^ddL,7c>3bO?a6_K-:@;@TVSRfaLgdL1g&FOX,Y@B.Ib6gbXA
S(?a@J=CXFPS-$
`endprotected


//vcs_lic_vip_protect
  `protected
2FdPAB^6DfXF3.ZG:5We?UMbGB(B<Y\0:+EO0C2^fR]19@.,=8ag,(VF14b5#1NY
<@N9#XQ6H+?-IK+GB]I;g,QND[V)9MIg:CL..M,fU0<(HTA[4(&Df+NOQB\NE3I4
XKFKa]OT66<?XM?Z1S1b7Ed66/gX2RQJ+=F.<2[2BV\&H:cEOI/XR3?^a:24gQ.b
cVS;^D4ZUFOX2QRZ1eUZI<;LX#KYGV;(8YH5a(\@7>ETC1.2F7a:T>&>9\a-=8c7
@LZU;Z)=?dOC@D(a,41:ZIdU),U1\0C2e]FYT,=>^g&e?#]Se]-S@0/G^Fea358.
(6=(<GS#8gQ1)]=2:,L83_2^d9d6Z8;7.KC^K__^U5F5f4.E24;W/>XK#EXNKZ8=
I:?1CT\UZN#,?Y@X#\KW..a-J(K@V6-ZK;ZNX-SOYY9I6K2@#>\LSY_c>)(a9\\=
cGHfZ9SYVR2Vc,I#,a/,-.MLP-SdJ9]d8T[=e7fWBQT0A;R^Hc-64W?JXIUNYW+]
gK;@IWFP\T5T)cG@S\]gM8c.<-H3?&94+]Ob+bS/:@E0AdaEI^G3;^f7CL1feD;f
f6GbPg0I#&aSF#MUO??C[,#Y2:]3aKBQ]CP3S;.C1[)b-XE1S?-O:3_O4]c:EBb=
X.;^B_.a09X)^X_XQS_81CL8RF+_@U7T2:;C4H]O9)+)GVQ,:FKCCE+7KCJ(UD4a
ZJ07.#eNV(C#\VUab1Jg@(,K._NH)1.gdX2??g6YK--5G:gZbR(#V94<#CFOM;@+
ZW(f5Mc[AV&ceUZTTT_-c1C6DKC,+9Dd2WC[,;f.7g6I/&@QX^W#VW^:7MbYOfR/
3?FB9BRSaJDSXg=.?aH&:8&_?ed4;-,T;/>(LDT;9I\7I>MR]8UQM[]>fB9\K/;b
V@5a3,6<-^9BTY<ZBa&Z;@c>M6&H+RY(/;AGXc;A:F4Xa,+:T.:OSe#B<2We(a8X
S6IXL(b&EP6R<M?.N)C7_d-B.FG8VdC1JS97FYB32D=OUDOS#5c\9d:.#,>P+?KN
Y<;PK#U?6KdEc.K<4CX#BaX.DN??5<R]2/7\8SO.._R[<D.E=II+,3]4Ad7R7-K@
aTM36JO0#gTTMP]P\VTaHZ:9E2VAH:YU(f3;/UNHc3cUT,VEX7.04<[^0DaP7HJ1
4-QKg12b&VA:>cDJQ+e^,/[<(-SdHVHNKPTH;aaJI8[Dc:P_G/9DEK=1g:/SdXA8
R:2ZL=]^d:#+3JH2R.,\[A;gE)/[1>BN@Pa)SKE.T(JU5RC)5f:@Y6:<T,L@Da?Z
,4W5CRJAZd+JWI6:JXOPN7]3gA,0Q:^L+4Q:J(^dWZ8(9M#B;a>N^.dF2;Q.BA3_
4>J37baD6RS]T[7S>b><F?eHQ+EgM@:Q7c0L]NP4NWSd4^?B#AfZWBHKH3@OVbb\
]aP4;TN\79b)6Z(#VY3Z9C+;>DEK9[=_V/X4a]-M,Z#g+IPK0<&/D(SA-QRe,^C>
^7KEM]7;@X?JeG,22HR@d^(MD(bU5P(9\6DMSDW:K&N(@\7(^/[1C5<OK35S>R<:
UHEE.Ed9U??QW1AMd8(FdRM7Mg7ESGA7)X@+S36dE9J3^NI,1.XJ#VZ<TD[^?CK[
fTBB6SFeT1U3Hc=[^?UPTdM78$
`endprotected

`protected
&TWV9T?_VAf(<472))b7OK+Ie8816ed^9C0Y4O8?Z?d\Geb#V?5D0)H21^H+T-+-
N&;X2-4&Z:bILL.9?fIa/5+I7$
`endprotected

//vcs_lic_vip_protect
  `protected
@2[=#?dTg1d@\=7QXTNd-,VSJ2Bg_..Fg7bfQ9()6>1_L8;=L:(f4(5D+eb)X_eW
d35S]#J;E.]GHGV=1.;BT@50GXWEIM[-17<@DTJP,>W4L8<LXQOc2\?g[&5+gJN\
aJ622])ZfPCUMF[2G9+a]Q]bg0G+W_G9&6,)2F3\gAMIL3T>:.9GS.3PMM;_eJ9L
gS_O@0Z(WVJ1\_fHg,Gd#,I(GM]_F^HB:gPO/P6#f^VdAV4bWb@1Y97ABQ,A2U^9
D4FK&L3MWO<JfEd1BS81@24]^-+.8G-\^a.IB2-RVTN564=X&.=>Y4^:97d/+>FC
9V2]e259RK=0P#680[D2ET/H?UIYd53E9QR//0APUWB2UC.FM\;CGgC6K6V<eX4.
cJN1Ta+O+]<LdMPe8A#NHcf;49Q6,V_0+Y?TZb7d+3:3,aA(JSLQW/<.))N#J:CI
5X6GX08A5fTG]3J?_QTNJTd5C,W8ecG(F+=&\_O)/2;05</1\Sg?1/T0gFXF?_L=
L]O1Y,1X\9Td(AEQ/4D.b48[[O[O9F=9fR_6&?B1fF6_=71Fg5NXZNBeCHRB+1UY
.F@E;<2cZR7VO>_J-R?Q0YG1f-3XA)KINJC75_\0MUgQXe61VNE9PI-0)KLINDE7
G9482L]g,U/gc-B^.A7MIOI/&EH+JJ@Pb\Fg-J[\HLaPIMV&5BeJ-&+VCb?1E^46
=?L:&ea?F5+6=5XW=<>bXQZb)>Z1\_3P4Z<=M8D-.3f>FOeN]eK##]Eg++eeBY1c
2G@5WV61dQWb45WV\Pe)9fG4Z3R^AA(RS(\0Va1KTDM\V0L[eRbO7Vb=O(d&U2-?
@.KPX2&<FL[NI8/e.SIEFN=WFd-HS2T,=0.Eb-bOC@(Df)cW/U.b5=aTa9<\)TdM
9CB=/RICC?#8_#CSJ<0L0X@1d,&\X5KRL0gRaCfT=L@2M6XYGcS-7JVSJF\G(N8K
C93B#:\:Dc#;9?3>8#D9(W][2D/[aH&B;P842VO,W#FK\Ia9;P:YZN4(BBXKP16\
.d1bcDU^)LA=\bZ-]PdN6)Of)QeDH,3W_PA-AeM2KXIbO?,?I/\:NSc,5:aOcD&8
abU<OBEga?Y@C3dPRKGg,J?WY(/U8ce/+8#SgQYB[DQZ2+RG^XA@U2T(P[dXJVOb
-;[-S0OU(FC4T\KA))T.&M@?6>MHSM.DTHbg;+IeFZSf<^5PRXIA)M+COZ\Z(dH>
;E4IOd.W7VCLYa_/-8E/>TNZ9]]5QQ0AINgC;X[V2_/A0-VH([<IG7C^:NJP+I>M
J5/EHfWZ7ZbSeCOWSc84f_-UK_,:/CXe7bY1PIOMC\J6?g4g940C]YX_WZRNB##E
=N4F7>7_Lfb6VeMOc,4ONYSDTSC((4=BABC^Q>YJ_Pe7PREYVY;eZYA4d+YGX_P/
(6bF@S=cf<5\6c1=^AFPBeJ2U_&IK9D[^KU)Ug/?_\(/>=?bWJK1g80I-JK5#\Y+
@#B5LXQ>#1_9\g.(5X3XA-g)7V>.U9U/T;d[<1K^?I&J8e4#[\)>F5+]e+HO67R6
)JW5-&ZgDP,Sf),2=8_IUPd=c=3319;bb\TFER3f6PT=Gb?XSUU90J2,YBEA2WGL
[E&(#]O_<5#g^1dV3U)=<VGC:,bJ<&6P;)4MW@,M@Z<_a58&fV]-g.MB664:.;X.
>S<S3LR^\CPG^7_8,TfcERbF&a7>)0,NM<_BD.EHM)PHAb(2YB>__1X4_5a6Kb=-
X]K6a@fYQ[M=b-IQ>XX,]eWae&,I/XCK+N0O35gDReG;T/+L^R)KbXAVMId7Z8fW
4UMHZH=@RY2eU+2e286#I]L[N)8+1aO0c4&P4>-;a]W\;YI#\C&[(85#VdZa.9B]
YReHIaG410K0L#a-/@M09Cb@WPG[4Xd/OK6XXEUO).)5)eUR9d\6:L-;D>8N26SX
87c=A#6C5#\X&PG-F+V-U(W\L=&#Z._L5bW)L,SY?^M1f;[SIdJS2ZN=JcGZ#_DD
ZQ\UM@W-3.UX;B3QA5I0IQPI\2I6S.W-BbZXE\7Y7dT;PFR)VQS_e:<eb>7CV\25
aJ+aSgXKcAMK,=M\:eZJD;f449Tc=P#),;^R/MU:B)#94V,_KN@cL_#[-[NOdObA
?OEXZ5HH,6QASD-@38d?eaPN?VX/32@<;P?.@M5A72+Vd[\2Y7R(c8.?-021EL=,
6WZ+3,+A9(NHd+[)K#cE4M0QKZQ?1[AW?,8]0Zb],9=g?KBO,(>RRJ\@f4JSAgfX
68ENd22@aaa@aM-2<1+..3#KEARIA(;2=f.U@T>REf<:CGTJ6>^;d;<TI#O7)Gf?
0FQ;E><Of8dRU9.5MRB?A\Cf]EX<O9-SJ;C@K)Z^cR?S25Yf\]e1T=;4(R:@913)
5N@(BHPfDb)<<[Y35ESY(CJL#F?/a[(UH-bRd;RH+eS\^E3Eg9O<@.@;)XQCLT>B
?,_,T<f8]J;#fES1=@5/3Nb3ea&A49VBa#d2;Ve3PZC]_L,9G:5>87c)G@gZM_&b
1S6K_6fCcND92<U&cKJH;.FQ@B@[gK(&62)80,L7[=(aZN)EL@VB9PC6P(E6_SM=
[;aTbGO,USSDZAHd5#0?B6H2)Ka[R[0a>]6K<U4F3G.1P,Y@cZf+=<fe#=X1ORgU
)^]YU/M+TB\@eF1^]?06)\&Ca4CFCTXE]E1QDf@NQ7Tg;5CY-55:9_Fg1P/#F,WZ
DFK7)]1S[R#DZfC&^BTWe@.dg6=6?2+JAKaSH\D1db>^<M>;&ZAJd@_<0&&MWL69
AIa\JCK)CA8T;42]X?BECG@0]91N.9G2J0C7UGgW5RG&.#b[[/EdHGf,SXH@ILXP
95b__fJAU.-U>GM=eQWAZL_<C0#[c-=>Y[WLe]BET_PRV]=Je1f5-I1FQT(LaDIQ
?:V#DVXd-Pa46BcG6,R]91WVJ^)YA\3:\Zg(X&Kd=c_LU=b3>:Za\:(_0:b0:]43
8>.e;;VT:;05;8;>@KFda\&gf791Cac(4]I&UD]bYI0,B;149G9e2NTJJQP/,9a^
;+V<J\O,E\7;,I#XWPg-U0T1d@]5S>R^^<+aVA4I&HSEKC/+>?c92^=NbdQ@IF1;
H5)_KXg<G@CAd;5\<6MCZX5X(XE@.NN,bg__W\gCf\b-8XU2ZF=@\d4<GA^e.@F5
WX]YVc;1,#+M<)XP-JRZX?Y,=Wa##,Yg@I9^ZOM[VCW9A&LZd4?E1JS5(/0)egN?
9#LP1O08a50(0,-YTF\?7,WW+++cVg?g/P).C226Q(]_GcT<Qb.VE,^R/3BE.2C7
34N2b#_(+aON,?WXLdS#b\&)/NTUe_]b;3PO0C>(Z^?74CLdGX3/b:>M_;bN;dBZ
H5MM11=WI\DSbE>V0V./O0Td8?6VWGfbf>_^]U5IIWA[bRBR9aJaK4R@b5&Z2B6<
DLOZ>D)9WXdg/.2)-R[I,B)>B/OJ),8;b3gH^afJMIBCTE<.JH6#]((gQW&b1@UM
HM15@4eIa37.,.3e-11KRd^39>fKC;Tg_KQ@19<XeNU(f[L@H24<JFV949LPg(=@
Vb_/TG,1gVfEM5ZWID0#25gKE1S0X]8^Yd<dU1;TY;OB2TCJ)HJ1/<W@[@:<FR.Q
5UA@6S8bc\cW2(dS;+HF;EZ]69TWd=fRO_MMOB8Te3NY.IV_NE;d952X+EOe,\5W
_;fbeG55.^<L;bCeOJKF5>e8-A/;;A\OX+e-Y(JKcSbQbfXe3#84J,c8+:0bOK95
R]47.^/]HSK+2Tcb&K2?aCX8?XAd+6OcdT+VZ^Z)&3NE95]T^:(ZQWF+YS@1E4M.
H8-,TW<T6^H4B?;FI5O2UY^:OT:C@?.cLfE=/HM1VWeRUY-C-gNNGE9.1I/d=_X&
2L;VLUEN<#17D[6/-eJ/0&AE2PHIDDVVgfAPcV<2Fg4QOFW2<dQ.T&NN/3:SQV;8
UJL\3bSe3XQEP)>F:fB4b<+L,:[@/[3d1Ja4BHP.RST/4?5fCa#EL&b5Tb9;eD@#
F4b\33OPTE648A#9:BG\QH99S7fJ\QQ8NNZ:R_c@ER@2Y/N,dLf:@/0_=+P-4Od/
@80L<L;-NLg0382EXKG.V)L=N+QYU,A-2&QCdJUd-2I_&SU2ISI?f),ZZJN&@FS+
;E^(_.VJeTM2a7)+0fQ9XH;Z=/7cF[[@&adQ/],Y;a0<U_)F72M/KJ0OINJ@d[B2
00caKHN5FQBWZ&T.c2#F2)[_VXT66DQ3dEROIL_0F=5SNY7JLaCd)O=_2_+A2?VL
>S4Sa5<g8U,>T2ec@_:_ZeObDfD\9eA<X5SK7#DS8T->fcL1K6?K/M]_=\P+SVbA
fR_&)Z394<4KBWPFY0YGH[D=e^NO\fP]a+af=cIL4CH-]1_=2K]6PXVKdTPJH=P^
VI0](Uc8(gCC/T99V[7@K[S^SE@&REZ<3dfA,g#;^Q20#L[E)8a_HM87YcBH:&62
5C4R=\;2>^&V(M:Y&\a5SDGNCHM&)@E]Ad[dZD.ZK9N<N&XG#2fbB3?7ad=+>L/&
31J=)S6CZSgWHJ2LF\&K./-Z9@#(H35ZdT6c,,WO1&G)B15d,K@f;+#<VW&<=&@F
^L\_JaEO7=dfP;AH:>2B],3HSNeECbFA3UF(_a5_LB+bf[(7-F,RKU@UA[e;=+g8
FJ0BRVQ;KE]GTW-]9WSdTA#3.MV8H1e1)=@f\F(DB.\>TU/T/0e)Fgf=&H]&S21=
I^G;>LbF]dSJ.f[\aF,XCgB\&_5<0+/J4AaS?[N(&QBKa2RGW,S(P)RVS842DbdH
U0XZfZV?gKb4#=C+TQ-I?b#fbP8cb[dQ0D5+QVH6@)Gb3Z/T2KJU^H_._MB7#7__
_+ZaE1UXZEa+5]<F?R>1bC<0UYS;SUX-5G2f=.^-PgMOD\_8JA?&c_DGDYH:921#
3;=NI?H@21/<HFXCK9aDZN)B\M:aIFg]6EIHWfRXZOOIR.VVHcB-03-f-UX^3bfE
4<A1f3=G82A?<;XHG#1T6^@FJ<[T(3\0S-0I1>U-ERL(fJ3KIN8M3[QfaGd9Fa)K
d#\X?I[JGI4&W/g]eJ8#;W#1<4D4&NPNBA0ZB\@#(8cZ,)@D#@D.]BC_8#QaPQ)^
C=R/8GeB1>0O-Ya,J(H^^B>,?K2.7M^K,.RZK+#XYIM1V+#)V429_MY.bZZFd41#
<=2;\b:>4[]bD0SfG,ZU_GCFU4ODGeAg\(>+.,&PfE1._Jc:ZJ,d,GAHO.cD^[;H
\EU<a5c3?9_,P4V;H^cP^?QZW?X7P)5eSZ#K&W#.e(JL6C.Z>_E&#CL._C,&YB-<
W>Q+bfOSQ=JBTYB=cb9)_8C+H1AR\W#VJgX>/2YBa(/JV+NA,6Y<5A>I8&GRX/2W
]<_d0V0=c0?AAX_=U=F0e4_,XWJI@b3U4^ZR@5T#?=3.TDUbc+3?5^]J<V@.5KWI
_c#W3KP@CgOFQd&#LR^062WZ@,^aRG0EV8g)\3T(Q>8NQeKfa5HTI4P[OL>38+M3
b0#e&-=[AOc_>&.1/GE4B@e<<Z==+@?-ZI65@+)I:Aec7^W_:28dSX#1-1=d+=2A
;bZaS^7a6a^@c+_A?]d25aB1NG6UA\^0M(:CPHXe(EQD:c&K+dacF5)FYAb)NIKP
3MCA+Nf@42<\U&VH_Na=5RJ@L(\bHQE=+4_5]:6dFRa:c:IT3[4I0-;5[?f[,:?K
g.8&gN_/P8&e=&V>6D<8IfQ1I):KE06&E?5&;E37E/D\Ub+WU34O9=8&EV<4RR^O
Ye<D]+?VNFJP-bK?(0FGRE5NK&a6]19?N._GLB@X6(XZ=CN)7:+.e7b20IZ#74-f
5MUHIa+(b+)Of42L+-[0TE1Aab\U?GFJ8PFB6bEJTPW-JW8I5C@9\7a3N3J_-7J9
><JUV/:0I_Z8V[/_0IFOcMgYXXZ]6F)]QHTB2+3:.Z]@4bB68S,6JA+>@5Cd7I82
Q?QNE1LbHHLaBR.V5;_Y[E[]10WK.587&,)0,8+-G(=>LM3.UX_:OcRfT[ee9RT+
1>I:P:CFZW0E<010JSZH/c\f_A=G=;c[J[8=ESXF6QVW2]3[gCNXa]14P8KU-DR3
XC,\#R+)?9OX6?LV>8^]C6COSCg+J)Q[G9N(04[_c9=@H0]198]:/9/C??3E1QS^
D_Z5OSRML\d<e42]\5VR=J;]2IUE[EB&DW^?+?;gB,8J?PW3SScb</gME\&=ZYg-
Q(e+Z<:@&6<IP2=2>(dWGOY2@0=6G,\C=9,NF&V_JW+\D]&B,Cb=4GU&OU=b2UO9
?II4Yg.W@RIDb3(<V1I_QOIR^3]c?5&Aa;\+4+b7I7+1SY)AQU=\>?XX5NS^FK6H
FJe4AIL??:e^7L:V>6#/U>M^gR0VW5]8YdCA1.G@8PZ;f#H/:3H/X/e2FIEHYUB.
ed<CO@1B/-)P5g]?(+UC]Z5C>J\d1F5S3M\fL[1NKTRe8=NAaD<<>.+KTB;.dONV
X;B-CXVHLNA;SEAWMGLG:X?,]7ETE62PRK;)47;1(aTG\9F8cUPC@V1^PX:d/#O,
?gT5XQfOF,Aa:b0]dc+If/AdSNIEU.JJGc11WI19I?49gEA]Vg&Ka6T1H@>9FTA]
<R]cWZK_e8NS2NOGd7UVY.9G@3IbBIO)Fc/.^YbX&MUaEWM)@>M]\Ld_bU\H#KVF
\[4eQ=H]#KLb[OWD>)HdN-VD(F)CZI\8PSPY&R7LW7Wg]Jg3NY3YD^@)X.=.MV7S
QaTEUOQ2-(e-9Q7HZ;0/]CFG,bP^?]\g;811;PJO0eIfgUQ>DQTYPKSF=&__7B/V
TgXA#0(ZR7CP(?H/@[\VN&6#E(677LRX_@PWB7?C3D+T4;5eB/5EOc>=/I<:7<D@
C52.FN[Z@>Q8.<Z1CV]+1OGF&aW^+aD>B[D=K@:gONLE\>TLR8KF/-_Z\==,Ne)E
Z=Q:KMc#g5TbT,CgDWb?3?8U^H:>C:@2>FQ?WRT_+DAQAP-WA:Ef.B.Rg=,+S0]I
PH8Q@NeK?+cII^RfMR:B?)OF:bd?KMF>Ud+SdC+&e5gGH&fTP8Oe_De4eeW=7400
2:/.-0BL--4^Y]HR[Ba+fO7WcOP,._/b-N^BO05-f]6LY-Oe_TKQaW(P?:L\[&=#
2JOcDE_B];P)LF2]PMdc^^>GdJV8++K6/?I/HUP&Q8>_#RNPIZI&.D-cc:>a,Q/Y
(=,J.+63_FL[&YRA-B(.>c6/>7),&@A^VYY_@8+WIL/:73?3a6]gI/-Ge&A6>-#D
:MAJSePbbA0_QLHa]?JBcR,S8U.Z9N[2bR0W5]1(_fcaT]L(C3X(9f)g#If_Sb;#
>B6gX537GUD[TMOY]A0N@WDa9G^aCD&E,PEYWWZ=DF>cSP,:7ed;7D+\S4_)47\B
Ed;8/5M[\Ze01T[YTCK^-Da1?&U:NF@WSX?2>4#e\<aaB=3L8LH3RL7NQ-&bNASa
Xc&&;[&?>EQRI68.\_5?Fd.#b?0B5?HF+4W(N18CA9&NP.#&CdgDL=_S[8K6H._3
)=I0Y_B^Af,@I0Y<XS?_0;\@Ag,<C1W,&Q6/\4Tcdcf@->Y1fP2gQ;Hb9dXOGQA+
PaDC2-BG=(@5@/LZ9\b#C)Y-FC0P](XJYg,b_gYKA&AHN99RLM=\16X3.f)6^6&[
X(=?&:34b92V;aI5a&S&HL;8K6(IZH21:LNNDTC7BDPFP2]#BBC+T+0O?[(c:R5D
7R.>@3/_Q;4RJ?0K[Y>OS[D\VRc4ZC\HFOI<BWJ;^1[,@gCd(<Z8+bWNC^B#dR,2
@Y?4M,P)+<TA_MM]9<+;bBHUQA6FK:BOd^UDN9)cTZeS#8b.84#JB8:65GI=9bd.
T[(^Y7AUg4Y2W8[+MM\(9Z&GSR4,M/c3(C_XD0#:T[V5a\Uf.=75PUE[8(Q)1<F?
1MIOSJL5N68_N+P6H=:4c2-_4Q-e1d;F_PAX6DEL8B(PGAb,2b[#bBD#.Z_T-d2\
Zg@V#8;T15_L53bA11SC6#^1f:BT5_Z^)(.)bg^#Rb@X9&cZ5NYPU<T,Q2X5@@ME
BN&Z6a-HK2V[.0IAeN+8H5>@/L>VQ/SQ[d6g4&b40^AS5YG1\>=ZTF3;IN:g5N#^
)7M\)]D[[>9Ca.RH_/be^<^e.D/G9@I;H^&e]@HXE8<6bDBg=fT.,)\7(\aU[e0>
UF__((C1IAB1C6L:;5NfSM_A]3TNKf,<0ONS,^QE23IXZG.;/A(Y6ZP;_MQPRUHP
PJfK=RD^EV@>FaOHB;:c;G]W#V/40SPa;_:?,<ZM9&0;;_0NN>((T_6FcRaL>HFC
MDRBH?,;SdM1KGFdW3DCJ@32UK=V2[g_4<T+^3F,BcO_G)7SFSG_D=O].H&I[C&&
TAM])C:SUD<.\/V1]Lbcb84A46Y724;bL>][Y#.^-9-&M\RRZZc(5<@<QPL7ee08
TRde]_bYQZ=18AFY\_Zb5E._[d.>Me#XROLY(?a.1&NYW@\>>=;[d+,.L[f-gAde
U^NY#+CF@9?F:I0cGGG5fR.V2Y0T&f:I6=@?B?g-CW#3YeA-e,^Q2@7gN+KV[8Je
/(N7OTG0D&#bO?(@&P3W+8\L:^F\Y\^KJb]S;K@SQY,@AfTRK[C62TR[J;-/fHDQ
ZAM+9::3AZH&Ve>E=V\LfQM_>^GgbKAG[W_&S:EZN:5.X0<(L_HK+,GKCV;XaJX2
,G)>I8B>0Bfcd@L-K<F.]@OT\UW,FODeNR=,#7/Y2Pb?f&^4P2O7T0--2_P0^AM+
D.B9c;A56#(0EbSe7\?cA:LZR\;B&#J/5>E/E>9KDS=A2c(5dU1Y^3/[1f_@NEQD
d\FF3OgK?C3BCO;R.Yf0]1Cea<?LEA-3e,bA?g1YYag&KLDB@FCU+(<JMN2aF]\7
@(HeeMYFP8f9fL\Q8<,:H<GMH76PcAb/bBQcA)+3eb2B4RZe:5Q/;-.aW4+e.F.(
:1W47^-_ID_5#^QKI4[GW[ZW#6Y5O&=N8c=T#?R(,SJe/<OO^C26E1PX)@b),-JD
S),_@;+APLWb)BB0)E.a/8e+2Q3C9RMWHFgeG.5XH6S2\WDM=a.G&XH1dR-S[d(#
g;QEC9gH9H1]1\ZeO\](M1/L,IH/,Z1=OPZJ_NeUNc5^[b0Q)SN#2E(T^4/823S1
Cg4TJb-;FgUWMMaca3L/gUgcXCAL1bB#1[_BGf+=Jf-agP6)6&=0^TX^S05M&BXL
Z=LPfW7Jb(aLN>&O6T?K-CE2?X]Qda56(&).KXd0LB&2eE0VZ>/Q+f(N:/+3OEeI
b3OVDL.)IV3eAO._:0@&McC^S+S<b=c;8YB3b9#6IC@]B7C81+e6V^11NMM4>=dX
EQ11OcW<T2QMVfGH#Ug[KH)_&0G;KdNVXQFYXM(5HCf\d[R(_T5dAQ@8g^FWc/<0
4B(c2cQSPcIZ(=0[I_\[:3U8(XO::H#_CJ(QLS;(<MgDcPSRWC_KbW9JM,ZD0L)@
4-._@@##C?IK9KQg18B_1VYD)#B1cPB&egH[G#I^CQ81([B/Q<f:RIHD53.JeY&:
A<>?7:gK^,@eYXH^_K@]KEdY&]+)dU,bZXV1D&;+d0AGd5-UeI;PB\SO[9,8#^46
\K7],fJML)E#BHKZJeZ)XdWZ&^ZPY)JP.<F^;RLT;7(bAa3(-Gb4.)FGfa])WW2N
V+\Y)4Zb]INU2]NTGI>L)(Ia/NJg?+eeV-U^+XS^7a?1YIX-)5UN]<SI?-:(3244
1&d\N@&DZVD3QZM(L_c=O.B.@QdGC)8D33M(]M_\G9;[Z);@ED)-J\I,\\<(5e-9
2,+7+<=Aa?EV0X[=WR8P3<TCVE>#CN)f5W_=TT^74RH,S2J&b[[bI,B:^b_:&9GQ
]/Ab=D767<@eUgY&V3L6Wg>WW.2IB.8G3ePaV=)EXRa/UgCK5/:WP+KHO.2De?)4
M#[\Y<1R<P<6f^b@T[\<S^2,WE35dABT-XaY=2dGP@_D/-13Tf>[J#Ne,/WTYM9W
M;BZ>.]0@9dK&G,=fI206:TW]Y&OZ9^XIXR[?)4YP.#&gZ[4BL\Td6H\JLIHN4C9
L96[UEBR_bWHW.3<JeeC^YL4_J+[<R/0B8c]eP;P\M-L72[8V[60;:K+H,2YJVTO
I@8]S42b(-LCMM>R3e-aA(f<@H>3g]J>TR1R[/Z/6cUYF-F,JZJ^>Y<&.ZV+15+Z
4_K,VdI:&f<U&eM;d20A+/+^4-4ON-6?0Eg70EbLK9MeE]Z5+a9bUV;66+Y5XHBJ
GU67Cd:IV(Xa:5MQeSW00HVgbLU+?==3gc+E2>^=N,f^07Z(-gg\QARWM<cO\g:S
VNAeVFg<+_0GA)+;?L=VQ0FP.[-;<5&c,X.X<E@QF6;>O2g5]NDc?a03MVbDCQRP
,1_U]J0[W,R;ZAB;-G<SI?27]YWQP/PAA.DbYG]:VE&POaM9&Wg7SO,=0;E.f]O\
W)(g@_g68=Z+&K,S-f9SY3=;0GaSLQg83:B\]cPN4QfX[B7+C0^9aGQB;.QN/]#(
?O@RLI]Q<W^U53K.=e&-O_<\XK+]UT-0MA\<FM0;d=>7V1:ZU6(P\9Vb2NC]eU-H
G>-,&:W-Z#C^6\CfP.8?9A-E:#Yg&./)AN&TF]U4cQ]R#7DO;<J=]A&W)^/\^O:,
XA-56VJ4E/TE7de2_NIf(;G56fba6g[_V9TfH[dO1cC=T(BfLMc/V0@AYK8KGFdZ
#[3aJ@<E:X>SUH(a]J\ISE(ROR<=UBSeM7^<WCV,C]85PUAe0?[<9AOcd1B5c7(3
f>PX]GJN61bcF+/IS=d09ZA&2O^O0K\@1Q;(>(+D7efKTN(/?F;f#Wd1,g5f=PS?
DE9+JE5CY2_7DAfHd5=Qc=1;GC6gHSGaG::;8=0A?)L^IFTYg0f\MA#,_f9M:HHa
Ka(fg;EKN;LCT:0NT,PYIG&dYU)Q6--@:gP\R3&4C&-VZ;;YU@U1#G7>N>_GRFI(
,[6;;#J7fe<5]5,<FO2)3D2\#FJ[DDA570C07&S)b06NCH:L#0-a/HTA-C]RLGQY
>5CJHP-CQ@RU-5OJ+3L4SK<DQ9JHA;E7QOG_fL?O,I.8K;aKc9O?U4YVbS\#3RKJ
EPE^\>P5R=CG0D^G)Ibg1FQ/JcC+O)=1)Z0).\,.>(P)#FH0W2L-903[TPLL(f2+
Z0RF?d7[3-0-.DTG(T-C,ARcGRf[3J()dRPBXRff7X2FJgT(4SCQPG,3120Ud&([
IZc&^\PA.LF#)C_PXD=@_5ZFcaTG;CMJfdJD9f@@d^UISJ.4NNS@4_?PVMT80K+]
/Ta04KK=/YZRC_44NF8NIGR@T4OMG^.\6N<BYGS+ec)^L-Q^bgHR2G<E9V&F\EaN
2U(C>D]S+P()<3cIVH58.&]1:D]T4Y<GK@=aec;Qcf:<I1#\cX<P)7&Y5FEc7XXK
&KD2Q_[4e&+8<NLbDbL^7:^)e^EYL53JeL@VCbG>N=d#+(MXD20SIg?HL+P>e:I(
(E@W^9S3_-VI4g:gbX[KVb@\GT_Z]2D1Y)9LT4D845M4]84U8P1S>_/MaD5H;f=;
94_7N3C9[S\b2ZgC^(]#<c04(^ZM=T<WbF]NCA-?SVY&0Y6BbgKR)[.PKB7e[C)M
0P.Xe7;)/c\(8VGPPAFPS8f,D>cc742Z:BA#<Kc-C>0E50O0a1Pc3\L/W+:14SR7
-33?OdBX_.WN6,21#a+PMM-cB(AXg48TE8B2f]N>2.?X1Q6b1CJI6FI.6CCQA44E
88b-?0[BJQF+](fNF+EIX5TFZ/22d\0&U#HE<CgE1gCA_VR+]a1&,;?eFc)CK_..
?A,7dL,b/If(aT<COHe3EZ6_Rcd/7+e[U^R[(SXHN39JOK>\<@4[W3VU\f7\1Hb.
9&&[aY7c[H?Y1S)[H0,^f]VCR]d9C]ce,&7:H?=CVX#DZYTE/8#W_fN^3@#\0_N=
E@fG_e&)[A2UH6RTa#EE3/dI[Wff+XHUF<:5)b8(^&a?:LI1g]GCU#,2&.c=@4MA
EK,DM=2W7H<?5C6b=.LG:1b]TZc4.[eE\2H&#e>>[XOR&6XNZcYfVMX6B#0@RHH[
d:WYLHTAKaOGB_EI.\g?9F0aR4?Ve2Ea_.:[6?DCN:8U<<c7@22b\-=FDc1D4K\5
dAS+RSGH/HJK\,&3@B1bG&<VNJAdgeK<QE;7R4-.#L&>/<0,/@[C4IN4#7I34>aJ
?FE4a^K_gP&7W^589^X6?0G)?Ab,;f0MSRD#?A333G&/BZ1F;SfE,TZ/.&?:+[dL
F=;b6W:8APZd,YA9E,2.OZ@6\0Y62gc.IE3MM<OY<eVYGKO;[P-NNc;+C#_HUVCE
ARU#>dY?6.c^/@K?<daI[a,Q8^;A9RS4;]PW(Tc\_XgNVPQbOO0c],cHA79N0+Q[
5;bLVY=1R34ZUC-I?ML4\5HZ[6L^)L8f[YcPKaBIBEbNWVL-EH8F6QD<9PJ>bd4;
5B7LgYRd/?Xa.L32B5:YFX[1@:7X_Z^3P)P-dK?eS-</G?RU#AZM1:J0_(D2]K08
]FeJN.c:).1C0P2[3R07.I8Cda-RH?=)?\I+3^)?g_)E=C&2_),_Zcd]2=Qc,EWV
:UU.X_=133>[)I8]025F/Da_^[2NHXg4-9K?/-&4/D\X>6B]H/2RA:1QBOG93aCO
.VVVbbgDNEa7O1-?P(_M^[a,.(14b^<V[NU+?5M1\XRJ-]?W\(&\]B2)9I?JZO@8
2X]-_NbG;T4#GDKIUY1/1#<G+K-MACb7S)\?)\WJ9DK(fgO9D-JO,M#;+HeKD9&M
X;28>b?+d72Y8:F,V1236,f>A>EW/(fWP4WVXU=U3Z0\#>?5/T_^3a^0SQG5d-,R
5DaHHY]J-4&<3K:4DK9BTePe#/+c>EG_>S9LM2Gfgf4\KLAIc+be>?0SJM+aT[>W
M8e=?,:JEf(24U1#T97J[>d4X39EN.E<N1(0O.WMCM:B.aZ9?&+&\bPR<J.[[aNM
ZS.9]WI,Ud@=I;(d?,2,dQ;0Cc62.DZP0dL):G1MZ0XJb&.DCK@Jdg7^N@HJRH0]
X=HTIQ:0.bU?LBI?7Y3_9N,;M9;VPc-[@Rg/KX4KLaDK#QHWJ4-Pa@:Le?7<S-bH
7]b[X-?e02@\>1]##V];5UGYg^MV)R(e[+EcPSL]XM><-N[+VaK_J(ac@W[G6WIb
3]D)Rg._^E,<)76WPe_&2f:6XNU@M.GSeO-8^1V#EP:ZWG4P&PfZIH4D93J:@GI:
0g5]_EQN6GOH&?BM:&STYDZ+]&K+[gS)=UE8IDa@F;5T\(c83bVBI)(C]#KGEPO0
;,7V3(X-Z:,=&&gPEGPGLDSP?3fQ>7I(f2H\:QgQR6/7N(Y<dN#cNRQ.)D_?]0E<
&LHS<6BT?)(R46)H(RBFCFDf<9UeRISO1ICG>@_.[&I[S@Q7BgW>O-f/^?>KNA^a
W&[-KSR:D_/0)-53)&65LY0fa.MIA^cID#.57:QBSQKMZDBHN3IE9XF6-7fdR>gH
T:->H5(E#YPaeYA8)&\<MVS-&R#I+@JL)<G-N=GBPE38_g(PW:NLDJf>U)Hd4-88
WGD6^H1]WQ[OPTII4cA5G5_\F;/HOD3OE5D+MB8N>[I;3G1e.R3FNA71T0KZACY@
+?RMAX]R1,(7_fa-FC(<BXM13R,3Pd+7/A9I6.3g3RVNHW&dGM4P4/H2?b;7E.(X
IS^eH+QPD\0.]/PZ6O0]f1]((U3NLdU9^c7(O_6#5Jd,AL=AD>Z9RM?[_KE]9ea1
KMDC>Z?2(bH([G\EZ]^HIXX;Z7f/;YcA58dT0=#)dG:J74C^F8DKVIP<01c:&IO=
W:9U5OBT+67;D>6eV@0)(_/_C9RgX16fL-T4J)?()IZLEQaCA7CZ&.[5+J#5L/:Y
QT;/DAJ\UP)Yb+60YN)g;JD7IAW8V;GM4aTIR0_U;da1498Y#TAO#PfO&NJUH70+
Qc#15dME9\_34I(#?,3GQa]2.9\NR<D:.>>e4&1IU6LdI=e_DUHMIR05>N[E/?R+
<G,a2LR0U84IXPbaO2DTQdVb2e3_R^DI8I.2)7=-XTdZ50>GOP/BZcBEEB2Y1K6P
?YOKEA<:2(VK1NULXO&c+O\W,d?>1a1gR:U)DXYXdT6-S?<O>993FYEe;H48F:I?
P^R=ES?eJ.QJ3R)Ba/V.PFXWX-Mb?UV_I=gQWB/5&4QWMVQIabT9:5L6_#_GGSFK
R8J=X(G<@QF3b]=+PUP2T,]e;C6a6]?gH<)9>9X/73Hb&^#eB?F[?@;g<&P(cY2f
@]\>RbeTX0;6GaO:TF9TW\LePU^6WON=V,[#QB#ET7R2fd,W&SaPaJLN:J:3=\Y;
J=6WfXQ<JHfF.1Q4X=#)\Z0:JX^>eU_LFdb-J\Xe>+KdK.D+.OVE;P4K65=B2bXC
ALV?1<;f>_+2=c)0IIB6WV9,@(45R1e[9KQ-S5JDYT-e/daL.O^X<6C+[<U3C=BX
W.[#f_)f#]##KCYV]ZW(MMN<&J6+B/&^-<6]F_/3HJI&@PF7RX7\/+TR1I,BL6VF
3D<5TXc?0D#VI@]#BafeL,3gPfACZL-NL>?RW/>D+9X9cMab<9c/<L-HK@616g;)
>+OAPTX@1E(gGaIB-9Ee;VE#P5QM-C9:[ffVS[BR3gOA<N#eDZHWd,)^aQ3@H6MF
N4D4Pd8CMT)X=-XD+6LAR6:P34,@QW@,962<DU0VWNC#2-/e-c_UfEF3:^1LWOGY
LKf0P[8T72f4^/TG]N)4<Q&eV#FeR)O>&2GM>IZ0^E0NMQcO+JQML)JEe&L#CD4B
^X1aNSR&R]V<SKOE<-eBA@Q8Gc654<W/5Z3.Xf,#[UJZ&CTBaV2_6.3=8^L\22IL
#/K?>I54X[2HD=.1)_K6c8Z.V;OQ([PV5f]U12/Y[4FP]F[X#\C1[+19.)1#@(U4
FZY5aY9e5\:,98G0DC=0K(gVXbX>dA@HY=A)Z9fQ,AS^Q9AH1/<#AaZFF(f[RGC?
OLHN@0PIP1OY7^6fT,2>=b6g3(.G)/9a<P+Q>cW7?))0CeC0d_HAAR^0@A/7#NX<
US]8Q]]Ya-MVW:,D#.2E8d0cE0V9H#b4&eP980@WU7O/U1E<Z6)ST(+VQaBCJEOG
Q,XYVT@)OT32OSOC+O@>\QLWQ^6B-Lg+[B3ad3c@Y5/.US8[>4K9U&X@N^XfMNT=
F3;5F@SYC35-AMJCM.KBg/a7,8R;V9e?;/#6#O0?^=;OdQVRA6SBH=N<cQTST2O>
a&CaG+V^95XT:7G5A-Ede<Tgf27QCZ>O01O4e6g:U#SVHd_Jec[OaRXIQ:e1NWPQ
IPLY=b?RF]>f2X?9-Xd0,\QYXgV1gb>1#b2^L/RJ(BJP)Rc=PK:=EaE8LZe_?I5a
dHTX(&Y8-,L7-@b=fVX_IHWB3#3g8J+WC-[/-f6a-,YeOG=S]Q0@>3ZK^2E(PYLc
fg_[b:=GJ,^_<T#NQQB+d+Z^G@&Fc,W.E\-5UE^&GT1B,V=>J_U,dddaKYeLEZ@I
>f16Hd@;3<gC9E.I<=SFSGUfa,Q.UYWEgC-7C6NM<Y.X4)Xe:[-/c/QI=07F\?TZ
5K)(H]<IEBM\H75X@1/aOOc&+4Dg_fEOO:#YQ)TQLWUZXGEMg.3-f#^ZE<<+T2e?
KRH6e13B,2;ECVB7/a7XIg>0-9I+;)@</+-<+f2aQ7SA17(#XFN./-40bdB#,bg^
RdII0FN3&+;.)FK=#^-X.7F9P^W#gV.fd)[3(<38##P7d#4[L+U]3-SCeC^S6[eG
+:2VBDLTC(.PZQBg?.aQ=(@X-D(N:O/9S#<H)B\f(3TD)+d>T)@114;\S_6NENB7
@1B8d7G&:RZJ-]QOT-8&SZC687[<77+XDDSKg^cXQ)JAO_3eNeRF+PgTN6_0#X#E
Q=//F_7)LP,;:G>3#6WAK4D##^dM((._E+5f,]S7:XZ@gJX7^6DXe.b4>Bd>:@-,
B;HV40dHBA-,=MG:;[B6P<[D0gP-S]TJ+3XDRHeWIg:Me28gLZJ3=EbEfS.A=L[N
5Ue^ZJ]\@G]LI]8HH,[59C+&c#UA,OCD,(LA^S.:?0,D2Y-A^W#BX>6Zf93E\6DU
49\^UIG)Q3b-CBSK:FGT41@LA:M#(6-\-a2T]TOLRWQP14?S2WDeg]<;Q&9RF]#a
6&4.=@#&5eKaNHBUAA-82^cS4EDFE#W+<fJ6f7#BC525XD0ab4[KO^18[gI5WbUC
.Q@)P:KDNT0[aDH_DDMFcYc1PZa+?B/5]SFFRB,&SZ</Q/SEM>81<6R0:Q6C8\7e
HBd)McC>P@+1):HU=3Z\R9]UA1b+(U&6WdBXO:TNP>W72L?f>P),;-1<AO\];@[H
>fTNL>d>VGcEcVcTK_f_7+b>MHDV17gQ.c@?/Z=5[]\:Ldc&/:32SQ.cFY?/F[?g
)DE#Y/D>RBG,A<JN^5NBMfVe]\GHNLY&ND8,9g(^D4dZS,f]eF>ae?5e1#R6R3gM
@cE2(J97=M[<[DVEeD_.d0FaV:JFT5QVV.V?\C+4P8^Kb\D=/OdJc)a9Pad4E08)
@E)D,6WYCWWBX=\Y-F,c57YA;Pd5Y((>)LB7b0ADgZ(:fN0We5_3e.fJ8FKKVId<
N6MO+,ZT(Y#9,3Z[FbZ:0G;TI,Z&:QBNLHO?d0c>3ZN_L@g\=.,V;e3R2a[[a5(\
CK6JIJOB(V5-1V1-4PdE3-E&([QG=dBZ]\d]5IY;FaCfKaRU1d+\=+BFD]3Y66>@
bFb)<5HCM-.7AgMO+>OM^82&@F=MYWfYD0@fRQ7#\NU6^F:(^SY[2=QR8gPd:D3I
G>ZOQ.,I3<?\b9JJ?UL6Q&eX8\dOFH<Z<>1M;O&;RT=?]_=<]K?X99B1ML5g(CJ7
(DKMTa=dZ,:AUA2.b\XU5PZd4>/=V5bOW04SZNOT4>WA&BTE#S^]843.8U+cd]f/
^A/IWaOXb01QQQ7@5__fdW8F/gU9gNL>6S5BBV6XJf1<NBEMAfW)92&(aWYOC&MZ
:LD7TLd3bf.\/3M&I#KN>15XYX3>\b)S;6^cQRV:OKDb+gKIYC<6K;C9[2;M^9;H
F]\#DZ@4D1;I8O29/aJBHc0/<?5ANJN[#MaV@XE/bQ#PQ0&5ZR)SCQ4>HGS.])^J
]V5b@:Ma<N;XW8210eEE:.Ee=Y2b_bNU2f>Z_4e7Af:6]K=&3[>[[O,H2e_1<+2#
C.VQ\GKQNQX.=Ee+c-LDf[OTDaa_(ZQG]dHDMIFI0=#(XRQ>#Z&(I0>I\H35H0EF
K?W5^(-1EJDJB[PPMeK1ZTKR[MOBe8@E(U7ScZYZ-;CCF0IR:?MMH9AK,JC,gC)Z
3R7:9bf/E-+]]aVRb]_U<&RR6BV9XbaP@>c/KXJEG5d^O?73+PbA1^TU4g]B3;/+
Ce\GF8a:1D&]TDUL4DMP5+@(.De25C8TN.Ge3RBVH7.cB3,FMNe]FYX+(^KOTL)6
Y70ITWXCe/ZcW42(92M7RO>^3e)I@(I_>C\SLFe?OY;;_f_]35/.6SDBU4PLD76E
-5?4Ec15\;V^16Wa2I&Ua;\#Bc-S\MQ<IC63=#bN<5<9c,[#;O;AJ)<4b[D]WSZN
>C=DGPO/Igg<.-7?ee0#bW:R:6V>VH?A,9F>@)ZD@b8W;(;CEBBKD<.AVbJ0H:c<
g]S;USQ+H94.O]JeREZS5A5NQ#)P^CRHU8bbSc)QgZ\I1B.0g<YJCc[df#4GE#?F
W_-X@&Q\B63:TFPW(N4f9=-2Y7#gg_;ZF9(13eUf]X#ZZ[?Y8K()]CEaY+ECP5ID
=_Y#?(S@HLUbCdPULI/0QLN+96\)[9.#U^384-4N4?e7-\Mf#4F9)(N:5N(_[4SZ
)+HL/>C?C/5-6[@@/G@S^+D:47F<9MYXLRc9X#15;3PB7P7R6M>dLR4dHI4(1)54
c^0:HR;UZAM&8#bS-HfB8T@#-/[-@S9@@@7/5\V6P.A14eG3ZDFO;Lg00=_/=^;C
/Q@AZR37)4Y#[.)W1d.<I:2eLKQ^CG,4<\2P]_d(],C>dbF_V0,PDQb;,8->)\/=
/H0)0)7E?Y>8>B&IXe[ACQ]_^Z#gF;PgX?RF(8I;J/[acFeIC)c;;6VBJW<c58O_
R4C2NN&(Ud8D,ET7RNcQ3;I[e/dQ126JA_X^R0NTE5(X.5?U@,L0R<CeDSU+ZN6e
IeR[@M-R4f9:a+&GdRLWY.W2=V-<]L_;(;4KQ6R,_d^F>&W1W]V#-]85C;I#PW:V
3GN,GG;Y^Ub&eGI>V#];V8<WCLFD/?DLFRYY)A#K-&c@\(&W(9Nd?&SZbdeJ.22V
H+:6NS^ce9aXAf8bIURE(<c+Kb,#aeWXVGf7WfX6<,CE@GdI<CeC/2<]a\418KUC
W3&>4&I<-85ceeD+]8B8_&c(H13/W5EPXQA?V&DKNf^;X@>=f@GgK<:E,:#2CX]W
F][2R6^[XJMY[[/f4D<H[15B,[VBOROca]0ffBCYg)b=8Geb^I.XN3S&=<.1(MQ,
5&b2PXGML^?8AEX>\4K:DOCO\7L.=V/GfDS?7R;)8?FZc,D5)Zef^f8JULV]Y9M1
_AgF)c&c6@XT4gP:OA0=W#MRaeRcGWc1RMWU@?-A#T+f0][GH<<0:,QT]O-c/I9(
5cN.2NJJ(U>gZG\[NDC<-AcNJ+;MK=IERe-D(FEf8=9N-[\]K\WA\^]NC0?WdPD?
Dd\0Q.a,:K&;-32c?4)c-8X7e[J@Kg<gQ;.2HOfDc&R0[3OaXdYALO6NG(7S,X1-
ZOPTC<X3Q?O1ac,;P8OC;.<OCTLT&Ub5[^+W)HJe8eDf?R@fI<Gc1SNAPH=5.6<3
#=]bVU9_2_)1QQeMD04;1&S:gZ?_P0D<M@Y5^(J+MdYN1-Z5>1Bb[TYWJK/,d:5A
7]VEM&_IYDU9.D[L[;>b4;5E^1ET]GT,Z^B,HN:cdf[CLO6O@3^YJOc>_,;7=f/;
/;UV-F2QUQ/3A@,^[A@aKJ_CZYg62/I0[?4PK,I(NS;Z29JbWB9SC[c@CP27XW1>
&&DMV3/EQS_7db#86]A80<]U9P,X<FOHb.#JQL:9HP\6-aW._@T@12Td-dCX2ggX
2((eWO&E68R4d4NLJMQ1EM8),cd^:5AJU8TScU;_9Y@SK&=O=BgQT,KUUR1?^UcY
0d>1XeZY7S5;/G&d(5I(HBP+^DDN^g21])SLP,ObWET8,-DH#@UU/9Ye\U>ga9IN
]Y8U(PRWcMDDHCDJacdX+N@e:A2MN0J4KMf:4#CRHUG>T\AG??e:2MLdVIV2J6cJ
:E?W:\[d@(K-284;eO_;XVTb;HDR&G=c2)4U,;T[-A?:[6=&[La/Q5?DeXX-0NbW
OGNA2e?Vd8ZHg?V_:C0g8#K,S@L-ff>9X(;_H:^TP0d_TaeW:J8fRT]<gGL?E#R-
03)dS5Z/QF^B7Q+gbb9QB_Y>-MDVM,AGg&K3+/:K)8\c-ga6:[A.K2;RF=8+g9aE
@?#eWgD<H&.f<Y/R#7./G7.a[LT,QK4WDV\?Zf3)JJ3OM:I&5\XQ.9Y:]W<?P<:<
2K/aZ^+3XaXI2CEY-SKTb)aZeU)c>f:NT,JE_&D@R2+ZV;C#?[OI,4O0?GTV<.G)
_U3)CKeE?A2I<V[=@/?/B;;?Y[X\?0,3O0FaWC.,[K4D::K&JCd2-BUVHD:;#,NK
Y#=RGeCYBLUT6&G[(GKf_W95^IC_13>@4M#HD2JRUg/1Ca:_dZ:0P5^O4GG3[I2P
GgPS,8@#M4-A9J2g8d9g.QB[1a/-NG=^@278WLb&=8aAU[RaQb<#A^R],18UWSN]
<:E91C#__Db<A<G))Oc=bO)0Oe:gd@HE/S-6I_QUb.Q8)^SI\2SXS;;V/C<C>)\N
Ig2OP@HH)4O8D5J:g&#^F?gWdU[;9GSJ+BeDWR/gZ+aFT(K2EZddL#:9#TI8E;EL
T^B6:AS^KW=\19;e<LET06C-AfbePQO&RW5&?OUZJO6?5@EQE5]c.:XZ#WD=ZE9?
&<cBRH0^_0bJK=+,He_D9N1F+^BY_aFV.OK_<@WMN-Ig81L>.<Z><-(&6Q1U+P15
V+Y@SD0@O>8K4H7RG1B8;EX[Y(KNaZ9CX7.P6OXKb7F&[\Z._aPedG;#2(^fKC1?
L9B_?4JX^Ve[Y1bTY=,M3O:#&@9?BXCUT6<=a>5Rf/.F:D]]_#.=O_aXZCB5[@J(
_E(>NE8e&&^NN+ZZGN.T#QYI1#f#TLS/C=1Wb4S].\V6+I,HJ.HgC@R:Z&NQO1;I
_A^HXQD];IC)H^++Z[F^1=e1\<Z3I4@6Gd=>_R6C:V\F9CO>AL6FV3D6eQ&]1([P
T(V65FCEe87#]29+cS]QN0WLfC&O5,b0:O;gW]e<-O<V21D4Y3g&(6:=_F5-&aYN
=:UD8Rb9dcTV3][?/)Q9,Ab)eK_9H.6_^/-YdT6A2^/K890#@-T_6L6bG9C=-3)R
S^,0_Z4a-0?ONX(:f\)G8bP(PH7VS&EBF)EYHdA(,=,HDRIR?,M408QfT0AY,[:<
;EY4+-X6ZT7I&UWf_11VEMTH7N\4^eN>RI?6=SQNMD0]_CGa<,d0=R=G6cAA(bfG
NeIRU#g;SVB@\0=54#N:W755K#9F(bXgd)@gC?,)I#&7cZ[5[Eec(K\Z]VaL_D^Q
aW#2+PQB7_H8,/;R-@(-a]98<:XQbX#f)+ME-5IB0A0F#)#CFOHCJ(&b,DOQG0fD
bM1]^&,53L]J5X5/=^=YaP,@A+;^)SOXV+C\FHSF-ZTP[+]<(J\J@g#Z3e0@=IaZ
CMVO>K1Db(bWP?>OJUgRg,gTB)IL[NM&XR4??62:RKTO0&=M@S/P(fUG/?G<NDR&
RR-@d)L8)3YHZ]82@\=^+:aYcVI]e;O0F1b?<63I,<.31[0D,:(L&2Q(&DH06#_e
8ec7AB5DZ,BJ2/EJ9eb5.2:_K3RM/:ER9R[^-N&/LL3VP1cTQM8D@N&V4eVfWPTT
WJf0C&<23.R^0c,a[0<5^D<B4@B2YS-Mc<(4F5/(.Ud+:d_UZT5A(F.?baeU(-@>
-g2B0^W:Ud.a&@X-#P#&_Tc3eOL#^gS(R[9/Ec=:QT8Zga;I_+MS:4=4VGf9ES[c
(]<aNR0b#,[RP_>)HRAH[OYXT:,-TR#AAGeYbQ,dKA<W)?1:6LEd_8])@Y&/[1,Q
YOQg6Q/>I-B6GHQV92WE2?DP)PaC1(4<a5TcRDe4_W?9N^DC.Pc_A]c3W)S17AI8
K\0#T9gHI??NA(ODTTAVLd(EGfE2O()JGC52R@\B:[FC\G44Q9B<+UIVLWIJ8b5c
1^d)1R:#8I#a4,T.8BS([W=Xc)=\L43R=<6HDX^C1;&9O=c2CEN5M?YE_Y(g)&B6
O6+B;Z?H3F.IAF3Wb7L/7(dSH@V+E>LZgg9@\E5G3?__KEDS:289#V;9;(1G_0b)
?cXEf4COAP\YU@K:)@4OebVaKS?5LLfR2.7\D-41).=SPWOW;9SSB;RTHXe<bZ:R
<;e:)N\:8-=)9.83bM739YBKWIS?P>8YT9FWG3bZLSg:E#>[dJ4GYO>1\@UJPgB7
R)#a[3&Efd6\=T0ecQ\g?^4/c_]@edXLBG[/2Fb:#4#QGW8;]D8[UEg:Ycc)IXV5
I-eINQV_JUa2=X;=fIYb3/3IFM=Vc?/_4]ZOcR(?(e&FCHJAC^C;.Q=<LJONg?4f
1[>DO^TOT[1V@5SB3V]f5V>+0C?O[OMVSa]WXA2\3&W#cADF7Ibce3<1KIKaRKIg
EQL9()RW=@_3.Y#g>,OVK#<QdFG9)R,H&g5]4]P):7H&.],^=41LT?\-#1\TSV79
T(GMNL>2e5PM=f&Kc2E)3C\/Z-7TYIJ/caUaWf@8XRTFV0_NEf=Z1I_,5ad;?^,_
EH/DI8eSCHY#(IaNG[JbSY0?)7g-#I7##3G3#?\N)\c5)F]-03L-9Q5UaY.bVY,[
L5,]7TER[;V9SdN2LZ,X@<Z@La2X)94^7\#Y1VRFI5/AKd_U1A&eO5g/cN<&@-\^
bP9\9;P=(dBe=;e,_7>eZSfQ)QA.J]O/WF/4:6Cd_[ZX_;4AcB11\Xd0_E>PbM_&
>7NDJY2;C)(64=<Y.S)0MIU,9)UL@]6O^&aAOL53^?8Meaa9fHDY\?(CgGNfd0A/
WPWBHVI)LEBY4c+YeU:Q;&D1,.g[,U&)FYeNI4W(/4DQ_6.?@8\N-FGc),BT88Vg
W^eJX.a5FRIECUOYOT=^bG-/+2NQFeH?41JQ?F9M211c]]IbZ9/V\a1H5\N[2(CP
b[^M2<Z8AX)S1#2T[c>4ETJH&,6/J0&HaUc17OLdSdP46_gF(9gC1R\=Ce8?H0aN
UFU+D0,4/UA9?9bJ]I8;]?]G^PW(Ed<N&c,:b&f68C?8bcTC-:P[-=G3MM3Mad-K
RW4LIN7>/81SWXYQ3_VZC<^d6@U5c-dQ1;PT\+LE<@SN3YK4J(O9VFGUU.9)8;,^
bc]KT8-KIeZK:0:/DKJG<5e-0_eX]bHE5\PSFNQ>(=BSHe5S@7U8a40Y_:6+HQ3#
5(3dec9][U68D7PG<ac55b\M]#^>?1:4+FCU4BLE3g;DHO65YLJA06HI=cRW_WJX
9S&d0]^J.V7e+85B0;AN<^C^_5OQ?##).9Q9\3,WPe?W?;P+JH\d2(4F+8Y[7d4M
4)78^UMHWN&L?bf_5F\LUE>Qg[2^\WLFRZUdNTFJSf18_=B_Z^a65VGUDFZ-5N)e
aSY;J.U.5)K\6QRYeV+5_:JW0^I,c7fA&I=P57dfb^Z0=EW#9&Y_gJeM-YDH.62e
Z[W=MFGR3JD[.Z6bM<S8C@@\_@337f&(^=GRU/O8PWH;:1ZY=2C>7&RS)DEL^TSc
H4Af,bEQ8H?BT77\AP:7D\/^Af.VYDff4.K^cPK0(M1S-Ya=53Ag/PeIWY2ET\;]
Lb=?;->+G,5[JOWC)(HVQJ5db+D6Y\e)e^O#K8J-D_b5PY5>FdBSJ:,)^BB,+6\R
</g5IRc/(0I)II3SLNEeZgM((&;<9LLQOK0If56g9?6Idc]9>2Q;ABI#F&bQ2X\.
IRVO,(JI9.)AH#B^PXfJeBc&<961K2_1].[HaZ>H.FMUSH_9C]S1BLPNCEI^KYO;
GHd&]XQR.7AdIE#E/JeI2H)N:QA@,gY/ZU/[NE(&,@U]MCX1.K\C866MFU8QI>AB
VJ;PAZW?+ATKR+(e/EKBS?WK:JQ<,7G9>e-SdH\MGPBO5>Ke[g.(S:)4-](/Dg:W
NBAIDf^1)I;0EF^XQTZ.f?@4:69MbVd3S+R23JZTMF-Ie+JXN-)Jd8UV43)Y#F]\
PAN0W9:IQO)<VeK;4.\L?+&>Ka&@dJLf34CI0d<=eRO2f_FMS[DeIGSTO#,3#&?\
.;II#(1bfGRA?bHF:3-VNZZ2V=X+45_MI.:QIIeabegI#\L(2;GD4RdLMa3E^]fB
/XE>&YA@3:9a5#e(X,f6Hcf>a,I,cH7UL?eGP4VbJ9]?3UY)Q&V0S5-6(OcZgaET
cB8d)V4f1KITTNG0-.B5-UVOQ:<^[XKcPQ#DQ[/WTO^dWVCPM;7(QgSRV1RX,6Ee
>R5TYKNZ@_.L,_3\7:_(,A_20faAe](@.@]DPD)-UfKe@_&a?2//74X;CN+AXc+=
c9:48H0FM1TY8N:OReFG.c+VDO:Sa^\U7@:OTUV(B)/1@d9EgbS(H-:g#EK>73Ga
L,,U7Rf=QUK0W:J#W/U,UW[YGgV\,LD.]\^)V^de=ADHS?&]3)F:^K)d/A=S]CH&
3CN<c:0_CgGVZ;8)&20[<WYd^WHZ-3aA&HCU9PS00+DT:Jc>[Q4,3.8.8#JP>+59
P5Id_]cD\9Ff=KKGDQ0I@0)KAV?F,cgRSK\P<XC2Rgg>.Z/de?^=UFQ5@JXTGJQE
<<:=4?^D9KA_M.91PAYeT.5RE+L#N7L\0f#I215^/+Y9P8+d]Z]Lb6,E7<;E@^de
;+07_UBH-ZIfg8gfgOZIIOeaHYT;HZQfdfCOWC)>-S?I0G0Ta<LWEOZ@>#)A4,0[
(Z[+]V7YdLaJ8.EZJa1Jee3OD/,.L=2R#A7VV^_QASS3gZ.6Pb:[bV)(MH)/(Q(b
/D,gG[M1,B:0[3TQLF8dH^.<UJ=PeW6,^f(YR2_?__YA7>=YF[+B2O0d5681ENaB
AAT+?8/B)\RAJI6O7a3V(I?OLM]a?0a(78]0T7@f6;A:/K7]3JAD@cUHX=CfdG&J
Z61-bGA2TB+[Nf;[ST=UMX9a,LNTTTY45;+2-(CJQeVTY;VdV==.@;<9PRB4[0P.
#\_b4E&;I2CePIM3E?Z?984(Ve)EB.AZ--G>Y>B.E(gGf1)8I86]VIF#F5K3Y@/F
IZI,&LbGQW,5I255Yd_(,.&?>M[>6Jf6+<Ud2-,OSQBJH\caL+c,5(>+LNOVGJ91
)8YAd+X1YSX,d0<IJbO=[c,[.G,d<)YRB6=^QOG<\SHEJULMC>NMNSecWa?M;NMb
.aNX;?dU27V)(b76TX().c673cc#6^>,cd/U5;9P:aaASDA0AR:C5<.ZQ#1PXeS_
g5=STd_[G>e64U&-Q.5-?DILT?R@U(/W]?]-SB\Y=)H<6Z+2@E[-f/O&F=Jc4fc:
V^X<N+^[Z7[[^SVA^^-0O58:/4KIfc>4C0Vc[7EO?Z1HafUDF2_d#NS;8]?gc7G.
?ZFc)EZU2)6;C7ELC0GD3UN&62Qd=LbK0WEB.]L)3ID<)D&WBKQG],,5J,I(#cSS
])1&)0dL.C#?d7fb,c]U]g21CVe^Ldg-SM63\NCN#7JRX?Y?ID,A[3HdY5Z+;W<R
A?_2#NOGHeJcK2V_/L99EBH]f^LJB\^&R0:CX4(EfVPT-X(JbG.I49b.a\(>1M,c
C&P8FV=@65AV4d@5(IZ&&#A;,VZTCJ(a48KbF3gaZ,]B-d22^IW/\M[6,4J,4]AH
CSSeI]<:QLAA]JK0TW:6bB9C<5b4OWLM]Y.Y7ULQYB,]Qb[XW-\D2Y0Da)#(=@5d
g4]Q;.OL/KP#eMK:Nb1ZDI=d+ZgJU,e2O.2.D+@FV[g#2fHJ)bL@OZR6+&dJ5OSX
[^_-N/ZXZcK#HSb0fLI>;<--fBJW2F6]GVR@&@@<;=[b_655KVV.-cX]:f#2G&PM
.&1:5OKCQ<=Je<eba;:^M)\RFA7@:b<F;Q?0PH>WcgP:bM60:4ebf-1O;b>-ANBg
R]+\QdEgRLD=7XWd+=L[(WY6@.IO=.M]=_SDFB99V78)E1^FGP@d=HXJ&7N@5AH.
KS6JPW8/:-Q6>Ge2#c,S4&1gU41HIG6?3M8\76AY#T[1+5<;e-[cLdAbR&?3_3Bf
/>?A[_)X-?a&BD][LO@J3,_dc_e\8-2X<N0<.OgV>7fJBgXQ2;U(X8Oe24;+M\O+
]PbNG;=-d_e7JX2V)1(TdEOB-?CSOdb]aQ/UR6XC1O7^=PAUKY;.B;3e-g+WgYKa
fFTe+:;&3c5d:4JQGBY[RAHE\BDeX0;6dHbX9?)5V)>H@b:FK(D9,,?g6g15LMR9
a&GQA2C=T\J>A>Z68B[#d9?2<afE,ZQD)D.+d<5?WD[&:23T=?KTe3K37??U5SI[
_XTCR[eS[7&+=:;,2.9;f;<Jg5H=H?S](NaI+<#Y,P[LMJY)Y31)H11)=BHA\71N
R2>QF)-(aK@_WF:6bH?KS8_1>30=KRWAb4c);Kb^_S=P_A=;(]G<8<0Cdc#g3R\?
8KIHF)_:Y5g/9Z/>/2O9G5MBA9M6(>[5F<@M30Z8BX\,Y(#&#=cEM^?2G1-,f=RR
eBF#,e2\cL4MF:?Z)=efR0=B_YeJA[,I:]T3c)#-DC\02R4.V(&Q_&Vdg#\6[M+4
(H[@AMWfV[Ia2^2.8f^bCJRN.e>9-R.G+1G&PYUVb_dXL^8_?\+RBQEaTY:B)@EC
@&N@]=3S./WF5\;N>.e6\&b,JX?FS-J&f[7g;9)1KOOD?fT?>a]<3[]FN:7[H[N)
A8LEd)NK:,.P#2]+O+>6dGBMf5(:N5AB)2M[,T<)9U7K0caGSLB(fE<G5^YS=:8^
95=[:0[6Ue\IUg)Q8JU.AISB12]cQVZC\Q;3AV;@eJ(BU<@9-L[Wc[SY/cMfgWc3
)UX-B]a0:9eA0;BTUQSf\LATD>/Y86^:4;YK@eME8W:a+W,K]g@TGM--GWNX(R<T
W:5<<R-0Tf;=CJ?aTRbcX)J5Hg,Q7XJVU#3eT,fN4)<7;7)&Me98g5M649NS4,-M
S[6E^gUC)&bdE/:A160BPP?O-)gE[XR<R5Z3=#^IdA_\a5(=IZ=gDA5e4G(TE<_2
.AN..W:#@VS78G>XR@>;<2)Ta#(_ccZG47f[ZD2C/3QaC?^321Ue_gLJSKS&F^ND
83_Rf</0X-3dJ93H(6Vg6VgHBU9LT28e;L_Y/T\W5:)HB<MK^.>#)W\L&:+bD8TK
dLV,DWF[HgIOQB4YC)ZSe=#WBG/#1HN@U)-8dQa47\XI&)a2((BHJ,-X,CST+II8
7/-3KVYbHPAB=>&Wf>#.4-)?;eLWA]#ALK[@Q^7c8E8gB])ZHd)\ILPeZV7#gg]J
CMN?RH4WOO<OBW87D?,G(+c5:d(f;?&E1H;IPP5e[=@0/ObG9-=^d>+gRD9ZVd03
609ONE?9>SgAKbPO9,PgNVT-_R(K:SZ46TfX\KY0PGg,:8#6f#?CfH\GI0ET+7XQ
2WXT9A3[^W@,fY?O=]]g6^;6bB<Hff4,;]/=E2:5MOTF2F4IBN<aMf#,8f/6S<\c
^2QPKC3(O\.3aCLgRGH^;I:;;(@4<Z2G.B5dO:1EPBe&7ZW[4-Df_119W95\N[Kd
egK/P@V.OCLOF=16KHeJ&;I3Lg>N/ZN)UL-S5.3#C0ZZ;TCQDgG_;=^/VJU;2Zc]
:>>+PA?ZfYL,#]=7_RL)BaY&cL/,609(0>ZUc6CQU[=W;P?=I@UH<Ba<IM@@.BRS
HECP9^#.a-^g6Za(]<3&X7QO30#dP59]>RR@LfZL,?]QYQ&T?3,7b?JfA]D59a9g
=A[gFa0[d2?C&U+S-\]7aRL[Leb.BQH=8,/,@9^f0?JF1EIOE.[DE;>BeE&e_g[O
C15SY5.)>P?R/dLb1^3a4B>e_T\:aWYF-]0NUf=2;9_DCB_e8eAZ+ON_IW)]^<4F
_)BBL\AY@E7M2P974Ue4]DbfMe0\@]4)3D6F>V^@(0+^(a_)LFfE/Z6A\8<@b6\,
4Z)eaQ97C3\.N=XZ,-.PQfA1V?d<][I10,/RK6LW;NJ\\)f)5L=DO^\(O?S3Egf^
)H&6R1e(U9CbE?8_>GUME>UcBWK,HO4#/<Y&f@;E4]1?N_,DS]\SL^86(:+S-,1e
OONE.GfgPL.Fb:E7Z_XBY^YN(MGc,;f6/daQCcb6YU\NQ7#TF>8?-0^E<>U@2[6_
=F]bE39?g7;MM2Yd1P[4NT4Pa3O4DMB.Z8a,,g/,^=0QP@&)OA7:&&(b/T]bgU80
V#9Pe;M8#2/Rf:AMd#OA=eT7N[bR_H5:cK?E^cA+S?Ga<-?dUQAY[1?<[)&GRg55
KL5f.O4Gba9FJ0WI9X6[>:SM:IYV;A)6+e]W9+M6S&dGT6OG?+KR3ZBc_(_LfAcd
K?6Jd)FE5<?UC[]-LAR-3,C:,P4]#ENBIC,Na>.(AbVPR6D]#b@Z6\/]W3F3K4-1
[H#0WGR5f2eX]W?L2g(#U>:PbZDJQX2]f1fL4[I-aX^CgJQ(9Z#<[W9+^G&=fdf/
CXH_4(VGW]NDX,0?Q;J]Ldef=Obe[H^V_@TL^(ND><c1>324C_INFga9,\S[1G6,
]6VO#;J(10>\;)^2-7)gcK(0HTW+FN4H9^aHIK\_+1E\1QF@0Q0@G^=/<@#RN3TH
b4U^4^2@^3AG;]#SKI0;/C@N[VJA1-LR9,29H+SdDg&>IL)5@GNf:QIfYO2e84_g
Y;VK.+D7]e/1Z=9(L0.PbXF9WNQe(\T\f(V.#T5DbEMPT7D::-a^UW=\(P:14N)M
W#+[)^;XNR]BB4FF:.L1VS1dM19AK9Mg&@ISV+1M[10b\]d#_#(;A.YW&_#7]=Jd
YH<PRQf71\)M5V&.VLS3AcD(6,Re8Vd^PD.gEB)I-fK4(W;]1TV;W>[]/)BIBR/S
aTA>/RL@#GOU;^a2LP,TIE><Mf>6GTHB^U>g6IaB2,Vf[>BDYM&?0Bc>BK5HSW.-
MRGW.bXPQXRfD7eR1WOa:#ecW11&-/eEZ260E\?C&6+b?EKQg9FbaHgYfTZ]dBeI
8X]^=cZQ^YU9G\>+&7?;Z,7UgeOA_]d]H5?40I1-]07]-/BZV5GMM:LCZTBN73WH
FCDH&=:1V29;[<@;1H4=@f0?NA(ea0&aSUYK5#G8//1B:5J<0MH@dI4M&#:+1FLY
[/\g]1cLN:H[:PN^C(&OQg-V8F-\c@22f@UBY@R]Q3.2/,^^M(TA^@8MSPMIeI4#
AASdS?V[P?LHb2f/g2X\O/X]X>ZN9N_2RW^Og]eJfO7F66OC.D9dC,_de91S8aBD
Vg0G5WHWX?[DIDf;0.<(c.C?g2&7CENGXV4QE^PE+Y(/SDNfe_dZ>SV0,FS<R=:@
f/K)NS;g,:7=8SM(-]^FACGaC6/U,RcSEfF=.[7\befRX3NV0(H8&(8BWe0E75UQ
ZHaJ.EfN9?FEQ<IM^&^dRR]WMc[Y;-e>\gDecd5>@1/.\V:f:>&680&S<X6N0?Ge
E\/ZDf6TBB&[6DUc+,FcIIJVe)bOP;gPG5.20,eF[0#4B#EBB2b/@9U85TD(:YL;
T\F8.G<PLB^UXO_7.<@=_b_g(CD_?G)I^.P;\fAHL&+f0RY01BF[C,A&RG1=Z;Uc
#a-\CWPgF3Y\C68TR==a<AJQf,fU(ZNX:+\d(_6e([dPL[M\d/M-C++KH?V6FHb3
2dIW22eGXD^T4-+FOY:abg:V9W5#UeC;_MC(<X=dRFNRB6?71Y=IYaFTR/H<c):=
[J@3&>2/f^eb3=QDTCNe,L4&b3H6#O61(49C[](B1^7:J&WLX3e<F#RFC+:c:b=@
4L[fV?_IDJg<BV3,6@\=X3[\462O><TeAOZ\SYZ_^8Z;\6^(8/Gc4ZCK>[@V.870
,Gf4:EfV87Y^=SJFO@IMP0ccfYQc/]-/#&L:MISFB5<W<E3_6QL.36NQ1f3W-[dI
a<>+VR84#_3W&&fCR2;IP,@(NW5>We0+1A<OC>P]@<+M/fD&5Z7:a]G>d5E#3PDb
&,g5K56=>3)Ac@d@KVJ_S:D#=28Mf,JTI8<BI=Y:>O9e>89f8(_X8\@UI>+F+c],
CB31_O4(E9P=-Y:[PdA58@BNUGaV2?73(]_+^HA=#gN)AI=c#AZ;@>LPE>d5-(-8
OC-NP@f5SSF>2M@QaG:V@ZX8:YA#<<IORJ58/>MB/R.32C^/:#.L]WK3JU][ULcL
=aJA4JXQ1]d^?(/L>#OY@2/3=K_80B[>Z;)7_0O,B4738]e1HQVfga7P3=@8]]D,
WAW.WN^+??[F:f)gAO5,@Z2ebaCR&:?0VDEH_?X-QL-X-DW[cM#BBd]WVEK:_Ebe
O.G^QfKcBOb9RJN>/[?6M6^Cd-BKN[.(9ZJ.TA+1/JZ&?S96S.L13YeMXZW+;25(
d)a0;ee^;Qd54UIa3)TPg+CJQfJZbX_=g=>+<<4X6^d\K@07Xe:f]]e(@-L-4:_P
_<YM8&V0@ILO9D;+&UY/Eg.H+(aP0\2ICb[Y8/cKHXb^-S16>7=,9Of\?&4BS39L
;:@5I3+/Z:cF^0)?GSf([V&E[/V24a18IF7LZ^QU&3>NS0fe2ULfbId)/#]2)[<Y
6H-_DK^>7:@\=Xb_gea1cMW5<-L?Ke:EB5cS=RM&V<FELN<(Kf9ZLXaDGBeWO_<e
J/JNfX11<J[4TL)]_-3XbHbG5aH9RPCOU(GT/Ug9SQ:+&E7#/@B9(D8gV0,1ZRAP
-RAGG1Z(RLW<J6>?De8Je\J8->,N3(9U&#U4[L8<X;&U@c&+Lb<8)S9a^[^aMfRI
HL2T7BdbFAN=/IMV+X\I9ODWMe7_f:FDS&JZ7FU63<KQ#TJ;YeGA@#CU&Ye33Kd#
B2If8AH_J7Z5eVQA5>NG[9=AR;L6Pd4H\P1-]a@)\RTO#-@P.V@Q=X_a+L_<AfMY
=UV1)>5G/d8X7=g.PGOHgbP>FBb4^RcJB[F?:VOCM#dXe/>=J=;&#Q.Y]W7ef+LP
](5c.c4P\a&_7TI9NYc_6>4LCC&;?f?YK-WM8eC]&SR8f-;[,d+KM5:GEZNUB[4J
+?85H4(5][[JZ]e:fTW.<XDKVTXD-QJ5;QRJ&E[EN9.I]-/5U3S1M20N8-94W3:C
W4P9)R83@,DEHJKb8fMC=48R^e?-KW4H\.[KQ;/[5V)Qe[PS5WGBGO<8O@M5N.D1
]?ZCTO]c:D(KB2_CEWDIZ:bH[DgEJ[e]f>0/Y(M3=>XOe3Y^NCBEOU-TN0\E5Y+B
6c.?^(MZV,GMV+&2(BQd2@WPQ==.(.7bBR(>C1T4a3ae=03/7FRg=OD0GFX,?ZH2
<K21_8PS4:4S)C:<8Fg?b[E#LgIYNc_K8dBI(:]bDH@M9\>C,QZ-H,R7a,U+B,@0
TV0b7C6b>7Fe7[(Oe<SJe>+.,7fYYTM/AL>L3_/aTc^7YLJEIB2OR.LSAA6),.LN
:]ZK#L^D;\\P,Z(@5\?VDGSON&,b;WVeGQDOVX_bfJ7C@A(g3GBL]3_M\ZaCX/DF
+YT4/V#@8ARVgQa@QOX9[T#JMcU?MeCe7MBTRb;cQ-^DF;4>95XZ5=25R?RS8AWX
f.U;URa,J4e3#E\:(Y?\_-M.<cfJ]+OWIaYZDB=<?f83Nb?:WfXI40-]6IR-]B?B
d8^H0HeIb@&H6Xb&+-M93D,>(3UKO3@cTD,,45:f+GcSV:;@W.8N;&U-=P(^E&][
U#N09>#EY&&<G+42>aVU:aY-CG&^DS,B7:WN+R=\Q2A5,Q-(b#AT<V592VFg29b/
f6<(,_H-NcFFS5UTJ-.)MO=XM9d?&2G5=T:)L#8Uf2c@)fGU^M).;8P-4_2fP5@3
QH9PJ79#D[1L/K6D0.(MCFSZK:e0N:-:P.Pa4YQL1A6gaV6[MBJ7+NgWATH9Q&Q?
aLR:69a]X/J6TGSfY;-d13^J52GAYHG+KL^>OLXY=E7GLTOW,,9Md_8f39aDL[E0
WM6O18EI:)_.#_1>15Dc78M,81La36@,g^@dK:?R^]Q7T,+HK8?GLKR,7XN;ZV?O
X]#6c]4\d7)Y78Qf;O&JDMd0fObDR_<bUgSJe8H49VHdO;dbfB15O-_:<AGFQ2QT
:A:<RS>I1P>EC8V:c9O7ULGgXW_K(N&cb.HK1N<G3O+4&E>BTL2L@ED:-N4Vdb^J
Vg9N#fLYNKEZ+J.>B7Z\N;L-A82b./ESUMNHW(@IK69^g+39[ZS88GI.ZE:?I,;6
E>2O6IBgP)H)d0YMX#GR>C12C>Z&?74J755:(S/aLD^=#:<U(b[FZXG#3K=-_X#<
^B+81-P6&(U;cE4JZ\X<I)B[O?<-T#^&=X=U]Y8a^dCb.@9PNg^]KS4BE0F-=9W?
OHP&R,L_8EC#\EQ5_]:/1-g^>+eKVWELNg(O3g[DAS\c6c\RBYF.D\;=K@@2Ib6b
eX6JSF4Z=^?C#U:([Z4ZPHF)N?eW#(B5I9<6L#^@J.7.J@7(V)<<N>U(]1T:RFK#
TJ7..)1H+&.5BcA?)Y<IT:2E5QgB?=0[-cA2M,If?V<\-B-PWVXD]VF1b=U4c1Fd
P6#/]N3H)<@QO<HATIR/^9fYG::[fMCQG&]a0G-X]6FVg]ED-N(P10PIC]19+<3[
LG93?4e.VaZ&VD@bd4fLdc=2U\#4?@IUgG@?0B(g/f\LgEcW4VO7/,B[Wde@D5X#
:dd:=eLM\L8/^-MCD[ead25H9U;IRbA>-OTJEL2:TLU9Ua.\FfbXcA]c3DT)2Q-Q
N\DP96/@QYL[6#S>008\NO)\Z0S7L.8a/I[[[SF((AcX3.H0DdF+&#@][1U;6f5E
46\LTDIR#Y@+(^>KX9C1F_ABV>(YOGF1JFF3JAOU?@NVa;@X#5?O1b[RKKD^-[1^
b&W1M]L580e-6D--K5GBM\FZ(LUJg8(LWVCb>-]0K;e<HX2KSN^,^7N8ACT:SP7N
CNRbWD_[g,L((?e6O_--I051(MG>dDFE)MYaJU[J,23N=,(+=M9<KA<8\-^,.Y&;
@4+#AS.SI+>Q2;cO1VNLaf480U\T]<9U-]C<.5LW#A97W;F7[&)FZ25E-^J8B0FD
JfOJOJc[TTV:9>]XQ#D#PPW8L.9Z<##cK[BM50&5bOCfgdRbTG[@8@@aNB^BNAB&
4.\1IK&dLHI4Z_a->P-BGF=LM4CS#9##^=QO5dWZ&37HH^AQ:7<<1TK9?\d)IE+Y
D?2=fC>1[C&;;E&32^-GaCW3W>L>H[_E^_)VfQ3+ea+,FAE-V&B5[84F3V8+[T2e
cUIKaWAVF;BRb1L<KV3BDNJgPN@FD=Q.SA(8-PIX7\)6=Fc)C:BY;F/YH/fg=SWE
7\7F,A,\c2WQ=ZX2\7@gP50&7=87aHWJES=3+Y8;Cd,+RcL:31G&S^47P]>e2I[Q
5P\6&c0,.4MO]>a-]eP>@@X@#QELFeC03cFN\=J:YD@(/PC/YLcYf=4Ic\eS>T[9
=.SfFT_>PG4MQ#7#263TgH_@eQ#eD=^#gY&R1=RP8J\S7Bgd8_+06\0?K=<--)K<
F,EU>8Y89MU(3H<?L#6@#dW,UG-,TP.L)PH,9(N466Ke_@FX\^S#QM+0=D^)TgA>S$
`endprotected


`endif

