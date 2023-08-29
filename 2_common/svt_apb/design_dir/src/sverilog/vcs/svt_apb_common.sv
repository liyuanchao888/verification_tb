
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
_DJWZ-_:9Pa/c>;;=d?,N/3(C\Sb@cW3WE#\/)bIAQZ;b)fZW.D9/)\<4/XSG3^]
^=fU&e,6?f1F7QCDFC0[6b]=1cZL]d>NL[g3&9d?M\_DOf,SI3@7V;/T4]//FQU,
Ea4ef]ZA=IRJBB#)10.BJIbGDc+Bd48:7fO.AXWYKSQN&RDDbNQBD85:50eKYEJT
H@X>&B2JYGdGDR?8YK@-Tec5RZ-Y20aaUK[dTVdCS3MIU6X,].U53YG6Q.>I:DGB
X-)K)^(_N;OKFD3JLJG7W>#6&(]18af8R,4TCDNc9YO)IR9XI+Q47(Q#1Ec/U4,:
UQ[Mg8A9UWDg72L/<\O/fc;I=M9E@Y5H/X/eVV.[3L+GE?cZES5SXKPF7Za3d)[e
/>,IO(^GYDdL#@-XB34DF&;I2$
`endprotected


//vcs_lic_vip_protect
  `protected
B#I/PL-9I#J0c++)WMTR+ccDa/Ob71CVeEIFK/T;<eSAXF19D_>;,(4O\\X<CGR5
ScXHO.1+KDN-R8J8bSQ-H___0:S00N-E,ZC#S6WFKcY9A<;WCJ4G8_9\(_cQ=9N\
&eQWGP0&](R.I3<9b(&U=59G2a;9;48f9S^[O9[:]1+>^PNUD>?B@QMcgF=@SUbQ
ebM/_6Sd]I^JXg<dCNg]?3G7\:?2<T#Je/&D9gGK(-^ZG4NS;Q]52U/b@[e6aP/P
7)HT8A_dc088[2]H&aYGb..C+d@27:<(_9>g(THXC+X)@KNN^(9/E93?b4RfYbcR
UIM\XbU8W_c@(?WgT;AfFTR,f>&NV>X\EK/-/X:c=947,M-#Z]-BEcE=3I8E9[1Y
YS.aYCO_eLXP7C6XT&:WH>EF]EDUUa28EVV.8Qg-<.+0Y>L.,LSZLF#1Ub(4PB_M
@,f[/VJNf6;aKdH3^6<QT-K9(A(dC+7M_9BX3.(GXBVMe]&4BXQG<eM&3\K5cgd5
A&Tf]PT&:;<KX=QA\IA?#cD\Y15b7.:><g.1L^.]Zc2BXR2+cGG++ULB_cA^WbFS
:#dI+BC7gFf\?b>f(E7[3TO)I?GXXg^]=AQRaBJfGH,ded&f>S?+93HVH#gG3_ZI
W_>/57G3216&LQ#dag]@^JR;A;4P_8R/c544_G;Wg+O615CgKWRJ&PB5A>,R]OZ:
+S)@M0fCFf8BRI&bYdfg_a]RIa;OfAB;]f:)gg;HgEAE#,<dWCA5;f;0VGZ#GO13
/?0<Wb5A7g6(ZI34B)HO[bd1I,f)?IK;[e@=VRCTK=<NDb[aB/A/KZ@(L^XC@c-)
gCc.[,aZ54XIK67IUR_RQRZBd;@,(De5M;9ZFb6O.)V(/G=ZHfZAJ#0[G5GARG.Z
9W,cAXX(S#&dO+G1\[g+/Z50gd<&dc]V<UYEX_H?L)@#O0VR>WBWD<UP-26\Y5,:
#XgA0EE/3g<X;9a?[X2P>/A/]2;>AH5,;7Lb<O_&JOL9E:8G_1GQE3X-)@T@HKU_
DKPab:3IAO?ED+D8Nb?8b,AAL9BITB)De[HU/PTC=8fgU2)fT#@2[0.JNL&:2CGA
;)J?T>OK,0RXXUYK]NC:1^agWXf4?NBU?&(?Q/BABRb]bHeE0JV5ND;Y.[U=E=&@
a=.b958Cf82g,X-MBcZ6G)/K^B[GN)1Q:GG0DYJ0P;=Xf5>)L#VUbRNaWM)WLI.9
T+2F2[a/7)ALc?=\Fd@Z;1]3)KM3G1a0G-&\SZa>EX:IIER+68=24GR6:W,D,)bR
X6&-;FQ=IXJ>->gc)2HR;R[K.R?-e7D[1CD_0Q=^F[IUb^.D>NI[&+P(P7SgGW31
D8fOI)f]bY(+_V1-&@2-,>_J8L^GF&7PdP04883B..CE[WP?RC=3&V&./-d#U&^X
aPU=+bKe,_FK@_7gI5L#J50H_VG9FdNeDCPYcE1>)\KMJXO6,@F1dXeNAg.8\=@0
@O#<8d#T9-06+SfXXQF,DTIdW=C0^_R&ZXc7(,)aW]KSVD49+1<E6f+b1Q/Y>.Xg
FCD;JI]RIO[c7AdO9@c?2>;[8G;_5CaU1K&:N2Va\]RS_K1W_7CMN#EV\8JYIV_L
/FB9HHEcUd?W8NdcR_C(FTCdSSe5=^Y/RBBaf3YYVNO[Tf8;KcT\/#OPOW^M31;X
HS8Jd+e]XFP3FadV-1S(f3ed]L;=I2:eX?225J[;>)H6c8O<0)C@bH,_ZV?VUZ<G
JJOL(B4FIR9\WJ[<fT&OJ;2)b(\)g6&S#A:_>X5,DgH3da#DE/0R0Ua/<+K_DgB&
D0=;<B]01X67]DDg,[WR=U[<@6Q&JP0K&&/,FJf<6+aB#0XM&V=?7:>H3cBHcgg&
B>PdC?d8]:MKIQGS]Ta:6+-eH4-@GLZYSWSd,]IVO\L#Y,E0\M?P.L(K,2,\R>#V
V;SFdd^S;F2G>6+5QU<=JEWeCXAQ8;K6:V;c3UeQg[-.bfNQ1LU[2\-;2RB.TP[Z
>^G:DaL9DP>M[M-.&;W5OJC4RCKK#=^^[YW+>T6U6L5KL.3PNT]:3B<WX[2#T-2U
VP[SW182+\a>7L[?9,XE1X:F4c+U6Y&@Y1=[OY#I28[44<NA8#:Rb0Bb9,4S&<0,
]3QET>?6QR0:Ea\U41LVPg_.OZ=?_e[0\9#(.f(bT\(5#AD0H7@UH6XAEPQ>P-SN
d;NSGgF[]TUOfX.c-[fG>AFYBL?cQ]dfHI\5D),EF@J5PJ;A=V1T+=DCcM)?GSU)
H8;R;&J1#W?dUX9a=^-4&KS-&VGH0+B/R]Y06?.#0TA;D[4eV@K/I#S5L,ZAO^T)
>cNg/KCUPJg)e8HYObW5RV5NP[bO54)=ZN/#/EAO3D<#W,_ZMO/b,f33:?AKLTK+
L0,D7;C[.8IHET50U+W^C.ZBC4T_cK&?+=>;KN=VD<EBGNIdJ4#.EF0e]B0\_Q)5
>PZVWdL0(1N<Eg6RK?QN[Z^/#DMLfSE\SMf4:Q>77VP_.KJA7<R0^[#KaXg>(OMP
7=,7TH/>670g.^.79)Y9T=O<M)BT?@L(.#SQ3f2<XaPQPS&:SQE\DJbMOQR^9VXB
TG+HFI>]Q@)#3CMFVN2JcY@fWEHWB5(aP,-_:F94_Tg]K,3f?2X5(131b=-G,FJ[
)ULJPDW4[d09^.PS:1)\5/#/QY4D_JNg;AQFPHK#<3eIKO2e:432.ZE_SZLUYcH(
GZD)@K3Gdd5_F.ANMbTV;c)>1:<2_/N(;ccRd1\N>BXC^1;/E5a3/8),#=4W\3[_
E.K\_-H3g1d(+Z8DU)CT-Q#Z]c4(W>&C@B\g?0M>9Ic>E9ANR3UF?2&[I+O\9U);
<V4O-AB^WC_<]E2XF;V731D-8=AU;B<?V09Pe9dENeNTOXT0bAb2M,cYHTd6#5XI
0ZPP#EGg5#UCP,a1GGL/6<8#^>XaL&fe)?Y^_F)?YR00I_bF4Yg<W\Q7)S9I7/AF
,C7JQ,??-6G]S[(0>c_dbAYM(d:MW>eMcKY\?/^?d.]a8(O8:X>U9)QS6596dJV;
4#H?&;bI#f1<4K+&U84<,SI5\#Z\FMKD+BMFcR/26WY>1/Fe^ODG?ARWf?WMT/g,
?P9AEXYC.J(4-:/C?BVb^,a^-?2/c/)9cN5S7Fc./(-B4f-?Q7E)L&.=<IaS4@PN
[X82T&TG[K]QQ\58IE+3;R\OU07HZ52Kb)2@\35R<CWI)WI@/Ea3IJ,fS)-5H:>?
AJJ-^[]H9EC<cd^OU<II+Z.ZRd._bNc=9-NDLP^XZP0WOOTX4ZZP-,R:O]#V-aTG
S6)L@9A=ggV6WL67f#gRZO4;,G5S&1JHM.bSeT1D7C_#OOTIREbA(\ZKcbg.H9_]
N,FZ\dP6#P<7Aaf1Q_Ie>a:5=g_gHKUA\8J0\UP+4KQ<5\JfJ^;9(=cD;ZMeU83,
.1TU&C0Pc4VU5Z4YM;+02DVBDa(P#GO.X@7aYQ0L4C=V8GBa0\WM3KM[e7ETO2F&
F)Y9=)9.BTEF4VfLeg78eMD;[beAb&8+HFK>-E&>fHdPc;-2X-_J=/8bSJcJE\_2
&eTcC7U=1/b=HZ.VN:5UH2^MV#H_OX0^J.80=)_AU__C.5>cJ=FJF(+[,^(7/a5c
+\--fgX/TQR<EL8<(RIcVD=[^)VQ#K1\O-CZMAKD7_UWY6dG:OT=(]NLX_:5BUZ&
[YWbYPPK3[2Cgd>QZ7)c:J5M],W<GcW==6(JY4&D9MS7_10gB_6GeCbPFD-3Y5>6
IGZ]VdNK=:\1@<TCc^5PdA:E=R;Y=+Q/UU&2(Dg5ba3aG1&CgLPM6-.eLKW/d>HB
S?J-O^F3\F-FD2T.Y1cD,6#8^2ZA&DZ^I5+1cQ(bb@B=/\J&)XL]/K=C\S^B),I5
7Z;7]IN,=&;OEe,_R-\Kb?YeW+@PS[V4&bC_:+VTbQILZbO)73]K-eEL8IHf<M]:
>#FIZ6)PRN:Nd>]\,Z+I&(;27@8?684,S9+TM>=0gQ/7Tf[c/T_SUUGIYf?8M@9(
fR+DR=>fKTJTF)cb&c13.90KZ2gb,4NQ(MQYb3FXXY0<7OQN:0e:C,C^K>9I6^IP
>P][)WU3EXdGQR.e=K+&Z5AZ^-]<T1A\(8f3LARK/::RN0&g#5,(<eEd>IILM243
7<fDbX2=9&64e=:f1g:W/eU9.+T):XWJcZ<gYTDCC2F.\<T>-]AV8^AWg^-LFSAH
KLgF:A<gJ/KN&AOTYN;S>09d/N3;)WQ-ZaaUZ\5O2P2MN&b<gZd>H[:3I2W]fMba
OaK(B,./>6e=AXOKAD/J\E??OCf:;9LF2bSB^c>G.ffCXQ+YUX_9W_AFe<bM@-7=
5K(/Q:I@;[T]/0^^R]OPWTbGO,5@DU98YZKf6dRa+#VP;aJcANA<a\@BJ&&(PgH2
6NIRd&eOaG-YJTed>1J(XgAc3+)UXB9JT2[9dQ.E7^PG@NX,[>e2Fc+BSGV8b3=,
:aC]b1)M@=2:8OA8(19L@,L;MG(:Ea)e5LcP)MMC+F_NGPbZ=bT3YCY.RUX=/F09
T/3KP1<.Kb^VS()<(Y^)]D++,#g3,1B_)Z0aL)=WFEF.IRLLE.TJ=OaQ=ZURWc1N
XX0gdISYNJD0E6.XB)W40ZQU-K//I1#8A5g=0Q7UB<AE9&9f+(F63M_20KB+(2S)
(GU:-P@6Z3@U7-ON4<XbE-?_gVWM(WS0Y/C)YE\Rb@d>@UM\T5T8Ze\bMa5GK(53
?X+d>P@],@d4b9G;(^#CbXV&g3]g+I(Ta::[97W3Acf7C/M7NG.6ER/43fg-M0c^
W@ND&e&RaPbee)ENCYU-0PN0)>JJ9_.O9[aEHI]=\/\U=CIO)F9K;@<_AUL.6ZCE
XC5c)L.9YPVM/^DN5+4f(P.:#MA4@D)I8CB3-F1E3NUO)^.M90AJS6PQW[:3gMZ;
2.EAIdNKT.d[d8>ZZ/+6Y,1SZN8XE;Y-?^V9?IPJGA>QA<dWd.)+LZ#<=Q(A94c(
6S/-4Edc=&PaL?#0(_:M/Y.d>L7\aY9&bM6#I:c?@7>Ye-W1^:^,MUMDD-e-,H@1
fD5SI)cXZ\aBSN(W4N[aG>(85VX9dR<22Vd;1-FUORF_DA=V(UC?d79f\L)VSH?b
QN^3[.H]O.:L#;OF(8+-]>^ec=4U2>V[Y(N-?YcL)VWRQ+0OeL_/N45]:/fOP?I3
VS-E>_S/e:N#5@F8GdS#B?#M5bS[eYH+SW,T3,SR_P-3?+.^]:I4OBA\0[7SQ4J<
;(O/O[3I=eU;Tg-IXR0Pb^#M4$
`endprotected


`endif
