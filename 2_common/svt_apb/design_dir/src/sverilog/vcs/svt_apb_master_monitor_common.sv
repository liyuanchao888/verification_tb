
`ifndef GUARD_SVT_APB_MASTER_MONITOR_COMMON_SV
`define GUARD_SVT_APB_MASTER_MONITOR_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
class svt_apb_master_monitor_common#(type MONITOR_MP = virtual svt_apb_if.svt_apb_monitor_modport,
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
  extern function new (svt_apb_system_configuration cfg, svt_apb_master_monitor xactor); 
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
  extern function new (svt_apb_system_configuration cfg, `SVT_XVM(report_object) reporter); 
`endif

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the signals which signify a new request */
  extern virtual task sample_setup_phase_signals();

  /** Creates the transaction inactivity timer */
  extern virtual function svt_timer create_xact_inactivity_timer();

/** @cond PRIVATE */

  /** Executes the penable_after_psel check */
  extern protected task check_penable_after_psel(int slave_id);
  
  /** Executes the pstrb_low_for_read check */
  extern protected task check_pstrb_low_for_read(int slave_id);

  /** Executes the initial_bus_state_after_reset  check */
  extern protected task check_initial_bus_state_after_reset();

  /** Executes the bus_in_enable_state_for_one_clock check */
  extern protected task check_bus_in_enable_state_for_one_clock();

  /** Executes the control_signals_changed_during_idle_check */ 
  extern protected task perform_control_signals_changed_during_idle_check( logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]         paddr_after_transfer,   
                                                                          logic                                      pwrite_after_transfer,
                                                                          logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         pwdata_after_transfer,
                                                                          logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  pstrb_after_transfer,
                                                                          logic [2:0]                                pprot_after_transfer
                                                                        );
                      
/** @endcond */

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
bM^L5Rbe0-0M,@bLY>8=Z0g_N5fb)b]2Xb[K\AK?F&7#NQI0KOE./);W;-QgNAYe
RST)KZf/@Q3H2&\)UW&^1Od]HTYJ]TX?/ea-YRAJN09=QT:8OC.[gB[^f7\JZ&[,
#I4d4C6&@c79E@-Q1,,]&VDUJ))6BVVa19A4(=9W2MTDIS,5<I66V8=+T5.G2^9B
8@\D[b5cDMN)ARSDSd;#<cN3&:+&-^;W._.g49g,.I#0/>e2]^[^UPcXSLZ(9g;R
,HD65/@0,J3FWUW:4MGd#IL_;SMP=(.PYR?&gGBJaH,=N6/g:eRPg7GIgS6Ce9Se
cZAHB>Z+Oa3)Q+KL40_6f>[BCUf@I.L&O]>R#F>dQU&PbDBa]c,f44aFfcMg/AOB
][_STJXQb5b,[GScWb7QG?ZBQU[Y\VIDN)G<cSOd1<J\332G&,1L>\eCU##^-#c]
,L/9b^7I21YVHY+?gV10SYNZMUZU6-1d=[1;<dKgP(:T?>=MS(A)YX^[C=,\D-)D
B)QY<MMY(]G;;_D2^17L.(CR>XG.gA2X>IYbA_Ia=MI<He+QM9ZX+g:2D7Y^12SM
c3Y[0]=;/WaBP>4F.C#cN0F#O?6,\e<\RK1P0D,b&SA#CH[dcf1E/M(I._fJKbZY
&_Y2]?#Uc@C?F5-<bQB89#K7TYW^T@BQ27dTMW-N7b?S<L4.^aF_b9]5cX8f;)U>
S>gXBBC@DI2VAPbTAIJ6N>.3#<N=e;c=@ZLCGE,BF<UFYC1GU;^<:>=<IYE+aKf;
4-b1HfRJCU;R^DE+:#&.Gg)T8dL0H>_BG.2FJ-UbIM,P;R@N3Xc1::dbB(>\FB1B
MCRBe=B(C)8/;X[B\3&C,c&ATJ/.^gRHd3V(:eZ9aBGKZXT=4@]6Y^G0]/1f>-:R
Q_C#YJ9?O@K/+$
`endprotected


//----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
AE4Kb.&&4dTK8^2.743(V0THM/QDXd2V]T6?=SN/)Q7T^^JTf)?Q2(/]bc:(QdAU
6G0;K+Y;^06,D4g-U1DL&Z6SJ9Ha7;d7TdM(N]e4J:<P@XZdI8OJE2,7&_Fb./^f
)@cVB#]6O&?Zd5:=I7;<_Ab0Tf?WcB]^#<)D7-G(b_cFAPBE,AP5VQ3Z2&MS8SGO
c8V5QORDD+N4])80G.=\g]gB)[/,<4OC4SPI[A)CGfC7)7045Y2N=W75M7C+.V6W
_<7ICOCAU+6POONH530QJUP/@F:H0/F,27<>2YcE#8N_=VMDE3KD4JI^g?eE69S4
6R-74+-JdaKV&&5V[B19J=KW>F7eV&d8;Y7U+5:[GX>_\V.<F6c\E:=A]->,U&c,
V&4QG1W+S[8ReX8#<AXg>T^JaMH#f-J/f92UPL[-0316fP?a)UR7+[?@0bPX?N1H
92D:&2fZ_7^[T\DC\Cg2;XIZH:SUJY5:c^Ya/LM^UP-TNG4)P&K?IA2+R20EMKc4
^2OFaU=D@aNb4^#BXG9HR5Aa60Kb7#Y8INY8?4+G06PQQbFFe<9L=GO#g5_>=)g&
RV7J2,O.P224E-5<V]@1.OcJ58F8aN/c1WLNQ>daL>1f02LH=\gN(#De^](e3(-c
\aTR\R1c,9E)+N(<4\e?\dWd)GITg)BgO9dYadK/OPJKbbGJS\4Y[;UB2e,faUP\
[VSPf<LZHI/fG7T_edY-K)a\N1D=P,=]1L9+E(M]PB.<aebE&2>I=C7M91Q>9F2P
aS1IC\<a^@.]+;e#_E62WFd+KD_RXW==IcbSXH91+g5D+T2HNED_LO=;CHRD8AE#
A20@#.IKbAZ[KYd(48d9,EFP/S<9N6^&gN(g4]Dgf.eFQfRQ^/3TA@5gL\SJ-^UX
YKBN()b.SXCS;J+@TKcAEc<##&gW6.<?WHW,6=8#JH4LCOCc?T/ON).XHMD^0Z3>
JZN(g0f)BceF.<[5=)c:96Z9A+W6++(fag#=R\@SO?BN2W&gbGWSOV.a]MfTE>,/
<AH#g4&(#E3R,J2d6/M>&Q,HJaO(Q^ZSL\[)8Ma&,>7gE@Z(R69QgbBAC-e#b/-L
8U&+</_0V.2X]T&KR6[fM=??^ETdEW\O#VR<D8RPR;b^8N12Rc,K9AX=-b,(/-Tg
H;:?<D:R\>8..HN^4+fRL/Ue<BN3PGg.D0[18V7,3OOD)P:)HG&LLC=8IV[,3\7A
26H75(?)c[?E6,LWZfe^Sa=UdeRMc@3:agc:NXD-C_27DW,ZX8_-Pbe&B/HNR^JJ
BDcb5<@J1G-^be1V2V3T3MJ7_Q:Hf,-WcB<f_0-6?^+:8AO7D4a3<eSWN4K;dH1c
/3453]HNf/A3-.-_5BGO&a_X]DL:/)(e#2CFY/f1WZgD:(,a_#Gdd@KCKR)0DOHW
.4)EC^cc,4F-&+LP/0IC[OU#CRe<;WQ#Z7Y?f5.Fe32A[E_2\5(((-=\33Mf92PG
-/0-VI<bd=.2@aP]b]N<C\I:d9+;/P0EdIbC(V,1Jf]SL.F9=XD7Z6cG0+X,F8B<
.6_:#VD:@8^2_PJ#30ZS+K+9MW#X7UVcV_J.f&1R0Z,;ZK4?07)Z/+37>VE8(g5:
2LcN3ZbPeaf&.?ZXKC^gecS.7fU?TJ@^+caA9^0I5:/B<^V5U1e(Ccg4Z#C&27)A
XL^?XJY?eBXDQ)=,SW05.AYLZUJ>gSe1VH=.GAI_8(Ne0/FDK&F)TRKAEH-^5>2Y
IPHa<fZ.;M1G\=SMU[T_dX)?ZMO0,MME+JL(-d4G/SOX@>b6bG:06F-cR>OWWSJ3
3/9WHcPG?PC7Z;O;2Y.WV#)?d@J#@V?J5A&fd+C&eD>]84GZ2ZO9Kad=24GR]Qgc
6;^Q)]B[8Ifc+/53eK5bVSdP1>3R_bA:@dfg2]G^35/K?a9Y@7TNU[^B.9_+@36R
38BD?+MP/5SeOCA]Hf>)XC7bS]V=;^\N)ZPJ.XC27VY4AS#M6-fY+],803_@NV:V
=9K)A[>]c^^6[<6XC1M7[GGKVWgV,1NNaB#4]R(^5N5X:Bc-TF1Lf;]),23Q6IU1
2dQcM6#=:QNQd)4UPbGL<P6.O2TTFG_5\OV@77g#O9/ERFdf__g8>d8f6/+1\E.J
a[5I/OVDMgOb_-\591Fgdb?=cIUCP-VH4:a#WC)CdA2=SU\B6Y]YJcQLS638L_G/
/IXS-Zb)J<RUK:6Cc.\8S&RKe:Gd?_E+ePgXPBQQa>g[+,^aT7-=,+7:fVDDBcaE
J3HLcdc/cb9-]Oec_3B5#UBVHS4@JC(+LNT94C&=[>A^SMJ.,OOCQ)_YUCW#<e6e
2.<Y[Ec,=63R\^#ZI)M394R:(3?P+Pc<V<Q96=S3#Uc4)5(?\YM^;8LQ+V)V_H_:
[:;#>\&MEPNeL<O:Ud[K<BMQX7@A)e9SLV,b/I;SX>U7;^N]#S[5:Z&Rc,_99UgH
#b]=>4.0.bK76c[:UIG6_Qb74/6S>4::L(.8\QFV6/Q1a5+7W?22)A;OG)NY07H6
BS>Xb;H?10?P[e=-;a6fRF/>G;W(bQWU3J4e=>V@KJ4F]=^_=T+/@R][@bQ0f\0e
8#fAX[FX;#B^5g7>R-gWTFF_AY<CO:6I.?YeUO\eR;YJ+OJE>B;LW6X#@QX\TJ/=
I6G^74?:E&WM9M>JQ&+)R&05ICSB8,IYe<#:/cIT1QUJ;,X8V[/2fR&dL?:N6GcC
M_F?O/99U>)g0M)8YB:5^RP@J6,&e=QI/PT7N;[@?N]OEG-eRJNQBJSZ2>cVBJ0N
V^Ea_N3WF=:R^Id&0NT1;2KcFT.-(Q=I5C598@]c^3[MHTHW03\A,;+ACH.a#6AR
JJgBR8fY(/McI,JE7CFR#+,B4)c<&UU?94RHd;(D.GYF#\0XEa57;SD90K1GIG5c
K?O-f^/GY(fSfWW^bg#]-g8-(37\gf]YJ7LRc3beD:,]I41./;F?P^<8I\(K).49
#NE<G01fJON()S<RgMbE#ZQf5M,g>_H5JQZN?X7PFd:@Bc-T.P\J4=&J.G]Ze9M-
VYQ:X4UN1>&gV?9ATZc(;/WZS\[>_G.-=_N+8>#]J^@b7AL3g)IOQ^Ng?JU)>X2/
V,PKe.4\TH;E:]KKGP4XG_FOJf7\G_]#F<\OaZ6&P0_8>DgSFb4=#QgLIVI2JV_F
\:fa[/8XgA/]7=B,38dbdJ9K;:b4PHeR:N9-HXG0U0J\9/_]aF\SMPVV,T[^?X4b
IAbOA6fGe-g7U()]57C-.E3R4\IFd=>FDNN3/]S[ee/c<J-5VF(b?X?D3eb2PY5O
\6)@/R2UZ76bWN;B;:b9VRg9&2(2<VDQS69gL7P0P]S;X3865>05DX<IIVbfEV<f
bA,aCT\+<WK:+5[)c56/+O1CNA<>26);4XWb6OR:JULZK5=D(1_C9L+Tf[<]d_6R
Q\05G(R@68\PY,UOg.fTA&bGU=RAFP7US2Ze4b)AK5-J9f^EfK/c9]dZR]gggRPV
0IAK@>+3Dd2V)S<-0>;<3C(?XaZ#aJF6J>gT5RIW_-0D>2&+N_UXI#3?gDc6P4AU
0H?N=bQ1NaHaA9IUH#,JIfD([3Z?ARWEL(Bd5QF1/6D+Rg=6\Q)<3-[B(488Mc75
(72:#W@Ha>>4\Z_2IG/T]D.I/ZE)FG-K,&..P8H15;XO\Z2JPTL_5\Pb4<&OPT,.
+TbeX@ScM8ZP,2bOW>8Y&fBaFbL;d,]MKZ-;AfTJ_g[[SM2S##XNaH&5<P]AWNAF
)acaD):=T9B1,&OCX:U@gfAFP5e?R-H/?fcSBJGN=W&.]SbcQ0NNfJH<7V(cUO/8
-9e[bECW.;g#M-VNX2-=1&5A?+:eGRf_f;.A>5+?g>0gW,8g\2&=e]Q:\M];d;^W
K\9/g]SeF3K>3S66N7)=^M6O:5XX.@&3bF=DRIKcKZMg)]C0T.>@5Jf-I(V+@B5(
L-3UZ/,2.6#04]O/.ZL[25f39I<)24b0U#4UDA9c\B89D6P+AYH^<-d^KBY>331A
XST672\ceVfg..V23QGDYS&?419CdL8FP4(O6CD-EV9&&-C3WW/<.3R#G^gIM)NO
G/MFY+RD^Q8U1YR?:Idd35U-5OcRE]QH#d+A(\JDC=#R7XD/IZ?3NRAQW1QebG33
:1dF#b:MSN;H(;/7X,RCD11.93<KQ#a=#/PJ,N##YNdEdMaWAZc<:IDFAF)HLGU=
>GP\JF/].L;SQ#B98RZAPFb.N59a0+]N80c@f3=V#b5NP/=4I/2Wd,)<(.Z]V+&_
JJDOWY_NeA7?9,>eUVSZL;Fb\0:(V3;/RZKS)c2WGEecM0:e9-L#5/dbb1bI+9-f
UVB\(L(3@)F>bN?\;^B-^GIY[De],5,UfS]EHRQLCK:&TMV9F=bfHS>JD)@G-YgG
]X4JcHg=EC0O,0UA6d8RE]cFA5>JYeF71^Dg9^]#32;/@KF976TDcP_KFF1<Q?0R
#gI7Q+^W]<.)4S2G4N,?)7\2[)V//E(_GeDTbfR6@8EF:M7bg0c.c@0g(BVQ[M&_
dV0IORf?G:;4=8_>PMQ-Z;CYKTfF>/V:>>BIAePJF\W42P#P;K_/^WgegDY?#E#g
&J6_d7G:I?/;1]URJ[3PG#+@>5TV[S8&TUcQJ:c:12CH_WQ8dgI,5>7YQ/5+1K#?
0g-<==2[+/18KAIL16B1#/<WUW/WJXfKZ]<)YFGbRQ\FbA9GJZUP.)VZ7[E[;[B6
.H-_<+B/6R>(CA=^GcI1;H)I15U]f]EKJ@1,&(QJ0d:_WCdZ.O,4U)?0fOU9\N&9
YY:JNc4<]Ga0+IPe67<;9^R6YROJ;T.JX;;f3BE\1<^_(dP;b7)&[?@SQbf,)J7G
=JYD+>=E51)L^&55U-5c.^M;4&8M?.0U/7</=DX;]ZS9Le8SPZH>a>c,8RM#P,EA
:R:U1)>/HVd5&B7#?2);&dZ-\fFW?D]H_7SZT<[dWd[[+EUHHS>I[N>U/?XTIFT3
Qb)VHY2-f&dJ&W.X-e+2g,Y-:KMJGBZ5MeP\(<=/<FK3N@0OJ&.3+G1U:dC[52_f
H0X,^bX/1-^0dGLIAGJaFg&G_8cUKL+S1MWU@7Y4@8N#RZK6U&C\N8U/ZBXFF[VJ
WE8>LS_0TR2QFK>I5SE,X^:;&DTQFX-EY/J1STF:;70)aPM640>-[+aacNSZI--[
9][17@SgCS.Q?[D9.UFf9dD^R3,6OC/LA162H-DO1>1S04G@:d2J:K@KLHbR<679
+CCC+d>gM/aR#LE;8g.3.YZ-BQ<gg3(W\_@_;gUB[MXEE0Q,ROaAdB/>JS1W5OG.
ecT;V#7B6]1P,[3(0?QOA0Z(#E;.<.PQJ]e1e5ZQLbAW7/]Dg-HY6_:>W30#.,FB
?#^O:7XKBBI5H1FSL9T04JAUPS]&O-+0<3W4.)@?#+-X/:a0M@Gd4dePZ>:&F2\D
Ba5=-1=FXDW=H/E))HM9^(J6g05?XIgLR_PNI\)IC&XEH[a881SRRcXVE3HA<5gN
LS?Q55[f-AN:78@J70&JRHED[cWb7cS@4LQE7E9BJ]H.c/dcLe#,0[JU;DU=G,)Y
Bc(,ATbKUB94CSGA8LDa_H3-(dcce##U.>1[eJ@R6LMFQ6CC.fR>]M?<=M@aZB/[
E4@UY(TbD,E6YD^HH):)G3+(b-Jf4VE74R&E(e.I=U=(d).G.\6V0d/\5A,3bL@5
P=I+Af166@SEKM=M3Tb?O_7?g5-2>)^V=,:HdW:,0O6J^K5;Bc76XTT+aN0.<&U3
R@V?DVc_g4/a\H2=J1Jd^fIae?C5&E#K&69KPP\0gb4)3FI:bHg]_RaY#_?0Y(H4
JZW;V,0304FZe/B^42?fGeI&+ET0;Z508#M^+-=30M-MK2.?]<C,H?#g6g9aAK)?
Ve_OSaG=/aG4T&6IL=A[8+XZ5\NFSS>4MCN@R_VgLE1VU9[^2^[3Kd6<cEAH\Rd^
@QBdb<&#ZJ)bEFY@K(G>:_HId?E0=9(,QYV>YNgL>a;EYLc=_g59aEd(6LZGX#>F
fB.+eb.cg(cKEZKKF[&H[<):JdF3WVOd9F@A>5:(46S=K]]X,7&5\AM@-+:2;?)@
dH=9&^2KFH-fL2;a-G+3#4a,+X#2P9@)16Q78=B2RgT1OKK3O-<OgZDR-<[F9EOR
@?7M(Y]K0+FP/FSXRCJa(a[1Ne\S\W4d2PSQ;VM=3VI4g<Z0.cF:3Cg;7cVSB)bX
YFG/+@FTYGM/HQ9,?BB/g[B+_?6f8f&(XOO+^g9KWbSL7(K<_AdZ_SE#V5405+GR
5C#IOG]0APa=a1:,_ADI-&MCJaP=Z^Y#+&H/ALAPVZ(+d\4DO82-3F:.feD(.NU-
SSOaYg0J-^WV.eGM#;T6O72+H<(HFC0H?]AKf436)>U7-dBC_VOU=FUTR:eg?+Wc
1:D-U,[6Uf7A-Y+W:<SWgRLa_4GVZ=.Y_H&;2G_H9c@\bVaES)++2=JaEa.>C->A
1H0J4(/G7V0^De,85Q;>Ce#3g=);C[e#KFVJ#AJGDZR#,YfYF=8E_?P:O#2fD;(_
<]FfO&O(?,)Rd9MEcMUaY.LFXE[OA\98Ob]@[4&L>C,2daD//E1.J3YCT._LGPGg
29<[>))@#CSQT^f>agHY]cG,AfGSL2=?d+6^aW&Q6eSP^&\eLWL_KCY3.KBYD/Y]
Y>b_1;^dQS/Z&Nf@Z8cT9>))>X\KND8(T@8_,f?8S+#@[edcL(^M)Xa;(DZ7>YON
aZNF]/H^<a0#+X+6[D[/Ef8,2]NB]J9=Ad;HSd^0FK,<;3&O-U8)06AMWB4-eZ9e
8.<D1VKW(&5E,7P2,]X,,ffRQMTQ1#?HB)Idb7B/50,7Z:c9QS5Lb9.RQC3=.7?&
aG@(T>[9H:8]=Ae\]G&Fd:HFd7T-&gBG09@GA,Za,SaO;]cO[d79KV(HZBL4N4>@
+(//6[8<JLM(0\UD/QIN,06Zd.=)?25e_G@HPKVP6(SXH?9fQ^L=@cOIK\g@8HeE
4PgZI2<@3>?81WF2?I]aSa8?[;W=FFS&AHXgDOM=:M4(N>.:Ra\]LL3^/#9TfJBa
a;]b_OB^YDWQJQB)[RYZ<4:;#_cRd2\AZEB^NO5geRE?H.(JI6e;G1;RD.QG7-.?
^UG:@2XB0SLOb1S^AGC=IYRHZM>A4WYH27</:MPK)V2fB/.=@#BYeT?@EYf(;1=d
)&9TC0CSd<O/)6[2=,9<-\/dNZ&/NbIL?#U9LaA[UC?C0e2WHf,^3M)/fQ?M\-R[
TY;O\O(>9a__#1X@/b(NPWG0;POUWO]G9P6:O;-0f)8b4&_F6+0XDf6)^YU</36&
-0IYLZPFIU?HgV4QOFF)NS>0b>.,:TFg0&#-U)D^N]COD<>,(,DfJ6H@U2N#LUb^
/HNJbG_QSJCg2HVDOD@G/-S=[56\N46f)c])B^H(WUBDL7(_c2H.g+&-4O/2QG1g
RC@e@dN1:&fUB=96H(87#ZE])P&PK#A2:8@OPGK35:DG)8)3a=;d]4X:+;>[V6H,
OGC=Hc10J+\,/f1b?+a,3?0g-&#3S^Y=O318V/=Ea).:B,OE6\0@>/<.+4DC;YNF
0:-BYNM<[C+L1MeV50H]BE_VI?\Se:A6EOEE?5/=/>,;_a+C[T670Cgfg)UNPW-K
P94^PTS_3c91OLUJD,?7<8:KgXQCbTZV,WU)H/_b_T:=.=FEfH9Hb/6?&QQ(0Z+W
,3WB7JEBO=d?@_6<\a>)UA+P._g8E_/2RZI0PA9ID(X54&@b<SdX1.8??6+^1&G4
G(68JO4?J4L2P#[2YeH0_aFA;)7cWPN5N]=/?U8L)<BV:DCFd:Z>&\+D^,)4<\#2
=N^bfU07A\RLPd9;ga:KI7dUGD)^LB.<\+=V:\J\6Q/_ZU/)&:Ba]\Eg)R[g:R3c
+G<[9+(6?>(X(Pc2U>#[?ALbJ^[;#AF0<QI#cab]Be(bb]W_B1#X6CP/RTK,IWPQ
[aeX,/BEE3;V@Y]8:>TGX783[Fa?7+),I(0[&+ae:J7A=bI)eMT.^RQ1F9EC),0-
;.Y<2\)LAMNJb_aE)V,?ZJGTCGGDT-G-5Hc7G\4F.&2Oe&A^W@1<8fI9GOdO[RS:
4+0[LT7Bf[NbG:&I@_2S&ENc1?<=(M8D8eb4<GA]P7B8TD^0-U&)0W=:_gOQU91D
7HGX_,Z+_4:]6^b@H:]F<K_NJ@K><,E([I-]0J_K#1-YU1,CHU@@O,\a3B&4?_:5
.X6?3B3-?<eZRAgO0#,54G-1UXV^S@HR#_34_L;RdYd4:BFR[Vg&609^R#CSL#/]
]:2D#aD@)eU5Q=ST;SGaPHgA..7/M#([Cb;694BD)M-,@a_NAN[9/]&Q6/&f6LOa
dae8d7Xb#,aA_eVTf))<.f]HMPL[C&/Q/bA6f:#c>TeH[/N<7a)>?&,UGMRHL2#1
e2;dS)P1BcAC<F7NNM\Y8^.M2OWU5Fg>&(@40TER\AU[:D:;&=VCQ]73DF6-1O)9
^\@M(De+Y22+Se_JQQJ^V_CKDNNPJ.gF6G?\a#e,+LG)I1aZ<X366,&=]+9a,A?&
a]Pf15C8X9C/47X+a\g@/DBa&c&OB0WGWV[gIRcS=.(0b#)(N[_S_YH89<T&Y#H^
-IU_g6Z4E93KBUQLUF0&P,@.O[KX/>N4faBWC.X.a0GPg6PCW-[@AC3SI122HHK]
fZg5QY#9KG,A1WBeI:da&L@aAZg^NE>WZQU+T2/+FJ8:\_?G;0KBG-371dQf56PI
6?K=#^ZTKT@9X+85Sb;8C6KWe@-2f,PA21DY9&45YXJFJ592_[R;(aJ5=CCg6:OC
C:\_BV]MY76>C\UPLW)H)K+B;56S#GdOSKe)\WDUBGP[>Q1EI5R\-2&b^PP>./D:
,KG/V^:MJG#MR91.Ofa?If@=:-F#@0G>&5<5341d^ZOGWHDEIJYc@I@#O<_2-XCU
1d44W?8bH?X3^,e)UBVc(&Qa5+Ae2I)H6ABKAF^KWY:_He1cc,,<)B-KR>FgBQ,/
2MaJeX2<7O+,<[7NZUL9)I;)8^OLD@IK^0C6_Y_5^U9,6T3;,CM<J.WY4ESWg;g(
F<1J6dg.AG[[KA9ScV=>+TAcaVb#SPY=;N+>Z7_E^6;W1\@\<6X39ZNT]0EE.ULD
gU=[TgcTF9JMU<SW>R\E&T<3S:D_PMH,Z;>#ccZPV\^9[/FB#g358,fe7;;)1W.:
QNPgBOT3R>WG/A0Ta+@QA=(NZbYEG+O]M))-Q(UFFI<aEG4<HWMRVMffa^Fg>NCR
WZ-6U>G;,0B]N>D)?.ACd@JY:.>PcDUX+<<b9W-D=-eCSdU/3O&JPD.Sd;N?@DfK
=KFEGCHU+:\SfHT3CAe]Q#OA=UV9OgGM<JbU?J1(]QHG7fAgC<4Gb/d8fWK#K@,E
,VI+97?]2R9e]R-QOe@_NeeIOADMDY-3Fbd#dS@7Ze41&GXW7UM)fXIecfWcN512
L#(W12M,@7B@eaF_d53O(KSeUb0SKB2B;=b^YN5c_LP9[#JQ>IB]:PP3/C\YU7D.
G)&2MLa9(3b#BcUOXG?>-ZDf?D@d-\3MBXUQ8]e6/?\@Yc4P[^5W3OfV>/(?:SQY
KBWE\OI\8>32,?^J@d7=GM^[ES3<&=7eZJc\&])bK^CFGP[-ZGMK&?cZ450.F@,<
8WM@\+^+U7++S>^370JZ;GWNTWXFd]=+LgL,3#>62GJ.?>gH;?3@XDNC^G3c5CX1
G+DS569J#W2P/IG-P0I)fPIg/K(eT2,;\EMcZZG5aPJP0AOf?V7I+C/^<QSE9+b:
WS\:M9bZ5()bY#3eFOW&-&#+A1Z_R&71R/M2IME^\I-;T[QBHa,T9(#4Z)RS;)F2
A^MV-(E:(#c09XUC+P5=Y7/V;-;(X)2W:0).>>O(5\fH=>ccE;^I.e])H-D-Y-J.
\5=RF\SUe>;](05&\EZ4TP_FQ-[(WO+;dL>cd+C1IBgQVZbYA@Dag-QV5BYX9I&)
\9M24OFbZ]9H@J.+<LNTYD^3?SSQXRHI@+@V+_>MTH9LEFUMOIa3_:7@EZ8g,O-\
3D@,A=>P(J.Pc9ZD8J=YQ&WCH8^Ra=O3X&c#,XdT4Qb02B112A-;Q#\?\b_5+QVg
S?>0S,eeAN&RJY6Yd/1F4YMa]6)8QKJg6NPHEIQ\K/BM8>f<dS?_KM^bI@T;4Nc]
eJN?U)TN8?D.?+]S=NM3(,-d,<U9HZ4/3-WHJ];1#\Z:M7NWCPJT<9)9VR_H02bI
-B2YL]g,;K<67e:=00_\=Q.E1-LPgEVW;=AH7(UO[=Md.=edJF-fC0386Wd_8]Z5
3LMN9=9(bK/BVb.MV_2RW-Y,8c11B;BLY6,d#>B-HB>>O-<.YUWTN;)<=9^f1)<9
e6O7QeBeI@LQ:-#MM56e\>[dKaEVY8KVRT(K56>GYP2>Le9OAbS=APE5\TH<>;Z,
IU.VEIP8(+S9,E(=Y<=fPQF;\(:F?X<#2=&[);0?.Y6@@#)R;7)SAQ<WYEO\61(M
^Q?4BXOQO124O7GR),f=ZM,J1gM\[GPK,K\c[&TRX/&^V4EO)/d_LeD7D=>M[.3(
cfC,,.ORSa1/NI/8SeIJ#=N^ZEAM9DeN4]0d:9Bc4TI007<3BTO/EXNb^gFeO>;W
SWCDXaUY&:#cQZ44)&:O59fF3>9>7S)Y\>+,3/<2(LSAG?,2Ug+H&6I8f2PYg,YP
W3IEMdL6Y.;J/@I:0(N^0T-SR=B7#KV?S9#-@Z.&DG:)>9MGJBF5ZLa^L2K2G[+Q
T\@]fA,f5FWF3^V40@]M?Fa([=:<<:^eN@eF\XCQ4]59W_(/NHFcBZg/VOA-OX(T
RD7?(/D)g?f4/VF57[P7EVd42GE/G.?I/S-Z/Q?84T2V7IZN.ZJ#9L;1#dT)AP?d
4VS?TTab2J:YM2VRR8GY9QZ]L5MT@&_AUU.CI@RIMROI7N\b@]X10)X_-g>2]KfB
[bJS,gGCO3F(3GAF0@?,1+PWI]TTcJ/YXfI#1K;)IPI2V_:6Y<8RHL9_>K23.JN7
W;T2:3bXK1-(P\,=#Ja@+(@O(GDb7^DA4@H)KF>fZ60V.=TNR6[3#)]I+=04GTV_
;1@Q;M_bJ^S_4^Aa<>M]BbT99_>eGHJZgaJES1Y\)-/;):RV#Bc0K3JPW(K_#@N&
EF55F2ZOZ<F@X9.3D[>f]^+D;)YPcEQ2#Q:9,IRKb9T3WGGd3bbBZ0P>R6W8A;I[
9=W^dZRa:J8#:]=K?BGL/DOUUI1JFRPI2;=Zb?fP>AYD2=^D]aggJ[AB^1a4e;@K
51<;@\6?;6(J2EJNS;2?ed@eIZJ9Ub@((2\=82P&J^QYI5^;>L0SS2<e?,.5)[BS
KK^CScTeHVce3HQ0P^,Q@AE(&.^<T1K8c2&EM+,1BDX\MH31g^a=V9IMfbSe(@:/
(657#BIEFZ/J-G)&aMS7P0;]DgU05U];1,DbP#LSK?A]Vf:(Bf#C)]Ed4-c)QKg=
2f2TH/DVfOC@@G29D)W@T?Xd?&B\,dD]N9D7:@LU2WG124U6.=&YTZO0X9138cS(
Y)_UP;Q.)U)WT6-NM)IgWVV;PO61gLY;96FVA5NXD\^[^[A7&C9>X&4Yf(^9U)+M
M(R]eXI;J;FBM<0CRAYU=;A,(>9W34KaeQ_N@O&-dR7/GUOUB&#+B<#c\?YYdXH8
gH)0SK>CIb>9DX)ML>C4ZG1<B:<3G3g\g.-W42IAMWG59\Z<5+cf7R6ZBWgGbbJ<
&e+WJ_<.2DVeOR^eO#V:-24#g,C#V#b,>ORCZTU_PY2(4CO8.\SUE7;=<?@=-\a(
OYW5S4,KN7&2e1:BC42W7?Bg?Yef)X@RYE?aAIeDdCECK5<@eE)D8[@8H(\BI7M1
;QM+HfX?_P/&:@)W>&RYb_CVC8_E:IMceE]JGdMc1CbJP<O&-.[6NY@JBS6I8PaS
HBcgZ/E/;^,),cW-R\=I^.ad2aSJYeS4;XWMCB06+J]A9\#>=0)(13EC07P#da3Y
J6W6#g,^KK=(Dga?5cQ8L;b0SXW54LZNQcV[JY9U&FKJ2acD8;X1W7ceKBP#9F;:
C,)2#Z2[S)OR[;>f\<2KLP.egd<S]4+QBD0X]2IC.dV1L6U4bRRY9_^1L&QW#:_S
((e#1ZOF(I>Yb=Z#-L.G,<Y\eEL(>ACeLL3IQA(K-DNOU=b<.]Y2cKZW^[.A#@QB
M/(>BHPeX+>#R=fQFH9,[^<f.#7FK069U2;aW,Kd=O9BcB)\#E;9A[.LX7RC2e]R
EBQ53CdJP:HD=\<gB0+NGH5KHaO7#NYS4/U.aT6d==G)TB^gE@4C?G,3#\1AM^Z_
0F>9M[E7:^PfI+Pc9BBb_2UHRG/[<c/YN6W/M53JL._MJ@5M3JZ_0&1TXHeUdH_V
Qb2(&NA\<>WAcM<H#1gbd39aE^D[6,SgSJ;:W.&R_D>KYI.BV\J,54O4DaKWX,I\
Q&CWT3]X_d3M;3>YSMY\N&a7PebFUSM@XW=I=I<3N+g]<+a-67X^COOe(aNObW9:
5:C_DG8]R:b:XXFEQe8LWd<\eOT/HSGa]6-c01e508]P)=AeJ\:=OVZbA7,IB9GH
;.MeD/TR=\?(caR,H</.#R3+@fMMYF#:a[;1fCPK=G.KX&@#T],P5U?ef,OcBYZS
N-,,(7F9JR=BaE4I),KF<79?\Jc6\FCJeVTA4[\ZT(S&dgKD[EWI5X#cM<\G:V;@
Q1HG.\=+@)f<aV_#9U=YgG8K=YO?L_G\Yc+G#Vg31U[+#JVG3YV.#+TT9R&<G)Oa
[<F7\QcK#3(LF&>]Y>AA5D+ecF,^&HJ;Sa;D#];=JNGg6LB.^<b4]b9;H7)G]9Vb
?+&7_e.VYK5@R^A-]1^_5E\fK67@MJ5L,.^25L=<;f]X^+-5W>MOB\YTc&=,=Cea
Xc5820d6W+K.WVLbB:/NW6,U.JZZA1(987L_?AAA=C4O(W7D]E#)#]7F[QYC>3M;
3CI[CdA(><:UJ@b<5XKagEI@<R-eE1A(YYA5\--bDSXd\7-A:7d=W67]7<5=bH23
:>@)8?O5g-VAPUV?9HJ)#]W1KE,6K0.VRFWWY:X6]E_G.bEVVed]fe59Cf1OV]J:
Z]39(N\,0(W:\]_FL7_<.GS5&OTN&8UeZHOUE+BJ)=TI=<?7U\\S0Nf7aYH]Y)UV
:?[U:#GXW^c8Gd8d^)eZ10FbZZb8C+.;/=\Ad[L(H.?93M.f#WeR6518WU60;:KD
Z@UJ<=Y9Ydc<DT&I<03&?>-NE=>CE&B=bKDV[B.E),N<S#@&^1T@K)K#NeEQcU@P
P(T(KF#H-;-Q8KJ+Y_7,\CRYI4R>SFPS#fFX>)CD/_T2CbVF6J=TV#e7>G84=YNZ
O=&D@.QdD2T77Q3)HP\e0aO6X1QeYG?>ZFM[P@D:cTRLC1+MQG>->8A6R2T4(H&C
a>/=X6a&64O61gIb#>?g1ODSG::9gHcb9:ef>+:3X]RR?Qa\J6d?#H=AG:e[:Ua@
/Z8Z7/8#6LF__JgI^ag[&YC/51Q8E(.XcgRf[6O++bXf]Za02Hc2R71V:#VgIA9+
T].=98W-V1V-QL00E5C3c3c&>MA;V.=c.0CA.ZW#;H(;8,6X(2V2WWGC,bV^OT.b
3C_Pd;<.?0F(9)IBCH=D+#.8;DMKR7^NXNR>Y5^?P:=+GIP6:(H19Q3<gLCa)SN+
\>[O#f;-Y]g8cZ-Vd/]F,e=7T,:PF6GQ+c9U\W(W,XW6]c;-ZDIFagW0/B:IQN^R
<Q\Q3](_eMDQ\XC^5?(0G)?<26P@N<\3,0XB0=]f-bRJ-EWJX9FT/gPg[[2-4D]]
bMQ@Ca.H;N;P@9=dfBbf2UBc-YR-M3dN,/P9#P1S96;8c1))RY[[O&491GDb,5?:
I0CW.+T6X,&M.WBVJER_UNU5BXIXG@Q+:4)#]=cW\6P?^Bd,:C@_,-8C=D\[^AC,
MAP><>4UL)21=>/8L]EM08fWbI,/,05JEaa6c5LTL_5_+5U7M+KJ65-_U@U))?8(
)U4KA=(4X_JPbZLZ>NdSBQHb\)WNeFPAMOUGdV<XMW,P+0&VK)W5[A\5CIT+=83@
DDRH-JZG#DVdX)&;O>?5.#WB2dECD^>QR]3(YeeeHB?bFFV38<#@,1fMS7[d?O_#
U??S?@2U;#305T(BVPHdKG^f372])96b#>G16N20,#,D0,T=fbQ-XfNA;f;BVC\^
PU1,d(+V)[Q\XN3,T52\?^Wb28Z89L-H,a:A?a7<MfbGFQEeF4C9:0C11Q2eEC\B
V;H84-.+eCHRYK5)a7fa>(@-^KJ/gFE<DUfeR=EKVI8(8-gXH/4cd+f[L9-?^7gM
O^4(bG[fd/#=2X/<&KG8IG?A.HJLd=TaYRRaSZbU;K=Z@Zd1T,H#Q]a\J39T,9IH
NB5aPYLWNW2B)^bN)cP9?WU/e@d_UO8f&QfGSc7BeJV+J?R^1Lf(]5_HL=RDK]KD
E58W2L3WIJG)MG@d2AL?NV-<74J&Z-ROE)_dfW,W/G-2^8QeL[9.[OAOA&_@IaF6
UDW9YXWDK6VA)>)NOYJ)9fe0L6gbf-N0#ZMBe#Q^6WRbD-7EK=50TJ&dXV[8/=QA
8NaGVO(bRY0MR7(dBUINJWI,D8^_X)XX+Y6\G>_GO/V8_2^Ge+0T)K&G<X@gUgEf
c#c^c]T,ETS7+EVKS^?>_&./[X_[&0]LcbY+C()9/d;PDG38Oa.G_=.^.(DX>Q==
JR:](1>\S_Z.:c3)#N?;.=RIW1)HCa+PQG?P.[B@@F&V3O_TcQ+(aTD7cIa1]QaU
YcEPNJ8UZZS8;<U:G^X\Y7O+Fe2QAa0&(7/@K88,U2^Dc:11@<8<Z_0&M,=\]2)f
.=G8W(V/c_EFQSH(M,;_P]Z]_7,]M=8<7;WS@RgY3U5];+W]\T?ORH>eW])O?7D8
>JO^HARCgXD[\J7bU1^R]K=>9)B+-Cd.A>EeIP=3A/K<U9C<0F@fDAGQb.&V5@JE
RKf#9Ed(D(:/MUcM?bI@O(SU1OLB[L\W&T,(A9\D6e)&.#_?#;UE/8;PdIU:f3DW
2+2?)ScaG8I&I(&S[2d9BeK+Gc8RN0[f?3,GKWU^^Ne9IXW&@/A?eK[;J43BWX\a
6D15;\f#-V0=4WgC3A?&/c_]6F)a_7E]fX#2/4E-U?ZK1Z5A1M0a,;97N;74J2I&
XCZb-V,eRLBFD9(JJA86g:M7)3A7-a_YIf/IPVM6&(HMC&bc<8@FT=dTTZ<,=L^_
OHUeL^O,L.<5>IB)-4&I#X47LT<N)LfdQRN3N61B30[WD7I@ee[<g.,W(X6D4XE]
X46@UbOPFSTWTdC3Id[QNP-A?_NFV<[72c@@\NCfgYZ0Q2E_eIEL\YYGLc08+W71
B@;7-A4I7?U/?fe=U29(45P0U^,F3-fN8HS0-33;c\#(CG9:6]3][bb,KXUE3T^_
cNPgb<QV?2[P=c=g]fIS,d#GJYAB]=QgC-E++L_Pf1D@I[<Q-;fSE6I29.a/Ag=C
=Re):B.YbU^)&M7.^]TSS.&886R.DaL1U3WQ:IEUA8^NS3<eS-AH>Pd6OS^/<Y)=
eA@BBG^TYA&2XF\ELX-[@6I3DWX(70DMafG]-^Wg@W-H/.b4?DPF(R&_G>OK?/;#
O09#20[^UcS6EUe(R+/^TPdXgc;86]X_N\Ac>60B4Ad8aIQM/S1P[BIR,3^CUIU+
]>c8(Q@a;D&,Yb_F5:WFU#MC_B:EffF/SJ<a2R/C&K@VCMIA\3+H,.JaJ#+_N2Z_
@_;U45A-?:<X2Y@KO][=KCfa=dOL5a,3;dUbE8?bSH3\KC77--_LR50d\2P7.0QN
.<.8L.+ceY3TdY;>W7,f[Vd0Oda>?QM.I6:^R&FH@X+9QfPB(R\>9^b:4G_JK6gK
\I)WIY4<ceNZ@UFWXD_17Q_WL[I;8^H?0N.BTD_I?BHf.][NY;_3,Z34VgWLI)S&
&\EI+c2e1@L29I(af7M]D9N:KcKI0TP9TBK^^OWCT7G481E<B)[U@[R38GGS..B3
OOcV(J,@)U8OUCDTHS7R0O8=0Zg+Z<gV/)MSFII(U\LRe.&72Bg6;d]]A?d?U<4Q
&PJN9L]6(:M0@a;M<D]\WaGe=##,V6U,W5(=,f?7^/=?OAK^bHD8.U4#],+HH0fG
NE_GQ?YO79.F.7)FIf[>ZM<D1]&5)@330:,QLa-IK:WMe;bI7)[&CS,4<36bYCSL
OeO0ATPM](#b7WOaIZJ>F0e,-fbg9S39O(4g?,1J9WbIb8^:PcR3aRS1Q>_D:>CL
JP7GPf@T]d#2G.\77VbTJR:BN-N7S&(W5-_P4X0>dBG<3L<M??LE[D8^WdDF(Ye@
TI^\&:OHLC[JZE-[MTLg/g&G]E?<SDWGXM&^8[+5B2J7]MLMZ&BOc)BXV0bN;?35
7-16Maa?6;A/F3<]R&UO66J)ge?V>cM-TagTL[53H=e/9K,eH9JeaAeV\UDg[^YF
Ec7AAfQ7/e@U7RN5Bg;2PT-fV_\bS#]#8_70.7#1gM0HA:If\9a_AP@PR>KGT.S.
.@@Uc10\8KZ2X2@Y-&X^7UZ@#C@_&g>&G+MM_aE-]AJ\3GDR/g)5.T\-.O,@/TcX
\Y\VDR]U75>]6#<f\J?e>WB#7::a,F7K@&BE]RT?bO(JXVW^3L9BB0+<bG,5SN2]
H8(8f&YE0UdFA;^X[J[D_5M=4&b/Z.)7PJXF4UTJR;Jf([UgMJQ)<Y.D(DI^D1,e
GMN43FL?>(S1S3QaY05gYH&(M0f>0Dg&YfTVdYDV39GO>7OT)K(]N=IS++CWa[@e
^E.,+e4C2dH<0JE2LYQg[[5Mdb=1D&T8=C]9/GKaODNB)?=7^R54TXX>XK)?geWZ
6)dXT::IF-B\bVY5)5;d&)]4W:?geHW_+U\b?XW\,fGJYVfHP1X<-1Q>(@,-EPKV
,R3Y+M_FELe>D/E_.@bL&CQI\0T1\;bKdE?SPeH]M7(6R2RA9V@YKa^:bb0.>_L;
X(TdT&G4CSQgfaR#P,O@7WO5EU#QX9Xd[<,FX+PR88>E=SQ&)&b:RMRN=Q2e5;72
e0D^,IE<[-^gS\.LM6H(6GdG.gd8JP2?E89GG8@fU(;8:JP;C4Y?P#[6#PH--\B5
QK&HE(3a\3Z&f5OVJa(/?+0]DZ;Nd_#-beKgg0,W]4WLLX(#&C0Oa+8>#AGJ8V37
c/S]bfEHU3\Y;?].ZUU3T-QZ.d40P05#AZFL5PDKRgQ()Jc_gW9F+(PI)a,XNI-A
_3=)#e2)(XM5/ZF<)MMd5]A4F7a>e]+(V:8U1f@;(AKdRCS@G7aY0#AE\gP3?NUP
U7M,b>2R>I_ZE?IXGUYN7R6g<1(3f-&.X@a=])&\<YXWcLG)8R4>:>CaV;:4=9O:
ANJUGN:Sd#DKO+9=L&H9<,>?CeYdF0BW&<Lf1/C(fbO-J@H#@AC#0P]HDK/e&;@Q
GL^e=VN562S/1ZZ].faW2RIE7X,[_8TMFNPeGJK:I7^,M#=#1T?,L?LBR+HWVSA.
A55Fg=AeG,Rf?K&1bb2I:CHN?R:_DD/G(P^&BUTF26Be&TGQ+-G@I\]]_KS1Hd#\
]3_0O9P\^3>e3]_N6?Kgg^f09,b_+5J?S(;(8eH(cS)1^<-L91V_>)AKP,</Ab@Y
-]2VPHQaRdH8XMbd3WVD5E]#22/DM^W&dFCbV[4?45IE0GHNMJEWD9>RS=6^/-UL
U.]]Q#c@CX_&=<WM&9I]b.Xd-,A<ZNGgZND1bcAMNM8AF==d^M3-&c;&VWO=[<K^
1LA2PLKV^D9>FSVFLY+,US9&)B(BJ,g#\&?QcRbC]V?L)@B2SJ+F#e85XP/NcWZZ
bfcd<S,7/&;A9LI@RA6:KE8a&U^#0.BP-1aPgFc+X8.U3KV=dDL\XE#FCRMgJ_\C
=))SVMS&fGeEAReS1#aH@C:[+Vd44S-&#+((F])WJ):<UBC/S09UR/_UR9[c>RR\
MG4@+3?WXZO<ZFOe)3)J:?<B.Jc::K))S/E#1RV&)Q;_2UASb@F^8KEGGD:L.VRW
KW/8OO+_I\6JM@B_bPbb9P;S8=L?0THE^4JOTDOe_2UOD6T?[-8N<7&=>4D8cL]7
WGg/0+-eRg6LBXS[IF6NOH?R,]?T&CL3NO/d6F4UCLR7\NU+5<=_/0IN9O1@3]Rb
0EMC#J\/RKEX/T1dAe#D3H+YWF@IdH7F#)K;\.H;Ic]?&O]LQ<[\@HeIf>)7IL91
4D\LJTN==:4e9&3SB)B+=C)5ZNB^gNVSGCN,:>&3)BR1c,F92^H2FD=W0Y(g4W3V
.#DT7;.G29#_6;96QTKZQ.(;OP5Q>UR\8>d[NP4:BgE4&7M<L<W\52E@dB>?>,AY
+#K4C-JEK_C6HC)ZgeXS+OgESR7W?<QHB&>]5f,V8I@2ZZLf6[SY1aQX:34J0-HS
SI4VDAaYfTIVHJBc:@/XgH67ULa?H;aVR>K@TV9eb_I0(Y67>(UOL)VF>:B-]Y[)
a?7@c-+AL9B@,aRHF]U4gJdfKb8D=P-W>;+;87@?)V5143@_/AYA4E3S?ZK7a#[A
H[-7#Db_YWX>./+C=,G.dE4747FBOMe7]&0]dCJK)Db-g-+54c>FJ[gc==f#Oe#W
e=JOa.4_X<R#XKW?I)Xc]712gfJ_+UM3T<W0RKR3W#W3YDe&\(>GCFQYH&)(7_]d
fVZP7K]]-@aRF66a>O@)^S71[+>;?F[:OOM:AO]P#IWA589.dc/::=L8C([@@NR/
-9/-ZJS^=?N,3ES@,P5A/>Y6[Z01)9)265I;Ae(L&-J[21^=#M\WUWL=6Z)b4[\W
g2W8dOK/d@T_L7\KV,B)bNT]TL-c.,H(b=.6>N_d/4HY[D5W9a:5H8H7a-fP,[G^
CNPS<.8\PRQ0bZ+eE(-bDBg]=4#)7J0+F[_51Y2C3G>O4bb=Qg&RA;E<3B\aa68/
;(WZNE#>)@YEJ,J?HLOe9]#(VY3fR6:LSO]aMBNPc\TH(cMUYO7_6JRT)KHO,b-]
4?a51=#>.X1\(6\^@B4cef_[9bg33RJ(P9&]fNLV;BOBXSFeE8(4<a3C=[b_7,J:
?>F[SI/Be-e6N<^?gg7g,I&&]--\f5#L=/&RQ.b-X^-7H2,6#FM4g)>FT;)F&0HG
JLGdG&+MMCRg=5J+LOd<e..cMIeTM19,dN[]O/F2I8bV0d-SML\040d_IV&I)]d\
,5b]^D/#,OOX(fHMc@;+K0#Y.CbMDHX?KXZa0A3RO;5MS:UE99R+&Q,4LaE5R2,e
:cK:HEXG>K>M^6YYMCPRLGZ=G\ZGe;WS\O\)=3bF3]NJ;^W4:P<@/C0O6T0)X<3a
.?@Q_Z(W@S5g&G+V4^K4JQa(PeJ52A@GC]L1/,>9g+4YFGV>=<a2a,6+b4(&OK,#
\eQ2=\/Y^,A]ab=G^D9a=c=S9e9UPMSb7>_A0Qa/7.d]afE5ZZ0GJZg<S0VcE^c>
_>dOFF)cgZO#VgU_/^B8L?/b&e1:#Q;3)[3?_XSAX.=]/NB:+(I+e;-FGc/ED-J3
,JP1a?,aT@-R&38#R(S>9XX=([0c2J]REW22HgTecUVE8Q;48@]3]^cNYJ;PKBaF
dg#L9P90.](_1AAV[1DR8Q#^W#YJ<E:)Mc/UKIVa48;GWV)Db@cJQ^SR:5PZGgVC
KQY8OccCc,VXP:9^Z-4=e@5,>0O8BdVJ2_R4gc0S_<VI1S])#DH-;SCI+KN#62WA
K\K4C8bDLcA,+@-Q?&P#c?(+(8.@(/^<A>((\/(YCHQ/8C\9dOX.N?1a]2O>:^c\
8>,1OAc8PL.#cU=JW)6D?#;X2);Q>^S\X59^gg7#b>dL(7c;W@ZPb6,edI^.?N.T
L:@W]=Z2/[)EBJYEFfRe,UA<;78)=.Vb72g8VFFM]5#1Y(CM4GHMc]f#X(0e_6,2
7gX[0:/J.)^=gdJWUP_/U>gBaMIXIGNaP85fB_<X:#W8b9XG_60P=DKY4ZP=+Q/U
Y\N3@^I617YdMcY2e/;#dFcPPIJ_^YcMS1#<O/EKLBVd\>FFcRGeB.RW:9G:(Qcg
>OL\UdJ:)49\=?NKXJ.3ca/0J@@U,7L?B:bg:HTE,.KO&^,V#4cR:1=.D\A&0]8_
^U::^)#.Q0Q[1V;IEK#N3^5IU[<aND-cH[b4ZRIOLTSEK3EORB^\G9IZLJP1Z5UW
T[eF?H^W&YBOe=0G6[-<Zc:V\7>4g#U,,@4aOcgXgX-1V0eGO59ec]D_3fSP1H:N
MIdT#ED<Y+IbLIG#C3.=-SJD(:.VXCG(+_)GP?GV7R.1M>SR70[53FR_9KR=J.J:
^W+.D,5[(O333NV7Y#3GR]&)=STBBT)2+H:29Z@>=4BEfKBN7aRYQV\@feNT.F(Q
8B+R@K1JW@ZFIdYW,OT6Wc6Bc8^6Q&Sb-:2Of-6+E@F&]g^\Z/XG593)B8U8dP4?
0aabUD6?LcT<g<Vc?<2(54f=Y(#_>8=PWNWVaR=e:XRU63R\VY:VcKH[e.9NDYZa
B3N<ENSS@=/&gPe?XI5<.GK(>0:AC-.5DL[gIfP#6]O^cKcI0O]Q>9R<I.,@M@S5
6d14X^dW[&5=<K_9F_:-GKT#YM/S37F;G-LUcf^U<0eP)eIW9VB,&J(7UEgG_Z]^
&<>L-YF4+M8P_Q6:C68V:K?@^=F#J_:5G7R9Y9G--<T+f=^(fSMGIQaI:0?&]DY5
;@CA/5Q=]KXT(0/d@Ub,.,#:]d[.JJACY_gUgQ<GBV/a>0=3YPXLF/(8SeX,][dK
-g1LNgA<2_eA6>Q.Y+V.>bWTK\f?@X^Ub]eUg<&,A<)(IWC[2?([3?9::a2AO(7I
Z\ZZ>]<MU1\00W/H6K<?P>4@deQM7Q^TKeG\:#8#/0L^_2d5Q86@,Be(_>Uec3CB
Jd^26YBC(Saf>)DD32\U,L/7H-_]03g4:5=<)MT9[S9_Wc^JXIM-<6ef;=aG51ZN
SbWN])17V5E<;AA>^Ib2,H]O(@A#aR?cCd<4:0G5O&Wf@1^N8>-Z&<ZMFNB;N[CQ
cReZJ>PX_IIf;^Q=3RK?gPY:QLf[7T17a@f>#f<g:ZV\@MDB2WPI1Y\M;1C3=9WT
22eL<1R\B:_BYB<=,;C[M5W3;8X1LMYf(V[TSAS+SPOc];IG5==9_XJN&LNFfKBB
eSc7bKf=;a[_HTA1bRN@(:KM#SFYR,&F\L)eEZCP^H,XC1NS2Ua42=0HC\?73I7g
g8&CLc=Nf+]>:^/=e>IIG1Z=dOGKZH]+J3CV.H_6\fdGJ<&YV9A1D+#D/8\&Q^8H
\Y)PE>@JF9.Y=]B1-VK1/[bN0MO/UKDF@X9>Jd8Q@E,P^GSJGDCS97LP^MIQ1);Y
aaAU^R4B7N5D6P=<=dbCFELJ;gbQLUN9:6d[BObf_)A]Rf-FeMF-d5R,NE7f:aB.
Q5[3;HGXC)J77672b-=I8[eHa]aL_U40>BdP64AA9/)b/Z3Yf//L0Q#.##=d>]af
;WGAWHN\2d;Eg8I0d@A-X<F?_f:ASX5_aF:VLg0O(e2\aXTQ\aRbO7C.2McB;>NQ
2P3D:],8M7[eEKSd4?7-I:2]W>^DEW,Z4NE&D5WYKF7C7JI))E<E;OgOEYNWL=b)
Q];Pa^KV(-60WL=>M8BZd8;]d#H5d(&3cS;UE2,McUg7TV_9R9(45C0+->B^)#(6
+>^WV87,?A4V([9TXO62_JDVaB&90./aL5FI8W5dZ@5E_Q#PJGc:AXZaD>AUN]d6
GS=J6)BEfPJK&+bG\LgR4L;MFW)eBWU.42MV(OG,<E&/QW2JRFcA>LCf,7I^FPE7
_f,Z@:\I6a4e^5=Bc8FPNFSH&3M9Xd=P[#D0=+M8YC?;OdDFSZ]<aT>\P54>;J2T
XCS8PRB\LZ>1.a6BF7T8cfY1ZAY81M?d@&9/b;9BV8Q2U<6ag^IO;L.D^:2f1SOd
LbOUY+IY9HfV^3a)XgBM2AH]2LHA=<>OILc]N2Y4VHbM/X<QFb)FY&e]_TcAGI;6
f(4f2AS<T@EcQgW?+_S\IL[b\I,U5^EO8J,YF4/P;Z#fPDZCZ>e_EV<HH.e+Gf^U
#fFK[B+,]PUH@&,(8,&,#=f_OMd6E4))\Y9FZUVKB-d>+,Wf(Z3GGO,@-\,b?)2P
/-]6<DH?+S49dYdM4:21H6K0_F=\Eb)S6[aDD;:O#5d5);KQ7[E5/]38.?a_6MWI
JPa5bFZE[U)^/_+&aUMY)0(+G.NLB:a1+DVCW=;cB5Y@E/e)BFJF4ABM\2C57<>A
U]Yd(9Jc0V3F3NGB5cL(\U1R-eMD<P3KN7[.FG9;Lf&RJ]E,ZQ64;3ZT_</D\;OV
Q(CW]LV,&5L&M0BK_ZR3>#2&f\EN<QU.,^)LTII?:1afdPV\&_-R0-5^?)_.Q&L3
M#c50(6B(cHTVc5LQ1gRf8TVYg:@.>505Q(KRT[RSD<f)F^V_<cf/CP\+((A6MHR
\L@391HJ2_;;SM56&Igf3QW=Z:aJZEbOJSSc^<XTHXf8-/T1P1A27C-T-36TZQY,
Eg8Y-.<KI&0]^,G_6gbZV/,8:R)PG044AG,PT4c22dV7OTE5Vd20bMIJfcd?Cc86
-d\2P;^f94g;T-SSTK@3816XJ31DDeEg(JU;M28-V&EFUGWI3218VE;EV\12gMB[
e(B)f-Y>d8;)QPB^S,,DgP<[-6)_E1=BO(SSIS9H92,2>E.V@.bagV+S._X;bHWZ
\&+P-]4b?UW\ggBFGKd9HNM-Rg7g6/RD1K_Iac=ZFX;7&IC&5@[VS=SJ^b5;KS#&
&a(]?+]S/7<HG)/2YGQ/>HE/^P;X:<^]N[+ME12[/XgL.E_R\YG3D-8UELXUA/JQ
49XQH.I(8b_=P9eX<Y3EU0WS6<APg&)620[g(e=3SY9D>];;))[<Cb(RAW[^V:O5
<;JMF(Ec_Z2=_49eKVMA^;F_eMV)Q&E,Lgf-e\0>=3;J:R23W#gLWQJK7;#cEVJA
[(PQW;BA/:Vb]3.:\M3f8&HHR@Z>_fDYUK)YT+b\&8_LLDc>?O5C_f,,S147C]6Z
1C;<,.=]XUN55RWR@S3JRUI6\IL<X+QYTPMNaSa[6c(Ce@U2\J9([&W(A6VF0a,R
LS\d+A,9Y[;W+:(X6Q<WeX2#HJ:0aSdN=JEI.XL>1GKAG0II6Ke,K=C9,@NFF]T2
]XLB8cRR^CJ@]2FB>IM>J&VFJF=.Vfb=MSA7L5X3+A#-;aN4H5e++7&bPb=M83c4
G[C)dBKVZF5E@5R/4?&O#D6C(VWA^L<N/JQ[N#AZH?\>CbUO7XaL3ZX>JEc?.O:O
>RFJE[:S3HE[1EJ78GN6OWJM^GVK;?RPGFIXY1B\CAD0HMgMMeI[Z_M[-,370fX\
gLOV[2X@2=5ZRLV4V0E0K6Ue(8Y=d=9TB/CW]H68/(0)9#>ZUIM?;/CLc9YgO@e8
C-@5K^2,E-0\EG2?L2[E_\.V?DN[c3T>2Zf=D1PG#_/)Q)UX@PW_I2XGfOXX\f-@
9(Z\/=9(/-WOEL2TD?,N;]W&47YdLSZ@O_dN.BC/,BDNRP@@:ES8OKCc:A:cA=[0
f,;+,KSAMGQe\ETT(f>fg;c[XeETJ3:@Fa\)R@@Z,@&,M_FNbcSH+R6_39JQeKc:
.HgbeGSS+?[4LJHcbGP\]O;,Q:G&8Eg/9@R,g,O,0,)0CMOgLf@VPE)E\D#ON4^H
.ISa>VSg8[-G-ZaX0._5fM<aIG,TTDUF9:IRJ9^TEg?JKZT4,8GFHQ#WeA.903gS
H<8R-]4T:-BCTJ(d6S>3INfGVf0ELO9Y.4B;VCV4.RFC5cO=-W4;P#cX_6WI6JZX
:,Y@/+=>32U#@2H#XUUWH8ZOYcO=4@G/^bE<H]e8P)]Y.-&F8E3?<\&B^S6P_Q&b
\e5.gMc7GK1dFB9N\,-@A39_LAQ+1=KW^D-XM^QT&H\G\6/#77W#4ACcE\3C7G4-
LBL5L>103--5-7V^N(5ebV9\,V_d0R[#d#G=GKJ9CgASgB[CM3(5#bB\eFT\cNJ6
>,T>0@.B0#1S,V6QQ>08:3<H)QCRgSRXYI_</ILVCBFZCQAQ:SMKW[S@H=;R_IF)
<FLBO^e#B(cAC5N3e\9:AQ1L,D\1@Q/S1<WfV&4b7CU[HS55.\YCC=eO3J[LI?6K
I?0AI.G@D]&Oc[7KXCV2fFD[I)KL++J4f+#gB-3=NAE+8fE+?dfL^0L_5TAd#90:
5<3B_\+9\NUE[(G8?D9>60-+a/=AfJ4bbg3;dPJ)NE:F^]-\L+3@TRS25RAaTKN-
.ODN7;KGcZbEBB^\I/+7_c[\J<SQQ2&IgQeYP[]gA76HaCS/CG._&T9b\2OLW_R;
+_-5;a94ZM/7R5H^TSR+g(Y<=S5R@7XX42O9/TRR7b-K>=F7>HJ.eWH1:581_EUX
U:d)W9-YKD1b7LAQI5#46;X]HP#)&_VW7:8V0e-<Z)<7YfSNIPMXP+daY=_[GWGL
O(R&Y7d#&b5LA&8a&[&G+_cJ9_)R/4-c?b<3I,5@[(B<dFUYAN=0N=aSP5.V,QH@
=fcEK3\d0MTNY:;-A(8P<B55F0aLF7SBF^)[L\+b&>X8)e=d-VS6I3N/-E@QFTTf
;dO3<XfZ0.3c8601WH^D(A)3D9_(Vb)9G/d&PJH.:0\LDPP&_cNGQMSc_+aQ-X?;
E@M0E:4>=7QZU=M+O++6T3=5RT&\H<WeT/9.F=R7Q;?P^eb:.@\E0P>Z3@(?SM3X
5(.9Y[SB>d4WPB#253Pe@ZJ&/L-S9\Z^]0UHTC.5A<+W144,S\FI#VO?H\b<,F>G
_X;dY^<34+c#0<A<&J4>D)K+>a&>#+4gKeUb__c,LJ7L-#_GU#e592+7IPJ4N0T2
.=TcZ(F8#[N^AJ:=)J62HEVMb+M9G:b.D[_.(H[=@252\4J?,SF,PIJbN@_SX=LP
#eIA+.YcfdCF_82BUY82(PQYBIOf[Eg->3<6DD3e<F:=4#gF/K6AUf[GMg2FS)+C
1P5+&U(<?@N.:8DHHH5J7;IgFII]9X/728AWQ1RPg_3\N:W8\A4Z(41Y[Z8](>YX
1B&3f@:cWH.S-KI?J<?d;G317OA+NU7c_F6S=85KfUQ/eKdS)2\=B8<Ff55QG,@U
g:9f65;7)-LMY(Mb@f1JAIaR4SOB9.B]c=X[CW5fH&HebLDFaMN:SH?ZVPGg?K0f
@bNOaDffKXKF1#[9.9X;E+Y?9,((X7e]ebc#X2C6#GF,Z)PSJ#e(;W;,J5.-,#TV
cWRE#K-50W[6DV<CO+97eM_6RD2/0E<HGe)P6[+L?+I()>Q:C8+=cV]B+_CUFPN]
XA)95<@]R>9</>=Z5d9.WQa>.H&cF;QD(3Q,SY+La:Q?CPM.9C\Q=QH60PH>=7AX
A,D&\.=P;(a+:7:3NbJcT?</WXfK4BJ0]QQeJ1J0d+7O4]K7TXX)+6@57U,BDY@d
\]c50-]5WJ)MV9-&^(aNZ=(\UZd_]<bD/&[;T0O;,R3Q:Y^;.,#QKgRcB[1LN;8D
YN+KHJB)TO&SG@c?d@eFG;P65g18D#^(?L-Z8[Fe(@DQ1X(@dT0<d&PR&WQ?d+b@
PO^GNM/P#89[E#I20L<P2PD^:;(DfN+)fR4\N]R+cLZ0JG2CNKUdD6NaR(R]@1<C
dMM[^95f0@E3(1.B?D=DVY?a1:9eTJ4Og&+C,C_E>\8KZQBV?VX(C--+\R8TbJ+&
<HMSc-@OFaf<>1_@\.&2Y9T-R>(>KUUXaROH^EVdN:(#:#2VZ^9G7Z<bU:EG3(g:
GW@.P/K9Bc/>9F&;aOfVM[DdE,4X=,EB1_O\Uc)?I7]S8]+5\9A6?J(&<K]c9-)E
/YcHGfF::<6RHfd-S:H^SBGUdfP(PE@.07ceGE28(IMBW8/_\,_HJ?\3-Sd3e72?
=&(5;1fOEaEE;:gO[@DU493]+EJZDSAKZ0HcHXG3&R#8<^W;MIYX>U5K6(&PDSb5
:]d(2[)Ma[A2^)RP+E018<N:@f=e?V^)I:I<BQ6INZD_3Y@,ZH#)GZcRB(2?5,H1
Sg&>84;93)>P@D:+aTEX:C5)<>GZ?N^-TgG&A^+3T-6H&H[-PFZ5S)0bY[3G9;Ve
@T[5d=g7WXEX>LXP+(Rb@XcVXJ,<W2/KK,;dXH=HWdCUE.bG(/R@B]5N.S5aT,bA
d?/&b(/=&U=dO:?)6c(0S&UX#4#_&9_GNI_/,_a)f.#_,VafPa^LWgcPFe^\P,gB
(8TQ9]S8/01J6HVF#_,X#>DO5(E,/CS6U3+=UZVK7@XJ4,dN:_U<Vb=F\SOI8c1c
Ld0;ATS(APUL_Qc5FX@IU,MSAJGJ3RG:\DdI#\/I#@<OUL]<DL:aNCHPf#7L1EH)
P?#U;HIE_;4KYX8&^QJUNY&?+D#?V;_OP4a#V>D]9MX3ILRGGY@EA:U]0@d3G.SF
a-C&IBYN-<FCWS/&5N&c_bFZM-7g_HYF3/Z?^WW.793WPa/VG0/29:&.H[T#bY9G
O@gE:D3G#S@&&)cd6V3>OQT18#b--gc?d)RY_DBWMa(2BO;-WV?_[22AD..NJ78Y
a0]W^@gGU1.&0g[+:5K3;R-?8C,3<U3H#:HQ;.UVM1(gLXgZ[Oe;eM>SVbY\]\_\
e1[>@,:5YZI=7Fc/g@6Ha]VK(aE1dPR?.YFKH?L)0=;8^PK>M^_CReR+,YAI@DYX
BS.3MAI;FEb)(QF=)MEDLY\Ngcg7XVDD&^4H];+&.Fb_Q\M;B3[P:OHeKRf=LHM,
@O;L@FRKU4L/Q]XIXF7^E27QE/2;LN<19LKPI9JVP#VAH2NObBZ10Q,;X#WQ[b.+
4,FEP;ONb:;WRd&C57[7C)?T8T/]T0SMJT?1TP.4PTK0[(.@JZVb^I]N7ggNM\),
JR4#,,AG0C#:HOPG\\Y)8?M1g;NR\+/9EaXUbH9TXP040SN@I-S2POIGf?0=Z/<-
^6Rf2.L,/&3<gFaH:U=1RfeAa\<W#<cg0ISQ;TRQ/.9c.T<H:S[KbIGZ^]1-YZXd
E12_X93E9917R=e-:LA(_(YfZG^;E0=@3F\WYLCW@J+F[JV9WMdW))8,\.V?>Sg@
(;):WTF_YD@_d\1&L2DNTcL2[B;,/:QG:P/7030XM1C?a\a--CQ:EDa6AYS._J;0
U>LXXaY2)DJRIO<NJVZQ3b\D)@9MeWLW?>.@LD^08)]T3.\/HaY)<b3D57I/9)Za
Gdb]D#FdF)a,Q7N@DaYSOZ@P>7d.K?EB[e)\@d?_a#]?))R&Ce..2A]...+AERcc
f\X58K[11#_:>WPc0-X1gW=cK(Ca27^;F2MQ0S1743eEdFHNWI\F>]LcHI?)2[Uc
ML8TdCU711EONM)DVaebC=XRFf-Z^aID\-HL/d37VU.2=ITQDCe,;^PUS&_21.N0
bYA]?eNA)<7Rf\OJY2Z/+,\HRF+AS.&^NGNVV2-1([=@cDTgC>==X+C3>?=?B5&1
]1F@/SJG-U7IC/d[-Ug?8O4M^9[OTF9>0AecKKCg-_9_]XLfY]W<SDQIY1_7]?1_
+#C<@Wb&T^X.f6>=M1\>>\]C4(X^f7WQ?A#YKa&;37=Sc,X&^ZSTCI&DCFVgF\+S
&)NYIW18AVIW\WG_;CE>V&YPQ_0eC(PLO#.acCX)L^gTcD^0[gJGNN\5V0Q.RQ4/
I/gGc+(:2fRA80A@K</])Z?99PgD->&[WcBY[8,O.+A3X1g5(+).-=b(]6K;P-NX
e>:,OM8EDK^9e478#VWC?ZadVgODb6&A4JD>CC];^;^T2b:RFc@]=Db(O$
`endprotected


`endif // GUARD_SVT_APB_MASTER_MONITOR_COMMON_SV
