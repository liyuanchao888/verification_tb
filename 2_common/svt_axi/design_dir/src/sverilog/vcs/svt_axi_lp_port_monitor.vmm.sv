
`ifndef GUARD_SVT_AXI_LP_PORT_MONITOR_VMM_SV
`define GUARD_SVT_AXI_LP_PORT_MONITOR_VMM_SV

// =============================================================================
/**
 * This class is an SVT Monitor extension that implements an AXI Port Monitor
 * component.
 */
class svt_axi_lp_port_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port makes observed tranactions available to the user */
  vmm_tlm_analysis_port#(svt_axi_lp_port_monitor, svt_axi_service) item_observed_port;
  
  /**
   * Implementation port class which makes requests available when the address
   * phase is valid.
   */
  svt_axi_lp_checker checks;
  /* handle for common error check object reference */
  svt_err_check err_check;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AXI port monitor components */
  protected svt_axi_lp_port_monitor_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_lp_port_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_axi_lp_port_configuration cfg;

  /** A semaphore to provide exclusive access to the physical bus. */
  local semaphore bus_sema = new(1);

  /** Instance name */
  local string inst_name;


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   */
  extern function new (svt_axi_lp_port_configuration cfg, vmm_object parent = null);

  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();
  
  /**
    * Stops performance monitoring
    */
  extern virtual protected task shutdown_ph();

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /** Used to load up the err_check object with all of the local checks. */
  extern virtual function void load_err_check(svt_err_check err_check);

  //----------------------------------------------------------------------------
  /** Used to set the err_check object and to fill in all of the local checks. */
  extern virtual function void set_err_check(svt_err_check err_check);

/** @endcond */

endclass

`protected
.F\J49>S<K#Y^##<e\G&(K.X_fQ-;&&<QIR6SHfaMaRV6d(eD-aA-)+M),#-g,A1
aCRM49,[,dV,BV(?Qc2-)4eW8&?7WHFC4HQ;;=RR4/[@gX725+d=9P6G4YIT\UbY
]D]dI.(JPJJc5G.6e5Y[Lf<4Q-\FgN8KSG(XA+0RfKSfbaM:27bT1#1#afa@A[6V
e1D7P\c[\/XefI<C&D?.VI4?:=?EbU8;A9S@U0)I^R+T6WYaHUcFB&c2NCd=7(V,
3.Dc)TNg0][ZUD0,TJa#\WVaA,&+>7?:gNHK:6A7g5aH].adcLFT&+&[H@),7MJH
PFM;J?(LX;2c)ZLWGSO7VIVU.,N5^a+2@fK+_eFKIT<4.Z@9X7^b)E1B\TSZ^)Y0
O^eMJ3GD[2BUE6&cEa,H0]A)V,#d3-AIVb#+debC3+RS[aB;,b:#\93Y0.NL8c-^
]G3)\MVKgI:>G,VYG&HcE1ZWP&T]C.#+<J&fgE+5eL1N)DMQUdV+eWPLKX]8a4=S
@L&<@.KH[Ke/\d@0G6_2d9^XW5Cd[0bT,2Wa6.ARK,ZN,W[Ng-8.<3a0#TMNH9dK
UBVN\.CJJ&A-e\0V=ZfgLgSc7-3#XbMMGB,.<<##5FJX3:^GSg+XZ0/_8dI+&MUZ
:a[]S:;8fUe5CIBCYG@>cATEGAF96..F=#:4#&Q),Bd7W>Ke-J[7<83COHC9RYHA
##>##1-LR<b-@J2P=6_>g4?.fG93fGIAT573G)]2]/1f5GZA8]=U_?>V&\Re@[(P
MdG/(B6e8a=d>_LM6K-\Rg]Y(DHT/E1[K<UM<Z70a:/817S3\8XA6^HV]^U8;[cZ
NMRJU2SR3f[D@\?bD?FgK<S?_@S-e:/Z[M<_J[><I?g1F9H39<Q(A]#KE<ENOR(U
U[C?\VEScN8eKL=Mc<dNFX_^)TbICKdV5:f[;X9F2PY7C5gL-fVZ+51)d:SQ27f_
\P:dK@(AO2R]43N<)Z.4\?(Z+#HDD]J=7)0Y):9>&#:5=+C8d8@;3<=)U>\VM=BZ
4Z;;>V45U6+^d,G0X8=49/]N]^IT[G##[>Kfed]<)_bOB@TEQ[GCg9aUb:F?1N1G
HRL@:20RA9G8ec>=Lc4.E@W&ZBQAg8W>\VY\gT(#@N+#,gSZ#0U0[OOR?gW;R&+<
,X2<5FH<?(A4+F:588bC/JEfJXK[E_I3&^[+?=3,^4.9[92-I.92#U>QX]UK?VUH
faWXY::9=aRW.R031QIXXVXT-c7O=>47SR=]AJ(Y=2X@MbOK;dW(=fe/Y&FQ:Q^:
8<WI2c>XZZ;?Rg/e6>3NY:NEN2576a_PIe5@&^3R7cOESbK.7V#QB4ZE>JE.,A+5
dO6a<>&SU.<-^ZF3N6/7gCaM-)+>;JK)_@CKWWbPg<Gb,8>1[b)8(U5Z#J9Ag4g(
0JWTBaQ<+&dZPI-TTOOc20&abB7J7dK0C##ZY_F#\D[IU^2U#AXf/W?-@WD;J+.e
3_9Ld@R+S&D^P;-XR->7]J,<@+C?QTNd,VGc9<V^J-@N9fQB5OD;?@ceLBH]5[Rb
O,T&R;EXGMPc;NT0<1XRX,KVHOJCd]:)^2Y0[VRbI_OTNJ-<7B,G77HTYf<8NI4H
6WEc75^PE&[PPZKNXU\KI8S:\Y9O2RT^CNZ&5W+QX5LF38;2[,[C2CM+S7#6Fb5g
WQUBOCGSW@MB0&6[LJ9PGIV@11#A;(IN6?c(<788-<O)?11;5d=d-UKNR)B_GaNX
25f0G@.bJ](ZJDRET+DEcORA49(&g[4a8a(B;H/)?;+8O/(,)5ODOR:#-.=GMUB_
A#N7WSY,KNIJ@Y[[S8AJCaRA4$
`endprotected


//vcs_lic_vip_protect
  `protected
c@=3Z>,VU9dG\BBE;;<+@\WV=<V#d&DcUNG[9SK5.]Vf^5IATDJ11([:+=/L^@b<
;JVXY0N+ba3^A.:IJe<KI[OMBe8O2U,#MedW5;aQI93KNg2bLNC_2XJC9RS;24A#
a)(]#DZgY(2b5XbI(EcfRb3b,^YDg/=&(J\-c]RPV37&:g;X#U=93:-0g3-b>0#_
I6B-SQCSf]D&@e7dZ_T]ObS@g&YYN#Z[Bc3@6HX02;UOZ^<@]3@L=C.bg_gB\e.1
;52.I-F839IQ<RY,RR#4L7@I)UT_1<L[:4U)Q<#0)aDcID[;=)>_4^?B#SHY>,4/
)&A;,48#U7QV#=EQN=5=7+&#L+7S=DW6A6E\ASY#[7N8D>U:4TVSY:83,=WR?\@<
#(^Y[^+W2E/(HA-H?\]ADgRD-@^,)Q;,Oe8dgX)UO?@T.J;-a/FeE@1;ee8YU]f7
E4:UE,^TTRfM8_,=d\c6<JSSR_^H3-PZ3#6ZA:T4=K&LI1PHJED;?=ND3X48RC]V
gFgIKVe.e<+K0a?NMJ?W4=1W7Z_&N<&&ORK<H:?@-.D(=&K/W1FD9>8H#G:IRWNA
YSMHSBO2/FAO:]>@fVR;@gS4YgEZSIZF5SH,YJ)T9Bg&NRA9b=,>2#Z4<E)M;GT+
MC[Y@&,J3U_MOc0c1WWG408S^-)96e25e2O&F;@:2_G++([A=eN2YITcP[dNd>Ng
R.#+X[<W,bPfT75O-KF-;(>H]fbEYeb/PT\e#ZH3(/#Ef8\4U13I/4b_S)Oaf-?^
O;CGG/9GDBZYSV>X#R-1cD]\,+/I:a6?M=PL#EOe3P2fI5II<M0RMHN-A6VC85<9
U&ET..[A:4Ta&R?\.8UT\_9P8J8SONW6C\a6Uf50&:M(JT/-P;#ESb&J4bC9<0C9
&W[.1FV1eCb4ffD7VcGRNgPfa/D)1c25KE<)VZNU[L^<A<&DHLO48b85_WIAJD,U
1d1@f6c6^-)@^TLDN#+(Ac42+WEDOY7D,VYQcLa@-+:=I<0C]4,K9/gbO::3FM?1
B#<+.[@OGFec6Y]_T&3URM6JZ^DdN)ULTZ5CC,IaP4D&HMG;Nd=(@M52,2a&@G5d
F2MK>I@PaI[?^\Ac]LKTR3X_Nc#>ecfVCc]I6RH5\])QH9V473E/GH[fCGd?/dN;
a9IRG<M28)PZ&ZT2VY,TKH0[-;TE9<:(PYUAd\H68_^)ecfF#,1=P<6@<A5G1SOc
Xe.+0Y#7;;-c3WIgR.?X9C[@.:Qe=d#_L^,@DX.;Y<J[2&9(K-R]U9&G3LbA&W0D
;H<?g6Q/;]SAGH6Qc?dY_Z=]QGX63cc]IcDKZcg^aMSP<ONJ58gSDL-][^<)9M>R
L9]0W^(?E0A(P[c4RZ4K3)^+&._0M5WUDBV<C1g.SGHg7Af0^JVXCg:DS9Xg5XGY
#0S7PX3J:ZV(DXd4:.7:[P80&IZ@IFK&=)Fca?CR=9HLYFUS770FL63BFKZ(KKgE
:+Nf^DfNFe@U@8L\fPYD;Z(D=O.a<dG):GE,L[<I@?(fEVN,NcfF/\#,RMPJgd(A
W:NZ1bVD8ac2NebR7Q/YEV;HJCDOTRGDEXg=a.6S/^W@EbS;dF<>[e[N#f_PJ[+/
ACf;U(A>W:Sd?:Z005B7Rg;3=ASFGd5W+U0_A38B@(6)PgZW-5>H<TWVDHFS=cQC
PWQYbPFBTY=+ZRW05YOd=>UY45Ag.YZbYI]XPX&]DgZOa^f:<AeYO<YUag^OgZR/
-7<O.H]F\?ZJK/C;Y@7(Eb4ICH14U,5/]47&^>^Z_6J7MN1ZR::4A>5a>S,NCa5V
VZ;6(KMUVP<@;@=[gYH8->GM;_dGOEX;8A663[g@ZBK/GZL0R.<_01#LF^JY6Z&-
.cL3(\XIU;-JG/#.<_36H>#/a(0SWOPT^7bR-<H9aHG@@O,YW_&,Z)<+ZAWARQIK
&YFY0S5TKI52#@M[)\8A];SeJW08[/O50Pb(#_/>EYIe]D/FOefI..43[O3+>;U7
S5?0aSQ;;])AM;eF;7BHLJ2T3H&(@RTfOdO-P8?/.HMQ.(\Xgc6E\+8,cBHQ>S8R
\(f@0[9&LL/OW>=542]?&M5X/&M0PaCQ4;76_/@I@++AY<RQNc^/3(CZ&X(T2aB5
FM==0^]=J8C]1)Q&QH?E8<UcDEX<V==818@CBce<a(gfL/g&0C7WI9Z(0W:BE],]
V2>U[2DJEfC2dYY6>9=2D^gP/L)65J+0bU\(TZF@LW+gN7_9\[O/_GAHL;6=Q:,2
FSBPb,gJf_#B?=fSP]=BZd9fE>[SC+8e,=6WW]f9R1Fc<0Y6H:/KS+e]E,:3]a\R
^DTF[78f]edfF3WT-Z4&N<NVc;;GaQQJ4M9;UC:@bgO01HO9gK^g7@^VK^M.bN0-
fYF=H,OR:]5.\Y\4SCYg6OZCQQaggXH#9CWJ(&1[YgHPT=CTOEFQQ1W1]L]]A/V,
F5RUX>=/CSQ,:\]=)K>Qf[20.cKPIFRY<PQ.==YRN7EO6RG8;LT#:AJ^FK@4DEcD
/R<X[[Y,30#BT&&4,#J-^\6C8\MO>ZU\I:eGNBS7DT5OM[^<I@BE-0+V>V=&@]#K
(2QRFN]D67Y.(.B<D?g_QQ9Q9]4EFT^fU)Ed1.8D5?]Ac]I<b4^&X,cd2G\<YGWM
-4KFPgOO+-JRW6HJbIaO03.c^Lc[FTW83;b5V_T^aW\]Q2LQ)6/XU-UfY+?0QUbI
?,1=bc8afTQMM1g@\F:f2[:-\@g6AWLFD/4@OV95(+@K.<[?Ua06\^@^=cE<_AVZ
/#G[T&OdNN.ARUDPd;>:;KRM/0?E98ML?56^^H2=c2#^dI_G]LBa]5B\LUD1(P(P
fK_?:?BLTHcV-<)(=cBJQRa2f\917JDcI=F]0/b@E3M,T;,6<N[;PBG(Z:de9+6F
T8GgJF,)T8&Na/KCMQ(2:YIcc6DN.O32Fc=&?3?Q]+e47a\cdLZ0>[]<N6XTQK.c
3FHIBS__?gEgaHRD/T&B7aU[E3Z9-Q#C6AKEbQ(T(VFM&W0]IT1^TTEGI)SbV2\f
FW:1fF#&bPg)_\M3b,bR2MRD[>cU3JQD&Q>ZaI:?ZX<PS#C=9aF2YD5@[&55+F_N
UMUg&X4W]Z6,6g3G^^YLQ_(SA3D)1J=VE+NEATfWG[--SN_2<,N3]-I8E>,-I>&8
AM(A3)f&A9dIV?1g:bg\>BOCbT>_/GGWeQ<Q-cJE]gG46:ad)ZSD:C@&9W^K[2XN
-MFR-Y-\QMJ1\<RIS[L^R5T1BB>S-:^DJd;95?^A[01f\e.&a/X+BYVPS>&>]]/9
T<6=2b<O?M@FL3WaaI9A9AXSI^d1F5[#b0UBLJ.)3K.A047b(e?3YF-c+WdJ/^-M
d#cQO+IS-<VZ\.,[Mc)?bIYTSGgDP#):11.cP=MeQ<N2/<]E[NYd.[=:f27,6<^U
,#UI6N\f8BKV8JaBCMe&<AcN3RbZJ]0gFWLNE0LJX.?\E(=LH(/WJ7\9_/>PKE53
V9&I?8Yc#<?U@D@>XDG#(M_Ob:.U(3J:Cc1TNL+AH<#HWeHc_4[g5GeMV<Z=>0>d
/UAeR4&OOP3TCGg8KDD#4gBT_d\YHd.dCf9e0g?R[_W;2^G\XK]aTaA0T/1MXN--
)I)YKRg^@VcB-#?V-\0272+Y#b04)#bWb&?DdN>,G&d9e(LM4&<&7W5ISb+/JGD2
CSA01W:^:f;Eg]X/?.gR(P-G/&J<]b/SO/UdTf8/<\F9I@f-\LMB6B6^5&G.F^fV
cDD?I/E\,I8_^:4OGG-e.WC]B9R)8(a.DYXa)PRCC?:M<XQ[V..)GN:ERMe1:T?#
H-5>LV,P(6[C9UE;CYfQ<KJKM[^W:+D[I[b@L:H>,VZBW1a2FHegAOFIL+6,=8Da
[VP?.-6VRS^RA/L(?Ba@/WP=g[=CMOE/06bZcFBNHg+aZJ@/6F(.NfZCVK\M2>N9
cW=<eb3C&Pc^Dc]VK:)>D3#+#-MK]\]&:V8aBG;-fKd:e>I,]3dPI&e;9<UcDZO@
4SIG(:RL#4N\:R;@W537V_8O4_ge?@VR_^eBc^?Mba:Wa2GILT1.QHQdLD;)<d,U
>/?I_a4WdJc4U,2&A-MY5/H/1a[]UL0eFT-?>df.4Y?F?a]VLO5<O;<Qa:Me76fT
+?8UPaadOE>^0fB<#73Y5D61cIK>Y3Bf+.VWO.@3D_bae(2:6B,ZLV5559CA-X(6
>&aMF_DA8O++)d6;3+JF,OH?JOMY0bV+EOUDZ#eFa><R+AKf5E1DYE)-<?V3Q][M
#&PE&9=S-#)5Q+P2<fQUP\9J_Z@Ag)R<\c)JRL/DO_eL5>fM06^f6[<C-9)A<@\5
gL6A#]&[]g758Z-ZB64,=>(#&c546U=..H.345UHf67&aO<,Z_ddBU@FIPY#\1]G
A_L-:DP+a(\^]d25a_RU_AbA4232GaUY(b:5?\HP=_21_C/Re@(CKD]G[>,,4@MW
>Z\4GB0T9FF0bObM@Kc\\Y?EIS;?2]8dZ9aN/c^T35DO=^-4_?(/Y@3HF[c/6cG+
?YZSQY^VH,W0]K3AZUUUg>_SA7,G\,L\60[)QfN4O(J7\\N;+#fVH9c5?O,NNB:8
c3M/)RQL-]b>#0:3:d:3YA.)3(;7OL2,<:L(fM>cH944K[C7Z,cWPEFa@S#aS9V)
#XbDaCOD]+G50B->=4@</_b[SVH[Q\<6G?)WR07&]Xfg])g2@IDB#O5NSc)#Z71,
FT)Y=Md6;]^+-DL=+W?Q9?=R1_eN)6>2M1fbZ47KO+@gfac#aE@_@c+D=SW1,N&M
8-JW)891O27TRV,J0gZ4R89^CbVNg7UL_KPI+dZ0D/??.JfW5A#J-80,R;&();8D
d<7F8(XNM;PVVF:0b]ea-G\RNX,ZX6S0/bagAPW8aLS3G5(G9[G8Z,GU)O7_1^,>
++Kb@^=a_Z7)(UGSL^OWLd,VJW))EI1@QNdaR6U5)8c[Md^:24JXaH5>>^Z_.gSG
3deB5?80@WT\_Z9,PLF06I:03D2-0N815\6)f2Lc]X1FG8YZ,^T2FKCeQGC/I70T
_O2.4P/L8C&X4VIWN_>2^aP&Z+H<?^5=<AdGa5&?AHYILHd]><Q4OR@6Wc7&W7bg
cQXGIg4dZ&5-G>X<b,B))O:+\H@OGPJ=)>Y,K3FQ(D\F>>f:<)DO3b\dD][@VOMd
@2_C?IUSXVO5+U,:+@dX_#A^V:\MQ4cQJ1_8TB=,Je@\YI?Q&^#O2ZH0:Z,CV804
94KG+CF)-G]CG:WZWAgW^,)VF;OVcO5YFd,XCZg)VP<2_Q:>TG#UE8FEZ>\dF7b_
Z79RGQ1U_45a1KJg(+-g;dg2J:AT2LA0BAVc1Uc0Y2/-e3+6U@Nc)SVD@YcUZ)7Z
F+418[5<B63d+C^P:@36W/DH)ARg584;:W2?IMcN2@OgC_IPbU9d:E=WN,)PaFHE
_R-YOFEKMFR=:ff&(dd=QNG+b^+LaC?L/;L&4K[Dbc,X6J36;S5(:^0YRO_+I49N
-]CQWQ><e)d_]/e,f&FU:X@,=1,#Yg)/B4LJ^-BTE[S\Q2IP+T^_4M1\>Q8?3b#G
&eIF=^eFg/\2OJ8N/F@=>8^0fVR&e?LLB:<(UK1&#J.)72CROI)WVB(S?NI9:9eX
;D6ZNDI+1K[2\Uc0A6.4SIcDZ_7#C[(+.Pcd21bST>6S&[<8#[V#35Ab4NXg5XEA
N.bYMPR.DV-S/2?8-A8E\RCREIN^:>]-X4Lb/O,&>^\-_S@.F9G<W0De1b/5?5OX
:e1,bG=B(4>#QJW([ac=Wa.V[Ygb)>>WLAGUX(FcMIXL(BY<AX7bcb6([?XBB;6]
c@UMKZb23c@Mc-#fD<1Fd&\/90<Sg(5\\7N:HT)H-adY:S7=?Zc6.N3A/^VOCb6^
_Vf6&,7<e/,3eN,(PLWaD+\/2$
`endprotected


`endif // GUARD_SVT_AXI_LP_PORT_MONITOR_VMM_SV
