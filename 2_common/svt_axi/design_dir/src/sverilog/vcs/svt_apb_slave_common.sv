
`ifndef GUARD_SVT_APB_SLAVE_COMMON_SV
`define GUARD_SVT_APB_SLAVE_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_slave_monitor;

class svt_apb_slave_common#(type MONITOR_MP = virtual svt_apb_slave_if.svt_apb_monitor_modport,
                            type DEBUG_MP = virtual svt_apb_slave_if.svt_apb_debug_modport)
  extends svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_apb_slave_monitor slave_monitor;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Slave VIP modport */
  protected MONITOR_MP monitor_mp;
  protected DEBUG_MP debug_mp;

  /** Reference to the system configuration */
  protected svt_apb_slave_configuration cfg;

  /** Reference to the active transaction */
  protected svt_apb_slave_transaction active_xact;

/** @cond PRIVATE */

  // Events/Notifications
  // ****************************************************************************
  /**
   * Event triggers when slave has driven the valid signal on the port interface.
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when slave has completed transaction i.e. for WRITE 
   * transaction this events triggers once slave receives the write response and 
   * for READ transaction  this event triggers when slave has received all
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
  extern function new (svt_apb_slave_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter used for messaging using the common report object
   */
  extern function new (svt_apb_slave_configuration cfg, `SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();
  
  /** Triggers an event when the clock edge is detected */
  extern virtual task synchronize_to_pclk();

  /** Monitor the signals which signify a new request */
  extern virtual task sample_setup_phase_signals();

  /** Returns a partially completed transaction with request information */
  extern virtual task wait_for_request(output svt_apb_transaction xact);

/** @cond PRIVATE */

  /** Executes the penable_after_psel check */
  extern protected task check_penable_after_psel();

  /** Executes the pstrb_low_for_read check */
  extern protected task check_pstrb_low_for_read();

  /** Executes the initial_bus_state_after_reset  check */
  extern protected task check_initial_bus_state_after_reset();

  /** Executes the bus_in_enable_state_for_one_clock check for APB2 */
  extern protected task check_bus_in_enable_state_for_one_clock();

  /** Executes the signal consistency during transfer checks */
  extern protected task check_signal_consistency( logic[`SVT_APB_MAX_NUM_SLAVES-1:0]       observed_psel,
                                                  logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]          observed_paddr,
                                                  logic                                    observed_pwrite,
                                                  logic                                    observed_penable,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_pwdata,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_prdata,
                                                  logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  observed_pstrb,
                                                  logic [2:0]                              observed_pprot
                                                );
  
   /** Creates the transaction inactivity timer */
   extern virtual function svt_timer create_xact_inactivity_timer();
 
   /** Tracks transaction inactivity */
   extern virtual task track_transaction_inactivity_timeout(svt_apb_transaction xact);

/** @endcond */

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`protected
g,9aUOeFDG<3[YcDAAE_Q9C2^:P7g>R:O4S+LF>RKO>Zc[L9B&e@4)Q/N\+LLS<g
R[TP=&]6cgKc<f@P<YSC-W1?SOd9P>)D#]#A6);S:+C-5AC(>dY+9]+d?I3\<gZ3
fA7,KGHVEG/ag3^#\&2PQeNJaZ&0TU1_)3((L1;#4M-9#NII]/OBPWT/5&D)b:a7
<+BS;NGKGD3Ic):g8+>c#(WF\fZ<@-#)K1SZXdV/9b>NV0VW95-?9.A\,Td/6[eF
VWfJ(1]I;gKAD6S)aEg[F=9e1H+K(KD&-)BMbaA/)_8;CaF.ZH[18F2V[Ja..Cc)
MP:^?U@.E1WdZYD(=+-P:OVJMf7A<EG^C>V=ZK]:@f/5D=@<1WJ^17OP<6=?4RI(
@C,dg_2(HF/ETANO8WJNQBIEKQZAO^_=S2_6:QYad)A,aL^O+Ea8L7^5Z=gYVENf
,IA1?.9+K.9[5__Zea^JKS8<6_4VB2Cc>X)05P;E:&5P(9dfaQ3ZPF\NNIaE(2]6
8P?DA9HZ-M/b41=_0\9/;MVN5(R;3cg+ITN(NaZRYb\1/_\?LRX/&#cZe#=NedY\
6JR/R5;&c;<a-4BKXNU<c=6dVERP2QCfD/f#9fZ,\-4CSKQA3,T-#CX?8V(QSF@S
S1KC02KZI&W:H;,#.4T27J;M6^LHJc^X9Jc:LGCU7+@85/OX^3a0(A(BH@[4^QK2
a=gZD3>C)+.:.6+P]<Y>?_a@:&/JGgL)(VZ:+B4?)UD^Q22-;?.Q5](G[.VbD;DA
NcdZOW0d1X)(Wa=?T0,dXRVCSBL/D]4-K,&S;^^AQ;=[LVC\4ZX7aZfLb+B,H21M
gc8;>W+;a=gYf5c;:P+W0ML,7OMRK]M>e)H1#Ue6+EV(SSHQeTTeZCf4,,3@WVID
6aUEe>2U-:UEGZZ_90#JU?^J5.X<C-E]OD/X\M06#6b1_O\g.A#eOURg:c&B;/Ka
5L>US(M=5:VWfGL476^c1\f#S5EC<<#;g@B(ZbOLO]a;PHe]R@3P+ad&6V)f,Zf;
BG)/V8^)+3a&:C#YA@1<?T09f7PVeP_J^VYbAc9RF2ZFN&>&<#D0d1(JeeaAWN_e
4[f3/^T>4afU<F(AD1\dFXd_J#;JXE7URC^T[5e\^\_&ZH),/]H[,BNCYe)803S7
:g6:\g@\XZM;>EYZY(;XZS).#^PgM)WQW;R^E(0+>>4cB6IXOg#3\YNCJ$
`endprotected


//vcs_lic_vip_protect
  `protected
M/+X_V0:C??cK@O8_&5/VU5W0)CP<5\:C;P<F^:O/]?U(J[[MU7X+(__O^#+beM8
53b&+D5O5E(B&AbATJIO;.17SH__SUF34@Hb8d..Da_4//4Y3ZRSb(A@^FAENTeZ
,4U]SK^JWeO[Yd>LB:#=c#/OLHH=7M+WEUJ/#70g@S^Nf-HLUR>H\Q\f4)F9MR#M
V/]6XXRc+B&:ZN35:1^YB61JM[VHT_T8^JZ^KSa/L#fKQ(\d=#;e\:LEXR-UIeaU
].-H&_XfO3bPY7GW^O3&W8.H&O8]&gSJ?KM\RMPD=,e9-H9ET_e?+(L79#WO<^QU
L([QK-PJU<4^3NS/YZ;&?&be)I1fC1C(:=28V:Vad7@_YB0g:2>QV+F+Q;OUEWLG
R5>VJ[F?Q1[C/fYDBdA1/.cIB+F8.cH-M^LdH8RBUO]+fL/ZL).dWFVC;U:=0eQE
>?/#A7bAa;;4L4;BGJ&a[ETOR/.7SRe3fA8;?f,,4B3SNHbLCg[+GZgcc,eO(>K[
SCgOHdIcUYg?D96V<.3Tb;PDKN/@.g6PTV]1C8<IKB),7HWBg.DD=ASQZ/.]aMf^
C5(P5RQSBWY]SQbXN]>7@6]UN&MH#2;MVTK_.AP34FA8MO]DWH8F+-80\NU/955a
:33=:]5[@M#3,.V^)O1T8a9L^UDTDNZF3_DP)JdU-F?_KH8D9eE7WFX3JOXcU4RK
8DVH(b5=XR=/&TWNK2;:c89Be+BKM9Xd<HCLPV[Vb)e-Q30.D4;]?N)Dd5]Q?RTJ
NdZeCO-U5d+:^69K2Z795CT>ZeJZV=^GfHfQ<IJ+PR&eHOJeM4L76_JAE3063WNT
8K#?aKBEG&JFB.J?VBdaR/f3-,..<T6-0)Ie4^JNL98H3DB79c^4XA@g?G^??=2#
/E:RO5\9AQZORLMPBZ/)EHW<,R(f(^T^8c&Y=6D6aZ(eE1dU^(2M+N0)OI1d2c=8
8KR>g[He0SPcO3:Y\I)Y)LLNd]YYgdQFgG[=f7D=VN#g=+F7b+I[5CL(:R7J51PC
RVZJ.Jg)A5H0GGC(HPX,K_(R4.7:S/81A=P;8BF,d.RE[9a6NE(:G=Y;IBN7VJ5a
UA6V10@:L1458?0gM0>6,P(KEVFQ<(CG+Ye1IV?UaO<+S2O?+M1aOT\ggL#]4XdF
a2U)VP_cfTP4^4-5<(Z(4dP1gdQ\-AK)@KG_G0Xa3Y7CGfFHW9,V39.><BGFWT]c
L:UG0(@I]K]_=fdMPXNYIZDRe#6e11<e#9[;dfH=GYJHK5ARZ+?_<cOIed8\5+7[
^8Y->=IMARd/:L4A,,<0bG>NBgeYba#_HaK0PW;A-N309gI(T2A+WF])9eZ/A+#H
BX4)gF7ZM,3GXKJ()[YV,>RaK9Z8UA+.+P0PS<a-UZ-/X0]Q+gZNX44N:5^-.Z/(
XIL9Y#;d_NW8McN&agSCeG]&0WM>VXDc2fHgV<[8&18C\]9c0De0FgBKF\Jf\;F-
5=VXS)ZHf<HGaE30+L169G;NV5PD?7ZL1X(+I];g6^UO#5//(^cL#<@O83(;TT.[
HVCcQXeFS[V5HJV-LEQ^?W9A5&M@KC^FW\CBc44SP0D2>W+:5D-FNZOe/;9>cF7X
PW_7P8QR+GCd-FN;1#C:Nc]##0+b4<BZf]4JR-#2YM8fE3e5]QXZ:1>#<3;AcCg1
&UU#J@#_59b,24gM[\/c6H+C^SLAWaVaAV2GX?5::26Y#eU]b2@6Z]>#O$
`endprotected
      
`protected
(\ZEVUa]gE@.Rbb@]IVF.W1NA_\,90BbMg7Z,&5?W:_6(Yd?R,W1.)TRLa5A7?cI
2.D:O#Q9A3>+?#R:df5?c[8(cTL1T=:_=$
`endprotected

//vcs_lic_vip_protect
  `protected
e29E]K:2-;Hf]Sb21&4+Te18CQL&DA,W/,fcID<^AeM;6XILaP_J&(\<J/^G=1ZP
.=-,cb<eF)5LWJ6<g@@HZTH]@S#8P)JLH>b,Q38?D>a[]\H7YD\KBUE:g0DW,bCI
bG<,CaHe=I.F>Q+5F&([YH<_#+OBa<?2;)A=bCET.9JNU#,I<.E@,92AW#H?Jd>a
@Oe<K0\8BQ-AK83@cF7X&T53&U)g83B4\AK:0CVHQPPKO(Hg:M5\ZL;AH#^)EX5Y
T_fQ4,:XdMNTAL1[/f=EN56H=^ZG/Ffeb>d@9,H2,T&f8L#@MRDVe=KU+_eCc&/)
(O#O7U54e#8Ec;4=bX#_f5LV<^&T[/3baB[,CL\\+P8V-<=7MD5<;f:0T&MVM8@M
=](S>NKE&F[H6@,d+QKe]f7CTbf[GaUg0#1#AfIZ15MT#?XHAW3\M1X-<_.:?L0^
XV:7Q#<UAD+84]f[=;#PED4T25]26QPWGFOaMAG@I[a=QR/;V,C1RcPIRM_Z>FTK
KN6g]C29Z<1dHSfE7BW_8Q#d3Xa8,F,FaW]O[1+W4/4^.bMT@<TK1FTb#_FK6^XJ
-^UQUag[.RWYgY;&>J:BIFGB?=IDCa3/1:/F]/ScU&:DTP?c>egIT^YJ7Y<=@6DF
gg^+M[U0EL/cOYV>GY32(._9@(MIW2#.QCAcMM4O4e0V<.J+&dS/VR#BPQ3ag7>:
HYCC78WUU>@KJ;(,U[MV,B_JR,g9_\(.-M5LVA4?_3E8;L=UJ<4X7#Z:AZ&Y(#cD
,<b?80W.^7OZINJT]RUYC#-S]E:A+I0@&>IRDMI_[MEAV(4ZC(5e<>D>E:O@S0fa
+.8R\>c^B2Uc10E:Q9/7,B&K\9W5)AdQfc0-\;;5VPbgb=UBE?1/2FPX+Wg^0J&d
5_g(PEe^61PeLB-dQM-c>eU8b8@9YS);d:9K&9VP02V\0OGN;?8MG([NMcZ7]O0,
;ba^O?)T;DB+S00WUB(0JPKKVZ(FM+5-?-3RO?-b7PFgIbJ<NCD4CdA6O5?&MO5Y
aG[fXM@)3I6N1<TE8fD_UMZ]EU0CZW,I5JeM_3EFHaIF?d;K1G.WbZC[@+W+d\=@
8_>;@PYCLD<U@MJ^/4.E&JF_BR_fZP:=2?/bf@=f;bfMd(-GB@I4a/@T02))XG(_
A:U1UM)6[6.CG9=ba<f)09T@3;Q\2Q]I5C4Z6d@KP3.ZU&,If)>?3aVMUPP42F);
K_-&QVb&3>#C\Y<ZRY9^^cBB,^6b78Z_,2gb16.:,;SeAWAQL^^ZQ3VaB+JN?-=G
VIb0fJU(EOIQ#C70<<2FG.bH3cVZJV0fId]1,a6L/C0W&>LL=C(g4eb-AKAM^P@g
)[d-,8P2GT3WfM3:9\e2=BZZ9=_1dH,\d><\H\I+WC]K.&8>8)NI<D6XHBG1MA<X
9dD<GR,&G1#8GHCP-+RCa]<^(V_N#F5)?55JK-\e\WDf,bJJ6GG9]25KI).0#LR5
27#5NQCXQO8&+:G]H;fJ0KfCL?BA80C2_d/&CfXFbG&0^+9?g-=+d4P5:=HKa8>A
EL>[e,JfN2=P\\TF5?:R&:T50#[EL@Qa5Q)Q9?^51Lb_YMdVeOVWXTQ7a<[J9e0J
[,Ja6;Ye276-6ZDI4#XELR@2L;RH,/_1H7P,EIc@]RgN[3(6@N7,?U4GcHP?YHY+
1TGXP]OLN@89KFSD5.0gC^9#V^Q2.-=4d\<KJO>&HEM]<3b,)]B1Y,V2\<\I<7+-
c=N4341:MgEcY@&2121&VY9N)9=&T]-gVUJ8L=8K[+W#:T33)(I2>e3+W<BabK2N
=JFa9OWLO,76,/CD2R;V/_22RW&RPCUEK7I,0-_2GMKA5>(B0K8VDcYQ(OP2TA\S
+eT,gP)B\IX];MDaCQCV7@3-f;##8]9B)CZbDNI53J:L+-SP.c#ZY0L.a(^NFOc3
c@50\T\e=M&W>&e.XX-d7_U5DT+3bdY4BZX)bW0.M&c;6MHRDA8_,V?\&dD,be7/
(BGN>-,H+0:cR8Qb)OS+7.cWM6@8KH&UNE]-OW:)/CY7f2.GV,G88PRgID47[+DW
@G5O[\^;FI\MbHCZC->9OO@G)U\.e5:4INR8<Z?O@@A72@Vcf:KW3Ggd0URd09Tf
[)3P=5)FR0E7c43Uce]W3D&E>.CgfRcQ94^)T(SV>b)^BOFe^GUY1-U;-gg]E9:,
^G.N/:G1?_IF[fOeEP&;ZG:X\Y#8^g)(IT:?KY,2U<6);\&T.2Q<cd9FY=D.(Rb,
1)J^X:/&dE9Gde>Z[=LB<PJAd\YOKZU;S8[?:U\9g9aL8ecA[_H14ebN-M0H>aN6
J&ae/1A=DbW4V4L3__:[/B+CNJ@G31TZV9aU.[Y\Y#K>[U/D,0&Cb3/c<W8\44GG
O<AGE(Y57.c_VC+]d5\g5RG-YVN,X]2<T5SSCSA)\V_7TV&QK+@I^+=<&+GRGEA1
KELXM7cbR-;DTWWC9CCCR=B=1&/#DTKP]X?N9Y@N8SM:2^fLGNJ<[WU)e_K4XRgV
30^8_STb+ac)5XgOARI3:N6(>8=e#LHV^87OY/\8<=W(6#f\:-X+#SdLF?ITYId1
/C/cCD4I\;V-)d5PYb[PW+BBDWBQ7EQW[g/Id+1cXJ5bQ?3g\b87b_IV[D8ZLfeN
M3]+\5c)\154N@:<G(&f7[fWGYIQOF8L?YQ+O)-8199;eee)>Y#3fH1VWDK0g0f?
0<d:./@ENT=K</NH.TU-E#BA/L7_YPB@Va?S9YAT\-6\C+Wg;D,TV79U=ZR/PPVg
)UU_V>Paa5C63<M,<JYAf?D_O[d\P6/eQaY/]M<0?YSAQb\VecJ+FUVYZPM#RQU&
->2[TQ.IP0&WV\?:[3LN1QH0Ya5:)TKS^TZWF<XUMM(BBO]02;X#J6?+Y\NY1F+S
ZXJCb>a2:EW1^SF=K=\B/0#ZP^6AVb.,WgRf4;eCPK_36f1]F2:YMHg4,JCG8LS^
6:2KAF+-\2R1+5U&:&-UZE0U/79bgT<:-g5bY3N>HOZ44IMS)1J4;O5fOAcaI9EX
]O)DTB9-=K-8_JDXD1]6L>;/MJCZL7N=g:LdF8T;OfY_.[5A)\RA(V65A0ZedBTN
=D4E/9=]9_@_F#9G@DAe#K6KcL.;e:9Q.XP]EX=Xf6J(ZOM0]+5M.#3VI-V>9HU3
AaM2)]7f8@S./e,73K>^ba+]_@ad3RO8bW)0H[?WY(Q01g<d,A]B,X5W4gO>+cNF
V,\a<OeU/8gSTS6fRC[0[>RX:;],_G9b+RD\I4Zc+1O#VW7BJR.23W?9aXaG\2VI
N9PYA;VYK)&QeY2#.IEdTJC#,<DFDY]b7[AMHZ7WEP:J)ad8RH0aVGO6DR#15@4P
]e,TYdH>:6Gg#Ue3KQgD6RH&c:>>8[3,[M;9)cEJJ^]ET+F@O61>Z49X2(N/,^4?
BM?VX]-NeHfR&BF<6A[/MD1fgF1Rb)Mb@OOd11gSGDXVI.2;9K^U:6?;T,<Z7#=\
NZ/ENQS\:IL:A_cH;..(Z_B=#GG;a=.fEE)b@SWdP_S@E.;53]D3]]_bfb=:JO(7
(?DQ.W0/N9P&RQd)egdB25)BMfa:7dBe?@ad6J^C+E,-\7U@8T-37&>2D](^VgSD
?[)[\5JL5-EC<d3f[,e>MSOK@3G[_6,aXSQ)V37&TH7P5a@K9APHg2Q;>)M48;9Q
>=,6]Xf-e=cHYHZf3bXNJgPd1IWL/^DY4,\>_SScI<YQZg]+b4FOP=B=@6.F4O_7
2T^Z4VEOJ6]#JRV3D(+I@H0Xafg=P,?B;\/F\=K:Vd\:cC75OP[S0?_OTN:[5E#F
Be2-GH2O-+C)6@?]\bcdF)SZSE6ON+4+TN#:X[<H<fAI,R[N+)KFP9V,C#aC/G8#
8P_A3+<]LD=A?eLbCGM>LK0EC;e:6F5SHK]7:\Hc=SaDU>YRNK.@V;YU+L#@[V(O
/:ca2fKPaL:ULc7.Wg76A3a3b44K4\[/I]F&#&IZ-?^gIL04=2IY3[55RCg(HA9]
29bO]HY_/7,Md4S\\&Q=7(Z/HTK<D;LBc^9P\0f&Y+U/].&OdV-FUG6Bf[Q)H;<.
<L5-0P4(U3,8S8)USJdI5fPQ+M14I@##8Z?Kd8?bSM0QFCO::>F#-aEXUM<X3NYF
g6T)B?5/a4-Oagd4)@8>5D:-2HNVLaJ-P\&584)3_.\aC_W(gW[PY-a3ZVL4-SQ7
S;-]5.[5B:KgF4JI+Q(SKb//-&F(70\AS8_D&A;MC,fOBKBfT=_\-HH_HP<,TD2O
@eC]#:37VWZbLQTB(R0#WJ-#(W2L9U,6E7cDaA_.JZReFIE4;9\@R\1UOPbR@/OP
LU3:-4]U#7MFf>/=:&/BAE[K=IS-D<LG,efZ.36_).F_TM(cJIgRKE[e(D.&Y?Bc
TQC9M=cUQF1B7\Vgcd?A=#<RIG\d1e@d5CbdCGSA]&,_=M._U[=]J.<cL[(Y=H]c
,b_ZPVXfR#Af7AR<T:D8STG<0.VK6/V5?)ZMOM/T[F/BQP=aRSPH_P72S38W-A.7
-Fbb65-I1KF7GBgRg1>24G0gZB42#8,(.Kc+da4f?VMW7/=ecRW+J7@+0UXGB[Yg
T_^c7Q?>LWJ5,aTFLYc,Qf4MZ^+9MCY_.PMK]&X+K5M67/]b5Y3-LCS:E+^eaeg)
4aRC4@=4LEe534.?KK+I<:#BCWHKH(>R._Ef3V5c6BFO06g+XBJK&fA:MbS^=8^e
_2f.7QU.MbJ?4OGXX-&RB4,TM-c[?IOc?4bD#EJHFbAfLe3DQ+P^bbIO]a5SCFQI
RP3+8O4@dNgW\V@R7>@<(QE(YIfBWQ2H)]+I/]0b=YDE,.RSZK-^:;D/]]?Qc@DF
U-dc#/ga8ge-E\.ZEDb+RU^(N)QHV/AcTOUNLTV),?<\X8V0g4]TW4:PY=\L2fF(
P6]<JOg.(Z116aT-,VEN)\X/QP47bWba1bVL(X>9VA??TUN4VR\@5)cRCdA9;NC(
4R14(e2DTf/)1>P<D5;BeZC&OYK-W-&+LTF:#@^Ta2NLI;8L4ZB0<3G5==0B+dfb
ec4?@_:IWKG_8Z?F^\g#M;<SI)6116:O]C>_?74K5QUg_GD:-@eAM[2.d^.&H9VT
D0@UL+=DL&:@Y09cW:=69c<1QRGc6UZ&1,5W0&#WB5/-/Tf-EfDQ._@IR\RVDO^3
]82N[-FD2;>U</&;X@:SQ8ZYE172(Q[_#cV8-de?406NVE3&+G7=aHW9d?,WDJNJ
EfcM<GU]=U8a[F89O@I,,af(BLg>Q&X>PG84f_T9.[@-QORIJ/^CbcegS^.F_gSW
/0I]\Z(UKTE)#D1A@BCNf?cPQ>;9\@d/;P76H20^4\HaJGZG#fZ5>4(ML2eOa;,B
=Z&c@f.N,.H75gOC06R[SS8G0O[S^3D^SAT67Wd,_1A&+a2_(UB(6:TaI>JCf\/V
:KBAH)R:1C.F>VMfCKA_0#7d&2PFT0#&e?C&+dK[gACNc#C1dMQ0BT.<OG]/2aWQ
_J/ZOb;Y-7INY;>#X7CNRABKVGR-\eA(]R+dKAOT<?9UeQ:0^U>V.Q/E[=J_NN)U
L8UMU5QXKU3Cad]bIJgBM6J9N))-IKPBC-?\2.SGH[D2D>5HfZ\=58f]E7/CX2XV
+L<2D5LA.e7DbdXL.Pd.gB1]]XYD?)V33Jce(<J1+fbVSRC=P+Y77H;N,QR?I</;
K0e[<XN9H,P/2_U^<=+<[#HED4W6EL+;REOcQH9,,Gd2YAbRDHZ>,>6_P&+SQYg;
6g0aV?@)VO>10FSM;_MS;CA3=4f_a)L3f4@,Z(H,(MfOEBL6^CB6C.0]QI]c13&A
..7?f(AM@/BPgZSa6[5?1dPc2QVSG5If8b=?0f4W@T?e6IfITXVD_SJ3V7dJ5aU@
0D<^_J;))61aG<)50=>CBf;;11EfaV:#J>8/9S7.3@VJc<a9gCL-,TYLJTE@H#:+
ASKa8[BIDT=/[bB1B#TWDCZ]eM/dB)Y+HHP&c73(^T50:BI-<.,08ce^=fTU8_VY
;YVV)01O&CO.4E(ggQKeg=,QI_;[V3(3C)D?#aOfPb[XA>KI2F@-L[Z-7(ZLd1XP
F,OX_LCO.C?W^V=.#=eUEDSGa)MUcO0T]O8H)/cDATL5H#JfK+RBdD<7f_&Q.:O>
V\Q>C328f.SV:_?:MXL;CT][a\FNX5T<fK8bg#]3H)VeAaBcNY#?CEZaSW5B]OSR
4LNg4&SMGCN&3VWe6DJ4MdC>g\b;R6R4GV54LC^J.3(c1DeDD=bXDLXKc5Z8)g2_
FDa6<>B^XBSO)CHTUD2(^W<1B/Pg48cDc?,;50A<97]^RgMM0GRRNO)O#;OVHEYN
[VJ-J?#JPMJ6aK9Z.URK\ST)P@dX:EJP64]AS#/BE0]?cHDPMVTDI-&d1AeaAGeP
46Be1gNP,6H?3+-Ig8A13_Ka99WWPUeXK^^d5[AO\3]RLb0T?YX)eP^b0]V0<J:Z
FHPMC;HNBIT2IS30f>W9W@4G:[0;c&.b]]/8<aI4DF^<R&YL@8?Y?^C&P)HK^>J/
&f@&dXDFI1Qc-D),6IN.@?WGEaT#+\)E5N_NSA8c9[(9^-P2CgMQM\78=Sdf@),U
e#^fP:\^LaWI.LC9Ic85TRSMLZ;QQfg\.WJ<WY5^5:92JZMCf-]B./F0[A/U-5YC
0&SU,#fBJ^NYWC?G_Y<X^&EgF&9=N8d=eY<;^A\WCN):E-:TOJf>[f,;=d>SeR2M
Q5<cbDAZeN@^3>-RDLORc,SO)d;L\2DPI^c.9K:P/F;4CU6ZK/X7MgG1Vb5\a;G7
ffE^Db3SPH68DYf;)A)aJEHd,24[M_9;M));aV4K]]]PODNKR;EfVS<J:g=8eNXG
.(9ZQ;SQGK?4R(M]QeCgR\QPMeeCU=8.-58FL)7Z83020VBZ>ORPD_UZ4KKC&dYW
F:gALZ8(Z#([XTR<X&=S_)#bI2LcXECfR\O/@6IADRRGVg-R1[SWH;BGf0/;0YX=
[;@MVe<dXN.AMTV0V)Og(JS\4bH>;<U@b6U1:Yf@Y,?.V\4F;B5<ZCB\O^a?f@8Q
I?K139EXAff2+LIOR=-YSbVTa?+]>f,6>8\I:6Z0gT3A[PA[_Q.\_Z_AS]0BD8/H
P3#(VE>g7/9JC-_.b\RRM4C:53)b1QeKZ^1>15]:YRP46:_<(4[^-.-(8>-FX/d@
b[_T]GWdTe+3Z]EVMWa\;CWP->4+2<b?=Z,a7ONUVX[CM@72O^I(K]9R_D<ZFa;#
++-@+)(e_#I482KO[/.d.)Re)dQ?gN,L>PdAYN86a<#HH0\8PE4:_)cTIDQS+@[L
#3<_5)39&W89QNK8RQD[@-DSgDD,KIQ:84g;db2V(DL@a=ZQ+MC(^&UgDMD5J,YC
BRJ<_BOJLJ0>T-X+^P>H-5/=(B;>[@+75ad]\55@@Z8L>@W5<1VN+4OD(+Z2aeGM
ZT^/FeaEce^RC?>;_B44N5V?0?f&R+&EY]d[b9Q:Q..:]JD:KH?WM[7SX(R:^A6.
f0beGaFQ[?3.[Q9NgFeaOS.<+/QOZ/YJWb@?G^GRc986HNgE(;CM\:F;@9\7:[ID
?VNOKN0ENdD#a(YM0>Ae/@QY.)P?ODG/@@4eI-a2H03<\1+]I/1]+8G0>\\eM)Z;
_2V0;f9#CWH87LD/+Q)bd1=WbLe,_3U\,>eU1fg(<b+UD6@,+:65K@>_8#7,GK(b
W/.91S&?EJJd4L?QVb&&3NR:6QU@YV[[0J8N;;_;_^UULbH0:TA\B3W4D+6IV<W6
P\Q[Y(NKUP9-W-ED1X@<]e^MaM/0GKf>#7J(/N/C0JHB-U+_(-.2W(G:BW77JLHP
?IebMNK;GS:T)#5M_3c)U1+_K]65[G3,^A#QDS.-,_IY9\_@=f26Q?3V>)8bZ9>(
EIAIY]EC]BbE0C=a7(DGAX.GZ+\/:UQ90WNU:ON]bIX,5C&O99JY3+E^]S5/-2V?
&fR5Y&-VQ/e\AfZ&.+/:bP,WY2QXCa2E5:15,=;?K7^RDbKP1B?HcV]H82c->K66
J+K0CNQg0bBTMX<9V5XTgO5#W@HPZM9b+)P+LTeU)(_9DBe6?5OM_8.0T,g7LL4d
0-@016Z-9M=0&E=eGXJWR/8ZG[?=eaaHP7\CC#5XAF9ULVT/2<YYBO0NZeBL_&K)
WbNS-)4\==He-A^a&8-DE9@RWCM(d@N5F08d9Zb9JF6L7U[#K0R;1.bMQ:#B0a(/
U>YD3F6/]TRgJ1EH;X0V4B]P=X2.7D)J1?RbD89TR,.Y]675S#Y;<VIg(:e:J^,Y
7SHF1\70T[8^3:YKf:O9=XKK]/;R3-V_?4+Ja/f;,RALYf>VV^1@bGf163[dHF1?
Wb71X\T8MS6SX-=XA/g8Q[5E^cT]P5A/c]X.G@+5#eM8;D@B1F;^-1NPdPRgL]H5
HT9O\78g06:B8aYD/:aUW)RK>.X[Z.J[KR/X8QJ,&Y^)C3>,:MC_D8F+IRI<X?PQ
D#^)\063899(/3,.S>C_H8gG61=>Y3eEOOOMKU<?L<I)VY\5Wb:@3^5?a.CZ3W6a
;BWcg\IXg8VRHN^2GYMAWEU\b6:BH2Vd#e<NM\VG7^6db_Ld+R)gRFKTI2AGfa]2
\6E#:1]Mg/_Ha;6FeCAdJUM]^P7>S)aJE)Z#C5=LPWHDN:CTXUBSZE[4MB]<JMON
XEbV2BQ;T6UJbW?O75Z-NI=_CD)5R1?09E;S;[eOfA0)g/Og=\+S-T<^_SJ@0V3;
H@>g;DU(C0>Ode0HGYc0?/E8_J_7DdBMSL7ZKXZGH6.FD3R6Ef&-,NCSU7M[?R)@
a]:gEcB\)0@bI0BCaGEPH6I+[V:WNfFU:50PHaa9-bQW?E1g.&,@F,;:0XAU?UXR
N#X&\+STPc4NVHVJ.IOKQfRa&NQH@gWN9dBK3>=4LGRRc8&DA7\IWC9X8L[Jf(6^
5(DR]LB]JQ?V6.6B6QQK44+GD08A=??Je@W6>BU\N;[+;VY0OV2)[085K_82Ngb-
eZ,N#ea7\93+O;.JS?=2CJTUg-@((]RaeF5a[>XbQ2/;+4\JLFYQ92VV0NL.3G56
F#=R,]\FGcDLVWI@5<M5\IfZ<DD)1-ILR)=51d[_P[U=W?IX0EVTH3dF;O2Y.0+g
XQGSS=gNG\d(dUULg@F<4ZR4;=G]P<0d;2,?b)<KYN7W?6:X>57O3D8EPK#R)J)A
M-<6e8\fdXg(K-]EB81O?2F@8(GX?2GaCSQNV&A@.dON.a5D3gK;_:f?CRaR>WPM
b)4gXdbKEBL9-;]O4>aCc>(HP62>[Z1g4/-:](6#7QOZD+68PJSb9Ob0.8QP(O]W
E/5AWQSB1daT_J2X=)DW/MKG7#,[RP]\)cOPGEGcPfaKYJTeaZ.5\;=+U>[_a2^G
]CP14@KGB3_S8cI(470PH;^Xc_bA&1QP6V3/Jgc?WdaeAU1G2D8KI5\H-?\_>(Xd
#9daOPPgU)&H^EE;bUB.[M1G4?[M+.JL,^X2JG]-3/]W^Xc\>LbRLYIHR\g6(T7,
1<9dO6B<\6U3Y/e7&5?gKQ12RBU>6><P4UJFUO(382A>9IJ/1IP3;ZBN+4))MRS(
eWU4ePHb[?[Q,)FQ\[P&@=I8DM7;N,L<,LLe75(OH[&&,;d/#c[83B=5FffcP^#6
2V9\->f7)(=KH,^V<JfF/(08^]BM^Zc?\MNN,-Xg?_LUIALE/WX+b2G+/>DDd4V3
2I:=@WV+@N<G54Ng3BKKERe400f1/N\/_GWV66WbN\WNN.b[?+8+(+NEK(/8QH_4
IL#CP<e&W@C=d33]K7d.#XQfAW6AY>1E#CFfB,1EfSGMcW<-d0dL[,2V&.1CKg/V
N#3:[XR4L4B(0+OD5fIE?A1b/,)_4.75^NJ5K7_D.KCNEF2dec;ILRRf+AK2(F63
O,].WALR)?&J/RG/N<gZ.d--5]#17)A]6P(8S[13_/+Ib[5c\Y:(^O\MXR]:[?0@
8R#)Ad/#N,?PgF\fD,L2c3\KENEIL,,1MH>dH8Y+9GLbeN[cDcfV,07LR)(=6&XB
<1Y?(gb7?:G29@/,\Hb<H#KaK7C4AULHH[]>6QU9@:&CP917U7FIZBIfO\<XK@W&
/32YS2V;U5-6)#J7U<59_UWcH(]E54fO-]Tf;c-/M.CA=9fM-.<<4MQBTS)<dX?R
W>^aO&Ue]L\F@ZB\[^R=Ld\QZbN)a<(fK7TFOHJa0(P/1TIW4g6SW\H9Z36WG4Y\
[:/g8,dOUZIJWW&b#8Oa8b@(HVMC3Z5T_MN>?),1M^.Wc@K7#d-@A(87KC2OY2-a
#5P5g7/WA=X8BA?@7+gWJRA^F9&SJU6E5Z3V-UD4DLTIKV.QN,D+4N?9\.Ma.f-4
F70>RGF]g2OX.EA>,UQG/.8U<?;Fc8XS7S#;6ZD\O8TLe\:ggR31[@AR0BR-@Z;D
0XOND_,J:SMI6<,cJ(DJ#:E/O^8KAg<Q+2@IQ^?N.\^Gf:<P?P&)3BYQ<8GCS#SP
=>P:KQ&_NNR3gYEK//)DR0?X(CL+?Y[PZ[S(#H,B8&I8Y=60JI[;?_7e7e.Xc;CF
MFRS9F=)_#=FWVX]YMBe@9K:5VaROT0JAYb\V@;55H_TeJ#XUQ,SI,V0b&J86E[8
+429:ZJQW4K4<P5+1<HU8-5@;@JU.#A59g7C([LAcgKAce?L=7a(D1]#278B.DEM
YYT/GJa,+d4\A@QOB18?(LG#VP9+UQFR#aN>QcZTGPJ\C+VY.fP^[?CE6DdNAH3,
44>e<.;1-bMTCEL^.?S)QIKR@Y36@FOO6=]\>[>4H@4RNB011I[)RKH;9H])XN0b
O2f#2:JYM9T0F(S?<#+eWE;U-48GT=&;)IO38VQ,P=0a?X_Md:O7^_=@=Q<PY2F;
b+W-1R1E@61I])0?]9#KCeFWCP5[I:Q3S<aB@\M(RHYM+&,VQbHbNcBb,)\M<4)F
DY-[\S3_LX8O/f6HbZ;>741_NR6S/e6(SEgPe.US6>g^aHb@&Rad5L]MKgY&aVRR
5#DR715?=MHT0d5A)cJ+9TEHPOMd2U<#SQH^e.VX:g^2?>G&ZPG5:G<83F_UNO2W
K.[THAdR/WS:cFc-,?&QN;:VJ>-\MN\9QVd2c5^d7fE=4?]FWP35VY_Y5=:1bLHU
c:Y/C_YVe&>L6\(D;cGQWWQT\Q0bB;96KY\B=.UIFLOJXJ@?#E.N[4/2c?aYH)[5
5&#1=cS+:@<DM]^.ge-dK)[G-0bf.ZA8I9YeL?:J\M<IS#,:AIC9a7]G??->Be>5
5^+N]Z1g3L]_#a)c.&1+@gLY-\O^b2-P[<?7;]bXH##L#D3VPC60Z6//^c59WR:I
4Z2=_)cW^DKG.IFP3=S7RHNcL1[-4:9Tb@C(EC(JU?Ib0NNPBK.MC6<BV)?;MNZ?
3/AT3[;\]9RgXUTN&J-U5>3C8QgI6SUI[XMB<gJR0)geUYe+1[bAC&e0,YO&c<I8
(>.5f+b](:WZA6ZS[4aIIfCA_#<FcS[OZ?ePRfcd-.X0CeK1#;d>g1;#].9,,;##
12C.A]E&B^;:KP\(9]J@RK1c>/dD1;G?d@QF=0HU)6><LO8+]K]_NZX(AMYb(,^g
775L)<I=F1:#;^7@@c1bXg0dKQJNbN?\_8\(Ug6O7HA)8E3T4&,\YYHV7<(f.GU?
000@E6#^#[Ge=PWd)L1R3ICGN\8I#AI>O(4I6LX.O?]-V=_g\C3G5gcS9f>.Dg]0
90D=84-.90eS-GEVMaI4(U_-Q-N2NIeMVbM>2N#fMa29A==U]UfK488&)N0QD18V
_c+(?LFfJ5G&51-D@7LQH,cVZHZ]5<0;4P+O4XRO_cD14<E/P#NK.;E4IPb)[F&U
;T_@;e^S[9BL1;E-fOaY#L5Xe[V7WZUeEO(EP0WGSZ6:g[-4[6PddW>EG:#B6B35
3OgRBO^f:fN)7,U0WBT(^AgHH[2B5_-U/5=0RXb)<R?:=;<&Z>b\P]9OVG+)V79W
=G3K)5<<fH.;U=B;N#Q2M_P@Y4-a2.NdV[=R=DPU6U.3:BKT_\:C<8C+KgFR8_-2
W.J;^:-V6:9,BPKX?JA/G5&3c()IMS\Q6.2WQ(Z^>[.A<D&X42;F95J_4;&P+WQ/
]QgV+QF#;]Z&QXNSNZZX,38?fM+5L@=YcB=cX[&(d1gfZDf_\HA7KVLEF&Y]75He
Q1TW87/C#-0,A+^3717e)dbRc8=^I6J1:^QPEY(;QMg/aa)<]ZBOZBYAC<)?9@BO
VTJ_Ff_8JD_M]/+AS[Ag.VB.?0=Y=,H6C=6>6d=NWS41FO8_Z2TO>AaNO@c.[bJE
@-a.,BV4+F@N//+WK7LQ.#0[UJJ7E<WI2P\gS=;bAbg@>K1f#O=+fRAeGR0Q6I8N
7F/45;4=)fVNT8)+&0=f>J-WRI1aW&6GNWLK\?KaIbLO\fRQYQOg=8N-MWS=JQ0@
B6/;+.>[<Pc^CDW8/Ve_Q0PH0PG5O(Q)c(3>@,54g61=XO\D58S52[)U=Wd=<;ZF
R7)IM^_A6D/:<,M&aCBeC5&G#+W\+e2._1]VP-=S_2eV<Vd@^E#ZSTR4AP<@:d,J
R\.&Z^:ZP)X:UaW>@WI8I,^Y/N0.EQ3?XaEg)<P_2PTdgR2H6YdGY^59@?I4O0.P
b54H7X,Sb61TP]g2P(OE,1=L-<;Eb82YJ<dHXUZ7c/@QCR?IX>>E,C),<T&X1&(U
;L/WX9^FA:bPScUAB@[DMU3:/cT-W5<20b]/F^Z(@9]&Y-_\@DWfWJSAcXP@5_L3
>e^bYUDY8abK\c/M4=&54AMZU4CO_JL]TRf<>a0Pa.CcTRPK6CG?0CbIb;^IPY+8
6S\)G8F,bQf]\)42WD1+YWS70HP)XZc;LCAL3+e=GO3I.83OR1;.Z/JOYJdWB+32
?LB84],dgEJ1F#X4F?J:Q.V8_>(?PcDD],E?gY#/f<bc^(6WWU2bd0+#AB;(&fe]
(_g_?R:,P<=/<BT-eUT=g)4E58[9^+]>6H)DU54>LS-G,VCcSJR+U33c-@#:CCG<
D(b[ZOT_b-C^=C<OF9@6:=bdH0:&gLGYaLX+CUPX-K?,5F/P3);1Qd63b93^@1gR
:IG[g(Q)NN>:BCC4Y9:=YXE]d.M#.:CB[)U#dV(UFgcVZ:9]f,OGAX]Q\TZ@C8QO
X66@[A1]O4JA18fC^f>917BTK0<T.&X@1<FO_V]<c+\Xf31_.&63C@?LI-b@6VL&
L#C\eN/BfC&.YR6L;@]Ige>f?;_bb6@<F.>T?X&.Sbg_A:_S9,XKLd=e)AMOGV0V
20;[QPDE7((V74ef(.c?c5<Ba?6HbRAERBQJVfc,N+GH2fY=PK-A+AU/]28=K?<<
/;=E^)8^:C9L/Y9U6GG#,DXZN1faMU:LA0709^V;=J0<.O\eQ[D@1)L\TeP#M-1W
?O#G-<<McE4;[g>)fFgJ:gAT0DU]dT1dH(d6bL+3@+Rf+aZAg/G:<Bc&N];XD2=1
YT31<?=;2S==D,A,c#N-FL:@Z\6aM>dFV7;Nc0]dTF4.;)B\F;9ZLQ<L&Sf8,\M>
:b4Sg94_7JWMT4WVR-cMOQ\2S]P>F5?fC]d=8-,OH/#HTXRKJ,:FcU&YLUOafYN(
D\)V5XP.(SE)<4)KY\:N65KH0H7EdMX-ZMS];9OD<(#WbV_L+7@ZS/:eXZZ6f_6O
b\0/=NAV1=0(6U(S/KX9A?[VO>:gM6J+>b5&D)YJ8,1Cb<P&aIM::J;\HNFF-NTT
6c]]]@(71\A@82,Y:Q=D[JaYD;YJGD28f>U>G/T0JOH7EWBHbdX).,?[GTIV6a7E
\1aK\V6\9TS-?OC&LU#c7#:41b\I.C+(VB+2]9/d^R[d2OUSMb>,_[_8LgP]OP.Z
VLKD0^Y8HD](IW&Fg5Z.?+4ePA1I78@)-HA8&bA?a@C,fCQdW,Q0,,g8R5TEN3b]
<P760dWLN,RWF4b?<(\@0CV+geFG_)bJ1W7[NEUg(ZEBdd-HV79Pf/LA]2>=7QQU
EK+;NS.7HP>7]MaDRd>5F/=U.@d(LZQ0A]9YD)L^3FV-C48KD,F.<1YE/8/5K4]3
[-dGR6fJ)&.\_eDC=L:]8S:gR?Z:QX>+?H47ATZ7N_\A9CJI<2=4XWOCeSPPX_^-
Z>_P+BfGeVTeEIFHFNg9X#2?<)GYY\\A/G^&6H#+b-40GDOSC<#:]f9-Qd-B^,5(
/&[P+f]eJ\9@5TVKbfKSc.-C.VaA>RabF.64_XNJ,AWR([V7_Y@[,T7J6LSRf,.f
8)IgEeG1C_Ge21Y)4N(DV/CM5=TQ/d:H/?aVUbBDX)^&N&@U+J)DX#NDTIIP3,B>
9:_3aacCOPP\_e^Sc12S\P4L:]RN5PYWgbOC[<YVPdU+I&H&^,7G+B&#c^CJRJVH
4_afNg<6>2aUCSP3_V#&cP[G_6-DE@JW_C3F+0/^?c[DW.N-LF8ZKYY)aZ:6;f2H
XYZ>NZH>+9JSHUY\TO\4>Fd6X-;2719bUY[QgV-Me&GH3KdbC?=OQ,\HIfSG)(52
1=MEA:06fO,.\Y/=c2W/UIBIUJ.ZeM<X<DYXT\bH.(+,Hg^9:H9:gC;d<1(97>.6
\>#K/_C)UeD#U?b==_gU9,2@acS_Z]Z]]]JR3[UXA1N\T3SZLC/:,YBeN(VB,(R;
=GS.44d#V@eE)DNI8eE34_H[I&<&a)+XJDAM3g&aTTBQ_G#A6?N7N1H7gLg00KSE
7b/.]dU(KP1,1+TPH7)VTR,57G&]DB1_HK5e7/)EM];;;=WGBB]G_TEZ]J2W8d#2
VW=KB92G,@?ZVgS+:Sg[65@,,9-+_=9gQbR0@1.S,[+fJH6--Jd4(7>PH-d#Xf@C
fQPQb\@KO+-8WYL?,Egd7fc8DSLg.53TPSIRDIIOB9Z\<UJCOWN]W.BaMHA29cZ.
1ZCFLS1Q4?YSZA;Tg+G.MI5PT#4-Hb_N(0;L)M@f7,Z7:>@W8J5<-&B>^9YCWG&5
>;BB#(?.M59\,DbIX4U6N+E,0VaPT&<9cBRgZ5+^PDVUX[cTR1[ER69<F:XW4Wdf
1.I+,[g9FZb/>@:.RR&>gUHBPM0#C^g31(&PF#B(c@A=b.M<X.23GY(5RG-..[AB
&WJeAWWZee)Q,g\gQ_]e><1TRD03FY[<W:[F.2@Z6.@&^cU9V7)UC0;G<>fW?#ca
3?8Y.UcM1I2S0&cT4<KIM_1/ZO?QNMK2dV<OBQ@dc987gG/b=2JYE,eZBB[g<-UY
N@53PZf?>8G;LacIKL;KC)Q]_K,0^FYVdcgI/L5OZ/6cE?ObBe#f&^,-/4UQX;L8
9I#Cf2W;6Xd4d<FWa;=E#B#XBYP1/ZM+):T?e)Mdb:bB]/.VIF>2#FE07P<EeQ=Q
LI.bN79K,C]eBZQc(=T\O>5\25T=8cQO-K8+gZb,+&c?8DWeGLIg?dP;65aN13(1
MYgWbK#f=,HNY7WfPPDC:@L;C)eQJ&0,4+-3G46We5G0SA3BO.@X/gVF^dG3X([e
]<D-75PO#Ed\N_C0[(?E(D^91#Y/1HFT2b>Z)TSG7ffEcE5ZfWeO<(=a/7=>NFJg
_12;_M1cVLT,aKUXFMV3L\3\=@W(9:48#X;=-/3YKT=L[cb4\2gU[+NS(#;04C</
(g4Dbe^C66/c\6R+\QP<g>PMCbDAXa+#H(^E;?#X[dBUEW\T2@L<7Y^./U7_@(=A
3V9@<C3I7R-@^aG+agWdYU<1[X:JeE_>B8+TUJ9L.4d.3gZGH>e3L^Ye-Z5\4L5@
\OeK_<D_T&DL+,:F8E_\1Q5H<4O-3/+U/+K)4U&fV^>Wd-aadC((F2acJI_dDQ2V
VOM8/@8IC-0CT#GQ<+8BVg\a=V?9W7GJUV\@D.)/W^41AYBFSC8[9V+];egH@Vd8
Z+#X2G@:38e:NO0MI#83g\M2KbX]f/]gW)eU<HD/aDc544YfdIcYAXLG8+R5BY7Z
fWZQg?U\/@LOIY3EeSObeORQ^KE2\I?3R^9J2X__5-5X^?-TP_2HL^RBLT+ZK8#+
)(XC7,#Y8Re4370[Q15GZE97>L^>2(/)+#N,5f;03BL]1?@[2S&[e00Gd0@Ab7:U
QWJ-c#ZPc4)S]XBNA8dFLQ_gW>V_9aTV;/0b#]R7&d<ee:)D,DG:,bCL=-#@Y?XT
=.6M\G^5g=&OfgFWJMbF/7S5gT><)(IZ\BB2NOcM]M<:GYgG,g@gPc@)6;L:B=b8
:Ta:g;FE0KFT;].==?#NU_YUAI2#RL+Z??06^&=TV_J6.1(=9?+[]aQ)G>-BJ<cH
?]^7M:NZ6:MSgN1=KR1IT]JAKX6,4Kd[ZJfS)fUE\[f779N+X)5.dBQ:K>Bd7ecZ
BPN;2aL2eQ8::)dbHDeN,H>#-Z5C8R0^+d[Jg:bH7Db#ZJb<2I:-2Y/Z<.#Z(f&F
;_B7gVND1MVE)PD7eLL+Pba7<G/CFP(#.?:MJOYg6eCb1;D9>+LQ4<<WV/G)^/f0
9(2IXb[7HZ/3V;L>^JRNN2fI(0)fMN]G\Bcb,BMO2P>+Og0XcIQ>Z>GA]&5_eP<,
L8@_1FK,?01F[_;/:geR[:?gWf?.<9E+&T8UG/2BS=SC@&>-d4REBNWf7_#I,1+c
.BEG(2O:Ye8URK/d?7c>67UYA[IO/I-cFOA(..HP21M]9Hg)-C;6@FRFHIAY^XAZ
WBG.,CL4DS0OAE<bVYb/a\cOS-F,0?61V&@C3ec-,:4R\?]@M4SXCDPARcDCA3(<
KPDDZa];.[3G)7;KeSW.A46X#X7N6&Ia;W][0)NTYW-c@3.)5C-JED#P@;>P:3A[
>dcbI#;I6a42JYRHF628.AUC&E&;RL6C/8#,ee]S^b8ET];J]J9N#I=>][WG>XbI
(:cA:==6Jc@bAJU50&>?0XI3]YQF,g<_[#P@T2cW]d])JH6XMN5VCbR\R<90e-LS
^[[5;;9ZESMcGb[^8aU@)4C1Y)A07g)08GAX9.a,U[0Ib4aI&gdQ6b6TM&aE,W\9
a72G?_]0fI-)6F0V0VV-</WW<eGgY,]WKLW,N\63E?0W62<LW6@P?LR<FQ:N76)J
a4(B0),f161eM]UT]1b:\.<](C-e3ARDIN]Q;Z7F0NYX.]M)S#06PV#QREP;:4;S
Q7ZN0U?cPCOI799UP73;&P_HL0UTeIW8:2]M0//eb,MX6LA=8S_+MPPQ\L3b?5.:
;^<\66XM#YMJW.83>TV2@YGa.0>YfR9N]Z#<<ZE=>a0Kb@@W[>JF;I=G&?(Nbd:[
]d#J.b?=FfBQ(KZZ1bEU/-HTH<YHb\,5aFCSZS]WMM0<2XL/=NbM_DK[E@Md],E0
aX[T6LN<Y65d994E)@1?+#@M<6MIC6,-HM[]PO7:O(3#@gO&J0a98N#>aVXb)\=]
79Z@2L5BD<ZD)K];:@91I&F&<&7DH4I,^CEXC4(Hb8V@Q&L5]aK06QHUNX(S?f]T
ME]7HQV6JHK>McFLL-L_7]fQb1H)d1=^8U_Af4NXVG1e3d#9H7adE4A(MSd[P7/g
\g0f8VC-eTN:&Ne57_CV2YbT9+fK);1J8T2V4J9P1bEK(><6.YJ6)6;;B_JXZLN3
\Z@Za9[<^<U@Mf[,H<E49@GQT736XQ(a]29^AU-gHO+L3\MJMB.<cCEZURA:0X4]
R&fED]M]_Ae;?H&_OL/23V:M;R#H9T(aI(T@ca(AP]/DSY@U<V8M[6VLYVR:(MXY
?B+f>]WWTb\OAQL@[QKfU]R\T@X<NG\E5#He>RZDI:)#)0^d2=S[SBV0-T54cM3Y
WAI\=\[:<WXVQ=2=1X7NcGMb(+C>d:_ge?41)LA[R+dZ5f-8@cF/WZL\S5VfGY2^
Y919<.<]7RALYE&E4Y18_R);/8+W+#/XWEgF[IfRMFF3-E)5g+V1[VN1]Z/_eB>#
\34>#dA@_6/OHPR.WLTRFD5]&P\&e_5:7>,E^HYD=\_/E>VO/.I(;71E[M/\_a.M
+NW\A4)Fg5W0&,4_dS?LU\-)=1_+PQN?E=VF#QJVd@]T_@HKOI_W^?Z<->Y+HbKd
C#&26TQC5JfW/Y,M/>dDVaWc^[X3JF#R1X+5@OKE,[N86U@Bg&.0P17O-OAUO.,e
_+:?a/eD.ZF6/MOdNC#TLK?P0]TEEP#]ZGHMO\46U)U/?Qb3+N#c&=7B&K1,P9M_
RM12,.Yg)R_Ef4ZT#6O12DU[[gLc6O@)ATK@LI5MY1B(Z5f79\Ka>Q_R_8;MZWGa
1\6B-D+MCOKDa#:4=UgL\\Bg,ZSGa;CRf2;9>^eR\X5<HKH;(U7@::6KGdSRUL6P
R@JV-O=8P].;;b]?F83>D(Mc8AW8eV._;_a),NK_ZMK605_77X0WHbaZa0XR>CBB
dH@X:F+bYL)J6ZL\(a74b-PWQ=:_K8g:^3X\@KRcDe5#\L6TILfU=PSFeVFV<.ZL
P1;(MbgDRNR[BBa.Jb+Y_egJe).ePFA7_]YOZZ,;H7g<=()]-_2IST1Hg5\Z.6\#
N,6bLGSDK+\.J[H1@3#(\=;gbbE->^X1Na@AY_A0fR?eY/#0d6(VRF,A[[5U-e3T
.fVLWb2MU,dU+cNBfOPN<K[;\]16GJbH-?\E/UPe)eT3^e:NcXa\WT,^D>IL+TDZ
+g>.JLBP.IP<D63B.^#05L47;^_-=&(OV3DR8^aG5c/C^::Uc;G;1D=R7C8Tf4N[
GQ\->VMcN-B>e9P_-9BReP-N/6N?XHMLMX_@TW7)GB-XJ8YgGEW85DR)]_^YYfIT
6_^WC\dZ^-<JH,U@,C&\b&9AJ7C_R63#5SKZ3QaPb22U=,IS<Tdg)R5N9Xa<J\HJ
&ZaY;G?YZ3CT\DB1HUP9P8,g&;;1cOdV6^1;3[g9RN/?;^BG0G\X/0EQEg[V30dR
0/5/g9dR.DCXK,_Vd2,M^I5OdB#=3(&_Z32,a<^d,F7IDM?=_X2cY;F\gPYYK.K2
4-QBVf]?=(YLQfM9MIIV.UW9Bga]g.I7a2fBb6XBYA]08Nc]2F?_a@ZBK&4H1_aD
CcbLU6K0A,Hba=ZZcIX;0>83LfCUVDWNRCRZW/Q?C^L60bU676&4P43RX4Z1P7?:
N#gA<=+b_Me5V25?ZfD8feMR4JFV\>A-_E+D46_1IDRJ86/bSKSF1egT\[GE\/[9
L<3:3;a6JYWN6[?78J>a@\>&:1?FMYB;)/;/;f>A?G/R[eG2-VaT3bM+STQN]c#M
USaUN;T]H@=.+UWb_PL9N3&8Pg4#FW_1[AXU#^f=2T,J+NORRdPaJW=UO2<GX2Fg
_3G:b9Q7U&,X@c>,S,S#A=0e6OH&F:cCF2aV#EaQcg7&-XEceUH^d]8#:VH(,_,-
P1-15gZ&Tea#0WS&AbeYWOd._\Oc07A>Qe._#5.>^/MQYeX,5-U-2VQ3d_1P@:BJ
&@KS.e-^?e.(7HH-b4(H\1W:LL)^T-\(gA/+7<edf?Xf&P?)E\?b.P(.>_V54a3K
\^U^[D<;PK83[>>QO)-)0a(b6>M=FC\><;ffDC;:&^=2X=SdZSaf1>d\1AT_-::,
[80(]7UX3SOFV#e514]]DQZ<eG0.Y^6NaCc>g#TJHGYbY3?eZOPDTc(4P&>7^=IS
)O1^240SFM>.1N\(=caNHZ)YR@GGYN25DEDXJ.=M^]c/YP<HFFZ5cN89aSHSb06I
&MIGRH8.a6UP=0GQ>La@fXW.<G\X1aX\B?f2G]RE0\)ggg.S))KKE5AS.L9D;7E1
^NTMV,HN,\4-@eGR?8)LB-8D0NS+K/5R@.cRCT.[E45>2(>Kb/5U<R^JACKTeL]+
2F6H)2\?I8AO2&7./^3Yc>^ZBa0d[\AHV]UgTG3U.0HNHB,5T7fPGU\Q8g<.?():
J5:9B<^bNOf5&]JWD&fNIOa^[NR<^[1VUY7VS?&79+Q[.SHeTb?FGYQe08)LO0=1
<G<AgI[c?NC(V\QJK<I=0a:N,F,+0FG>Y/W928]800OebBE?g81,2&ZNRPRMLTRS
MSHTY0JIN1R\1e;UCU1fQ>8NEBPWU@a:G&C3JSdH578Eg53>^4(>;KB4FdOb#QCW
Ng);edBNRHR&N(PVH<]5ST(7)99\>2Nf_=6GP4c4P+0N<<TR-a8gH)cd,f&P:Cc&
J+M.R4-<e8F8Q3(Y&CQgL=NSV#:]3I/+;WRR&SCOH@@e^+8ZFBfbg-2QY&GG9GaB
gH.>9f;I;/\\)I4JP51>PD,g=T)2X-;O]1H)&NWcP2OOA0Bead=f>9<?;RfH,E_N
4=MPHcZ;M50WV+WJ()?,I)<9_McaM>N.DNOI(>HOR6YLc;,#5]\9^41<2A[Gaa9f
O9gQTcKJbQJC3<c;eK8LW6dQ9&-/eD\NZA-fV+VSG)2+T31Q@+/2[CK\dMa:]_YR
DTKc[G-M]eC:&H\<,>Q4U]dgN.826K[N?MLgNIddH7H0W&AU_8ZX>FaT]F[7<&X[
0&&@;[dUR<C[K&A&Y(<?E&4><36WG=H,/@XWW-V8WEHLaC_@6DC??++KWXd^?TUF
6RTe(80+c60bK:PL#?9.H4P.]L47NE/1GCa+D8/8W4Zf]B3=eCcT#g><[9&D++=M
\5EQ)N+0UT@Y5^[\JM1J7LTHY?c2DA.BE[P4d>>Xa?^0_/EY7.c08>-)E,PaJ:Q3
2<MH,HR1KO\PI=V<P91Fc+\&P@;Z<(2Y\1EL4^7+26)TJ-?A0?MKCUda86^g.a#L
271SU]9)HV60DU6.T8<=8\@H30W3@b&c+2Ze+67gOd[G7@Udgb&ZKJ@^7N;:bW+0
gRF7VD_7c5QURQ)@HC3BC4H<]>8cE&YQGDQ+,/d?DK[AU_#FTVMJPa<Y+(D/)_\9
[)[[a&0,CJ._Yf95-S,>;\B50g)YR97;fcS@KO7PZ>+e/5<GeW#P&N^4KY)da+)1
CL]A:FdD4e:Qf](e,baTW(M1&If4;C;=Ceb\T#V]_f^AZNN?cHT6eM9V0:]P^>e6
WJVb5JfV/4ZJU>6AggR<RDZI?M#\D+#?O9<H27,aHC-cI^I2aQ+A]A+D?SSc-G+I
.A^>A,L.6bf/g=eE,Mb:eTYC\/\ba)Z6SIDc>1B(Ea@aROc4C(Z=H6_6+4SS#SdU
9+MGg3UeK3?(U9D7[f1D?PHeQ.38WS(Wf:[D^+8^(QgbHK?Vb&YT[3NU:IEbaZee
ELeH&FWL&X-D:VZ<0?ObGLKYVDaGe[5ASG8R^-Ce.KVC)6V1,_MSg36NgJaM#^KI
?H]&>W1H=LXFH&4K9)6VD93WD;4G;O?65F^dVNR7a#@O>2[W<M9N_7F.@/ZeV\Sa
Q8a4@6c@&Db+-d?gULbW=&ZUDQ.,F>EaFe5,g_QX[Z63]A)HWZ0PPTgQ\??&b)Y6
XU=G>7MI[g#:VKL1K]K2HJ3(=\@1I:9\a13CVcPW:J3GcOG5SN?f:5WIF9?4K-H&
AaR?Z5B9FX)?.=P.3(Z[:/.?C.4UTWBJ>0c(^eS:G\gMKCIG1\GA,,5LH&3<F63+
B6P=e-Q84e#.7/cW:W(fO@@<bAY,U\VJUL9EDd@GgR-]6TO_S]\]fXBR-7c8B565
@2W^.3#LQQ60A=^P+f:3A+2,XcK-KWYYDFI:fZP)BG[c32_4Z\Sf<fNaMPQ+:Q8Z
f:>81Z.2^SN=0fO&Y@fa4H8M<-G#W^MCA-a/335]gfKBgS@S6D],FF:f7J8\[Og7
]&M;X+WE2bWT\N_>g>[Qdd^H)SBDX6LF(fAdP]H)V(#eeMg0a77d7eK=?SN2]V02
BCaZ5];aQSH]K80L8>\KRU5/-4[fG?+B+];G^3K2J_05bWb)H(=@?=f[cD8UEMM)
0;9VPR&W<==9FG@E,CD]fSY&LI3Nc>-:[8:@0:\Y)PQBYLI=/BFX_a_(3F.<A_D#
&M.bUSeD@9b:,DU;fAd>08F7f-4.[7RHQPP]V-I:b<5<CJcAU,DTX/FI.(ZaDJE&
>b^8a?,5e4_,P=dA09=[aa2,gcb\<#ID5Jf0+2^>II633<e8CEfe#,eb@Z;B(E-7
Id82M6[)&[Sc&fd96,XV^]VOg@7O_7O1B5_JaF571>22\^_T3E)T0a3A(>c_:R)J
3RQ@+(#D/GX>EY,0&KcGL^=C1@QGQL7@XC49[ZN3P+7bb/+X75.;NOR6/CdTTN(N
dG?Y23Fc@]TYCH3@6KU&JP.bP0_EBUN#QYK_)HeRZ[Y;V6D:F?&YEROeF@]LU[\&
IKcQI#c@B@69;=\(,gF62@SCB6@BDJZdAD,\6?L.G[/1:1:DQB:ZQWTg]19F?JE?
E-([&Nb2N=Ua[D+5T[@B#4/HAYG=c?IJf,7\:bAZ=#/8aGOG05ET@;e-R+e785e^
4eT#3\c:M-6CfW-=X[g#=+/T1.Ib?.A;@(ZV;9?A2H],18@@/F+@_gdL&^#Y7^NU
B/.OLc=J<Dc-5(_@J4>NEIC#eOQ:ZYTe\WA=D+?bN6X[,APQ@g^a1#(;]BS2D87O
,YJ.e,^NWe8+F&7+?<?aa#EAc(7+,VVOSBWP1XB4Z)/YB,N&L?XXDS<8=R.:1_^(
#&V2eb/\.DBcfeaL\?;#[8;>WgM\6XQLSa@35N^bcN]QMdEcb=9-cCQZ]]V??LZP
SG=O]-=_A].27QW\7P3I_VOV7F\b#SVS/Z8]VC4G[[ZWUMO][HMP.2;B4+>ZVRV/
DK_U@dD^74bI84]>6P+SY(4cdV2X;5RG2_R)C41Z;0P5d8G[T&XVF<QB3dU2B^E-
LIT<G_+a@g(]EY/L4O9dN?9K28OfbM],H3EUXYJd@@f0:Fa\I7M7P-Ob,V6C7_=C
L7Y+LJ2U\:(fITV&]JM(GDaffPKd=0=,b7H72FL2+[WdAKRMb43e</ZJ#P7cP0\A
YV#^:.F2,d6#9gN)C0FfC@G5>>PfA0;CTc/W5B/Y,6?MZ#FYM=gLgEdHBPO)5E9(
G[539Y33_c8),>3F4K_PU,_H^CCZ_eWf47cB+OY?^/9X-e;(>-/UI:YcD\_8=fU8
RLW(6Z)<cYb\H_Y8NN;U24T)61V<3b(NB9BU04P(B)0.G7SGY.C)?[e;-?-7Pg,[
E/.]FH+FW(e8:O[SJ,,dV0^:dP]<ODK?+PU:;(G#BF^TE/,JJMI@SCHF;-<8_R<Y
8/;A7IPYATWB3Pf=Gb]F[ae^8:SVTV#@HbfT9,RaS>&/L>,SP;)\=GLYe?^KG\ae
71B&]RHO0XYe8V:bc;-MC;G02V9JVcNDR(F53#d)K5Z3DZJZUTM&FZ)0J6V0>FVA
0I1YRR3g50dea;e3FMW201?+>bS73/Pddc0J8LS7;BQ56ATB#ZUI&SJCB)dJ@Y70
J4c.QO;OD[<KD_#]T^#\?R88b/GCgQ2>(H=7Z6U[a2fH1DJg<8FaR]3aS-P8SRP)
BfLdC7I./R4NeUV]0<.[GW,K85/+d1Y#GaN(MN@&.WHH]UX1QP,f2O.F@7e[JZQB
S^@&fM:5b_?a^be8S5_IeG-D=?a#bK5M,T;WBH&RP)\bY;#beS9g8.Q#>a/cg]LV
@,&<=E\RWa7Ueb+2Ja16(O+91I(ST33fVd)IA#,GIZS,>?Ca#G-Z1SVGQ])#R_J7
(;7EC2<.Y?e5?TaZ_,,(QS3J/ceK-^a-XgPRT=ENebVB[e3+L^bQXN^[),N3)T7>
?7F8,M[B#cSOD2e>PaY>7.\7-::BA)@]M&aEKWeQ2(<^C-;7B+5>1R^-V2Z&UW<&
1K2RA.VV[J(:XD@Ff^eTc(07M)KbMb=]<_]g>,00X+-?].Pd5VR])#2-U[W&YLfK
HT6YM@a_2aB.MD9K=Bd5DVKO7d5,;g6Gde-ENd[C[b8)T[^AJ]@N7=[85>?BE<+0
9PQNYIJPTD#1bHSacCDI4<KIfLVKf3dcc<<P/M=JeQKCU#<YWRJb[,JDXEbP5^,R
1(TV&R?BO=M-^>D[LM7>2-ZQ;:59MEa:Q=HPJR:YVR>b91Y<XK^Ha[I,^XL@e9.S
bT&aWL^Y[VWQE.:2Z5+/K79?a5?Ec3QY#W0>Q[8K(.3-=T.ISN6IMWBT#PYQG?H@
)>#X1I(:d7(Ha.bMFT0_E6FFM@,2W71ERcQaG3+F&@):6A^7ZY[0RQPg&Fc0(Gdb
MX_\d@/PP(c,R#4RC\>gYJS>&7egb7&0LJRggO)&OVYa\=B<+QF]@WH#6[0Q@.;:
9E@M=+f&==e85XRdJ.^-:WE(7_]DNA9>#3cZJ+XDW1Y?=/V5573dLV^OGIJX#)b+
8A>A#M9PBSGRgM]61TS9CFT.JJ71F0>RJR5^gFAgHYWI(=4E.37Jf^[1Qa2-IRJQ
dK[K6L6;dDVH<X@AgT_#LBc[eMM8]Hc5DQ_4</IM/_8bac/Sa(G;24f-^Y+EFd/E
O<)EF6S#f\D:aV)^;U\(#V8)N3FIU?4M)a2Q>eKFQbIGfcG4#T9-Fa[_?D@M@R/4
:?>3N9VE9c(gd?5ENR\HTLeT6PNF^:=cF-@Q@TK=<,>bV&5&3TFaaR;S@AIE>)7J
0)]I_)=>Xg0/T2dG8ZVVaCHNAF\6bXKcdM41/MB?.842gGb/H#5QU5ZaPO^S;-2=
H.8+:]1Ja@3@Ra,P,@J)]G4WdM9]8:C\dUJCO&H1^ZPJIK:8CA99P#b7(JX^7f<7
ebF0Xa-a1U+-8efRN6)U[ebD3;/BFH1@g.bU/e,^&B;;3H01IgHb^&506JCUNb1O
_#f>6I<OY#?\V_AZL8(,V6bgIO:\6[#]6<_d>D4IGd=#^>Fg(UV#fd0^:),d@;:V
WM,=\fRf8A>cOg.a?eO:)A64:2R9+3IL>)2AUPd8,6dA-&)(+)Z5O@QIa2e8,7R1
.;D+L)[gcI2gF//0R>\4=ZX3+ZCe^dQ)@A==:Zd?83fB1?Te&5U819H&[\S(Z(TL
b^UXFPbVO\[D<7QAS/RR+P:TIedCL3eR>YSGbU)Mb_4I4<4M5/d=T]-ga7JfBABS
8Vc.;@KVQN;(_/I<6N(>Y?\R6-;Ud\V&f<Jg()IAC/YN^_DYR.>fD[Z<?4Ee=+WI
<fA7/57418\/c>R7g4_T2P/7gUWM=If_JB^<1L[8JW6FZ(E;-1#7K[5:E5K3==T)
99V<M6_J,_JNeK02?;g3?H)1(f>/<E=XF7#P.bLP(#X,R7=:BNPS)cR,fEV6;\>\
KE;&7/3d;=Xf_c2Sb&MQ,(.d1;K=T@EL,.PV6J>2?aCNa2<WT\C+CdM?3E</B.0(
9I9)6_P^2f#IFfcK5O#<72#9.-6,5gTc(c1M_,aa]7G)O>IRVFZ>Z[,?@8cN)]9^
]VN5\GHZGST5SgL:2#R[[Z:gb+/2H(I-e+FO4<LF]ACN77c.7T021[8]RcN0R6N]
;4I+4=PD,\U;gOP@>5RSQ)eUP]de;bCKcDM^E;agDJ?^#Hc([JF2]Wf..\T\8&7;
__YgBG?4B)bbIMX^:GU4cOB4<I&OPFD&XGQR\<B@)4@R+78bCadN1RXK5O5Q[L/T
\,9G)=R7O/R.8-;gfXS]O08HRK:<C/_TaZ#.BN7=GeAZ,UfH4KV-bbZXDN6e(W[N
S:]V+:BcQ<]_DS:<F2]I.T<--V,H)-2J#g>L#2>PC[Z;XL,d^2[EKbGRKN;Ab+YD
2THXDIYgMRdA9..=O(gI(T?f^BMJd5U:)#R_I7Y]:[4KPENY4ZO)3FB7Y;Q;/=^4
E)aM4Z:38OGSU(e/PR=?1A1SMO)@8_cG4N:=,4=M>b6a^X0S\&]:/O083Xf?(],+
GF\09c3.9O8+TV_N_=UW,G:6&_[G>GBYH7V7.(c]=3/fAM0dD[WaIg].;A5@G;Ra
FdR68EB@#AEG1,43d\/R4?/(FQ>,d61H_(#beGa9M1)HeJ8OeZ-;:N]6H6XCgW8A
8J]T4eE+HWgM\d=Ia0XP2F0&<,8B=M+-8Z0@V]TZ1.2YDLHc(&#,#GSP<:cMf:K:
JQH@EA8>SON-@LM>FC]QNRRQ;K_ZRM7KSC1:8E2L0MWQa4S+^A<SZ<Ba=WW=#6<8
YWI6LTUL_e6@f0R>__HT.S<9a0[e16TCRGfVD\7&)2S=O)c7]W<5B-,+MSgTeUY2
b:=CXSD&I#59aPJ/02WGd&Ed;/1D(+.7W#gRa=)d>LS@+Y]KTG45X/-WR9/;\#WF
L[F?De6B1ZcQ.]:FN:]S+;][7<DL/V3YfDbSdUU\ADXVa+ZM).c)[NC8//V^>K2c
2E8Ug)afN>P#g)GbB-[eMd^#UYaO]\a7]g-W#ZS:W[3@O5CIG3Q&KZ2R>4T<=CPO
_b^NDcF0KWGedZ4Pc=4\A<),fe@]VQ)cQ7\1Hcc3Ed)7PdaGc;&?^X[8RcX041c.
?+#.eZ,^)COb5(_)@_0_S2(PO:cPZbEgHQfTXf^>/HK>X8U8R+G+6&b<H9HOa<c>
XEaHgg^<Y3E[8?[OP_cW8@1=RV4+1W[.:PO>fLA764/.N1dI7=NW)B,POKbR63P2
XRbO1OdeB,c765,^JU=,2]BDKBO15AVR#I]f+^&\,^_S\XNYS40U44.g]MY+_,+#
6A2:3:GTHP;-,;0CR(6eI;)4U_F;R910b)b?0#^E5W2+(WcRK_ZDdGX2[K,+e[LI
SV>VgXK02,3BQE07eY<Y.&947]5CB.\f@,Oe5W<7f3K)U4(6b(\44bE>HUN-A?OO
C]=YJ6RMKO?BVU/H1U_AfR_B>XF:SgSL,,K\aAa7;aRICW8c(&L4ebT_^)+X\Ja)
c)4K^;&#\_;@BY0[1<eQ(H+X5PdWDd-,bcVT4M);XN1P3-U0F@()CC_P,16H#Z&A
CS,NTV_[C);5-eL:I8/DCHVX-9X2:J4;WHM;^Ae#[=L56EWZJQGb9V+2&:)\J2Y0
b;&cbI<[:P7-ZcIg[^A)=IPgTS)PYXZK;7U_:#N]<e62;&aXe_[fd,.dgQZ8&A7a
\AHfM;T94M)<6BGB0ZA2eONE[V17-6C74F&d+,?2JeZ/(8I0PQJYAL(IJF<CeKMS
&@9ADRW8>8]LB<2#aB1D):YdQUgeAW6cD]WY,QRefdb<I_aV5FeaV0XDZ&<VB#;?
;O[(TK/7Me@66gf97BdOEgg&7N^4f?R.Z\M-P\R;V2(DCbY+DQ9#c?2_/BO4V.g;
<QW(_M&cMc931_9K)(\Y,E<?>AN<DCZUI34I4\62g7WC-S7&J:@U,6A>Yf=d_.0Z
bAV.^d;(WJ#c79fS>@dbC+^Bd_8B5X.BXe#@EPN2XFbWd^2>3PcG:DdcTNdd(B_G
&K1Td(aNSg?-gX.?AX;Gb]+7?Qd+).\0:YC3bWH>@IcW2HOBB2>R?#=F@,;]H6:>
/3Vc\4Q;1=X)+9:f^eYeG(^4_H4V[JI\0+IObb6<I2Y,N^][(BCORPZS^LDUdCM1
VH>cU9DPZ0-GQ0e]M.JE=b_0LYWV@[.,X?]<EgFPY+STOMOgQK][f&CGS_0,GX&:
&,49^,/5-U-(>Wa4-I@@1I3^R-2=;&/[S.K7+378J8++1TS;]1?[aASNK0KXW9cP
Dd8YGKF;XQ_JTAGTP+a9GGAb@(.e[[D6MOIGKebB.e_S5QWY9g80?JYS6_7N\KB.
V2DA9;NO?fCB-H(a,/RfV8.c-MJ=3-?R<Y8^(L+:?7NXN.[c1SH_O&=<QU4\fS&V
]4176S+;/Q:@_85&A\d.UM;D4DH&4e<MZ8a7:6WJ;CgMAHDZ+&3Q5:R#Z:c\3Y.V
+JQZD^M6MD<c@TBD&5eYSR:O(U<BJQ?gd/2.U7VO,;H\Mg(_=Ue?dF8@O3\QX5f.
YIY33eGW2Q&AXE=(]B_NMDff#32QC(8;c/4bEA5=3/RJ]-FXaU;BOBcTP=)YfAC.
[@7Ib0_P)fF:ML?e?UJYA>/5L4\]B?7B+B2c6=],B:TcT>)6Z//b.&LAJQ\\9GeN
P>YeUV2LT;AE,,F+:EgW-SZdD\Z-;UORR5^b5gLG<A71Z1c6B=8Z\X(Xge9-7]KE
05J4e0I[,.d^gaA94@2=ZC\e9+L4-Vbd,fDebfa(g[SPJ\N#:X1XGLg_SMQC@V<,
R1B8YG^RPdb9,ZB7_;)aNRH)5;N[EWbcdC8,__9L#B9LaW>YUB0)e&>7<;__+bbe
/PY<TUQ(&+7#?;X?E5DYB-F0X,77I8#CFL2VP(33GX4VTgBMFQVb>eVI6<H/>Y.-
NM^M.fN0/R=V?@XU)LO,MM.>N=)\61=ec;b3FdO#5TGd&e_3>1dBFS^VaTHV+c]K
a>H7[\4]ZUe+d#EB(g,[/4^7Zb)#F4B@XQ4#1N4g;@+\G>OTF1EQR8)4:SNEHANV
QQCV1H/_=Q83I8#Nd]8ILT72961@]OH&gaAJT)Y&.;:/,=34Ob&E2PQ]+7&-TdK)
UcO=KgQ7I.-JMB:AV0N-bH;e8QCKJFZJeGG57PA\07)c64QX7>G#UX4Da<VE8a;(
=HV?<;C0=6Z1V>D^.2TbU7)SV0QLT?MK]XK58a-;^3V^OQNM+CcW?@:Q6f=b0#LJ
dHP;EX1e,;,E0UY>\M?<[?EVJ=#\?:WQ28^L9a0Q4XHPK+>G2M60@Q#^(J@B9.0W
[4c]V[5.)_AMQ&eC>:R4A@K9aTffNY60Z4I0>:@R[_T6f7ZU3OO6B&9)deO]F4,(
CBK&eC0/RMBX6+#NJbHL[KU1bb\@[S&K;JCQ?].OZ<3NR=:g=cdGe[U^:bQ^Y?+-
[=9=K0V]\(F)I0FfNKO9OZ+/(UYg-3^FZTP#C-OSaBE,;=GbUOc(dG7T&Z#SS:2?
WYWS(R([+e<V/2#8_>8e=B5K7<6&M8@RM4@dW=:>TM#)PcBR,N\G9B(>TY-;?bYL
HS[V8MH^,7AfKLR=2J)9R_R1dF>6F[fG@SXT&B]7GdN/g[-9/)^BPML]\[;_X9g)
g/f]:E1-N3N?=_]=47b\R3(CBaM2:F:M#7e;4V:<D)Vdg044fML\#_L>/cfP,UA?
SARdJf\23((DD/.Xf6>V1ID=O2J07JL/3^55=\\1>_]DM.5cUEC>\@G,=5CTaH;B
aPY,7A<a__)7X)Ua>R4+?@<fg\a[TeG-0b3BX[MdcWbgZe^IK;<UIb9.ZLYX]_bZ
,FX@aN_f1MZTON&T8M/W(^QS7B(_S5\DE>9V#ENNCMee8eE0)+\K-H=^I(AOA8YO
^=/9C._JJU>=PBBNBUJ4NMJ5dO<22G0A6=2W+=>P)S8D/CGK8gR9beX/bfGeKWIP
<9I&<[LeHFU&Y\.aKgG?QSV/HUg,aH(gfRddY.R(.32TdVSc[V3&Cce2.HEdFD6I
2IDVYK@/c0^f#HZ,UK+2:\6GMP&/fT18IC6K(_@_Kf3e6R<3Z^8J\ae7G;VF6fN-
BI9\eV>8\^]8bHL0=ITcUcP]I_IO_2feYSgLF\IBc==4^[5gY<=X.Dg8H[^LTXI=
0_++<WID[OTUCf4f.)4g<38;(=PE0EC3YO:E?cS6TJYSIJXEN\NE\?2^[]EOaM?-
=-7=M7g9=8>0NFCC4.@3+@DG74^(Q_=WBOCLE3D0-\E)S0FG(BbaD27.feAV&WQA
/\Y5TgX7_^A2BV0E:&1/d:].Fe#4,QV1fCGGO<3.aY&fN?5#XH^L1TP4a1,)7.DQ
XM/6K@]G3e+<1B5+(1_b3A&C^?OdERH:8B),[\O/4&^\Ge7R<5bD\4?3B)W5dT2+
G^EL[TE2>&8RfALgP)e/SW)5HM5ZD4Q=IH0&+(OT/22O6bf=ec1PO@6eH=b+C[US
M)EUe9CH@d1GE)_Y;f^WVK\F[b=>;2]6+8P5IW-F1@3]HDUS\4e.(.,W)QCVU@3f
aE.^U56UYQR9W&c7;A:0B5e8^W6aT+Jf9N+S3UV:VQXY?G4Q#\RY=](JJcI.I=@0
F1UE<U##J25<VDbMY;:-00Cg<GC8?A6eG;]?D;4]WQQ&7HF/,)c/?6gLR:V3<M=A
T4[78IMY44&65gg;-1]PSa\5F,4eA1A],#Z_fC5&fBF[V<(G)?8N21;J<L\\KI?&
5UbIC04F_-F[gM-gFTVe5];7.fY;IC,g\?U2TLNZ]fE[_b3Cd^,C)J,\)SW,Z9_+
8c]#64WYPN(>@;J/3FG8+^@0<F<A_GZYY&RHN&XHA+N?bb:GWD;S1?28TB&eT?S_
1@C((9B(0ac;#_.-Bb[/a/QU0QY_cS(M99>HKB<OGR)[ReFHXYDRW@-cB=5;e4/1
A&)7;,0a1\c(C]IF&g1f?EegI9O;+(?OC?#;<.?_.(&]e,e<3VO6J?#;_^ZOBgOe
Q0M&;5_5IJTTE)H+XMd;d-9J<9O/BfC,:QY)J<AZ]]PR7B,F7B64)K:cAfX0#,+<
W5A1cR=4g]W:=23acRAVN0U^1&T;;4;2F6,Q),:ZY3=^T_fQc2Zc66fY6[YE;W-4
gdN]Df&@SMdZWJ[BAXHUeZ8G+IC+4<>W5T__:0CT:AMGd9fS=_e@2/3358JTe[QQ
HDTUP7>][bgb(0XE?KfIE]<dPUgT3[Og-9;J<+A0a/Ya>6:4&=)CLUg/D:GW-H=d
JDGQab9J+1Ve+5BG(a>_I_C0e3S(083D;ZJWP\EN7MTC)R7-?5aYM:0aM\AC4J^D
MIZa<KQ)0\7::^GB^Z<4QeA,0SM3aI=Y11;aY1_[6B+&?gcBd@]D\,D[O,9JOGfD
+0G89.cYV/H.OC)6B,GA]fJ:S]CRBK;9;aB\W7,E3\SFL1#2=_V_&;Q)([\0Sb=;
SgS/ORR#T+.?Z2L8EUB1WG1:4ANEC\6#d_d0WQ2gHVC20>JKLf;I[[+79d>80T:=
<I@SWeGWL5OcK15JE-Y.>ea[R9UgU1C;1(O:[W_H[^Q#N9>WPJY4L-08#\?/,dB5
-IN[TcWI6?P:c:8/36+Fc+Q(Le>8>RQMFe38PS(c,HfO6WNDWI/bBfI5Y@(ZR47g
b2_fM6gH:9.\/4@cKb+S(fHU]KHZO-d7,R>3,IF^&c_1U:HX[c<)AXGK33;7A,:B
VO]eS]A&E;SKW-SB+4Y[1T^5#b)&)(JE(-LL]M)1K?GWa5LE)N@I2_f0=K)fLbAY
[\:?T(Y91M9?4E/DV&]?GHNEfH[<V3ZK3W(\?>K3Zb8RK[[)))R)_fH/:Ba7dVe6S$
`endprotected


`endif
