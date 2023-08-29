
`ifndef GUARD_SVT_APB_MASTER_ACTIVE_COMMON_SV
`define GUARD_SVT_APB_MASTER_ACTIVE_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_master;

`define SVT_APB_DATA_CHAN_IDLE_VAL(enable_sig_val)\
driver_mp.apb_master_cb.pwdata  <= {`SVT_APB_MAX_DATA_WIDTH{1'b``enable_sig_val}};

class svt_apb_master_active_common#(type DRIVER_MP = virtual svt_apb_if.svt_apb_master_modport,
                                    type MONITOR_MP = virtual svt_apb_if.svt_apb_monitor_modport,
                                    type DEBUG_MP = virtual svt_apb_if.svt_apb_debug_modport)
  extends svt_apb_master_common#(MONITOR_MP, DEBUG_MP);

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  typedef virtual svt_apb_if.svt_apb_master_async_modport APB_MASTER_IF_ASYNC_MP;
  protected APB_MASTER_IF_ASYNC_MP apb_master_async_mp;  
  /** Driver VIP modport */
  protected DRIVER_MP driver_mp;

/** @cond PRIVATE */
`ifdef SVT_UVM_TECHNOLOGY
 /** Handle to the UVM Master driver */
`elsif SVT_OVM_TECHNOLOGY
 /** Handle to the OVM Master driver */
`else
 /** Handle to the VMM Master transactor */
`endif
  protected svt_apb_master driver;

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
  extern function new (svt_apb_system_configuration cfg, svt_apb_master xactor);
`else
 /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter UVM/OVM report object used for messaging
   * 
   * 
   */
  extern function new (svt_apb_system_configuration cfg, `SVT_XVM(report_object) reporter, svt_apb_master driver);
 `endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Initializes master I/F output signals to 0 at 0 simulation time */
  extern virtual task async_init_signals();

  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Update the component when reset is applied. */
  extern virtual task update_on_reset();

  /** Drive the default values of the data signals */
  extern task drive_default_data_values(svt_apb_transaction xact);

  /** Drives the transaction on the interface */
  extern virtual task drive_xact(svt_apb_transaction xact);

  /** Creates the transaction inactivity timer */
  extern virtual function svt_timer create_xact_inactivity_timer();

  /** Executes the initial_bus_state_after_reset  check */
  extern protected task check_initial_bus_state_after_reset();

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
+&MHJ9AdgQ)89E=U,g.PXI34J.4_02P0H(e-T/FJGaO0bUP4_1I.5)Xg3HV-c.88
F5M:;0-9,Se<)<6QfWTDCX[a@4_&P/JFTd6].NOb<[+AMM.QE6HYE#0.0W>@WGQI
&.(3ggR(1PTA(B6N-B>JfP#BUb80FeT^;FP/NR<L=#7-:_DN.NaDKUab6[0;<G3\
MW8[FZ:1#/68e\<SZ=4K;Q^Y]C)7D4ETL.70aVIMKYU^<]D@F3f]>@6c6[cBb8BL
U?^B)+NB8C06-\UZ2<^Xg6[b=)dI7QJfc=-XROC8J=P8R?>T3Y2]@W_IJcQ(W_>8
5FO;1<W=LFfZO\WWa+[E>(32WIe[3YbD8e3\VdZO97RJdcS+Y-_2VQK<\8&;,G;E
O&bd8&EW:,-U9KdG#VPUQd6_K_6&1RYGP5MJ.TF]Y=K:eJB<#9HU70E#_Dd:b]?K
1KWfMEfI1_6CVX;7#J,e+#W6aFCSgaTX,FLbU/2R;,)]ER7H_UE:44E.AZD3DHIP
1_KGD@?(7BBe).++PM&8(8aZ[\ZR/5ZSS7&2,DHQ+\G)IU)^8PbY(<XF2EcKTM#f
1DB,0&Q2_WTe/$
`endprotected




//vcs_lic_vip_protect
  `protected
fLM(W<@)c>?(&=NGJ]G:\4gIfTJ\@?=LC>\:MBcJcRV)=-<FN]]f5(aCQOWaM#c_
^LRZ7)V7?71;2F8eWLVH9TJ\.Z^c<7J@M<:#E9<4T0:Z3-Q,G4bgD7X=,+;NT2Le
@NTf46aA<P5Qb7gbU-,E=DgeHO<R66c?S9?Y_g#S[7J__ITHZG4Lg,0-KMeR_C[-
;\P4H7@6OIe?e?8a]8HU[(_Y+GVGS,U</AB>_Ld:deHVgWg_))W\)9#3NJ],M<G5
ZC9S^,.S@ZI1SZG(AF=;^J7:0cAf_&P:BHE4Md1Y^7K6.5T2=@c:<-a1bSb<U>H^
@9]&[DFc)&f\NA?+aG6c<=MT+_)6JTgcfOebW@J.[RU]fRZ;SW]SEI8&=E+@#;YL
QgdDOIJK-3dS4O&^G#g.V=#\#bJ3,[eQ_-IJe]NCEB?)F&Xa2&JUES3_Ob[H9:0&
MESb8LCM:NfXI[H[MN^gBX^:>7<BEdQMa?JMNB#RaEWGNPD]e4f_aJCDW:a)J4:E
L(R9gg&B;U2B&WER2.4>F@?&#a=592gNF=Q3\&)>18>:,QA9Q9d^[Q^f)b=-BRD5
)@X_b?E5<Tg)Vf6,/\9Z#TdYM=G@.Y_Q#VOdB5eIaJ1e>9aB/[HPa4^c<;cL6PH1
Z&QXJ3+6bd09X=#d8JAAQN,#(A^1<b4U5>6Xa//^Qd\TN,)YW,d?bEfdCA1eZ8][
fBDAMPH7#bd=)g5R)3U<7fYW@+@GVH>P5#-]8)RE+[<-)BSF<A#L&&ROD5KW;?2Q
7L\5gO^XV75\^:4>:?37^6T^eWX.b^;]54B[/SC/CY8(\&0df?=[BYOc\=:e[]a^
-O0,Z3FeE]XED58\RK;^U2?R(9cD>[8R3JHCS)4PR:A2-3Oc[;V8T]QaJ6T\<W;,
1F.JIQTKC&)g3DP)P5((cOc2<(c\C[@bgUZ<E<P+8U8#.URYXL.YD0LPdWWRZ^=Y
+Eg/T4A2G92DJ6=P=#76L&D.AX-QdcK2Q)X\/NT=P+Y^FW2gd16APEG(X#8-AZY,
Y3&_AM.S&+I?Z9GMM^N2T.CF;VW8gfI3VO=,MF#e/4F[7&.5gL>C]XHX-3g\CI>V
]7^1^Z?@-19+))_a?F/b]],I(0a=-fE5/NQ_8J6YM7#?1CZ8R1afCF#BKOCY@,1R
.2B@<U48g/Ma0f\H^+F_Q[B7[bAdQ;W0YM+BVX-,ER7)a7(VL#8B<V&:E9<^6OKH
YBD(FQ_L@3f]H38I5<Y,>17H<fa:3d#&c]E)_:9Da7Lb4A7A,15\96@^(dV8ZH.8
2dWDBCUSa;>-UYAWb80(GK9VR@6b2U^Og8?aGUT+\EN_=3YMK)_9FdMW,4G1S8WF
\E(CSP<P]C&3LeH&6I?/)d)PR-3D.(+@)5^:+47.Q^<gETX59W3C?#97W62Hc3Hf
eG1VfQff3]LBS+Pb<=_3gE)dJITcGLCXFR/5^\Z+#:M,K-5\af<(LTWSSU^WTSA6
&D-cC37/@GbCPM#?9bF.SKAcYeaY7\9-/K/WI0\UX#NTLLb7ec0=\USC([ZIHTCK
(M:D1/L7&@.?\EQOD#&852[1ZHL<U1YOG[8PfRJE2d/.Q>.\cAdB)\;XHDF6TLa)
WGR@TEMXe7K=BAJ&I?ZV,^IVU@D0aZ(R7J;]AdW[B&OOP/&L8?b^+TS48Ic@+;b5
bK=F8ZEdS(e,^^^&67)b/aSSe<@c56Vg3,+-JH6Mg1[-^G,ICX)H-Gg:dW^1+\P)
D\K&E\R4YEVMCeZQ3:.40QcK&8FIHYe)f5^N,>L/-C2IY];3_+:N=8g>7(@/Gc_?
H,NYR8K\<]SBO)2\CH?,LUW971+9)?)6HYA\R^BA2WT?eHcNQ]Z.9?<PgV-R2B^3
&fYafYUUbMYV_ET-\(<PKER>4K93]7XC0GaG;/;[MfNQa\gA#JP^>,#+G_SBEN)N
8<J7>.bc8?+T;R/#[O9K)GCG^;T3Z;9\1H1ZE4e/;3g[CI+C(U?;gd^fba6JId\X
[ba(UJGMX?-beQ,bb__a5Kd;OW@,B)[a.E:@V/P1HR#Q/Q_+bdVQS9B]_-NZS1:H
LXde2Y\CCV8:HS&a>UeDPC(G&/^4D7b1[X,(O-)(/7cd=MM^T6Y3TZ]e)_)gd2?(
E2XDCUfT^7d0g<[8aRdAR0/LEgPg(NL>0W?/bb\_(d7#&eN)If_If./A0JAMDY\5
_>2C5/_Xa1)?+]S4Dg5ZJHDWcKIXCCT#OS@=CMKcRN^.0AA=MKLbG\\N7dVf<Q^#
G:K0\HDg=b^XEJ@c4c7]IYU94NU0PR[Gf2SNJfE(/Hg^OBUZ[X;fAcE4P23a_F,A
P[S?#.g2FU,G,\OeM8]#Q0;Xa#_3@cB-8#^:_RYO2<dU_cR:H[@a>.XDRSLgN?)8
P16^##8TcAKDMV2:H;N58@=UD[U<7b-I^^f4\3U(#>,(3<JSd93G\R/6BB()dHba
?QXC1eZA+?[RV4R)K+M_BaIcdWK\ba2TabfE@Lb5GgU#0@eVO;G1R+S5M=-KM=Jd
5Hab-;@f9<CYb:EQg8(5VX[gNVFMZ1B&aX=gG2cHfM1d4aQ?TFNK0]&I+S,cJ:[\
7.XA(#)Vb6>Qd3>Y)FcA>XK<,,I[<ca#:03ZM9[/MSVf[/aZ)UdNeE]d^IRSRf_#
(c1>A#aN>O?f<LNC<Dg^0;4C/J+OdRT;1G+]BSJU1@P1U7FaHA5JTeDaBCM8Yc8d
.bf&S1g]\=62.#[[-80D4;?bGJJ2CVTO\V4+SHFc,3f1cDa,63NebO<297]gf+4A
=&F]BSJGWg36@1=;Bb<YM=4KN4BXMYQaT_ZPN,?LY3&9Q9/-X^9d40)ZL3-UDTJ=
+>9GPHbD-;bU\fA(.^IEZO&F9;Wg87T\.26XNefgHY9[Y:QGS.R-&I:e&)ZRFM=U
?IgD?0CEFbP9FU(5@CTDO<BeU<JBf3H+])Y:QCW8S@<9bO6NQ2J+1:c;2),3f&e4
:ZF@GPF\QSL<.dD,aeZGB&dC;^GMdI><XU;F4HPCL6,bD,?-OVDXAZ8_SVBT;ZfP
ZgVBKWQ#bFLKHd^cL_dI\>=GLQcHRSGUKF#B_^7XgZ1eN8,Ae:GNd9BOT0C_c@9f
,IGN_Z19\J>_1EE0<&aL2b;VG;11[<]N9;16W,U#UX.\FWBMG+CH@aabgE#3J<M]
R)3UZ1Zg_E7H7U;<YbCHP<-<Ue8ZSgV,6TB=Bf<-3U#>S8cWXC+V1G.1W.DCSc=4
68aIGD#;YC+.VX-YI[0fGP5#4<3.MB?CG/bKa_@O=Q[#+T#7:3<De4[>2/OC#?6@
U\Ye7<9_NPPTZM>S\?6dD5^gA[R?J10W7dILE2#@JOJ_eQX0LM9&CSf+WX(KXHWV
SAJKYIRF.,P,RID7Ff9A,R=X.,XY+Ya#,BF5JM^PT5a#HK9AbTbC,TNA&XA(W>6_
X8G>02[P>EJaL-#Rc-@;bHYC-FHUJF,a0J3e1OKBDV-Jg-G<-]HZ]ILW8TXM&Z>I
N?#=X283gG/JY20eUYcAL&:[?PY<4DQA[.>)a_85.;6\VNfa7=9;+KI-9g#4[H>b
G__XX.g.b_:O^<2DEM-g?7c?+P<8(&If:;f.?I.G[41M<J-&b/,URJZT2,XWSDJD
>8MA7[gc9S_8eWAI0AC20LSQ)UV]CKQ=0P\;S9(YWe&WOE8KFW8^@(-D\3L[e=Pc
>4R&@V)L+C/B+4A1([,E-?7]4T0)YMOR#XSd8[MBC;(6eFf-Wd?]JFQ5.\@fBD5O
GPg;AGA?6cKJ2-Da8;G)]N\OcLCL<39;).YK<^;4;g,Q\B0,SPO.RSadVD8g>KF6
)3FCSZd5H>Pg6X#2D-BK=d::VgF]UHg6FeV#@?,M]F,1dN7;fC/ULX&^--?5AFDZ
Y4XWJgF=_dX@:UXRc\/3LS2dRHbdZ4PB+R3I0W(=.9)c6[DHLSUNg,71\RM93eZC
EZ^W+2dcC2eI(KF[-7/1U3g0YB6+9]f&=gJ0B7J4W3g9F[A/C#\a#UWJ>@)^>e#A
ZPRY(:RFYENb&IG<.?=bf8RQ3>>deQL-4P/LJ?P1fC,cVc1,:[KRI5C1O1=@@aIN
6M9:;3H[>3SEd;D5Ka=)SNE\:<RECS&DT>3:fN=/>6GK)-gH.]GL)S:Ffc[54+N=
O_6:P?295A4Z=e9]]#DXW?7>,OIOY&dfc?:TJS8D\&5TLQN8:[a=(<-cBD\5(Hg6
7a0S\WfbEQ?K>J-)1@N8f3^U<9T]d]Za;[)9@U0AE+=Obb4acPFaFX4Ib[2#.a[g
N#,aS30[JgN]C4I]eCEQ+[P;AcD0E3-c75MH5S:gf=0U58.9.=E&c;-I4@I3edGQ
@&989;3D]1(OB:[GX#_,\2-AT)Jc(&H.4@[B@)N1La,=:^C1cIW5XgEFZYIU]+&P
PSMKcC=Lc#_5SW[f_42f^549U:KAd>Q]5FW1WVN8_+UG:Qgb7.[_MZ,ZEG:g79X8
P^U>CT+;)Z<Q6<:4WXW8SND>-WG[92b\?0(E6AdMS\7Ad\@P8c8^@/?0HM\SZC56
6+Yf/]Q4#7\R=-@dR6aaDec<;T;JVLH>:Q3?<Sc<97[/04GOCdgZBY>[(aRfZ8B)
_.HY^2L3.CfU:K2?AY4g_?GD:ce1);9WOA9G=J?2,O9BF5HHGf6>-[TVT\+K@b1-
6G]NM\G>@2c3&>\80.Y&HcUFEA[APX(<WRXM&+2eeB5\P=QS+=27F.PNf[aaDO;S
>PV#J&cY(cYWWdP0a5+4WC9Q;ZHS1@[^5,>_Z6_+d)5#+O..HGEVV/G30Yc_V:Z;
(S]:OU7H.Y;PEN[W=GJTJNS7FN3b/1(BYN)XP+Q;e4f80Og^N(/e&+[Q8I15Ub1a
B9^J(M@/,A>e7WR,XXe-D\M_^2K\GS:cE]<fdYCJ:_>H]+,TcT>SO2]-GdPVFH^&
SdZ(G2B1YL,eR6,6?E)>Z7a/)HeKFe])=)Oe[]Kf>VKK.F68N@[A6U--J37-QOaY
+QDBg3VJ\(DJ0I;P)8I9@CGcb.Va)BA6QCZ78Y8&N<L:ZQVG\eANP;Of57/[HM-7
(=<&5dXae+UC;b;U(BS\\L@E-@5E/e(CN##]9OLJ2U#NJ<[&RJ<0QZ1K_dRV:YF0
^0IgHf<Z#:NK=Db7G]<?+[Sc.IN#+4&ND.E7\Z]f<+c?Rb5f^;]S9bI=2b9DJ[OD
>1=G7bdKZJ0=8V6+M_5PKGO)e&?YF5F2H>a#ED-SC:d_5,I.TP,Jg#MGTF:<HQ7S
1USP9f<-@YQggSO4,/V:ZJO[CEFE?@.NJ:QQ;OAO0&,KFD?Nac/c&G8#-W_cC)A^
^BS5Sf#T_.feb3^/5F?IE4-9gD#[f7YOEL.A>I@+6=gQ=U7BKBbNW;>6\9ZW,LI:
eM[Y:\][P3[?G-(g>XM:)V>54L1/)8e7.BW;,da1D_cH+F22C:]OEc#-\WM?37J7
PMO+,^^U-L]0b-B>.Ae<+3e^V(S11#[;7<3QdaV_G2LMOXB6>e5]FZSLD@7,E;,^
/_WaG:LDf3JO/XK#:)>3#SE=c/C+[Z#-[./WO9T0Y7);_KM-YKZLdJA_6Ye<Qc,f
&;[-7D)+X<:@1_6DK248Cc].P\e4=(0M4VSe0WZ?68Se<@#MGELP[0fAedMdXN5+
FWO9F/]^bM539TZ]C9HdWZM+(1@<LZ?CT-X_f2_?9.\#GgS)We;dTS&)@>PQG>G?
]Y=B:D4\-edI(OX3]6]C&Q]MC6&7<[A-;8@JZ_1L,ZZR;Q9RcDS8(^/F?1)]9_+#
8;@@(JO18g9/0EJKR0CR8bBIf<<gESN5FI)SEOD3KVJ08S5_Ef,Q>^M.+Vga,+X(
G?)A(:Q];fH0=U4gI4C-GZ?/GF]453V=9]#O@&LO0VIg)3IUbJ8Y>(Da)NX;_F4P
6Z:]HU(#]57S4^Ea_J>bXRPd;Xg&:W(70^Uf^0.d@8L#Uf;K7,cCBT5(VF;D=eP-
V&UY<Ad:HeEO&?PXX.:dDA@e3@4()7[+.g,>J5K;6Z5K792&F2H5eQRZZXDXRJZW
8#_RbUU?HdKG3HM1Y:YPM71;]RNJ_(Z:AYKQ1)S;WC>;I2Zc6.0c:eWb&Gf#+,/9
+-,^G2?PK#f&7@E>=L\bQ1(->Y](Df92_g##QGbSb<5Q?b0I_H0&&M/X0\gUE64L
D(G4>&_KBgGfQN^9cfS1<=ea[5EEY48>7#U(6=?M?Nf>JCYc01g[MeD_W1ICgBKM
RW,f-?>B->9FL3Re75<aIU#cB/We/8DeQ77B:@]P@Q2._?:cK_7=NH@KYeMgK.U:
?^dZ[T71FH@V>&KG<_UXG;5=6CJJYKgO+L?B(+YDc.^D7E<cZYC2#/C5V3WNZBL@
Z7))/NBb+4=cUf/eU</-f0VYFXS#>(9)IXF[OHLSJW?cff=;ES-J\P<BU#OALJ\d
,d#(F,(;(ED2=:HF#7aQS#\PL5(5#1D[VN+1:,(;^:cZ3Oec:L?gVX#W6bLSSIWL
V_AA,-g\ULQ(cf9F<eQce25+K@e=X24>.M@FB?7[)^;Z-YAJ\+BbdZ07RCS&=L<S
T?9+7X&dgXdFOONKD(47PQ08R1A#J[,F9Z\N)Ed19[->H2f4W:AXcS8Q<eA@f2[d
V8(TDG^GTOJ/b4=Qb<Za?-M8ENNL3d?RNT54NN_6S>505Q\Q,8+9eeO)0\H_Q3+C
8UO6bJYbFI9G,G5CM>S[?2gd47\E8H+IJ8OE-+:W#PefLWPH;e034+0BIgCDL7P]
+^[H:\3S2_\ZfKXcYZf0&FY>.a[UP]N8&HZ(]F^HXaI8Ce+a.d0)S0d6^(^0VZ4d
OdS7]H/B\[5OINPR<.D>e-PE>U1NcHJ;/Ae[(\8U>0:Cb.FeMB:K5&b8O106=?Bc
IOYM6bZ#[B_&]H,@1UO#P>ULC8fV,19c<b1A>?0_0LQ>83cEa4V]:&.8d@4+61_d
&;/]IXY=g\;Z1O-F?[]XQfaL5E+6>b&K]YO-V65(,>13YE<KVE])H[?M5#.DObPR
McH.DJ[<5);@eWE/;,Q@>MdK#C>W4/OL=:D0g9MHPg4=-5JL=7M@@e]f)FJ[=EG?
\DNg?U<4?<ZM7a,D-O_2E6M:/e<,c3PAC\.7=-Qd#Y.Md(0THM5I,O4M?Ne^NdZ:
X>f?9K<QS]IZM5C#C[DE.F&U1-0MJ(UAf02A(PfH#YRDDV_gE>VR7;Vg,F8^BE?P
1[@1/]b=EKd]CSDX[_]WTEW+G;PO1GTJV4>ACKOd=3f,P@#T-H&@?YgO>M7)+XD=
KP^=)=P-J//f[XG30Q=6[SI5ee99I.)>A4L6FfeZa3Q#AIY@S&::Qe@8B99=+Db@
G[dcU#=R<Q&f4>^ZW&/RIC;A+UeB;EC96fKa3-BgT//cUe+:a9+:@5AGE,4WIJ?1
cC]SbPF_(,Y94IUZ8L^^P.MK8M7C1Y^,[6&g=D5ACK&bBI=eJX_KaE7ODT_MOLL_
OF;e@:MPJA(AH[,CJL1[1M):g?,1<)H2?,OYVVYA6A..N=F=eNWXXOf0M\U7^>=2
I=.Y[c#S#[NgO0]6RafCW\T3/:2fPUF&cAeC4_@>OIge97CA>8/9>9D>C1D[IEXV
N0<8#<N:_YSMLQcZ;I#++\=EQecO7IZ6d;dcO]QaYM_JFH^_:X074?BPIHGc7\B5
dFg:R)FJ),/Q>#C/a+-3?VYO<:=[UR<6U9PQKPaYbON3@aTfY)Z)K=5POVQA+=?5
@^2EU_f7@@T+?52B;X^LABY]YCGSRQVAd?JKNO.#:bdd+L2B0CHG-CNg5<?FZ)E;
W?MGR0O[O_ecPI^V_F/cB/,H&^B6<F:SfV3);5HG_2>4Cea^aW\>>CR,KOAa:O1+
P@K@S7XeYc-B)N(5#Qb/;:QT#SAF[AE&[I-[2R,>6eE?=)b[W.0#g/0>1.Qe_ZTC
.UJ)VF3XM@(;@PWH>ZTNbfL#<+IAS,\OT?63V/M</5^X^Na<S>CR&Md+W4+?(8HR
7X8<dJBd4dKN;5140+FfQ\Z5S]_S/-8JQ>HMWF<TU-7;B(gT<5g<(a^<0fcIABLE
H33Re[2;VMDA2K1MbBgM6c0J+K;>bZG-a>:&UbI[_Sg<#JCTGVD:I#cGHF[<7L:?
D^JYHW?RW89f#/J./:0\^(STD,H]fIYUE@P(R6,)>-^HWE22QgaC5F(6CT.b5Bb&
\K@6J=-Z^[XLJ_RKfe).(]8>-AYcBAPZg9(82R[C(6M,)ICffW36)#B3K-+V7SHa
=C8T0?:51gOL^TAH#VQ?>IITbMYe5YU5E&[=@X.-3-KT^6BQX?;420K-;G4PJI]K
L4E:CC:DN4\JYW3WWgUK\#7WZHO;caa,@[[QE#Sad<3]&AQ\-FSINO2M7YH,]VHC
0d=>E+OQSW,TS;LK8(\Dacd@5Y2FZ.ML=G2>Lf4<TAA1Aa:aP&QVBYH+5e0fI^-.
99P,E]I8KP+4PdH#7/Q?L<c_3GF=^H=-DR8RJ7)ME&3Ub37Z29bc47W][2dFOB_c
ZT-ASQ(f@ID<O5@U3bKXS-ESHV(\)(0ZHQ0#deJV4>XDed;f97cgQLc2X]PW-/3e
)^HNbDbc&Sa>@bEO9Y_D+3LOe3DL0H7\eE6R?[Fd?HJNB+@,A1EG9[a(/JbGfQN#
XL)Z^&C2fAc-.O#I5f-@egK+4bGVJE#M?eL9BET0AHV.L6T)/.IUDAdQ<9ISNf[@
6g335E9f]?SU^D)1>-7Q/(Jf+V]b4d2=5>QJ15RW><\G?K#=g>3OLE^^R^=fd(O>
3-b6b(]gGPD)9UTV92-[LXNC]KDP:LE#>0HO_a7C0+8MV@]J-(8WX]6+aT;3@)T[
c2[B,LM>@)<)RIW/;gOL8GJ-7,Z5ZBg[bcLLJ=]0VbLOFFZKX[GY@56J1WO?e.Oc
RN2LER4NRgY4(#&#/4Q=1cOY@4F#CSF<A<UW_)JZF>T]C5(RXN5VN,H]KaQH)PF.
[DFLZKB7KP4W(dcS++GA396-[\>9U0b>?_GQXeN(-(<U\ggOWbU2<?Mb-4CcSQ\E
4e)MQ+@g#@DF+1Q&SQEVCH/B.W1C&/cGUWaXVWCE&d[,_^N]/P/<L4ZHP)-+V-7,
;F\A;TN@9I1_2/>-=OTJMbgFgWdA<XB6<X0X_N.1ITFf=Lg7IA3KHS\WAWYC&GK,
Te45K>]c5M9+-.aNJJE>Kg93:3>#+6Q&e)IKX<db_PV6,_dAFGZ9[/>O9c\-C9\-
ZcQ<IYEDRHL<Q:<>bQ[P,OV(MLR#;W]V<Ve:;CT_<JbNUR<FV)C&R\YN]_U(BI8W
f1>13G1M9g_6Kg4:/LW_[fgMZF3Wec&KV]2->>\fP;8b,TRI=K,b5O[AS^2F?_&9
]RNgK[[UI#_Fe0N)A1>,<O47/XJX.OG]15M=M)[3e2g>4@ILd2/#17Rc(3/-8AL;
&XXO^BL]PaWQ+3\.^V@IAGB0dP:G#)J\=cSVD,.1[Q&5T8g5d6#@4Qfg(IdM7\F#
\a.POP.Jca\U6GK:9CdfdK9J.^)L10UGF],(NbKRD6Q<DC7-RUPX=H+]R6650DQU
47P2Q#6E_V(b),33)^H<4&_Y[-.eB1-9D9HJX/6^T+Sb/BV[??U>Qfdf#5X(XWb5
QNNI^&ReK^&Ac4>E+M1-TR.aM#+AeU8J?CQ?SCBCTX8P5>CR]R,ME+SQT)ZE&Y#C
FUOg)8_CRcIRgFAOc]:<GOVY#RPV2.0^W6cV<:L+M;Ib2D1_A1gg_G8ERg6>BOFb
00eeW?bRa],WcD\/6>0da85UYXM:LN#O-ZG6\C:fIfWSA[ET13K3N6dPUR&db)#P
PW0TV=VaVPQ.5NRd4C22Q\3CBQg6S<>=Y1VS8(B,<B(CID@Yf9()daJKgDCfC//#
GB<:fKZEe&=6d[&-G_g.6\\Lf:ACWUL&7S?[Q;7Xf?GW@]4)=)T1.X7&)REN<C,=
/F3(a#0[?(0KLE(V8Re=G1&IJYg2^GEN\YV9bZ,<g6+[P,O7D^QH&]DX7]6(?K3P
1P6gYIfg+&1QcW(9P&E.ffV/FD[>dDD3C@0bV&FE5Y(3N+G.A\D7N\#.Fg3GI)?>
#CB6VcX=>)F:KBAN5dRX1(GTJAaC6T/:317\0,8/[&/13DFNba7P-@O0b56gNQ[G
WWVM1RPV;<8Ec(K(S2O0]O4L-Q#DFKEB-(?S2>K5[5X]1]=RMA2f(Ad#&K8I242Z
,);17U8_6PD<7L.E[I,7=,O+A.)]/e^OGbaNDR6aUCUaNbb\1dPM(c40,3=R=5\+
.gH@ROFF[a3\<@>(GOI-K.:X=@WAM<LPg)M\ZM[600K]cZ/dLb9J6X2VPI?6&g[&
V])9E)f,EMc):RF[4,e?4]?#^,7\adW,L:f\d4K26RAWSAf0X9KIea#1D]NQZ4;A
Ma6D5+=0K.YI&L2.a,-3#LPMHM);@Qfec6cYW3(M#Z6D,H;[cQ/E?&@\X[3HHW\e
5cf7BDZ8]7cH>F1H2@]B_@;2T:=TdYI?EbW+4?\TOGg/>_1K2bcJL\f=3P2\1&2P
5f(68K@^F5[3.=)^6AT1Z:H5+e?4104NN#dgYb^.H5K(,RK=gPQ-a(VE]G=Q1S>N
R;^NKH(A[NI(VRa)ZZKFM<TKBG7IX:0<#3d0]BIXH5Q(4e7-M1e/7_R8D^R^+fd6
gYcKBaP2B;S/:UB_9/^=d;M_)I9AW\_B_AM_.Q;:49[)Y\5XK@TJa00]1b)&^aD#
0JaV,B>;NAB(O=Gab7\A2KG@OBR^++d;YZT1I;&)]FU+8\M5IQ1/P3A6MDQ4FL1K
.?(KZ@OQF829U<d2Vg.=FCAc#DeC58b4VWU>GG[BIcU:.U#Nda7R_=/B9Td@1^[X
H\@GU=[N&<IWZNcP;GK?@T@2,MVTa,3;D7Ae=LDR<?D._A-LBEHdENMEB@Ea;e7P
<0J56RS>8]+4dd7+g@O6M?7d+]H+1?T@5>I>:);7V4Va+/.-QSK&B#(/&C5K&\;H
IY:_Z0U_WCK;CRec4N^9]#R^M9RLL490\Z.?Y[B0Hd3P>WgC#:0F(<^F1JM8&_6X
&:AKST+S&0Y?;)=)M,S83af^Z,eG7P@1G5;(J,(a@765=_3([\.,D]E]1K4(dQR4
JFg9f]c-/f+KDNW?Ne<2DGDLdK\FF-/W;$
`endprotected
    
   
`protected
+:QJdG-U(bDJR&VD9K@Q>BEf#XMLHMVFM(=4C#5/ZW5cJYC+MK#E0)KTY\.+DEGH
,2IT&dE(.&QN-67MRfW&W^UG6+.KM5d;:$
`endprotected
    

//vcs_lic_vip_protect
  `protected
ORMS3UZ6SIL/-NT<>TDaHALSM,A43+YWKUM\;X)<W7<1f,b^ER:A-(?_EG+:5@C]
=+8;&D9^)0H/P.UKYEX5-^J37[3dRa/O9>BJSG<VP:a\I5BGJG4TI8Z0HKGO2ebY
3]@H4OaU[JU+4J7+Y,Z3B>U,UWL0gN;>bUHX]]1Tc\bQS1M1>>DB()b=B-FbKML#
_g)1L06[VBDB/1VS^R(8T)>bJb_VKae?3gC_4&[1T=OB[,D8)7GR,\G(,N.(+(T3
XMe?fEA#@1dN6b6Te^fY>LF[(6WIPb\772(=5gAQZ2@HDGZPN=^ZNDE0Wf/3U59^
&ce5de&RAK.=>PETaT;NT;W2_dg5582YV1F(LDEQJ+d<c59O(fXCJeO<>SA72Z0;
bWfgTL[Nd+I/N0A.aP/L&(JS&U&[C4;/3\c<[T2NRZ.SKWP&8[MJB?IW#O>;ICJ/
A8<)f/gV&LN&UI4gaJZ4YESbdF8UL>NZ=_52264SbG8E@UT7#X;c]W[SL2W:U]-#
GXQe&S]96e<R8ZEZ-d/1<:Ef<(9UIJWE#.N97)PJ[C.BcRY_W76De?S6eFVL(8CU
FZ^3A>FU>B3OJS4DZFa.)(8]-HG?b#ZT\6E6._(MYC01W]8[+]/T_4]<584IH[XS
g6IA.54d=cA;67UgGA_0<FK01\PgJT5gRSN09Ld1dX9KP5UJ>SFZ9IDPfINVH1N_
<IAFG9NEgO/5\>g-E_W+_C2ZRe6U(OfLN2c7M5Z>e]d0eXC5D@AXUWL#9U,CS/>,
8AY34.?6^=-_EC@c)_P>\52>JHM,LL4RM7X]:FREBFJXFNZD>3M7a&^HY&CbQ>69
(0+He_&HQ>S]00[#;P55NT@;I&b/7Hfe7)]c6G_1AgPCKgb7O2eG^M4cHSg0.\eI
[\8/1/3:B9\S-KXT9B9@?K(TdPNML0Wf:;PV\H9]PA<Y-7(8;E-9a_>f)aPg)-5\
OC;;^+b2=8f^&-EWg0@<>EZ#e/CBYZ#M4;1LU)8YLbH9W\V]68K&PT3g^Gd6[\]Y
6G5B:MM6N(M+B72Sa\E.eGX[9HQc7MJ-dYaW5(37HVcCD[2gF;EFH:TOTacQ)[Z^
fZ)?T3Q.[=[U+VX4X,;Z#3Lb(5#2H]=\Q-P0Q@<C_@E/Lc.VbQ81>^5-/OV0IOG=
J@=Qb4&498GV0[C/#-,ceS0HF@fJb&J]_RGL7.@[;9MeQ6+K\^G:<;\SZFH5-e7,
2RL8:;HTQa?FA?7D-&3M1cIH?5gMUM60O+2>A79SULMN5U#S,QQK;9)Kf(-F4U:<
e4SW;Ygb_6N3&)J1=Lcg;LR^=56UDPUEXZd1HKOJXPdVER\1R>;<S&D?9;0<;53H
Xba.Z0W=O&5,QcNJ#][LFfMcHN-ZF[,8Qbc[=,RW9T7UaX[>Ie&eC#,(f<1KQ##L
V1,@@8c<R,=@(9:6E[Yf+7Wf;FIZ5C3-B0;9?K_6^eeN7EE</Lb;6eGRfPOaZ?6>
WA72aMD,#-Z+0EUB_#:GW]SIL&CGQX]6dQNCXV2F2:;9B;21T9b-ZI]Y]AZVb,#e
;>9R^?VP._-/@^3V=9_[(1VG3K9?\YV2-aLg)]&#8&U_(,c]&_(^a@:Y3.(TV;g,
;/)4d\AH#B.A7XgR=2>N1^-D./ZCUb?OGN?JT@Ye7>1POL+EMcH0IQdNB_VSOBaN
5=D6ccgQdNYSFfF+)[MK?5UcJ07e2O4;#N?WGFC7N:8,M(JTIP0LdO;5=SaJNC;.
_9PLMQM&Y7B)d=c9f&4:W+egVNXHY-H&N3\ONFWCP#=W3/d91)N(f@^FO62ET_I+
a_2_UL5T3P[Oe=Y7JD)QO<Ca@J?=\TP+YHA-aB>R[BGD1aVA?c3^L]62M6UDcP[W
+f-+C^?,4?]eH4#KcgZ?Z._,gZV/EJA2bdV25ZM1#[KUQgNZ@=P2e)10,;bbJ@e:
2^C^,9HZNbIaJDG+Qe_3Fa\d^A)e]JVeQ.W:,8VL=2<VA3-IV>U_geeY4A&#WV=7
e1^HfaNaN?_R(PbfPTRS&HTA-J<OaU2B0eH3Se\QbEB@0T\W\O,S]2fAD2Q[@L[Z
(5E313^I<7[1AH+C5I=@IH.4bDaZD\a10_R]KWd]CKL(5Na(Pa<g.(b,71B?b<AG
VI?U^7&]0VS770KE0[WX)a5K(S5)?:[A2JCeHRDP+T,79b&4](B\+9?H[cJ(^D#R
H=[@AZOK)74>UZRf990\^PAU)A_>#eaR^8,]=6/QXOSI\N7,e0K=WF>9Q<B4?d;d
f,_5:d_0R9ESaB681+e_=CF3L,;4JOVC[866a,+LKY9d5H9XU)1H0ZH<&Y@TQ95O
DD+18g=b<-I_SMGI.0?3@U@5KMF8de/Z_6PXK]19\,GB.LL@4gdO8CKBd^?EC2-P
:RB7>3g5:)d,5SZF1BT7de9,L^<g-;a]bI,=C:>&a-1H-eP6cPEWgH/@0FI?e.@\
9Lad/9<T+K,N=?SI@f,\_B>9++(JM/BcP?LNC,#Y_BHIV>OJ[1e350bS-NHJ2fE#
IBa+8Qf7PLDDNNb#[BQ4[?N44Yg1Q(Y_CEX49Gb?@e+5d6,+3^SE(5b25)L++#DY
-J@[>^\?Df[.[ZMGRc9#AC=J9\6DOJY2+5G/S8fV9.1Eddb_Bd\_E55eJ66D);??
fJJCIJb(5:(.S:?M-H?M;/^+bLQYMbf2cGI8PMOZCRg_Bd-:MO4K;cP_&MZfW-.:
2[DGdHXBO3_A)V,3]BaK_YU+VX_GFd-<fSZGfd,8QSL+\Jf,D;5JFg\N3F3B^,P@
_AG^Y6&g-;S@/TYY&Ke.:dQ617=QW1bYATgUcYZ3c]TQQNdgOCM8_&8-aYT-;Jg8
+S2,U58aSHF:[e>RX,fb5\C/43C&1&-<VV\I5[<e?V6S&fgd4U#8dJ)2U_O#DA&G
7bJYAYJEF=2/E@(/J9SBB;]7@:TB\;-U5YP30&O5Nd0A5N<Y\_#6[E,T)HS;a>>Z
)RHLB;H=FQ(T@I=04<=YH,=-f03c&?NUNJH))dE36=WKJa1Z(bc)8,UCPc\Sd4^^
c+<[Pe0-7L=MdaIK-O1@;&/L\<P7fD^fI<#&W3S44JbY>W&b0[F/:b?8P(P)L5.Y
9?RJS2UaW^0=6<LQU:NU3S@7.LLTQWa;EaW8&S?a[7ISbRVK,X+P72W?).Oe,1&D
^=d?.WYHN&,LI#,cXVWC8IKfXLBOCa85186UOg=(PAI\Ab-b:3++VO#AaCC(@-de
5SbE1@Og?\Ze#)HAfa]@F)+8D;:ASA\0J/#&3S]9;O2+NgP::DFM]^OHe]P&g57[
V0&O_R5H63d#@:H<8OM&4:I@gXJ_.,e_Q@>[@aN(\@]O<<Kc]&+f5,TbW?)[=JfX
.OLaMRZ=)>\^M@AMJTQ/2\QNBU4ABNZcF2Y3))F]JB/g,[;TIYDRcEY,+K4NdOHQ
7cS?,V,+[;=9#MNEJWZE;<X_OcQZX9F&5Z<#X.NJ0JZLN54X55G3==-+(-4V:MT\
#D+^YV0Z/=QI]V@S\)OW?/2__,UC6,UDLRb8f;-=/\L3J#Z><d1E_^B-8C[B(a#L
;(LUdX5T#J9F&;:H^@]ZHA9]]7++])J8>Z,(61\B]OWScX,E57-6>N;FMYREHEVR
b5LN^MB#6#Q&f+dO+6a+5W._KMGW>T[Tg##FaU,]eA-dMY99\HH<UG2^W6<bU;ea
bKK6fEHFcLfeUcXb_DUV84K-JY:U&D\f]+7\d+eE=GP?]=3GKJ18Q[(FJ@_)>P4:
7ETAcPEC<KS:CFOL^4>g;.=\9T7;Fc,.:B+;-J9GaPMQcMWT>Jc;C[HCJBJF0AfK
Z<I/C#_M/@#AB@=O?_afSU5=b.[JGGP@Ide)dgZPOaBI_NNMYbOEeBgc,eKGVL<C
9<Mf85T(O:D2dd28_EPaQ69K.Db\-=A0W=U0]#)eBLMD.Y:E1=;g,c<E=Hf1&WZA
2,50<cZ=)T46@&_)4(NSX24agcD?Y^SNTeDeJ>PEd.G?5gL0_&8@H,#a4Z98S.@I
;_dV1E&&T:^bL)QGX[NgDcd<O634Wd>4-3d6V+5MMe>6@gcZV,O&:KUEcIN?[E.T
_\.Lg59bYa#BA9fW.](-BR2d1FI47CZS^b<fd09GA7&SQ:,,_IH<BRTIV((D>HXR
=7+4e-DLQ56^7GLJ#c,3RM,a.DH2b)J^,4A3EZK:NgB7/b]4I1D#5W;7.(]S,5fa
eO[:M1E<d[>;:TUgI5\gS:GH(<]\BRA\fA(H=)gXa9S,@,Z\=03B2#P00/YCN>IB
)_)8D36&PPaHC&;@TQKd-a\FON)K?I_3>?=cfaMYO<5Q8/8@5F:AZYS(WMD3F25A
)8Y.1^K]eOUY_D-BNU4)fN5[>:UBVR87H,41aV/BAdI8T?eda.+1+#)MB3<\B,0K
&90R4a_UE),=CfDXcJ5BT&GIUFB^25.Mf#e]U?9Z.7<@XLM=H6+=,&<V>adH2SS@
8EJ_#CODV=_P<8+_330D?XHI4L>]K8S\g:T/=MB4gD:45;42bg3>5U3_OG^V10&e
CSL[17[\TVQ/P_7cZ>7\DQd=^d8UZf]Y:SHS+R,a-G+Ff;7[H91CD&7Je,-?g61K
TBRLE<8VTZBGG=c/V#^SVX=GU>JHGb>&73&]0H,P)9Q73:GBPe5=4J3\DU]IWBIH
8R@5+(1N,0.YJGa0YSd]W#(2F;P9H-_b1M_W7E2ZFS>OfAJ=/?b+56dI2?<</\?B
aH,RdI\4:4=A)\5@ER)&V@Y(B,P];K(B/f+cFPV9U5OR^CNZU5ORCBY,daDK3QZG
@9f/@e9?=706:H<6.f8>c\?Be4N\RA+1J.IN:df8:G\5PA8KHV/+[W6W]eYHI,R3
C7(J7URAH:@J2Z;f^X\a.M(<UT6=6U6g(d0:Be[HH&1BGX.O^N2gZNDJL1(TJR/V
CBa+(K^:H1/?/7(^SPW/NEQ;8fNZ8Ef\?;Z#KMDAAKCOZaE+&78+U21:egVbA1<X
>OK8?CZ4U&FY6DP#20ZZ6Q0^I^1162f4bIQb<A)2UFafeP[K9P=PM-[e65XbFQ^d
fN_M5(Pa&/Wc[Fda<IJ^94,ZE-d\1E)[<cc:=GKK2\?W#=VHZVAg):FMZ7[LA5d7
edf.ZG9,XH8\T@LZVdXMfbIT?PZB>LHZ\F4,Ac@@DTAcE&K+P/@LOKPS>IR-XXf0
ZEI=4==;2b8RR3gJVG;@8\-N+@M/4N0PC/MDDRA@63cd;&4eU(TJaIg2DY5T&FJI
O?ab\bW-DbS[\H][KA6RK4R,L3SV(8T^KUI<eK6EH.\8</RY+SI,BH11X&J=(D/R
LK^FLDc8D@=_W,\5)LbK@>AC_Z;>e+>]I@<gP-/<P/8b4@[d&?f>=T&_:9BZa/D4
I>]ABUb94a#0)\ZFR39,7KV_e2NA(G+O9D3=_5?PK)Oa@8#8+D5QH>W,P/#a&P,U
L^P\I9L30)+(D:LET//Tg3R70:W]g_E><K13GN-cG1VfR#<Z9(BX<g[+ebbOAN.Q
6)RHCg#S\2+>f;Y4f6eV2CH1Ig0+\(&WB6#a>YEK/aQ.UB\RMfS0:PJFSI8Nee]P
#T1)&H,8>DO(592FUUGf304/L#4D:.I<6MNVG(0,MRJ)-=C<1#DR7/XQ4A\NR;C(
M2V=7Y#+RK(IATPA_J.MHD&2e9+RAe1F=_^dMI3TI_+?CSBYcIU;RVNR8S4[N]Qg
RBa8R_GSCMZaVDR/fZc7U.WND0\7__9+A0eA)g3N4b5QE,KfD=\4@;(a.c#Mc34C
RfKf;Q@>[S?a+$
`endprotected


`endif // GUARD_SVT_APB_MASTER_ACTIVE_COMMON_SV
