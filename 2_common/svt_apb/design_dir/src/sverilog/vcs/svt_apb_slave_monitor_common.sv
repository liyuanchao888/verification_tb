
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_COMMON_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

`ifdef SVT_VMM_TECHNOLOGY
typedef class svt_apb_slave_group;
`else
typedef class svt_apb_slave_agent;
`endif

/** @cond PRIVATE */
class svt_apb_slave_monitor_common#(type MONITOR_MP = virtual svt_apb_slave_if.svt_apb_monitor_modport,
                                    type DEBUG_MP = virtual svt_apb_slave_if.svt_apb_debug_modport)
  extends svt_apb_slave_common#(MONITOR_MP, DEBUG_MP);

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
  extern function new (svt_apb_slave_configuration cfg, svt_apb_slave_monitor xactor);
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
  extern function new (svt_apb_slave_configuration cfg, `SVT_XVM(report_object) reporter);

`endif

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /** Writes data into memory in APB slave agent */
  extern virtual task write_data_to_mem(svt_apb_transaction xact);

   /** Tracks pready timeout */
   extern virtual task  track_pready_timeout(svt_apb_slave_transaction active_xact);

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
\WDG=>Lf\LB]3cV0#:\<I\>GEAHVe5+.(cHQMQO->6:Q@E>@JLga3)f4[@8gfT+<
O:(6TO-6AW/K4<4XV3JMg\5Q/=;>@)gQZOQS@a#36DV6B/HD?&0bOB18RR9B<L\:
<OaT#,W-B]>6HA>_63B60A;((KCaNY.<=YL6=/cN.J-P<#b,<HMG2TXFMQf5FKK4
AC::J32F)38=6>c2cdaU?=d#B2I3QF,_:)f>M?W^G1\a]::T7#4W7TM&1g:;G(2S
-H./6.S8:(81+;S=P7<3DaN)T1[&S6BeE9g&&=YV&L,W>3&9#cPQJR9?\RP>c[dC
,)8UEP:DUEXgM25Sc2XITd)=>J0A,H8BLcP>RZ7LF.-O0KKYH=Q=3;/;O8QU+<f(
RCL=?gV#8<T:>g?Mg2/M&?]Q&Z]FVFg#c\@9FVY=&>N_L[.O942.WBP1ZJTSD<PM
>a4E4Z/5A3-/Y]H\2PQ+9,[>YJRGT.7.cM]L,V)?&c2U;Q<HH_V#W-P1M$
`endprotected


//----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
XLVLFJH05S.?6O3eATA,/_@8ce[;TC+9#ODIcN0K>c[\D/>^eN;S3(X=1dDW]g;.
ZB#)A<PG(M.K#<^;&V.K=_0JU565@N1]a0RJZHD))S+6PI,8G#Z#]WZ3B-8Q)YZC
gVY\ON2WQ4_Lc<,J<IUeP,MIJY8@V1)WFZW<Z3DK5e&ZVBA7K^/ZLIBJT8.D6QYW
Z>2N46^aJC4e0=U<P80fB67>7>:FGd:fDEg<ccPF9P.:+\87^_:&.Q=RUfQ/.WCY
@d1P0KBfBNM3<W29P_<?W^]7aEG_R3,dIEaQ4PB@5g?a_8PD:AFXfT<fF?6;AGY+
WYQ_N<U_6-#S(+a-b68d[+W\(M^+,(K@e(=?0NY8dYf;_7+U:ePW&9]UGRF&LNN0
8.d5:A\>3[@5KEC\ff1<2-@,PT<Ve=(MJcD_egeVE;1P(.#61_g<b_ZHOJ^C--L@
B319A6X7C(T]/C,+,B_9#U&>1687\]3X;D&_;E,,P<+-c5bX;>0TN22#[^RP9D[X
\2S<W+KF#)\7DN+:80&aB#)-;:[R>Re&VL4Gb]VXWDM1FP#O1U,<44?#GJI5b6[T
)U.GC,[43>Z#b@(_0;WB:<bA@X39NVLV1#g2>-LaKE_2[3GaC>Y34BV4e<[+,S4R
:[.[74BL^WgI>WCZB]fRUG:O=L0/@6WeA-9G0O607#6(FL><#EYR16G6=1&;/UM6
Z^LVM)Ia32(3,RPLWTYgHVZ>\O+U^D?bbZ3b;68/H:M=BI&?&=LV2Q^WO2H+X:0e
Y6\W8@PP+2Q=@>#C+]IQ^P&0FWA+/Ic,KG]dSC8XQ)(A0V4,8.J0#WPN,RHZJ/e.
FMIA-K)&BUQM^MVa@&[LX/_0g4;MO(864I:YH^TGGZFX.3H=4S9THQ>:Lb;4&df0
H2BA5TFHB[MI3NI8.7fU<c:S<2K01SPT(27bB8^cF&)g<T-NG<^,@M,NML3#\T-+
#\4FB:#QDV7XQTN7JDCKYeNI/68g,+ZPC5J/,DL5TE[I/_/Z/I8#6]>[V,LH7_)Y
8gfBDI/VRO#B1L6+d]AS(FeS:.NV=>[cSS62>3E1dDB+MS1P.G=^:5e,9Kc2<?S)
+EPA+I<\<f7,B6ZB34_?02:8,:e8A1b)S.(D4H7YKIb0g<,1.H-cc_GDD<KQX2IC
^d;9Wd6[VV\F2H8MIIC?@H;@0#;Q&#N?60.2f9Z6NQZ6;b?(f;T<f0A?/]J8RAAX
0E5O5=J96]H[9L;C_,I3M+;>(8:We^O#\?25cLTBHf_Z<4G/O2@4A4R>?fLJL2N/
.VULO5(+J\.MH?LV]cZ<:V_9Vc)(>_G&1-R^SV83eGG3:Oe.Aae<V@Y0LQO^\?(6
1T/82#JWI&3;cR,_0AV(#XKcE2[THe9IeWMY.>MFPAE,aZ3VIFS5e^]Y=S&b&4=R
Y\@X@5LVFE,f0_RZZbEC>6bYTL4H1(:(YDB4YSE[PV^cSNfEHPNWD18fK\DX;.Rd
\Jb,JIWX/2LPH\a_YeH3dXI&+.HaW?)55P9RRE5S+#-agKX&^7aaX^3e7/<3@87R
:X<V>1/;g(H6#YX38P+7ZcIb^H+_GPbH@7UcBI],RUZ=fU+?252P-1Y9g/I7gOSf
I5NB::Le7JeMX1L4:@^6dMNdH,6gZe.F;@Z9;UA_0^fI4?b<J@+XWe\AUQ:>?>Tg
>-P8INfPFI)8L@?LB09EQ4&@]=5/;R:M=Edc[eZ>=[+[I0VM\F[>H)D4T)S#AAY#
cP?fLIJ2JB3Cf1MSf]1TX;=TXH+2&G]=T_S<WO4&+5PF,fQbR7)AKM1_&J&01^QP
,)+8TG(fd4P4cIA>CXOKE4LX:bPP^(=(Q(YcHOEc,0-Rb5Qe/eA>WGW-2gT\_HeJ
X53CbPWL&2YaR@_1Z/?e1PV[HU4gJNbXY_<P7DOT#)K5SW(b\N+cdec0IZ&XDLLZ
R-eDa03UeHe^0L=dSXIT^#K?=e/=g^I2)cUQ[9XJ8;HfXV@MfBO@0OD^2_>.BC5A
@G(d;KAYE9=U>N.L#[A9gL_\D8Z1.F#R+@eS&7#D>-W\X_b)N1,TFFM_Z0T7IGI)
Ma8eaCT)^#VP7,D/R6#?,3_UaJC:4f>-W-[c\YcDgeb=a>I7A_5D5>YMI6E9LbE7
KgeJ[NQU1e[1aY45-9R5:O\,WRQ:Df6O6.XA09e8W:XcVC-NBU&Y3a.B5aJ>a[Og
e7IP-U5K,&>G>.XbC:Y@X[LB.,I\N5L<8QQ&-HbZL0,a+<V3Og574a9PQ2J_-][&
@6BQ2+GfIZZQTA(Z-M^g;]5D_DJ\GVC[cXX4KC0[g?6BZ0-M+X7Q-MO&HVgWUDCf
+QaBRCK+g&RT1f0<-NFHf5(W1C&:>U5FCGJc7a&BC^IeN;.EY8Z5[fdYScJOOC\O
D?OeLRM#373@]+.-+a>XV9K-gbSHQfT3_RMP>e2f=P98F<<Z/Ta;B+^Fe7RUGQCg
J?,B3Lb)6F9EH4(BN[_WV2C)6B6IY+aZXL2:[Z_1):AHN/\\_070\RXNb7Z?N#UC
BI_]AC5P4.1J?EBY9),[,>8/N1FZ.JU_NAReQ7JEX47:&8e((24J4\d;\JQ(->[J
7\4=R2:VE&.\EC8,FX8[<&7Kg>M#PKON)>AXW@O\)g03[?g:XC>\LGDTK)&b4Ce9
5M&QUAf9V_Z&]1IbEEUUbE;,I2)N7323SL++ADROc01F-)70=KW@[Y>7MKD&TKcX
M,b-#2VJ+M@e;c>4T5HYb-bN16:)3>K0eARQef1\7_XGR^#EYMKH5cP)-dF.FK9e
0I0UY0E=T;b#L58O=3)(WE]/DW13]0e,4J<QO9)VODH,O^DHT7IR?:V[3]>VJ/b3
/gL);9eFU[[\S&_=95-e@H]5.c.[<b\>e&TR52QS1eQG[\]C\1X9+ef6FX\30.a,
R;2CHde/P4,,38fe16)0E1c>^)8:6g\ReRV<4561EWXQ<85eL3;Be_LV35S-bK/b
G7=f7Y[aVFT<L;>JSMgKacaP?[3>^.N7Lc/UU<(OK_@/XX46OD3WSU(.NR&NCR+X
X4;>N81]agN^)D[I:QcaDdgb(g3dK.LEN;\Q_P9M5N81F\9JG.egI+X03e@0CdB/
VOBKVVD;cFLO94I[[T-_GFQf;Xg</Wd0\C5]08.b7_>PcRFUR4Z[9TS2)Gf=b7SQ
9B6XN5?2+6+_S?-=S;LVIT4AN0b9VWQJ,&(a6CK)/)3>A-81]>C7ZD1=TD/1T98K
(SMcV,;YU\cBf:6XWDY-J@5Oc/@0d8E2RU6T,XYagXP+J89<faD;;1:\IN:K+AXX
8NZM_2ZT;CWP23E\Q:9C,=Q9WaN\3/Wc=bL#CG2[+/8deIT/ON>H:aUAU2UZ@=1E
<YLWQNaJZ,#fVN>(Y7DU?d0dNa2AY(.J::ZAE/D#2b7XaK<JW&QaHM)+d,UNUD7B
&ZZ)d_+Dd+bEg.<CZK,X[0S=.EK;)G<#-OSc<N/I-E/#BgP[W.&A]Y-9;NRaC4eY
TKY<#Qb?O;e_(D._:EVTP]e1>9X[B4e>GNe?ZeAB-bARYaI#]3PFf6TSN>GER(,N
1@]VcI:#YKG&JWfOA&9)b__2WO2PC?@(P#;_CfKD#&TSRVA9H>I#A3\#Ke@LW8=I
@7aON<56HJ5G7=8V2DJ5E+MAA5:?694EaO9^-FF+C8C?:;K>^aMA.+;G^c5b0MRS
E0_gP4[F>Wa?;,C<bI4@7WaGB4YL0Y6(02OeTWc]JAJf68N7L3ea4?UP(cFY2]DI
+IeKcIO=M)bVV__2F1>DZ5OBV_=A#O\d8&g@VD+LNM)2++FHL>Y1gg^=NF_>FVdG
B:S0=4g^J0cGWKN^?5M/.IVDEOX5d]/Oa7_\9ScC#_G/a4=_QGO5J&N(4C1;2+HA
]RY\9IW7GBE]U^2Z?Y4K0&Hb[5;ZI1@eH#R:Pg?W8,>N,(B5?O+(L-LW1_?_3Va&
,P(B?U66H1N\R@R7]ce(JJAdD/[b87#PNFgd^d;b/+bg5gfE##I#LdfeZ#TAbHNJ
6NPfbTI?[27/KZ_Bad39@JKc2]JL__Xa.DZB1-TH+9F?-/V91-cH3IUb6VIOg]C(
;-Vdb=b[WEHQHcM(3CMf:ZG1(7@P]-=_XS)&^d?L^Lb2#^?J[3[)f\I^3MPS:&4J
C7_2U/O_3HaKfddR&:3gEP>BZ?/JK1#U<#JT)C&2e-c=T&(4,T,)aJf9Q3?+GL[)
P3f\X@=I3b^.^2-F05IQRMg^)9RBc,bK/71.P<_-D/-EIJE59e=B:J7^CV@YIW2O
ca^)1,fYOB(12gQJ_Rd_dKJ3TcSW;TLR</?d1V>#-dfU,1\e;;F(GY1&SEDANc2>
POLLYF69C)MTE6O-N#>(8)=EJ/XT\LYZY&OC)/7RTHKVCGR^+ffB/(,S+cY3][aD
aDJ5-b9MgX,)cJG[g8OF59^KL)YJW-E+;=II&2-ScZM.MI;6Z_LRCd@]a&P(UEN8
^1O;CGWP:2RQD@eXWTLVKLX=fe&g&/H2<F7(QdG]FCg4^O3EB/NK=C\?@V5LEGWV
#B/-2GFFcGP6_f3)bG0-L7.YDgI@KR8[&;RZ[>Ob-\eQL<28dQZS]QD=<:3K5QIY
6J#CXJZVC>eX.1&SZLZ-O.W+N:EUV2PBNW[Fa4&,)?AO\)Q4f[e_W[eb4;<FI7,(
T#Z6I3e:^)=@+#Sc.QA+QL6X\4ILUfeS+<-<B7&G32,#YRV:>+ZS@F]aDKPeVN:U
QZ>W,)DG:e)23^B^@(7V+22PB:+)eFXU>RTA2.B<RLa43Jb-OHBe=6Gd7XG[a>-9
W7B]OHPO2dG(EM?K>024RRY/79I=9=;?7BDO+E[;Qb#4\&:OLdW@>@5HdPL.\9Fa
adSDg,&V/;g6e7OaN<&V]GAI@df0+d5;G[C5YJO@;?^]gUW<)0H5DR,Yd#+c_NMQ
WKU,HVBa,YaAB/0RQ2cVd2^;?/EZ#7aC+;0#LO;A(Zb:X;J7C4=bQ.1=^(^?&5S;
Ng\T#bRH[WGXD_fIF@gW&N\^#ALX2HWSKR6UA(1g]Y\&#gc]?[.0;8.XUX2^(KLT
=8;/N4./9^48-B:0TaaI6WgPHdL2::@:f3ZMDg:(dGJAQUM5WO30cPJQGXcYV:;7
7Ce1NM0Q<U8dRIBN4XC+L^6J<-cYRSTR#:U\[Z,(&Q)\+71K2N@fcR=4a_57L8#,
^</aS9.TaH@8@3HW[J\5H?4YQaaWEVGJe4_,&G,V^f[R>N(M7eWdJdI,@K_.4<HK
[W++)4+SMAQ+g6f9bSN@Z2agZ]&@]RJUH[I[HI]NR#V0.?](F6P;)KI]Y-P3c_MB
/VX1;fJ3T7ZU+RE=)K;SA>TRFd9^1^<?6P_H.d?cGCf)&+eXU8P9-=MDJKaA?PVc
c;]&BU:RSFd]67c+^1JD<&7:S4HT]3-LB7IR).R\<X)44WRGa08c_F<I_^8S,e?Q
=gg3F4Mg<)M)T4Z9+A>[2B[8H?Bga.R8f]20T[^A[Oc)G/OFUEEdRXTGbALFV+KD
f&@/1P(8>WX)c0OJUXJ?O3?ACY52<ba[Zg<feJe2/99b7Q\=SLELJW&N/RAI>1@G
dG&95+JFIfNe,6VD?@\07^YZNTAUR6.1?J;fb)7B]:Je/KEHNWI4-EJ<CYEWE7_/
Y>\AEZI->I#4I,HJN41QLaRI1;<4CTWT6A^K;eG1f:Ja7=.E8H5BC])HEJ9K/H.S
X<EX/.bFNZOS8@_2Nb661g.URKdPN.DZE/,ef5C/,\+Uc)8-;c]8/1g[c&@Y8^:d
W=g?aMKg6Q?ZO->HOe7AH,E\;Lab9Q0F8Bf<6.9+.7=V2dXQUZf;C.8MJ@7/[R4K
A>P]\\H,P<YJTeNAOS+:OO&J]e#fac68.X(-:g\f^;N/R?d_E09L.YIM_54VfB0V
VFNe:20d4FR/2</a.CX--S:HY34[@f19HZP/:aOTQ>9KdYVRdUNe)3KB&:0/+L:H
AgO>cRT<-/&d@MFH/eHe3,N[)E[KcG,C;IJ#e@YbE2H_Z?bNQK3Gf#(6#_#b-dK2
8<4@CFX;/H,:Ug+F-3.R<3]R936WVJFX4_AAK4C(X=HbQ_3dV3?-\.<._f^R-TZ+
d@\eH;QL](OR^8DA<Z91\CB6@6(\e]LU>a,fR,JUg0E9[T;>_LP&59.-3W0EP8?6
RWB2Bf^L3f,:6G&CUc1?GYf3/QX^J^ZTbNP(A7K-?2Hf^)^X56./(P[f;1?e-fH4
]MRCFaB@@_dRY=]^9B4F>>bSH>DFeM_9)70@3QgN<J_WU\_b5U5:0.S/;Jae2Q4(
-H2VaEH=\#^@Pf-\.6HIDNE;ZE1&WM7?H2F8ee5Qc?Q)LD0R(,Ab.bcX.MSPEd6D
gC1LJUAILGMS8H?ADWeI9\bdSO((TN@I&-&AT^Rc-FS)36#,a^b81:K6EIeYd^BK
,HSJFdd^^a&N_&NU#bFP.&#ZN:DH,V&_P8+-;9PE7OWa#AWEJ9@T[UOG9)PADM2R
U(:]@aIV>U2LC:\)XP8JaF-0:]0DEVgegS)9RW]H-5A-W#4/V=H_6JdO,(FAcFCD
I;Q@44K:;RTb1cA65X.8eSJY7FQe<JA2T9ROI]9eZQ7]WJDcIIALFFQ)O-R,JG=(
D@CO7.ZT&7D;@2LG(QE,9>R6e=O7d1KdKGFZQQ/_&PMd&<,4[<9c0/:XeQG4D9LT
9R?EWD^D-YZBa]Na3Q+_<EPHVJOd,#(.SD(A]<0C8R_^a#LFU)I)AG&EY->\]NcL
KEg]e/6e)C/+fE>@K&FK?ACK<J-MN-._49YFX^+@0/NW+VgB4-1>F6X)I57KeP_(
0JJ(ZWNf()bIC3Z3KN)F0Z/]J#2gf[CbSf5WYfRC>:g1CPS@MOQaR;6X&.\X.F2/
<382eI0[VMe>_aMW\2?D&aVMF3>)WdIZ1).?G=-APdHY^MZ:P;,fG+7-THbQC+C/
X?DZQg&#&0N>7g[#5F?2L@)T(M9#0,UbAd-<?H2gXbfN2<XQQH,;fGRHG3S4521H
D4O_KUEV4RKI-7Y?>_+QdEHV2&:0#AMG>YH8_3;N;VXTRJIB-3E15g^gL&NR-09T
S/I5UI[LB>A&)M]0@SE-,WQ4^5I0&[Y5P2;,;QN>DE]8\GJ@3e/;IU+<WQ7CS0:Z
TRgM3/]LS2KC^NaXMO#[A;W+0YYX:[K#<eX69Y&JA,N=X?BZ>gg1TdKX.g4=^PH@
gCVfb.FR4+6JIH98F<fF0BEVEGRWf4[;g7OSNYKeDR#)]c<J.C.N?7M3@K5&N<YM
5&BXg6-QOf@RUYbc4QF3L8.]X#U=0MA<)OWBadX(YW8]fU^_>R0#HX>_\NC@@:U@
C#=X_>?#[-I<3E6TRfEQ[,+E;FYeA2T=XHC;eTFC/7R8-O663[0R1=I8b#&RQ6g?
ec/3a,bB415;T_.g:[O2OSS8R@0I5=e<2UA4(>Q.>22U[9:R[/E:UKFe:3?ILZ[O
PD(-QWRfOV(<NVBZ3H&=UTM=2QHP1_@fB-/49>Vc8-R,QU;1C7I99=^X1\-(T6/B
X:XYD]Z9D+18O_/d)#eb.D7TX0Cd?W7WD,;^DeRFB/JC?SSVTa;P3FO:X)I4O(5=
:X^+K[(@e,=7.CP)UTbL+&S-V5CMNc#-050B9@^NKA0.?)_X+SP3TM+R#4-eZ<XS
N7_JXRFR+Id;@=4(95^K?(E\+6QSbZEPU<7cS@\P)Z:S=>94)T.?41C5ZT]H[K2M
8SMb7Y>dcXPJH9.&C2+85>=;KT<2I<Ld#@+ZL4FJ9(Sc7eFXV>^ZB5(4UaBUI]@d
3K4RT.JbR<LCg=P\J2#b9b[fTZU]5<JUcEVIBR9HTT1gcfV<TO,](Bd(Aa3T\g3T
#0<@/G2FLJN+?.J]N6(5[1cN+Bg1M__N;GCQQ&b:>.\R5N+?7\]W1dAJ^D?]6bVO
^M@Z(Q1NL7WSO?BJ4RN#OT71C8>e1EZ29Q#EfbPA/.=I1EE7/D_CJg.HHGIgAS#;
N=<.gB95PP_F=,,ID1(1?^3EE\_106_]=1<H5),<XZ[?4A/7f&X8Z1ZOZZS)9<7-
C<VP)<3eH<>Of0]?3B@FY_fQYe?\C>I<M9V.M\^;W3[Vg2)2P:>5ZYFddM&A]@[+
K(QM-SSXIMA0)ZF/(B>Ub\]<bX[5eAA5Q1NW?e1^gIU\>VcRX=]T1W\.34g(FY=0
=L21G#4d4C,e]#3=T5XE2_/27BZ+dP_./HF#S<M\Mda\2#7AXAT#<A&bJGW_SMM?
,9^Mf5W+3J5&8F)aM^M]KR&,IbBP,EU13[f-+G/LW9a)#9FAP0GJ-aXH1-/_-5We
,/SYUCPe_],W#geA+7B^4<A(-Q>8?\TAb[cM+Tb\=e]WB-9.abL-e\&X0(@DDgJO
K<)_G+?3OV@:_+BBe^;D5P?Db(B#=SceD1#9-#1[F?b&TJ?3-Ca7CRf?M-<&U5TB
XSTW>#g7++BTYa].2\7Q_^N@JKgBCQ&U[2>)LOg7GV@,9gI//<FKO\P&^\DO3V39
WG7+V_<Jb^QH9QXKYQX\)^&LFPTF]PbZ?(cBc>f#UaBAZ2dS4g?9]ba0f@GY-=20
4+FU0^=BNI^^>W&4=0AdU37.Rb6]G/],K@:UE/VUX:-A^(J0[FXW_]C2K#]::QA5
@,4&P;BKJOEJWC5FF+C1LZfZH^S8V>fQFL/UW^BFOL_G)fRP.&#fYe9Q\0f&abf)
]4WWd5<U^;\bOFX.-FUb1EbR[gV4.4GUM:[JMJ-[dNQU;(aR((YJ)O1e/J#^=-M/
9JV/V,RMcZ9ANK#Qc(gTY;30TYb:WEPd=,\+-LCXd-/HeSIa=Q1?6DHXE^T;R]Q.
JCZA,1GPZ6#.))KG1&IKc<2+CHfWWS9&^AI/R7ZF)&0&?_K0e:NE8aC7GcKcY_9R
=b@7_F=YY.,Q0>aMG=A_R#DWe0&O-bMWTY#B939[BK?.Ce&A_a+97+:;)=a54a62
M4HEeL,a/-LSOQ9I<O:\XdO&DFMb^d_3LHRKR._?YSO_NF#AAV]]YK<Xe[-6IeN)
=K5J0d^PaLU8&@PCORR[1c>7YF8^=<?A,1c-6._8M#><?YQ+P#/NU(<=3Ic=I]8K
.(0HT-D)ef?b;TXb/0QV/N/c_e4XW9gRPaAXJg0.?F,=I3CD(YLU_DK1eFP3XgKU
2CT_1()^Y4Dea8b3XFR\:4W=eCM+R[3/]dGV?:d9(Re9LBYSUR.+[TX/L0,H=4d6
F\<[f+\YP<Q+\]XQ.,aa.=]7R?>VgbC)P)OB0PY#VL_57-?61JBLD>ECX/M\B6Rc
8.0:.J>3./7YNBA&U0b>8:0QeM:\4[]QDYRBLgFF+,=UH>VLP,\8BII2\gXYUda0
GSL<1K=H\3;MU<CJ],C?ca,-G.OaX:RP&\gc\:E_FVb^SZXd/5>[JZMUYR8>I@1O
F8Eb;c_Y(e67JMPdD^(@U>G?BL3e83/edX84W^A-9L5eTI#8,M:P_2[e.I1/B?8=
ABd-#bT>L#0?d8D@,UKa+\5/0#Oa+9=QD[8E[I-&<+FWK7LXHggJXVf,,@XO_OO6
S/J7BU:-ULBPD+f7,5;<F;I>#,AT1B?E+0H@Z)H?G^UYP]]?7Y</V6bDSB]XI-[(
:a+=J\1/&#?HZ0P>Hb:IOb-#XZPT3J(55LHW@70[8J]8bG]=R(#;a<HMd0CONGB:
d8T@R2P6;]F,)75YZRV@,g]N7g)e=LOf]W)9Q4]QT<K9K_O^JM?D.[ZMZV4S+LeC
_^U3beN&MQM),JW&X?+:FJ+>4&DP##G98)eT7O?LD/gd3VSUGc;KJgg<[gC1YA=(
G+:-ba7FBGW/TZOPC1<B;+D1(XZ9ADeO227DC?8bM_GMQL->?N\:3<DX.NI6MC+U
K#U5I2T>)?3E?CCQKSY=;OS^^ZA&L4WX0]6QL&_0AQM(<+O9-eQ/)Z,84H@+N&=,
ZLFJNbBMYBM_4O;.],>CB)HcH^a.29JIIS:388;64R+Qg,b0F<RdG+8X@BTD#6b_
]dFcFSe>ASLX@;N2184We+784Jae=GYKDMF<K&(cYT(K-K3O2fL_c()ZPZ2gCT?Y
W:.Q:XE#0A)#\/-+0X=@G(R0/X-VV6U<+;f7]71Xf5+H;]\:DX.g0Q)&d9(^+3J3
>0R,C4X3^d6;&,SfH4EZUTIGYY)#,c-54L)=;7)6U<Q=SP??V9>QU--O<e<3^efQ
ZO[TXKQ]YF8N/C].4?CGb//@9NT3(?RN-SXeLd=LIQ2DM:aF@3B3R>C6<:X3B#c[
3c^&MAFM@D6Da33(AEN7C&&b1G7PY6&=]\_V0.[D,9P^8G)Z24QJL#=^ANX5GE4W
-;7V<K;S&V.?J4U_]bELeJL(H?S^.[gA-cRTATKIfPK9_ZCCT&-e,Og#NXWAF9ZU
B7N>_>A-]DP]6U]&:ZF0<,FY#-,d5d:J>bG8SCYdQ:K=IFPWD6V/+65GBS3,HQRQ
\8-_5LP0^E./V8X0Mb#,4/H0aB=^)WJ-_SLUOGTKb+1ce;:TY43D3-:.g<Xc<)dG
S06PO0g+@.(?S^;2#ULY9e\]6Se\1Z7K25EdNO93,FR.-RcP:I/,FZg&dI\58A)W
DPK3[EbKXKG)aI][-_bOJX#@@1U#@gKDP;H.][8(6EYSR5SSS7AQ^=\,AKL/T.:d
J+V1V6]4:g6ZUdE,/1N^+/J7QW]7YLg.K4#2=7](.L/O;8SP>#V;?RE<BgFTG4?A
fO1:3B5&K3R)Tg:R-+OSYW61G4F,&=3ASJ/?H5VeJ(=2Y9&;f#:HPUZ8/E-/dV??
.HT_[>+W+8Ff37_T.IA@E5[9WXfd5W934UNOG-CR\RU06gX.;H7#7O]SP66I)/9e
4Z)DKJCS@251,M<RSC^30BJLNP<&-EaU,N)BOV+L#K:23<E-.bO+9eZ;+BY;CS>9
83/SCSOL;.@L1O17S\&#:HCO7,+D=e<(,_MBCgc&9P1U-Q_D<CP<7-K;C,,^2Cde
b(]1W9_KgI=I/E_O^Y+[H^(&5)WH4XWHJb9GSQN:=I>43WN0\^89WDf<EYQQM&:I
JQTBRKS\I^J.[)\6bMa(QNE0RFTM+:Y6]c>4aR.OBFAIA4FDIVPOEB(X6+G[YQ)O
DQ8>JKN&,aQFSC5b/]T&.EKM56bf()J-WbaB=eH=IJ#]JJe.2Id2I=EVaL^AX\67
J6BA(=O3(6gJH<=/Q4V;3I.ZHN2.V,CW_O;_A(RRQ5,J+-;c)/6;<g2Md-a[(ag^
,P99@&V4F,4Q4AeN-fEffB+HSKINLN3&KK::D1bUfZ2D+<e=B@QSa69d0(L[E1dD
_F&^7[Ne+>;9TZ34fYB#Hdg^/J+X#+H1AF[e)^\Bf9#OR:Ya2Y#PLD4&^H++KM61
Cd_U(FJ2N1@Yg7FZC+I+5:A>;@Z=.bW^9CN9d=21[.=1^_+P[TC=Y<d;7I_W93VG
9Zb+85RKWWM:O:Q\fN2-NPBRf\].,gNC:HB.B[T5.X0B>YHBdS>aRSMgPOHJ)_:b
b)bfX+=ZC06>9F7V@Oa=^R)S18\OOKI7d691X35>=:G;WUA?/GdU14<dS;#6[(fI
bJ7e&JZK;.8\dZ[E^RLKQB^VGX:V-A.C>&<[6X&d4<+cM:72B:2+;@]-F=?\HeXE
X=b<ISSdg2gWRR62)I0/eRGE5[7D?6J.E:<=W+2[Y\HK@5L,2.aR/^e8:;,1<Q4V
E2UM>ZDaGOeZ.9^50aB81=/MOVf]8O;Ad,R-8=287TA4;:.-_9@9T39=K<&XcFY2
D2V=VG<Fb.ZcUMaDY1=LG#6(+gfGU(d#@5;Q=e^D:WE]8500\FU=Q)J,I.28O<GH
;C),9;8cPC1VT(aET#d]c-Re)ZaSL9-CbJCN<O\+T/ZE?ERX&-REgL-M#^?f+U>\
K_=K@X[,/VK<\W#Y1[MT:M0RR(NLadeN2[,+2,JG(-EFXF+&1Z4U\MW1B:2Q>URf
&cSIbc?+OJ5MKR(P-:T<TR3))NI\(MMecN?TFQBYO&&]3N1WMXO?P6[YY)DQ#,2+
D757L;LT/O&#2Oa5Rb(J_<B=g4V>g-fAAY7e;T_ZUVAGK.(Y<6CeYSVa3N[a&d6b
7B^;LcF]VYTeFVLP650_O;d2?G0aN<.@V@NJ[>]fZCb8e&cGY2?4CZ6gcf[(HA^Z
c@(d6,Fb5Q\4X)G:+eN3aNJQ,YCHUOC3e&]@b[:LC#g7TO,>=<@V-MAR\ZNWb)FE
+R3(M<@4M.3]U<A&D51WR9G+&6Y0c]KL=:/;)U\\7gXe?Kcb\aUTd6OZ;=@4^#2c
JU^2.L^_fd-Vb3>\7<<_YdEL9?Fc.+GfD(&7T@N>W7eXaYD@dU[aZ/(#:M9ge(ZY
aE)I]3EH+1IXB7H^_\J3Q5P_@#KJMD4[_S)4+/@fNBT@1(8EIT\a6SQT+-RFQdI-
OSS+]Cg^-1bcO5#=ZLVJ\g)cDaEg&6R^RR3P^b;@36cJGI,cI;(M][/4N];=J0B(
\ge+@Sc\^-4#Sg-bf?_YQ_F47:ZU#R(DfWDA3&7AM\M,EUU-4A;DT4:Qd(PTdL8.
aYO1/DG[a-F.#J<)8g8>[D_^EW-(P<M4dR<L2&5]#e^?Z&FD]01+IW752#7-1D_2
WK/6_4><?2[^O(JfV-NBa57(IP1IJC8GQ=#6Cb<52\LE;V:WL-7EMD=I.Ra6#C5W
Y=LP1K5[DNMIEE;9BBB:]8eIUCWc&-E+I<L<[,(/\ZS:-RE/O0&C6B<AUf1]UFA8
UPIW#@@fUB,,=fJVBLQ&g_B7+BYJ5R7L1R.T^X5,YT:cfYK10&501=NW:+V0)EfU
I0g_O]81RM>Z1gU_LX]?M\cZbB)=C)-VbQ,DfXAC]YF8a59PaUH.8_;-(/):25Z(
6PFT\ZBcSC//V)F=@Ld+]^RKP]cZ_Ea;C4GF15VKK5E?0(MPR.KU-S=X/UPH\Q_X
H>dI<KMP6g(0SZ6IXIJ>>H=?6Of:^,C@81(4QME&2cJNVQ,cC/OQC<]-3W==b^-)
I^JE0f<[e2M[.V\N3]96I]>_C085@7bV.M#OVS8]0]7d)+42\c[9f<R5C40dO+B]
ea>34QMH;UQ5>AD9Q\.\8a05)885+bB+L>&-@Pc0d>-^ce_-OBOCZHOFG\d5T_##
I:f05;0KNZHa-?G0M]T34EgTC>f-812>3;>3BMc==PDCDbV6N?FX^(3Cb@bdR[BG
K6R=&(^YJ+CPb];I/UP-:aZ_<d1=:]3N#S^3V,KUd2[X&A[W4CJ;PWgT]2aX]JI&
KX6,d=J.27NN(e#4_M?52e4,^D4@ATYb)LGZXOZM]N@1TN[0VINGWN)#]c,A:Z+<
GG,&g,;G89;C)#73)0OIC;Kg5,ge+8fJ>O8d?g11gZTNCBK4L6Z8VR-P[3SNO0;f
+<48Ia[C\E\fQ]2;DO+/^CeTE:;J>052?8A5D-9\G\YdV;GFG&I09URGRB-Ig17c
Fg@H;^<\8E,f?QS@H^gI/S>1^WG&Fd4B@@^P2:3<2O.J,]U3;7GRX/cQ4W\Z;BY8
#/;71D43R,QP/WWZ)XLJ6W)T-LUEY=7-UHO[VIfV).Gf3QA<[9U2+\<cPZ_c(f6f
U11.9HC@I62JW^#a[f5]=SbK>1M]L&O\WP?<-JIZ)HR#aJGf2^8dg&T@?2PJ@JQ,
+WPC9^1@\[M^)DC<TJ5=98NTQ-ee1.G0V.2JK;1O>S,UQ]3S4:N@\Kdce=D1CVH_
0Y,IT<N)UaR6SWS:Dd0/]R+Q_;,Veb?aY[EWV(1XRQ.[1?F-?(#6F<Ob8Ig4Q=Ae
-X>N-.H<8]KDSAVQGd/(;KA.EY8#-.CR6(:.f(7N:B_XW=gF=D;8_3G536,S]8(K
5VC(F6V>\LU-0RQ2I3F849T&SBJK,L\=4SP]Ob(TcTMGdCR.:BfVE=?4+:ACNUPQ
]0QZa-DcacW?&PL6BdHbJX8^BfF(?=-/>L-^(f#.PgH)VL7;#?cgF^2FeW)S\HY6
fE)9Fg/]5cb;UA7&ELc]&/^KQ?9G::UDL?gfN<\3KPTM@H#Xead7VaEbM,XW_RP5
]L#PNIHY9a@65RM[J7E9-AdZ84DMe]LU/+@\I28CNG;MXCB8[DR3N6K]G-gT+6Xb
@dNS,5DgW<@X-;G6Nb7Y#3NF>+WOCPH2Wd=DOS+M;BYHHX4E\=CFL,5eW5=&B5/8
f=8NaLMS8>cUZf,eVe6cAJ(O6N-WZC_,3UU:VN53bfM^1fM/6[bZ.A#+X.Pe,(MU
1HbdB#QZb3I8<T.6&C2(\Vb5TKZfO57OIR.P03SF1g/#+?]IEa\V7HR@IZG:VD-U
&c66<9N+Y\X8?RD_Va-b1cB_2RbKN.<cB?A?gX)>-\(SVE51W_CVZQY.gU)]+E+V
2@2TaaG>XF+3EUG=f&6@Y(OBAgJ+I<Fb(E_,T>:.ecN7&7H&Q<-#3G99V8Mcc^g?
[aN.cK/0N,Q<69M^.4ZQ?0.KPFQZLA5FYUP)e7a2bXU9AK]Xe8Md]QT6DPddaL-9
XJM.#2KIW):.[8QA7dWUP6-ae89=;BEKXJG#e3_Ef=4eR+M=);WOAKZNT6Mf=F.3
;4aYZAQA>7f]QJ78EBMZTX0R[B-<O]YFJ2B=)06&N+-6#\5SXFgb6^Y<T#^0AUBQ
RFKaWHT=4ZaSGXBYT^bH2I:JeOM9)f,A<Lff;^/NQaWZO6U(gRJ_W/,+e/GV8RW\
KZ.>8/]&U1TNJ-L#:dBQbdK25=28W+0T.f2?C5ZPd?R,L)Z\5],7B#K8NIeVD<\P
M=Q-6&29MTccHa/DM_O^g&()Na?B1TI4GWV9-gG7#Ja8O<3(?::H3K2-DV-Y+3KR
4T:ZE\;19H5B_2NReD,3CXg7eBC8[;T=L4YHMKaeMV[FBFCSc5I@38/=Ba,G=(Ka
4C?M^N0/PK-)^Q@X57?VgH<9L/6-GU\6b=7SA:KUM=B^4Y#7P,5>[#<E<Q&SHOA#
^27PJ0WMH5>.]bVX:b[^,:dVJS\[8GeY./J?N.?C\M1OK=SNHUPKC?Wb=Y<a5RY1
>6b-5Y.D>;8^5=D9D4_P5I<@705Z\M+b?=\+OL0bZFDE,5PUZXI+5H-(RV;1S>/W
N[Na#+5OYFYY4:U7R-0,4UT&IJE67=MVC&0W(ESUd(:E0-LS(g#(]gZ75KS(2#9b
[B:X4.#)F2B8@ZPZSO_2G4=-FGgbMRW\#@O5Y&1@H+Cd#P]=@MM+T]aSLBI\OXDB
O.EYc[CP^^^.c3HI8C=9^BgfTU\4>,LBOX7#>W<Y@HVga2cALbY3P7>5RN>028,g
ZI>3EETB62[CgI)Ug2[[[=?24d4U,:S5W9TN=U2T80ggee](F\PE^J0LU<HJF8AW
Z:YBe2\VJ(_OX21OB0XQ<eY)O2dDZQF.fHeDD7?ZgFZE^&WSTVYRS,:_?WHZ&CH6
dd3d;ZYe.CDR521gPAM-QP7Mf<X4=KBKT+S\8(a0fNOPa]VZ1YY)05_#b.0Adf&E
YYQ2&5@F(ASQL=__PC6L/GZT+I[TLB@_[U.bbbZTB:f@dBPadFYGLM^&O0\gXc#-
AgcaAe-0OeZ0PagBW7(3g8&9PHA=X;S439QZN)VdMBVY,6OJ\EWYbZT[+S(g4;+U
-;\LQ)S946H.8SA,M-AgOM=\6E#76A==5<U_[H#H(g5//ff>7F.bCJ76e)7:M&>5
c3KUA<e#Yd]VK9^DaO+EPZ;.PJQY#a5]=$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_MONITOR_COMMON_SV



