
`ifndef GUARD_SVT_AXI_PORT_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_AXI_PORT_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`protected
,CJMTDFbb#]g^?OLPWgcNL^3&0-cY]&@/WfJ)B9\@GT<#,fFK>f^()aaeLO_KF4U
c5=##L(/a_I2[_-V/,7BNSb?O#:BKGOZ0G\Z,DDS[=7LO4N^?fb7,._C+#+]YaLT
[\)9_SQURIO7Z:I8D1Qa)\G\U]1D/0Dg1_TPZA@KVgJ72>Bfe=]b_-J<#V97-?87
&bQ.Fe,f?]8Mb/I?]TdZ\TN6f6@\UUK.(@3>N.Z[,2)_<<U[XE1Hf99?_T7aFL3H
?7J<8XBI+:=_a>fTLeL-3AeC?R@=:Z]#]S-O6Mc7BV.2OJ8cIEKH]0-I@^U&@RU.
)JZS>@=MgV,3\A,QW;A:(d_HUg^WUP9V49Z#6Y/47W-;V58XD2\d(YP2U;I<NXF=
)S^M,>?HG5ed<35G28+B-/#9SGZWCMH7ZKbB_U(:+W7(R4Wgd\)<W0>(FIMF2;CS
1b,(WC^#??c)[V<O<2?(X90&&Jg2XXIG?D7D^9b+@G+[.DX#5\47.Q6<W29/AZ8&
9=LKc@,2&b_V9g[2Wd.W8[K/0+G<.JLVgX:SAQ0-Y5S[Yg]SXSaJ.76<K$
`endprotected


// =============================================================================
/**
 * This callback class is used to generate AXI Transaction summary information
 * relative to the svt_axi_port_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_axi_port_monitor_transaction_report_callback extends svt_axi_port_monitor_callback;
    
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** The system AXI Transaction report object that we are contributing to. */
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
   * Creates a new instance of this class, with a reference to the AXI Transaction report.
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
   * Creates a new instance of this class, with a reference to the AXI Transaction report.
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
                      string name = "svt_axi_port_monitor_transaction_report_callback");
`endif
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on AXI Transaction activity */
  extern virtual function void transaction_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of AXI Transaction. */
  extern virtual function void report_xact(svt_axi_port_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_axi_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Controls the implementation display depth for a AXI Transaction summary log and/or
   * file group.
   *
   * @param mon Component reporting the AXI Transaction. Used to identify log and file group names.
   * @param impl_display_depth New implementation display depth. Can be set to any
   * any non-negative value. 
   * @param modify_system Indicates whether this change is applicable to the system reporting.
   * @param modify_local Indicates whether this change is applicable to the local reporting.
   * @param modify_log Indicates whether this change is applicable to the log reporting.
   * @param modify_file Indicates whether this change is applicable to the file reporting.
   */
/*  extern virtual function void set_impl_display_depth(
    svt_axi_port_monitor mon,
    int impl_display_depth,
    bit modify_system, bit modify_local, bit modify_log, bit modify_file);
    */

  // ---------------------------------------------------------------------------
  /**
   * Controls the trace display depth for a AXI Transaction summary log and/or
   * file group.
   *
   * @param mon Component reporting the AXI Transaction. Used to identify log and file group names.
   * @param trace_display_depth New trace display depth. Can be set to any
   * non-negative value. 
   * @param modify_system Indicates whether this change is applicable to the system reporting.
   * @param modify_local Indicates whether this change is applicable to the local reporting.
   * @param modify_log Indicates whether this change is applicable to the log reporting.
   * @param modify_file Indicates whether this change is applicable to the file reporting.
   */
/*
  extern virtual function void set_trace_display_depth(
    svt_axi_port_monitor mon,
    int trace_display_depth,
    bit modify_system, bit modify_local, bit modify_log, bit modify_file);
    */

endclass

// =============================================================================

`protected
EEQ([<,9=7XYLG7&J;UC[\-V9-.96?,1c6PX?./cP[SS.T-.FK]4()XBW2&.+M^2
+&ZAV(+0/B>7e[X;#If4=DZafDTG=W4=[f(T,c_KU=)\X>A^aA77/d.;eGQQ[]V9
-52B.V4&N?/UFg->S,H6UC=55/V\I:R#5=JM20OUROWFM.g^#XcHY35547R&feS4
]G^DXLc#JB(<DHHD;e(:;5f2QCE0TNT)a39WI-A0)2\MEI=?V3B(&014L:#Heg,Z
;g41I4T8+KNMDFZW/4T?^7)MZ7O=EE3(G4(^NVIAH4FTSWcd\#Q\b]g:3U=V)Bd<
fXCMVK8QM;JUKLO7DA:\E;^I=:0g8bK(g6H@:&S+HV<]7@O]<ZcH.R67Y_W^K&)d
+?U<@&NED4cSA,UTR]M3>;GOQ><6CNC>C+&?;S?EKN_S)@2S)Ga>K:QbS\V4a(^0
g@e26f6d=#A0@LRCBN<43T+9R6JZc>[1G.IES@NGfZ(7=dYb]PVW;,^TP9F2e=,M
Y=R6D.U86Q#K#[&@O/LW>a6bCXH@2ZUT]26^JDPHRCPS:14>1a/30.[#8O/N0FF3
H@;K=IfXe(O7)/gPcT,#<S4C_W(C\\?IV_MP0.Af4+E7GTBJYe_aQ(A)f.CUEV[+
GAF,1;(3?aHPZ@Hb77XG@.<<:>N:gVGf7@_#IUV5@CY;3O>e;@N6;02S]C@O@&]=
=Wg>f?gDd4d&6bPA@T/NbA+&dLFOg&6[^,;#K03EI,FBAMZ4RW9H2-];,SEc/9eA
J)]?H0XLJd\_OGaYPX52N8&U9L)>E=##X?2MSTFW-O-)cTY7)_2W]b>]T821?(;4
J6NW/W/^eSAPAJSgW,a1b5<DMCH(SXI<KM=dQd,Ag-X=8E)6Ad5+]8;_63PDce:5
>;0U55:Ba<Pf@D7QYHgL]I<^ISd#=f5>HJBW9Tce+50-[@EfgaZ/a,2TLIT,Q:RN
UgK+-<[eB[e8bg/,1HQdM;4SfLQ^<CTgcZ?;D[Z\WHEHU)e(c/VFFJ@Z-A5I39D>
ZB5XEMG:2#:Y]F7<PE2(/^W&F[7Z)bT7:_THXF)ABf(ScC8U]CRbf&BQ6OI;eDf-
^f7E9447D6(MW_IPM<_2[VWL6N/2__667MQ=;N+b=RIdN.Ab8ZJ[[C2fQK_,+W.P
?#e@FIKDW^:W248b8ZSOEXc3X(.c&?e^K)<IPU7REOC^?.5/@<J5E9O:/TNS32E<
2R(1IdgDa6H>>bZXG^+E]0PL\Y7561K6>/W?g(2W5?g#F5T^S@HSa+V7/JP/UFb8
844CC[S?\)<^.Be7(Q]@?:cY83IU#RdY^:<@a03\6L6)[+PS#K\+2JdW.W>R6_3U
@^F^1OC@5L.b;GS9_CQZ]6V7P8;FedC&#\,\a<4&Ta)<##Z@NGObb8A,L,dXdXEB
8[Za076,7RA-=.+Z:gAQfa3QH\GHF0A.FXG:J5cZg4#,K7<12Q.OC]d09N^:R_?:
&EYQ9KHbWOVR4d&]>3fc=,U&e]9Q^)RXF##W?0^:a\J[)I3IBb<@(N.C??A7K=PO
:fB]M5WJPdEBP_L&]9Z3;D/?2U>@+>A0QF.PLaNb/6,([U+1gWI0OGcR2=.Y0-JQ
FIO.B)9@:#-35ARVeDafR;&8UaU.f+K;XgSIg4aJ<QR[HO^C.Y(=;BXc.2_aUFY]
]bAFg8&Cd-e;S;QH8Cc.CJbT_ZdL4:L;Y=T.1[Y\[;WI-7S&^_\=B(/-FZJ_?)W=
K=>>)Ze/;0T:bUD+30R:BHa]P^7]4[Z8VJg=)eRWM^W^^Y&U#\,C.YIJO2\-)<Xa
?e7G>d0g5,Z@beYUGPf;9f&dUU@).#^9cM(00J<6E@&XUBB[M8&G\:#4^6Oea1TZ
&3NaP?g?D<aBWc4EZ:S7.3.Ib\c]JRaa1fGY)/98R7#-O>L/SU;0P_RR^)9WaQC3
T8f)5Q8ZXP.1S,6/eR+SSMG#H:dK7=\-80>DV<gUdN?UR?)2AN;1H@E3f5(Ugb,6
<U&:I.[N66RU\-L7.B+0SM]F)5SAI]0F?bZ/U30ffYQX-T]6NFK;T1,QYSX8GIA.
>./CGc#4fLJ1<Z_79>9BaR4/C43FC)_).K-8Z5NT#UIJT1U.^2F)<K8b3Rg3?J77
VR^cW>aG[RZF_Q0-2#6+2?,)6LFNZR,&_3;f^EH:;.,;;PTM7(/^/a]0[Q@0..DR
e9^7K>G#;SZ/Y/H?A9;;XA9L9-ZcZe4#-X1EN8@OYE=\^FVa+/-PM<dGX^1/U&c3
T:,4-+ES#;,EAa\Hd2K4dU/VC/&7#M(F/RH?O\(W+>b(:aA9W?Z];O_F0R9D>MOF
e(=/]](6@4g2D,8_2EL)22a,;;O&<40+NKa4c+Q3AEcQK0T\OE/+#c=)W;ES,(U0
;.F+\US#^RR2ZJg)_G=aY]O,9JL&XZC]?#4>1fD@@&bZ9b52XfBH^6NL4),P@:Cg
KJYd[^=W=c>\B?W9HGRQXJTTOEaZ9POUdbZWM.AM[Fcg[>/J5Y0:cROOe,ZCK]FG
0fMAFT0OJ5_C=FHbY4NYM0NL:.2B9>I58V+;9B0D@R>ILaFW4\Z?;N32-^QY.]G&
RM_NfK>U&Q>\5+Da6>3I1338T<?@A@CN?&,1XaW\7-AS<H46V;2LU,8S+<AF8#Y.
M40dEXJeaW7+/<;a27]BZe<=3UX^_<>W9PB1.bV\?B#GBMG:E/9SPZE+SeIWJeMD
8MFY5NBgG7#b1+9JG<B.Ogb<6f5@L[^e/KS?+X#B>)2Z6NKQJG+eC5+VKW(&;AdV
HK11d>3]N44@V0FT7)Wdb_])6=],P&fe=&KY^O2M2^6&141(eUH_f+Vc^N-#Z7N(
9gU/DP<dDODZ2[].[71H)6Z3LKIRO#7G>g]a>O5g6G<BKT7F3?@<#dR2BM16;FN2
B7RA.J)PZf9#bU\UMf-?1:E;5L:TC[/20aUPUQd<;8JK(cV?25P-7ME2CO2Z>GLX
Y9M6#.=Y?A^P\+,7,,WHHLg631#;#Z-JAZL4ZRRCM2=2\G6A:,](\XO,4\Y-(RU^
E>PU<8b9SA&8fMBaZ,451>I)2,Z-DMG[#@+&)(4&4K?JP7N02&eQ3;MNECDa/2&&
KQC83e9^4cf;8?1fW=0/SReeH[LL8HO7-09M814a^=0Me.#2I=Bf,4RM<6/-(@:K
#//BE_[CfC=1AU3RH_1F[0ag7VIRGB[X.\8#?29[AcEQaP&@2,?<R7c?;QeI:@Xb
F,VGQGMUX7]Q\aebY&5F6TdS(.3-UO(S/S/19TY2_dbcPM#RL[)\F9&;ANHD(&a7
^_G_AB&@/35K@9MD1]8aOB#IfX_2+COXJ,P0=L+@3MV^+5M&XR#QGbI.2@M2=;>S
ULeTVdbY0&5bE9&Y_E2MP?PP=O+K5<DE=Yf/F;?2M35D2K2NCCJ#Z[^#SZJ^S^3(
F-^<20^=FNc@Jb&0<f:>Y#Z3E2G1ZBKWM-J(A4N24gX]RR>GbCB07+de&@>YHgE6
,AU&><SAF>-e#GN8Y&NLU7I.\6Re_Af]O?KgU;T1UXcT3D\5D1FQ;?.8fFO.^SH)
.5Y/B&\R&[J5gV-4IHX9[JFLMgN\E+[NSgI[Ge8Z23U]Z#]OcKK3@9@M8ECZfG+N
,a4Xe=Rf=/&c.JU1PHXcB#(>]WNgOfVU1PVBI25G3?Y0QHAP@\;119+DaA)^VWae
7f8#SFKg^5^f.HO^1EXM.@CD]^P3(4HLJ#L1f[)De=d6EA?\Dg(\2e]AYc]E)5U\
RHGba;UB?6;W6a=<B/J0OH)5f38(D.fML.DBN-[5Xe53WLQJ/b#b53A3P4:C#)dV
G>YgKVb+=MdV2R5&VbWcbC-.VS5SM@G&N_W_]?;I4bDZd@X^4VW2EK5.c0d^QQ3,
SY\-PeCI)#OV)$
`endprotected


`endif // GUARD_SVT_AXI_PORT_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
