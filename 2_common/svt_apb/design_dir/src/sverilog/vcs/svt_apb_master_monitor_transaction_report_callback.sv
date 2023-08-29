
`ifndef GUARD_SVT_APB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`protected
A4[QV:4,:#MJNcVA&DG\(>A9?FLN&-#cCW95W?g6EBb&ILPE8IG;&)IT+Sd2?F:K
CRDP\@_NDT.E)Gd;&Y]L4R&cNfZ.&C.fG9TV[YBNH,_6=U&P36af</RV.T/^5TO6
\=VV;NcU:S0.LeZKRF5R:7#.^#g[8eX.C#XL=Z3+fGBg20YId#BG+])TNEFL-_BZ
(bJ#&aW^_;D[,OM?)KaMWfca&71d@3:5+,;Y/(&EH(JLUL]E+5N3^OaW>]5cHS^2
;1O<bZ^YW_\#9,[V3bg2EE7?C=EPf/2>7_18;R:F)\WFX,WUXf9Xbe6gX529YVe(
6_?=VKg0F=NVA-TP:I#3><#P?FW_5?3g4b[JUG^]Wf=Fdc7.?+LN8;R(S[R5a(VS
?cMSVI9g^1GE@:Y)3E=LZd<2QKAIUXYE#V-AT=_G50E_)ZL7:Z(1cU=?=V3dSK5?
.e0MD6[,T&XQJK]U+.4UB)S0&IV7MDUC(?X;QQ^Y#R/N<6H+5UeE^&aZ@RE#H9<.
(5fH;,06(-^?L65VA\4ec@(<Y\[deO>PH@AbOX9-(^dN>XI5UQM:^_f[.&T(b6ddQ$
`endprotected


// =============================================================================
/**
 * This callback class is used to generate APB Transaction summary information
 * relative to the svt_apb_master_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_apb_master_monitor_transaction_report_callback extends svt_apb_master_monitor_callback;
    
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
                      string name = "svt_apb_master_monitor_transaction_report_callback");
`endif
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on APB Transaction activity */
  extern virtual function void output_port_cov(svt_apb_master_monitor monitor, svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of APB Transaction. */
  extern virtual function void report_xact(svt_apb_master_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_apb_transaction xact);

endclass

// =============================================================================

`protected
F&4,-Ye=d:.8ZE#6PS:R+B@=8>/cK<?B<)&?K3GOEWY+7;0S8X.+.)6Id7#[ca:2
D6Z2DVa3K)bgU-U>fJA\6U2SN&)ND+SMP#^)7\]KcP061dBZd+BDCH7Kb9K>>\S+
?-Z6f_IV0A3W+X4d\00=3b]+DJVe)&_?2c&^1OJ,.C/Aa?&W+;O5:EgeKC;2C#[(
/&#2BIP<#g[eB1+9V3.7B[fb^YB43DS<VZ:6JP?8L4f)ebWL_HO[[E>VV8SGM5FI
0P05DNKO#E,Bf)BDL_0U1?<>EB22>b9Sc5faFF=3C[P#Y&9@D;R1&FBO04[MS#aJ
_:Y#If>U8Zg?GH/fPU#ML^Q90#f;?f.#<ENJ3GT=]0?&fWMD)f&#b-H@SKG#7WPB
9V4#+bS#NC^cPF9.PX9/-OQ)7EA38M(7G9FMK):S\#fPF+U)YWdWfY<SS^[c.VbE
B[BMMfg/<W-c,)_dYF,RgB79)R6_eG)9QQge]7PYI?Y=.0Tf:bW^WeLS7@83b2M_
.7U&aaOMXF>H@0W)?>5D2Q)>NgBVd:\,I#)eIYQVP\efP=4e3.X)0F^TVM#QY(E&
bQ.L#A3ATYEH/P>_+B>HQ\[WSUc=aH(<JEM>L#43f^PSU5[EFf8DELbOUgcB\YL-
gNG=4beBI3a1<VPJ1X_c,O)b-192(C_1C&OFc;,FJcD3U35>OHfC2,EeL[MggHM(
;X=TN/gdEbb9<.^2B#8<5&2WE4JWH0W.8X=:.WZ1GM5bCN9427P.D2@OC-B7d-@:
N54SA=1WM=D475bJCVaeOSba1B:XDdF-Z/O(MfQ-S,dG+Jc])EV0a/5/<fELV,IS
_9D-KM7X<+G:<fLd<U\^X33G/Zb//Aa+@J4\P2:RSc?,:fX7>SF8&=(642H-E7KB
KB58A8W9HJX1DZ?W+H>,Q98@Q.MG#4LS[]-b37SZ0@DI+/1[(?S<<I-^@_&:9aOU
X6eEH9E<ZR88SFU9O6R/5Q.:D+7d0IK2H-2@&&e1H(IcZ7g9N6B(X0IXNB5DYfB&
f?:5)UMD&-e(G8J#OUFPOK=.IPZX;:]DX,,ELP(aLd^U-Nc2XEVObX64S++GRbDM
?7;XR&Y#4.5-PQN)0P\;b)b\:^)>:;:^gFZ>a6NLZIF.B0MPRHF3d#3KcEScgPSL
B2e=<\_@ZJ?Z?1_LUZ1<3^HTG?PX7)>0\@\Hb@>\gAG1WOV?A?a;5:4^S\\BU.P>
E_Wg\U.J,c8?L_@;@](d:-YX1d)^0FabM423FK4#^PMRNb7Fg()ERM54V?0HdJLa
=0^W<@/X,.]K0babG285B<X\d5Qg]#3XW:/0LHC&_2;8H7&,I&9W)9DV<H=,D-c3
#/aXe)?,1I,9MJfKdg?Q\f,0OSSUM6df99B)SV7Q/_?2(M;(8)f=ObINK1MQ5OU/
)35D@V##JQeV.LE&?&RMY423]>ZaL01aF?QDPZ>[NO7YacIgde8E,YB=c3Ic#b\H
888Fe,9X&UO&YfG.QQ+;P5^D;?3EKC)b;G.#L4/3?,(.Q[G+1&bZaQ6YNRT<,O<S
T8L1&E:f=(T:^;&5CT\YHHf3J:8HO:OZL\R5f2)fU(@NdO4@,-,f1FQH@2J(TDWZ
1(gHC7^VPS?S<4cPHZFD>9-JEK_^6+#<&MNA?18Cb,N+Z7Z=K2EV79_IA7D\OX9A
I_E)@@2_>727U&E#+ELS)Y)HZGF:0+(g]8D5G#7/?[;?b=NG)O<F>@X^Cb>5_8W1
CG#:J+F-_2_<TX]5(B?E2L)&ed3Q@=17A.gDQ@5+6=aPg&AF=^X\faZ.&d4MP1FE
+/E&J@SRXV3#R5=1-Y@T<2_c19R1N=W(+CH8SJ@LJS@6VETY1_cg>e(=_QPM3&)3
+D#E.T).BXK^c<[+[?=e&aWD.SXVLY(.6+f#].82/NIP1CE0^LE3TN,;(EcH)QV/
BD]dWTR(<QeHg7:+[WW1g767B#>3H>7YST6;a_4<XY3:4Z<Ef](I[#L_HA_1Y;UX
(DN&&10NU44IOMEVW^J0F9e6.LF>2(22;8_:W25d<RMBIP.b@JS2_L9^Sd1Q;,J1
TdFT9@eN@#]^)/XVcUN<NbGC+cf@S?[3Q97=1>#U1_aM4A(AfAY(IET&<8CTJDE4
S[JAAOe:dH/D[#4]-O\Fa@cQ)(\P5YG3Ha5(DZ&8cXfF\F=8MRLZ6(R5V_[VOF^L
2@23,]J10/XNIWY9T\C#RO/dI.U3KW7BU>R^,HLfW\\^@70aV)^Fb\RV#86I3[W2
L-Od4QJ;aA]ANH16&TP(Q9T9?E;4gX^d>?.Pe.Ra?^#\RfFf-\MLZ#a.)?>fcII,
)PC\a/4.VWOg0P:B5YP[&L6dEEe4TG#QWXdTD24)PZEQKW0c.EW83GU@,(eD^0LQ
1],QcIf@CaQ?AF=LZLC51KF2[CF76YC39AZ##cL6=/XOe&KdcOf8KGXT,4[_79,?
=(T3/^XJc);BV+>ZM).TCT^G.?fgV6d>@I^JdWb,Z;>,^39>=>EfDO]fe]]\^?AS
^FH\PX<XRGg;0<(_FAd(N.5\5);91]1ARf(AIb#cZCJ[.X<)NRd?XePX_F)]?@T>
T/7T@U-0V(:(AKB(eOQ\TUc].=+cd+O?/-S,@=FU0UPJ=1N3bBLA(]QR>.9PLQBe
_52:e)A=<#8Q73g.^^U.INCX&&N:+6A=&-_TE=?:2.7AS>1QGB.6QGNHbY&WBAZ)
AD?-dM&b??gf.H^a<W]6gLUY;F&RccS2R351L9[6cY6#Z,P?.WQR-I=/L4Z.Z5\W
RAgTFC/:17V\gb]ePM:a^C/MTAfD\0ENOB&5)LU-c5\=>7Y02-4R)A&gGaJ=TDDP
,,ZNbORAW?-/OLQIYX]6Xg^;LU4H.gP#\PbDH\BBb0:.:QN7Pdd\T[O3DC/FLe2L
QeV@(3bYLGR?e,Zd^&->7I(S;a\ZPJ_U:EIMZgU?Y8C8cCe4?Fa75+UF)_VV9A6a
Xfgb@dX_:9W9<.RL6Wd?T9aZEW?;.c]#.-Ba4(cY=RPYT:^>bY>G?:O]7UVZ4T44
)AG;YC=Z)(+K/:N]IC/SL&EAEXMXP==)<2/\6a&K0g;c/CN(Q=R\002JfWT@Ae=Z
d-e+bd3g<cL6/R=):&5E/J#:L3>=E2SAEgb25/&@=H1/+[MO86Lfa4\?/9N+=22Z
AUCAd6)12_88R[a5?;Q<NNQf0C-G\AAZ<\3C^UV<0Vc_gU6b--/G40-T18IEH=R]
QgODDgLU4F)FL9)P;c<]2O:Q,2QP16B7DPfOPdgTERX#7acX)#4.[FR(B_C1FNUf
W,YF,5_XV5YcD+Q]&bS7BL[J\IINg_RcUDNA]ME\^f\0^UJ&_VCLSU=3[5WT[4SV
XM?)>&4N(_(FU>dMQEbUeC;T4I>X[\S97X?9JfQaTMT:74/TPd)?27]O0HQ/-+,^
(Ae7Q\)a9;]LE.;X:-+OcYcEfB6NIg:H..[)I:AKS/^H6T8I^gc\Ia-4EV4G^NH-
<9N-E/<]fg6<4T^RaGJ&/CAeVW:bd##7Tb]22g=4L(39>1f)0JK&#YY#(EW>RZ)L
-5R>dRaG8<MCdO+]Z0=+BB;eX3XB@Z/0XH;TdX+6.6V&c:M)+(<HB^c:PRNE<LEB
;M[&0gG3?bEfYbA&BD]>#T&EJ.F2.6-F=1VZW.UV[:T,G&B^C)D?@VU=b7db4g5,
&25Sb)H:+8Yf7E0^<PfZ=30L<AD-0R^+[X@LRSWa^Mc+JVH3KT&B[=8XP1[^<WGY
gBc;<VKMK[T;NAZ=+eS7KS/O46&];Z=M53:W?]SdGCPec^,F5;9Q^FIYaWX(^eV[
3gXT7G-bM@2R1CgL.B7(U-;0>e<@NUUf4)B_gXI1R0A,6C<=5L:L.SIYL$
`endprotected


`endif // GUARD_SVT_APB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
