
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`protected
QSOgf#D#.8FK4AO]dH;^7:F&A)#5eCZ0V:V2AG^)E-SR#R4>aJ[?1)6_-DV3F9gP
4ODc^>3bGf\FYTW=B@PQB/;>RI<S_BcX,?CDAF1>[;@6>_UBJZF^+bEc,4eNMLPH
3QAS=L2#>de>J&Y[0K:(L?QR)d,ZQEKC-Af3O)NK[#RAMQL)CDB?Z^5);ICTNARQ
I11A)(&2.T(d&8,=#K^PCOLF:2SCD5(HG)\0#[RC2^Q6@.B_4=&f?<)@Y@:]@e#Y
4GV<^9?VIIB^6.A=.JN./T>@+WWRg0.1&NKfEA5<O-g,LW/BND0R0AAS#MD1gX7?
eC\L6F]AQPS1J\@>>BWc0^HV:D3<\D:g-2PScPSP=QA>d<SRL:SR#A5WDJ^01K/-
/(T5&\/Ke/;+U[C@6=GD=fF_A]M_AIT?b?2+AKD6QZb,O4W,Oc)(DMB_U?agG8c\
DM-Q0XYF)7(^2QaL@=4#+#a?e+S0@.baSR4#Z)WSX<BP:PZSe15fK4).c>RfE5@A
UGN1Z,D-b0,5.,=82G3WMPUJG/I<TC#)GR&@KGQ,HV;KR7D?[d6USA=5NHA)+[2GQ$
`endprotected


// =============================================================================
/**
 * This callback class is used to generate AHB Transaction summary information
 * relative to the svt_ahb_master_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_ahb_master_monitor_transaction_report_callback extends svt_ahb_master_monitor_callback;
    
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
                      string name = "svt_ahb_master_monitor_transaction_report_callback");
`endif
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on AHB Transaction activity */
  extern virtual function void transaction_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of AHB Transaction. */
  extern virtual function void report_xact(svt_ahb_master_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_ahb_transaction xact);

endclass

// =============================================================================

`protected
4AS/??=1Wa;)3Y3^DY7V<WeFFB(:XQPIdG&62S:4:;c=a,_IR9(96)BC5e3SaQaO
L77:0<=1;g\4QbV+RQ^K^<5&TS]+-HJ].337Q8UV^XV@^8e8g:E9=KU]4]T&>/=\
_G-0g56(2S<H(;aY84LN:[B0JXAd6-B1bP<L9(c-7g<agA>Da(IA\R.N+NX[eCSF
9c_3bcT<W^\E?2baWEg#LfZS0JeFYebM<(O6N>e172T<<+<WPG.>+Z\eeQ+\=5Lc
A^Z0.Oa7]3P\KW,U[b/&)C^g[6MA3@aD_&/&[464ONOcf-E(>Hf[.42dXg)(4I[S
<MR_-+:2CVe9_<PFK0;UPMJeA8D_7.?ff=E9/TF:,U0SXTVH=3M46<>I58dV#MW)
R-TMT9]@.JFf4FHN935.(;dTdT7K/cHYKb4@G?=@WMf)4/&ACNg64CBcVZeg?BD+
]4G\=T3Ef<IINA5GY;^K(XOHG3\KeSEG6^[UN.eVHe\M=YUXAT?K;=)80.EZ6P_O
g4C_YW9F5@JT+_^CK(0e<WGd#UBff./C2)XgS;(3:C4.fdZ_3I.JegC#6@\\M6DI
QW5J@MdgJ)N9G5-V?L=c##@5DD&ZfN6_,GS1>Y[(FBOd[cNQ&0,c8P5IbU[RWW/(
O:L?QXY6\>.I=W0f9H0O\?QO:cO=gBQBIW43;b5a+bO(P2<U7(&e=<QVQe+9[_=6
e54_U6T/<.aaGNEHW\5@H8DG^F2fN@^N7<AZ#XRMWJS=K.gET5-_T+WK-PK9#?=V
WR/#-DB&NGL:Q79,W9]#(]6?L503H9F/T8LX3HO-LB7)^GRbWKVCHC-LM&1U.X;K
4BF?HgO^P1/0O:PT6&#J<g1Z,8/V82Pb?O=<F3/gTF=U_]f33\G\>A5EeOT9Pg9.
dL^Y]KDDN87A,<f35^0O7A#Z7-AQcf4,LP)3FQc&:.T^)PM:53G\Q(U<0;YYa.f@
I,2cZYJ2G]B>#g,^4VT#H)I#MJ)2A#):Qa;6_C[NK.@(5H,4POMB,\1UXF9]@/\e
B7\25IDWGWQPbP9HXF.F)PFTW7U>BFN0e[d:1e\JU#cJRZQ/8PWX7H#EIX7IXPZF
bWfRQf9_23N6S\95f<BE8:4(?_,PE0bbPG+W&E/OR0LgS#)\HPL_9@\b]^TG#ADb
.W^,&/9G[RHfUF\(6)6^#6S6V@[WJTS#>T&f3d&?H,<\92FBM=X\F&Md]<aAN>Y6
,#:XNACg)9NAd42(a<D9a8d>gLQ0QSR3145GGe2:V9YYL(I#=2/\8M6]=UA3-.HQ
/9WG#d/4<<e-cUfF8>RS3b#EJN.Zd9063]6X<QAJ:c)UUIDKa;<MD/-8AZ5d5,IK
)3&HM1MPPDSg#DASTL4aS2.,&JP^6)UVBS9\#?,:=F6V8)@;B#<[J</0QA\CQJ/>
SD+U/#[)G_D#RXU8]Z+.(;Qg(cQ\).[1R:_-3CCA([/?6Nc@I#@4F]I;Wf[f=5Zg
#g=[1=84#9:8OGf=_:1RRW\OBB>+E5J^9&.SP<)e2O0aG#M?Z.U(]f^g0C)TSMWd
^>>IU@G_O#B^SPCf,B+B1f5K<ebea[0eEBfcR6)6/4]G0T69E:f1TV1&>O9D:(H=
=OM@Z\N3[D4^f3TUDQ8[3+><XR^ILMPE<bfMe[#[3;FRFT4TD?)A8>Z06SKX7DW5
Ud,7ER&0<1,[,7Y\OgK7^:44IJS\;PW@gBKcU=HTa(]8?A)fa,+&^.Q/^8:D.@4I
8N^Yb9.E3TSIAN(1EObB^ZP^9I6RH7LR\?Q=BeX)G&XO>\#\2OC3g5,0:N#FLV<+
YT:]d4]N;/7ecP6.c-#dR.M\IJW><]Tf==J>S71HC<?)RMBJBJCTF\8gC4f?Kf)8
2UV/.8VGUM[3SM<AP\ADR0T3S56Z]..O&[KQHd2XXGd[CU:-;F@&O;g^JGGJPLgg
[&=)+QeF#H2\e/<18[41\@B)Z?#aC+e78?1WS+1PE^1/\<)YM;IU_,1>Rb)?3L7\
G/]J1J4;4dG^F86:>]O):Z=N#d11/V7H5?^Y<:g8Hb;::4S;ba&HWE\;3XKH3\EQ
TS3Q#I?d(VU/Lg9BT_(MDH+U4M,,_[<)W8#7DcJO_\,6.cH#Q>1f64bA\R[0X=SE
F8AO@.(ddW]J1fVe+6C)^E)Z0>3Vg9UQ3P^(>Q8A#DJ=[_Lg@_D(aWO.@OZRM6&b
-EYP[8<QBa:8ae)&e?=eEUKD6f8W20_2RZCCL>7N-9EAWW_<g-64IW6g2BIdES]H
PRY)b[IQe)HVAgF7LFZHb)f8DYQLJfD/D5,(R8e?#;W7E<UI\OWJ;W.44-SZbEP3
V]Ia/ba4Cd;M(Nf9dZNHTN[M8L)a(M)\1MbOeN&/>gP#L2LOZ_XgLag/e67^3?=8
ZS(FHH#S1dXe#I0;X@?GRXTFD=;YG=bQ]ZFPWZ@-XCfZNK.NaC.=+3QWEc9>9]84
K2^2_0C8eS7=7R9ggdK;C3WXW-SYP@6X&(0U9,Pfd:)bU>(L<LLeGWf.@H,/U&8(
4&XK>V;UG<K4#+3,QPZ/<[Y/e&OGa[b5dJ4dRL5614M/23]YA_)geM0[VQA,UHDN
2<J-;BIC2TF/1eY8DK(MF?=/<WF&W[]G;2R]#\):)[K4(<A+^]OM5;1R#H1/(=b0
YB95(U+-aMV5R<-7LB9RS2O73;LGOT>LXVH(Y_cKVWQQa35V:S2NR=+DdZKe(7G4
c[_Mdc@>MS_K)+Y>Tc3dDT>JUcZ>Q/a/NI95.-&.NP-[ETNOQ0a2d<?V(Y;V>HSM
c6VL;L_5Ja^)HB8I/=?d[d:SROB//O.0I6Y5aa@6&6NEa&U+;+MV7Re/Y-Q#?C73
^K4fSY[AEfbMH18<aGf^S0><;2PS2.,VSd=WaUW1XMF>,D@eO4gaY@FaBc\Y4P>E
Vf@G^HD@g-De]RPfX1EeLJ4.T8KPRU(JF@]5Wb[M6QSb0W6Adc?#JSgK_7C;UYHd
LeA<\d.<3P,X9OTQK@,G[)F@>X]=I:W>]OFZe0GPM#T<B).S1A[Y(J;d1<_JDd7e
&R:L;7PYF5B,UDSUU8g6_(VF)4K_RNLg#&VW\beZFZ(eWGSRUP5;-eIA0CYF6e2Z
1M[G3NEGW3>Ba?-^9@0<Ib>:OIH+P#PEXBH#RWIFga1A.Ba>MZ=[_7RfcXX.2F2#
.GFbMf#Q7c8P&a[4V.10#6e5+ALOP;,)UOBVTSEP6J5P#SOZV#<F)S(^_-T1,NO+
\;YY2S<)FE5=;UZJ@d/=@fa;)#SfB^C93@V3/7Y<EM+]\>NJ]XWC?RB/P(.eW,dH
=P-=\G#P#A8.U7_,)-PYC8BPU6b:@;da)C#g]GH.CYS<#eR/ZgaHC&.GE8AO5d_T
JX4^XO5-77CR3Z_7E\=A@IK38[PF]\(aU9[^PB9\>?/]XU_LAUZ]:/SEe]GSaeZ>
?DO/A9U>FR0/c_FWccJ9c37U^.(M&gY<:bVeC:b+MYOMc8H+;3F1(9)7\^b_c21K
+dF8OH<7Y#.IB;+&,1UP-82Y-NNQ13RDP?9\1a>)84YYS\@O=16GAM(,=0[.X]F1
FE?HEeF8L<8P1OXDN&f1e;XOQ@/]CL4JTD5dUg44.(IZ3=/SHA@J]PV;#3?ZTTAE
0c0#C(,d<-]2VdA&dZF3)g-]1P?+ANEab2V\Pd4MafaUEP89VN#BEMY>UOa:gW7,
_bKDe:fgc_1>A0_VNW)ZH;-9\46A=?_Ug4\F#WC[ZT@IBS)OV+Z)bGC;?f+45CU0
]Z?Z:\#:?\EOBU(SPZf;+-&(Gb7>a?U6<E#gR[S2Y=BHbH-:_@98XS\4OL?(W-YR
;XL@L9e\+dHXDRYL?Z+P9^W^ceYUZ7>\TUE]^[;>FJ&1OD+/XS^;g(H#/8:AAb5KU$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
