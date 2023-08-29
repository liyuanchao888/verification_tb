
`ifndef GUARD_SVT_AHB_BUS_ENV_SV
`define GUARD_SVT_AHB_BUS_ENV_SV


// =============================================================================
/** This class is the AHB bus class which contains the Arbiter and decoder
 *  elements of an AHB Bus.
 * 
 * The presence of Bus in the AHB system environment is configured based on the 
 * system configuration provided by the user. 
 * In the build phase, the System ENV builds and configures the bus accordingly.
 */

class svt_ahb_bus_env extends svt_env;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_ahb_if svt_ahb_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** AHB System virtual interface */
  svt_ahb_vif vif;

  /* AHB Arbiter components */
  svt_ahb_arbiter arbiter;

  /* AHB Decoder components */
  svt_ahb_decoder decoder;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_bus_configuration cfg_snapshot;

  /** BUS info */
  svt_ahb_bus_status bus_status;
  
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this ENV. */
  local svt_ahb_bus_configuration cfg;

  
  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_bus_env)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new ENV instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_ahb_bus_env", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the sub-agent components.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase:
   * Connects the virtual sequencer to the sub-sequencers
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

    // ---------------------------------------------------------------------------
  /**
   * Run Phase:
   * Arbiter, decoder functionality
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif
  
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the ENV configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

endclass

`protected
XS]:Q0BAMBDV;_NfA&#\(:&53;J^]R:L+;e2RR@@,:a[b(0I@5EG7)?e(]B]2PR^
M0N9Fc7Xc1/,C7B[gQIHdc\#21Z3KH>.6FJH/]W7^DcLMW3U638\V0V+g?O/0.7#
-G^0&5YQ)-c&[&>8]fCSCb>LDNL\G4Z_>6A>?@dC,FT-cT3]2KE+D9_+3@1Y.<^R
0M/:f4JO:JcS(N?eeEUPFP0Gfc+8BXKJPD+CJ6:>M]+g9S;HH[HKa?I3Y,)8c/,5
&c#&TE0DXa??0)fTD2Cg7GG5,@Z+YDW1;bCTb21Z95gGL2L@_?EPdE;^(R47N9HS
-57bN.BD@Z@?)$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
;R#(g9B_[e/N]>Mg<W^5>-FcJ]OD75EZ02950ga^c\6BV9bAeYL;.(baDCPX#NU6
;&GE)cc-@JCSPP913A;9UK[N.=5U0O,>_.dPS@R>Y?W5JbQPadE[R]?+N571YWNC
BLeYK+W<;JR^.:5S_,_J8@,F@-d:\<,[Cc@R(=f<):U<Y-ZT:1M\b&3Lc)NF(a>f
fgaOVQ</d,E@@e;/e\#8KTeS,B^8R4EM7(_H/:?50^0D^4Paf]D&)Y@\HMJ)BP5&
>[c_9WO+T8G\</^B:^[#^K:51\@O>Z4LgJUc;0CK)1g3fX8MU1-<eQ<&1VBf2(QZ
W=TGO2<,PacD5PXNPJDB]a]ZZ8T7N;O9X^2Nd^NR),6-,_U91&[e)7J.fe4Rd@bM
)KR,Q>C<ZG69\<LTL(4W9[X-A8B4#]>/fT3MK?Mc/aWIL8EM]<[Q7\Z-]<TbSUF^
4BJcF\.ScC;)FK51(^&HHe7KB8E=[S\2#a+c0^8E+PS:B)FDYWO31GA[(I0L2^bQ
4^,O6KQL6?g(,62?&Z8EFDI[U;OLCRgH.,E#@TF133#<6D]a@^DI.:5?eDU]:Z-Z
6Ea2E.3.gUZ.9]DNNB+c.=eT_82/cVTBHWJb0Xg<P7e.T2/R0F,e4]0CM;c[569[
[H)H4DGE,aC7fd0Na62X9CRd[6_R/b-BdU(T7IMbU6I(WP60N[,<P>We53F,QCDa
L<;@LFbCbSKJ];K\3;)9I[WAg1BN#4HXB0Q[aN[FP&acH\@P&G,;,Rd^)-WNO\H<
=WQC,81:Y)<HdRC_I1#4&5Uf>J&gQ[aXgI[a9:;g5TEF;CO_faMgJUOB>aYYABbS
XVH7L[0eJ94adM,HG>R4dCD\-/73PAK:J]]WL5FEVLQa0G#3WVCVU<2eXJ5LW7<O
KK,P1=fSS;86A@>c@DaNB+6(7J-9L-QAa0#ZgH.M3ZV0>4>WY4E5O&=EFJ<I#1OB
1J=]?7.+GeQE4^U[>d:8YE[7G><DG?Z7W6?++SKH#&YSKX,O63.\RL8NH_9BL\>^
(;]DWgA:df-6WR[:FB<5O1J04,JA8-Z-4\6M]R]20-,MZ>B0+F0[ddEA(/d;M,HL
P;0Rb@DB)7:/gg;._\HY\bT.N/5e-Z5W,HNG291FNZQ8\c@SEGO-QMSYQ9M,RN+-
WOVaI-@KQ)QXPU/&4fAePZ2&(RFQ]#Q2Y]=QIL-f@fT98f2V=T1&JPW@1<RW1E(0
0:C1f+dI[I:gXBTYPZ..H^F_;64OA_0?ID9ag:P)1[>Q;[,0?#Z^TO+M9eKC;K[<
1_eU.\/J/+S(78<,#W=GEeIb#5,WX4&J0J?Fa>a?fc28LH\QA#CUGLPNZ0N#>T,8
1-KCU5F5J7=7U]aR(X[=8#fSB9=Y>7RQ&LQ_2;>Q_KRWA7aWO2Q;9#b.9<;RX;B\
?3-UCHGE:V.FA/ZE\3G89/I2DR)@+O7R0T>Ke^RWT-NSe7:=_X0?B)L6Q7/:\]E&
K_Xa\EFgbD-5PW9VB#;HH03^]K:Y)Tbf[a4/QSHE\)EW@e.B)U0:5Re5aE/B^>FQ
B81,/B@XcCEP0_Q^Q(2]1K8YUd[@&KQ=U,B4/WaLEKS]=Gcf><A5&<BGDgW3NIFd
,1(ZI2VP0;\JG3T.ZUD3.AfG,g,1]aIQXTZZKI+_HP;QG\MfGK<A95&4dbP<@GfQ
7TZ655NICS0LTdBF@Ufe+#W&FT@@-51SLU;8WO_d1&HVb@,/N<SC2Z7K0U6:WCQ2
WBV@&34A7<;(^@H21VEF2L5B)C,5HRdS,c/8ee&;c6LNT>[U#V.:&-La?I1@7<09
O.:F+Db^WG&M2G#.a.7L7,V,A2Q4dMeZ,R_RMWG31(VH-YZ(Q4AONL9XXI>0e#eQ
V7D?BK)+LK:)9JT9XMT@.LRJ79#MJUg6Q(W]/(eNaHX^DN<.?a)746&D(C]Z+;KB
D<OI;QJ;9?2E<].0fD=2a(O;NCS\1DK.[_1G9Rb8BYY7RU0OE.-g>O9@gRF5GA,/
dDCVP2AS=QRD\;[=T;2THddS@N&D;CEP?#PU41S@P_9cc=XRAA2D64aMJgebBBI(
BKW=LT@16b)dCK@2)61+^e6d]+d,0C;AUL88Id^C5T9@<03LZF078QY]9UFLQF(,
<866[?+Q@\;XR?4[5?)UF5#-JK.H.(JeH>R\4.S&7-N>IFa@JDeJS^#EfGER=5EX
A\RGP+fI>DT>Ae.G.@LJ9>;7Hb]f2TSU9ETL3HcNUOe[@Z=?<<Ya(.0UCfDOTAf#
Y]I0ABMG]:UKHbI3=HJ)ICB/JeOK\W>?2MQ>BXc;:b#<2bLA7L>>D[X/ALSTeZ2G
K=K\>536G=@/5A;6aPDd9=I9,0ae^W77X\8=<R:,4)fVN3[1QdcBV(C#CY?JT[):
LdM9;>AcfW^7=OBLJSeJ?WfDTE@^<^RD<,E&HD/[_@&W.[a)=J/YXN^7PZ02>#T,
EH?ME+S\,GQe=aYJ&]06N6-PP9^;.fRO+EMg^#BeJWYT#W8#.c9@C.07RaU8b)KK
L)#MDOMG8f&G0CM@b]01I@C)DXe8.M[(U:2N.]8c(Og;MSd,YU8\&X\2ZG/g0M6N
SdeN=^H#a@A-.BXK>R\EbK=V&@I^/XAd:@).OVfgJ82:NA?DNXFGW;;&8QcGC)ZG
).X>^[4D\1&K=ARbT+^#be;(;@W/F+-P>dTge0HDEM/LZ\Y\NG80B=3F)NS/;_:R
M?EK7I/AVf\U5U3&T=KO]e<GHbR88OSdI53+-=A<c,G=N0W3A\NX4;3X/LZSd6M/
^:APDTXcOMceOE)&2AYC8GaFHdY0];3^8:b9&L#-&01\V/;4@1L5Ue,A;I:+Z_K&
-c153&\FC\J8V#GQ?-<O\]CCJ1SURO?S(]POeJ_#AAMHIB>=M;K,&d3=ae5Y]/f3
4132+d=G1S3\67R(--666V@gaV5:9:+CX0Z)AHPH,J=21g1L(3CZ5<]/K_N0d1g/
GC0I2>8&IU;M7U9\SEaZ<[A-C9B@Uc.GIcEOWIHYBcM8\=b:9^YT8]\72PZAXN+S
fcTK>\9<E[Q&cb;(GWc24TAYc=GNOE^[@@^f4[f;W_N3.I[(<-?EeeUbE4Vd7N:,
fLfg<N+DHM^eEWUM]dQT.O9\F9c[\:]&Q^Z^EU87[cLEeD>LU+E,<Rc?8c4dXJb[
U4:a2.?QaHBaO@#&[873c2N/<;V=QDR^^K6cSd1#_NC]H68H<W#8L)1,WE54dMKJ
<2SA(TF1V[&<GVQ[,3J+OE0LW#bdMC#AK=;>@),XQ<;#J?CNE_7HcB\)A[ZgT?4[
;;]=5L=]4I_JZQa-5&TfE@-HE;,.TCc(3-4JI5TF)=&HC>1cRI^JVf+FDCDab>[3
36Y##:WGUFP4T_aM/b?]McM,1?+7[98O<fJXG[4CI1HWV/4MTNS#YFcCWFD4RR9F
H-DBR4(d=Z-8?b6H<O5WHAUI[9(F/FT<_Pf;>2e@@gV[e)+A.6@4WT/a@:ZOR2M\
NDeJD8e7J/>>.8,9X7(:U#)9\QQV=:LM,ZVf3^AG[&:BVL.,Q_SOL6PG)MW-&E7X
@@d^U;TSXaU+@:1Q?=<0V932G2/+[0>O&VA>a(Fe;,Ed2LGWWFJ3F5b2+VZdV-0W
X^/DOSdB7I8:L>eT=]A6Z[a2?+4AE>DR#E:=Z:XJ54(KRBd@6F>M+dE41S=\K#E/
YBe=\QPSNZ+ObP#VZOBVLZ(GP[F,7@fLeL34#Bf@UM&<H,(S_G=5H=7:b.PbBO81
1;fR>^SCU@9BXZ@B.?2G<M[d:4b@b<R0aG)YPL0>H:B5^X8/ab<=+UN?=@ADg<RX
]EG[F_,5C]94E2^FW8]L8R:;aVbe\KN,ef8@T-/.aH8-:C.0cILH=>_X&Q43UPbK
2:B7X?ONH5Q?H0#SJP23YC)MH;CA8aZKe-90?/^BfO#QLX:X5fY=E5OA5PB02#fG
5T&.7GN@0;S.)>/>2MVWRcE5+_(@9dATN5>A63C=-OSV#Ea2T11]4MA6_KeYM_W6
R;_O?/S1CJ;299g6BAHT9]9Q(P.QSNOfJ9KH)2#KD@UG\;TSF<a2N\f)7-:^#^.Y
&3A<DC;CQ^IO:KISJ+#=Q?;]<4F^5,#;4N[09K\Z6R3JNd#(8,CQMF??\,\@P//(
=I_AIY<Y:E[XV6NZMEJ<G^,0R0f<:N]QBQPa;3C99&=)@V34J8fcQMRY]a@V3@_.
U1)RC0#YQ.+/&5/d3ABTQ<D7STgP0K+IYfDK?&8:\DL7O>dYGWFF3GIEAF/Mf=,#
/D-@RDWFd<51O(MNI?eFT4IaUO+K#6aZ+FV,&g7:@61B-[ScgY36#Q]d5\6ZeRMS
TeSQW;+^ecYHKfR_R]I.\O3;@;I-OOD\b151]8e=-0MfT0^TOCgHM]cW35d/?_KA
.Z9+6d+7dK8@^eUZC6JDd9G7AD5G#aJNdcT=M\@/A];WU175eYL1fb17GR:PK8Cb
NbG;bA[0TANSfeK=8YYXY@A(BEB#HD@d-Y7=A+IF<1@XREcZg2NX6A-CbC6Wg,QM
4fS60TP&HCH#NT42>EM;+YOM4?>RI9_X1f[U6O6]9e<AH#-Ud(3X>0IFb?PWfdS=
^O^g9c28]1MG92-eMgcW_1WQX+]G0_[8gafMLO)L+G(de#N<29D\W]3GcU[Ka)XP
.>BU>8G6Y971R#P#:c:M)+WgFP][L@3:WS>><9_V53ZfOS6UBYe60[U0[G#3Ad,9
Da+aB>.7ZA..g^gS:S<8@KC,eg0/\H&CV6/:aE;#cX^TCNR>_;C,7OZ,Z2(;OX;(
-87BU3R[PF5WfdMO0&=[AW&ZRXE/8/[8X#C2E,a^ZW)+NgdO?:[MQ3?5<6ZJ1_Pe
;L]EDK+_a8RZDETSNVFdT(M;O+9=6IV4D5;?(T(Y:&M(3REa:BdN)TCG7U2^7RT1
Y3P<HLN^N@04Jc7_e:_PNRCcW(O(X_fD,))V#[SbU;QWHcbeP8.7DT;Q3;gS>/I<
=,CV[APbMRB\34-#_U2>-f_N02S25aK(8c,\U.]+).7.@>T;,.-TE6ULdRcUK+Q?
GD8W\:Z@2HQc63AYACIZM6/5SC^LEg.fDH,aP0cV9>RSX?b=8OcZd^IbOH&EVDJC
S8Q#]?#fPEDZf:+U65+B?=X8-1)gg.3a+Y65=95Y::00T[#A&.)gK8J+7=1J4D8J
I\=C^;CG1,PLIY+AZ0M[_\]7RT_J<?Y1WdM<7c-\T;-VZbNa3TLAQ8QZ;K?c6=4U
ZP)@;H:eZ,AcU0+eYEe.D;I,:X:BXJEPbA,IMP@aOPHOG9Ga/MYHfR5NZ&XeFE#2
G:13J3I6(AADWM.<LILVQ@Jg4KY]f)d;&>S0]C>/_)SJ#&C6R)4WH<BM&#L]e:EH
Z40UP=N(e+0T5]e(Ecf]5f:fKX7VY_/a.[#_.5/D>&8DAS]@5UG_-.XTPV4.@2SM
=5H-#L8K&_4_G@1[#-QbY<Q8V8CJcN0T>(C7?(X/S8K0Q19B9NIY-N<1GCW<Xa1Y
.GENKcPP@XV27?)/SG_EOc050HUDEJdU?7[g<]PR9D10JY_Pd3Kb]3H9VFENS]@O
dBXT5&.]-;]3<M)14#Sg^>?VS5V@YZK7,BI(d&HE&.d?./cc][M7H)UQP9&:6[eD
be4LUc61BFa9Og;]7:.?eG^0UXd7C2d,bC2^V3&ZI,cU7YM4Z;@N3W<B\0FfB-)[
#=8fd/>0U=2HZ5K5S@V0ZXG0W.UAGMZ/f:DHPe1eTN.:D3_c-aVK?LdL5XEe\T3(
(90G>O=Y]JSR1V3cYGUU+M/T4_MfQOO_Wc>W8E4gY87F[/&(O:#,BTB_Bb5XX:4P
Ja>H@^/Y?65F+eUV]=)^A&B-SYRQ(V=26g,HcT>>6Y1KUbF3c8\+.&?2_P2D3:__
\dUX04OA18_L],b9S_8#Ka0RdZ<^T;C>9GBFA3aCU&6<7<56[-gK)>-CK9,=D=E&
[d[;:PK7Y:1/+WN<>,dY+T>&2(8^V\.,3ca:ZSHGg&;I^WfGH[DPCWJFX3OLP<WB
[0dgW#).=;,G57:DDfOd&>MDTDV9Fb^I]\fg&7e8ULN:\H6C3a-aE4D1b30AA7_)
RB#B:OCRR0Nfd/)D#J7E6QL[]8R=.V1H(>,<(JRR7/WIY1ZZEQaK/=E^=26a,/O9
>JVK,3^J)>[6HMd^G<d:.F69V]MT28UWQZITN[SJ[[VF0K?8DT1,_WYb/fS2.KKL
=RVE]XVBab&6J-d)-V3IN<4NAX-MA[FS+#3IH-58E3LO+8,Lg.KaUPI[eM^TdfJQ
.1^MZSE.>R,NcY77(/&H6(3ZLO/R=^b\2LBef1DP7Xe91T\LOZ[Hg)e;LEeWX@eS
<D\6<Y(FHfQ>b/F3K#KG^CFE0I_;ST;:VEV>9<00-S[,Nd<9TBI5]<&b>HOI6@FV
EMRO8X716103ZD3U1bUCEZ.\f15]6X7AB0<AJ0-Oed(#A2/R-N7_TDV4.\WGfR89
.,RV\_\8ZcMBER4=:0f]IP(,#6^g<M,aGP<5]V:0^NZ_?+_.>#P@A+B\_L&EIXRU
Se9JO+>6?+3E6#&[O8c=[H1-A#[D([+93L=_B=<M2EB&MN6<2-_FgFNF65)WB;-b
&7.:;IU0B\(eGf56eIO,GN@@&\^WR^db>P+7ACb>N,HE1/K.NAZ3&VNJ>W<)P=C7
(>?Qc\>RIE-6f()N]#NNW;3^7eM49-a)RVaf;SOU0I?&&,&.?9aJaFZ_JI=78@(g
S1^H:DDG>:CU96dI+87Q<BZ,0a(aQABWSS&b<@0:G(@_0RJ@cN2=FXYa5:[b-YIK
e:,(81):WLOgZEWIY63G_d8F+6#E6A[:T@UM7-;CL-]fXe.Pg/XLZO0,HF0HQac:
[N/,5Tg-++0NYN@aD8[>A&T)/VEWJGTfGK^M)ME7^?:C>>E1@6[CC)QJ40c\=4<V
Rf.Z:DB33^AU5J(N5d368.N\J7?2DANI9BMZTB>WM)ZfZLKdec@?^L2H5d+Q@XYG
=[-913G?O<2P&X_YX5&T7/-ADZ+)SfHgP9UB:W]Y?eJ,Q]+^,OJ3a1WI/,YLVR/<
\KQT?WEC/ATb_KW\\0?SJ3?,,)R+4SDgGG.F@LXTd&c;<[UCgbH-RdE<.8a@=-X,
U0U[(LG(3;3g(/23AbKSLU(,^gd11Rd^F:[/EM#DF/\KV0:YG&O@6R2F<:ZV]a?P
aU3.Y,GS>#/>Eb8G)&)ME;Q,66Qd/Q+4)d=:[GFY,7JZg]Z>?PE)KGLOI5Q>19<R
,R6^_bV>cW#<1EKYTG:__-<]P?<893b@?[)70:E>E7/WNag2Y5=dKe)-QV1A[]>>
TUWP[f5Y6[:S>/O,+A[Y:L)Ebe<57UTb77S-1Dg_LG;J.4a=_5SM.Z@SfF^Sd]<,
Tb6363gS+H/E#6KILCH;d8\9V7T?-C[d]f.4D<7INT7;VM,22c^#HVGdY>c5-=Z&
6F-.;^&<()JE->-fa;)=4<SC;FI\4O+8-fQM&;IRbEZT^,KH.9Rc7Rb?,[J9)0QJ
3G\X_Z=1_JRWUY5CZ@;GdTCVUNG<W>C\b>^H;54=)P/[DG(UB6<cbMU6J>_MgEe=
9cAN&<8KXYHg_]D9TbA>UGS_0Q_BTOL5B7?7eEYcgL\<DUTQP@]M(ceQ\>E8V-79
;+HD<#.ASI?A6T\5[UN&SAS@?dEV0?#V@=VaUAFMOBCW+_M&Q[OYGccV[KDDZH;L
Oa2/+^,B89c<A/MfQ0?UI>Z+/de.=;6A7OV,SbKf72PHE-/81SbN(9a:,-NCEFD7
S/8@)@ZC18,-GZIFOb+<D,?g0]#P:-N9^U0JR;UJB1dY4I4O(gVF5YK6^K@d#U2Q
d2+N>?@GF;)Gb,<WII=0<TPJMD3-;f)#dB3\ESeWW;9e^K?<B/N.X2.:b++^Z,7]
Z)@->P<T4B?O\AQI?MPVXH-=a<,ZVa+1GFIV8dQG=e5#:[-gA:2,\OdQ[?6HTf2T
4:?D7BU-7YJOV6GOK+V,ACcK9#2,Q8)MS\MQ4gT(-1gVc>_SBX58&;7dU<)Td2aI
<5B;@cRJL])/71H@d,bB4X)2=&F5&1KLb=@F4?M3NF7&R<G/cU\)d7+\/>A)M(NG
_X6a?7g(MCc1(N/RD2@4;aPD@Jg5(fODVE.(Aa+9#6F][B@Fc.+DDVe^0J)D;5HP
a3[e-;@5e?)<P_f__NE40&.a/M<10a=A;+B\:34>AB6?__8,))),c1C7L<b,b<MM
5:C?V:]Df&MFRFae>XfRdD]/U:ZY1KHM7<EZPaGNTcaBbCCW2ALB3:,G_0:#HUc)
^GIK?Q,S+<eFRX6:OC?5)C&#ZWcS#>)d^=1?7.RGC.C-_FgGZd71MQLMJ=CPYNb2
CP0(eQQEcZK&<C@37V0),cGBf)#fL<]12C?^@Ve;[P-LG<,TH/UOP[;&2bBH;@GN
Eg8RcY5+aSG1(UB.,RCJ,E;ecP:U1T#Cd/V1#E6DdTCC9&DEZN[Va33N8G;7T\0e
V;.HYA\PTU/6^cP,_[e>8,g_QIRa>\1,>^Z#a_>L+^9#7Y&+37-S/=9&7a@O>>YM
82.V6OZ_CDF3#\^(>7]O\bL6)._10_-<HC<66NGWJ29FAUOf[\5]:RNcF]4aAW15
5SF25US&RfPJYDR9455Y9@K_[d+3:^2(Q9LRAa/4dbS5_d4XMg:-fL)0e+)F[We^
c=:6-P3fCT9g+X:1e.fH,?1G#2#Ae3=O3V6D@CITIC.0T#W.,)8-(IL;SPB:]\7L
J(G)7fMd+<]/OGE:I.ce]c+3@KKJOY(+_d?\P^J>JBL^IJ]>YcL8]=H)B>g7+b=E
c@ZeX\UW3\eL[?<,3_W1[E2:R&37G^:>>&b_d@9]U8V&?OafCGc.0_N4O(S@(8/[
4ZEeI:R8(;)?[PQ.9RdVP,=d:FK^/.ZDFXJ:](7QeD-S67^<3f_QKS@0#:UC/>G<
QT2a=G(0>#7=_I434,8fH,)1J0;:d8+dc9.IJ1.:^TaB72/7S=B.9/N+8W?La]]>
LKbZL_XY?KD0/_dBI>]P>=.1?;D(T)>P&CK5QP8Kc)L2&3(E.N,LG2[=U.ZU)\BT
4:0R3ZU\X2N5R-U7Ufb70FCdY4)(Q1\dY3@a3)QHg04N5A7](]S0^@IV>9CggCT.Q$
`endprotected


`endif // GUARD_SVT_AHB_BUS_ENV_SV
