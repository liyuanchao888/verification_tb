
`ifndef GUARD_SVT_AHB_MASTER_VMM_SV
`define GUARD_SVT_AHB_MASTER_VMM_SV

typedef class svt_ahb_master_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an AHB Master component.
 */
class svt_ahb_master extends svt_xactor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** VMM channel instance for transactions to transmit */
  svt_ahb_master_transaction_channel xact_chan;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AHB Master components */
  protected svt_ahb_master_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_master_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;

  /** Transaction counter */
  local int xact_count = 0;

  /** Flag that indicated if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_ahb_master_configuration cfg,
                      svt_ahb_master_transaction_channel xact_chan = null,
                      vmm_object parent = null);
  
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_master_active_common common);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  extern protected task consume_from_input_channel();

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual protected function void post_input_port_get(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * This method issues the <i>post_input_port_get</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual task post_input_port_get_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>input_port_cov</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_ahb_master_transaction xact);
  
 /** @endcond */

//vcs_lic_vip_protect
  `protected
H?L)@,[<0XO:@aNSV&<DUe&?H4UWTWeFV[K(OON0CI(OI9cP51[74(ZD5F\WRbZY
3RYa?UO-bL=@UA-+\QbY;f]^WdY.TYRP8VdC93>3T,OS=aAI3:<69D]Y)d;?b0I1
;NSTDb@fW,IAeT_H+4c<DZU#03+SKC=R_cJbdJ,fH=2SM-H7f4cVI@/&@V&-_GC/
A[6aOa^G&J;,3ZHb#0TOH<#71gZBV[J]_BLd5+69a?LM7SgMGfV-@ZfVa9I4Qf(\
VGS79__RY4JYg#7J6PD2(,#76$
`endprotected


endclass

`protected
g_]d3^)_XRBgfE-L&MO<eedWgDFPg99BGTW6cCQgW5E?,ERK,]E@()\4,Q@[6e<V
VUOIH3RZ5VGYeFQ=U2V9Ua@e1PY\NVSZa>QaB;.YJJ+A.KA19/I]4X8.KBg9<2g2
WfJUJ=X2d=40[RMAQ/9F+)^ZTSDFX=WH?2M>K:N66=[IIeb=M&=3N,,XK49QA0ZB
374,ZJ\]:30+b=P/&dBO2&g0+CJV@(+L7CTaLY]_b,acOa)SMP^.B\R?Cb)11@9B
2^[>dFW9;6(&Z#NY>:C(aGT:CM6.)CLE7bL7QNU&@&3BDNCY@LN)D\X@AfJ:ga-g
dTd0G1K3U]A./DfHZ?3=.0NP(J=88O=NW6gPY7,B:Xe4>IUg\YUER08ZbKXOU?eU
caSJL4N#;1><M:>a;L>3-:[Oc^48N^SJQ<2aV1fYW.+F\>D#DHaZRI\SOQ4)G9VA
>NK3EVH@5X.@]LL^eO;DF8:b2g&S<_TDH[)cQ8&]):aB@K>c<.RbR->MJcWBGIYV
X?.+K)QAA]SVAJ2b()aKQc4/+a^&5&GC32O6=,&,gZ\2JUXAb[4^7ZC=5eR&>E+D
>/IA/aLF1\]d]3a;T]8aC(B[FNZb^M/S]a?##(eVQ:OK.1>D,.P4EHI-Z]87U7WM
fTUX7=93B3@OENL(NB.Z.OdJD8.Z&R8#TFBN]#]N@P8\4RDF8MJ@=LLNVOW.ReDR
Z8\BgDI-a[5&;]1V6,,2NgZE=b2UUX\dc7aY#PSC^>/99@d[+/10g[f)4Hd[,74?
D<A,Y5Q(SDFJO(UB1FW>#<V(=[\EH(0MFeDP5aV60HC[G:<>)&/f9;baNMZFO3RR
VZ55,^O:+CIHS53,Y74D0ZU@&=a71HVT0,O99CfLRg>&fgE3^AJb9^RNW;f0\bFe
HPTX1,K[.L95=Q_XV-d(;2>Q+5:NP441@B#52RC?OKYHVHO63c2#1P;A]3(]cE6Q
,b+4CdSKd)M6H,=Ee>:)NL6Je6DRS>LY)))K:dPEL]1N,NU2aDaAG]8W@M(eVJ)=
M^.FULX@=?9gcBKCc\X]W;?b[A-#;Y^e^(I@^_0IETRbX^1X+e@&Dde=+gEA9L=S
0R.S>&0(+ec/EI7\]B62^>3&+>SQ36MK:U=R[F:D35cE^/.?CET(UG3O(^O&O9>,
D:gM4-/F1VA8K^HX.2WcGQF(,][)5]5.Y/8G1G)4-HUB-5)6J7T9Q)N73^WN@Y&B
W7@<G<b>+Eb@XEfSUa09O-9K-=(G_O>K;a\L9?H&4R-+QP.Y_((7&;@7_9M;^RBB
.)]WQ>]\N[@</GD(>B39CY4AW/>YgM(IL]?EZRBKP(L?]TOE5cZA/eWL;Cg)TC_;
HgOeA+C/a:P<dMFR_MO2-eQ+\<T4aG<RQBM27<^EP2R1=S1e?.DZg@G<V(5B;;7<
\/9e,g?T@\8I&b,2T-D\Haba5I>H2EJbWM]@;)]N0;L48#LMXcUeB4=/=QS<PH6Y
9:5aG/]3I]4/Bf7HMKS=]<J2U0IK):c-C[3&A+eC@SFJ\V33)QMH)ZDN<gZXFZ0+R$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
5J8<UAA;9PG5Uc1^.c>X^#(Q0I-)8O2\BZY3/LUG\97MJWX>2C)E7(:0Zd6E3T-E
SPBMYGT>Gfb3YC&-]F2RE&P40Qe^NEe8<9g;&X-ZgSc1Z=UCgcKZ&+fOP-H.=GU<
^DF(A_ONa)0V&F^@-USH+)&X7O-Fa6&H;O\dJ>74^,YPHAE_)_&F3Q(eIN,<)M<U
A])IgFVI:7\C;]JA)I=TAODa,[V9.cc0&f6G.X,cL\W?^G6(.US3G\/8I/]ULQ:I
5LTE&_I<D0agE6?=NR&e\QccEgN0/-gTD=<=9d0?Jc1(FED=PU]#B&MfI5K1[f:V
#RFALeg?_B7O\PO2Y[PU8D#MK=V;BA+YM0/R\7918eE^,;M;3<4+0RC?#S?575DZ
gG_/U>C6(GG9LI>[6=f,8f-[@5(UPg^eE6C1c0bSdHR,G7?c]f+Z#H[6&,X8.RXg
2bHG.;O6.O^9V8R,LBMB7XdU7KK2HP?P<??C.EbXYY\M,BH..b\g>(<(&=100g:W
,:(8ONA0b+Lc>e?8/O;9U[_1X68MLN2WV;Y2DE./7#b,J>VKIObA01[S3@:)9fF7
NF,WNX1R+;0.;C+2\RLRL8#]<W<AaK;5<K)PJ@a1=/=/BL6A]EFgeRfLQ893YD@4
7R8_5\R=eZY##)e;\(P#4FZ9LdOFggGN6f[HN;2?_K<:7e^6a8Y8TagCY02\NU.1
L>MJ#f6&d3ZA(g9J_:;-R;<B+@714N7#@eTXC_H1P5ULFb6^B1QR([4V:S@.73EB
C_Lf.Rc9H+4;c5fOG\&OI91S92\AGF[ZYBfK9a:ACMS:gQaHM@^<_SE^SP1d^U8_
)fa7RFV[R\;YHDO48LQB.YMJS<SOa2;Y.G>d,53D#._IQPP.^.7J^b;3<8<V^gOG
CISaORLTecIfCJ4SFND?\+N>,d?HFB7GI93H2K+bX]3ca^IbLM&fEEV+)>d-Z[f/
(UA;4X;?>W.>>;JSZ5.)gV_P#8EV2cgAaUTI30\W;2L)U2.SdT((-7(E]dbd0B@X
GDD4\R(WCG?5QVE/DfSG#8[Hd5<AE:H9gVHQRE^dd_0:RQFePeVF7D>A#;)2+&]0
5PE4XL#X_#^YF_=dDKT.H?)afB;fd4gb&QE@NY(F:Eg);YbOCYRHAd,;21e0&AWJ
b_2B=/9]^[e/DEL)5L,b]/>M-GKBG0_T#TaI=]/OE=_c6;28AT8X,Q((MX&1K>1A
+[UBHV<aEX_P1=X5M)+-ecS4?(_bCd@6]C\EELHcGLH89]QOSe90CZ)4,JFHR^(7
(1YfbJY0>8#=4>>#2g@@><ZI/M1=AdQ(5edCg/LO.<I62H@BUFBLG&E3bEMHAeYJ
2@X81DNRJRYWZLUOVXBc9aC-UW_gI:QXdcX5,UNNa&TA-W;&&=NR/f_#IXfKQb#2
U^X+(:cO(fA=9bR>8C?24)G>[Y(ZKDPg^\FCSG3WgROdUfEC-8O9de7;Cc[FL052
f6EHaTQ5Da^7:c@GaTG;>A\D4cD6LA?Bg@5T;Y;g,cQef+6<RRb@@K=8X+&I]E2G
b_Q?HRGB?,=_.\d?,?0>H7)48)]g1]=3(SCZ8<:VcB6fY/:K[0]@AQ[a-0a_A1RU
=-5D05MW\UND5_\/7=Hb^aQ,T>X-<)IXC6LTYSAFJb3-81;^)<Z4)0EA)6W=&09#
8(g\L0&B@\^7S7)a#.ASd6HE-]7bHCS?6+C.2]3^d&2_7Z4?SKeLeG71A&>R=b6L
0dOLF:RZ6F+N_6^AL&]WZK8cb/SNK@3EQ[&G-Y/,W/M#e;P\#WPLPc&HBI1.<89D
\AI&(Z;9gQ5^?a8K6TC)QEJAXHab<g0FW[M+[RaXFb,)8>b]I=^8E.8:_e-Y^+@>
IEWAKcE=QJeXC+BFE4(B@L6JEXgN&-\GCd4+;f_1BQB\Af9T,cO@R,9CJK1[T4TD
\&3Y?,QIdY-5a>SA23J><RF#;.#R01U\UDSeESgU]E@PR^[EOX:/b#J#[GU:DVE)
C7U0+VQ0b=Z]Z2f0QbHbF;:[MX7VbTWPJ-^NL+XM;CbN,NcW8KL8Fe21+.P[47ZK
LVTT-Ta4Z2\B(2S#D_8I^&44&>#CIB/83BPE\Na6^dOYKNP@B[HbC=&&P-+dX2XT
8bTY\8_BLUTW1S[.8VT2/&N1;/RN-]^Y7Y04^@/;,Hf6),H1-XHWc0@Ng_OXMK]K
0+L:)><U-)EfQSX_<TNLY=O[cPM88P\:??VbDDAYbWaM8T[^cXE^TLT12Z_V<>&M
K6,8NZIdTcgE\;gH^];.;J-;FD2Wf#J)[^M/U>,^DdQQX8>]Yf=b)cL^IFO2_&CO
6fPX.>)dYW02[W:OFg:&@3@=]__4f;,EP=:/FL\AG)<@P.fM0S\Q[6Z(C9f+H@F^
\:dDC=;FMVe1G,NGaf5dHBR:O2Y<U]_54,M.>C^F[_<@YQR.Q9BI_+-c=U@Bf:2P
7e=XeaX7dBY+3TWSCW&<56cP3._UE@:4<DYb4(_-<)2>1RQf=-g8W]#H-E:N[KJ_
XHY-Z#,\P#&2A\W-Gd&V0G(O]6],01d+3@NXa2-.]./3OB(Y7(/I7A)4/[+,64:L
@0TA3@E937PO_&f5>NJ^/2_228V>cGEL)cQTCdF:H=Tg5?c5FO,<5.5Y:H-,\L[=
9B#WfDf5(5XYe;1X-XZ:23-1DOc-606-59_\]6\IS?A;;[)3+OL-_faT0N_1Ee=C
EM/U&)U4DfJ@)F/gNT&>AD=g+WI/_b_W+C5&+#&.I90BXbMM8R.^Q4TZ_V<SH?P(
\TZ0OfIX<Fb6X7A-D^]F[2(T<ff?\Wd93-Z:Ue;G.f-+==PE#af[C=X0aCXJ[Q@S
JCPT_PP7@<WeOaZQ#X@;?,\1JUQ^GX:(5;G:5JV-NF+MT)NH0fW#G+^0P.DPgeFZ
A#MgHaWQ<>7g>e-+&LK((E^X^WU0ZEcDAWXPYag:D9\36U#5T-KE_K_5=e20QNEg
]B&67[KNIMIA)YQMWGCU+5-1bH0Z3PW-0QV9/<Y^XBe<N/\/JQW+J_-L^ED6dLEM
S&#;A/:R=1-cgKWe@We7V#>J_//B[[SK/0/ec3H4b+R8N:)DS:9MGHKMgcG3ITGE
)6\&GQARZU7BGaX1YD.CC4J;2B>YREUXd^Yaca74[.,L\9>4IY2bdbL9X2[gMdBb
W#I:\MR5O\O=3d]LQNJGQd(.LW-YQE<:STC>VA,8=f#_^H>.A(^Cc3G^;9(#W[=(
X8b&e8UM[,T_)BTa6cT(/BUff5;/4THa^\B[B(f8fXI2.YY&1F>a243V\>ZM<[OH
\K2K>b4P?G/dbBI>bC;ZQN,DDT0\+C>L>5FO9;CH3ZSY@E9Se&)G]aQaCJV:H:,Z
W+7(01O.(ZN:ELAAK.6VLc]WRe@J:+E-HdfZ=<d3G@D,2[Ta2L9\K;9Xa;A(RXIf
2<L6IP4VN4MdB\KXE?S82?FR2@[RQaM@L7ESc\E:7<0N3;[&934fgT#H+G:QJ\_2
L3b)#63Hc:=>D@^3S<6.dIFD<SR+C2WL[_B:>3.TQ<DSLJ<5=Ee\W+Z(Vc-@Sb74
5c0VL;U[W5af+FH+PY]eAc)c;D;JV@LOgC@SeL^+P@#.GgD@#5)M&=ATe=T5BJ,B
D/fT^DXd-cPfGbM;e0>K4eN4g=Y&#=d(#<P(>Q=c2(VMIL#RWWCdWQ.3^eG(9Ed=
@,N+)g(\92QI)YL.((B_Z9b0&a]&b-I958&&;O<I7G52Q#5:/Wcce^I@V0cJN,eI
;Cb+C,&c=YZ#<1D=:DaF&^NMXPAPdJYA=aMa@^6d6J/7G3=<d5Z:IQZ.3QBY-_OR
;6XUI_ge/NS.E&3:6_Y09SA>aNO\QaUHYefL6#Bc\F>Df+@ga&8QX^9aCVE8X=GJ
BG4W>@a?Igf<?gM3W&LZ1cZ@YM##4L).e0X+gO)8H0bV6&RDJHUC5fbTJM55^HWf
_]2JF9e?LH+9^.I-3/G992@a@SE7O;]WU0NUHK=b)(DKaDLAE_=;S)P.+(LNB0?E
N]N[V>6:[[1I+7IF^B;C1J,:I-/NR:XR_W=Yae,g\5=[=F1XH0[)L,d&&Q&\=:[2
E8]=-\g4ES?0?Q+I,e9>@PbS.Z\HSGQ<Z>)Wc++&#Bf#?8V2=QBS:V^?8\K6-D/M
Y-_B5:b)B7)^&NT=/>DT,:=gH30;:9Z+K(bdVDMd_,F_=[T&/b648Bef2\406DMa
Q-;BFLeJ);N\KKAe<0ZCecHf)@]/(Ye/ga.Q.dBRCa-;&ea9)JI_bcRW.cb.G18I
3PD]<^57eD+gAg2fDSA<BO&MCRK?c5G&=Se##@Z&G3IS#N)#a&0W[II,cSTS2a;(
/U&(c2DGLA8U^UXBH@A0^S^\d[]&Sc>1)F8dY<D.PWU:Ac.<PT-0_I(7ZS=HFCBK
0gO(g(T(UD-\6\207[MO^beD3Qad&+(^ZaU[^<@ARH6DAMX1a]FE6/E^W&2b7&6(
U<7Z)QS(M88Ga=aNN(Vg#OPMD(82.<3I2WBM;-=10BBR<QGERQJ^FMHOddGc<f:Q
)SJ90=Y9#,,O/Y_1X2E8LAA_<:>_e>g-;6[0A5UZSb6PV>2=2MEa5ARYgW\-AW;F
Z7+^T_J3e:e=.DBQI(-XI(D&/Y2d/2E/E[I6==f+fV\e8)+_OQ8NV8LB7SV72gd3
O\?dGDB8eZM-SJQ7[A8LJA9HadfZTY-3;<B2M>-F.56<[cDW7f(Q6MWXLS>SOT2U
G/0QI_gWORXM3&27^=1)]NXL4)>DJV:3Ta+6+Zd/48&;_&9#c6C6,E5<XD<e0Q)N
f8S]a<>_53@L00:J9M:Vd+99U&a,GB-d4ZHPVGZE#Z#,5EZg3.OH,3VQJWf;dFDP
B3(LKe.c.SR>d#6EC,U.3L^:H9cEE[]+.X<:V87^11-]X7FMC5R4>N?8GeX&0QVS
<TYF<D4>,ZD+FE;<6I)\IV5Tg^X0HeQ8(A<#;,,?>Nd+6I>2](=F+\]-I,9JH/_Z
[-F@Q0bUWYVDLJIdVNCeX#<:A]GO_5KKU?;-N28UBR>2DNSAX8?3.D3384+G>PJ;
]gPRF;\A]KCO:,(SEggRJc6.-ST>\CIfIP+3XP8(RV3+<b83TA0W[;,\I,UEMLaE
T1(/=ZP35d67A.&ZY^#(H_QJ4E36=[U0]V?g1.Rg8a[V)7KTd;e=)R69T9@B--KU
<MeK47AIC0E;Q>7aOgVaV?]G.&#fM<E@U#N1Id->+8Qe?CJAM:E@R9=-eR-@:..@
?a>2HM(BbUcY<M]Y\JT4=<#4#GNCbRf/[.G<.8Z:0,<5b5T)R8;XE.-N?<?2MK8]
adAYbMf](ISS0e7XW;dWR[13AH++)_,W4^6H=071DEZ^[N6CcT213Se1ZD&1>1A:
=9aUT)aSQ<.gWZgaD&\WTb93,Mbf1M0-(IFS)\#);7[(]]]I>9-)gcYZ>ICgTBZa
S>AXgJO_B,D1&dUU?6YY?.<)SX<(?QQ75MHAJ3g)b5O0OXB#UJM:-D#822:3Cf)<
Q)55&dLM+NU7&Cf&e.>2H=4N2g?\MXYbbd,RFOc7/Qa_.+SPC4^AcTbdYVW()aT[
K6KY+BZg2\)_PT[UCbE(3CFc>=0/GX)bTC#R:0X>_,U?@27A1(EDGCb4M[;O#]/Y
G9O:c,\UbC..IVU9;\dP1W3[N-MIWOLH,?cD_E#1D0T=bDL,C4GHN^6HYeR3E34L
OcSXf[.[cFL]OS&a2aabeF0@MTE)YAK)f5U=\cQ:X@N>P;f-)U^FPI095YbY)1>X
R00U3<ASBVOVJ?NE-3bRbIM4Ad?VXC&LL4G@L-\gO_LM3X?4HF^X_US@RMeg2eA5
N2)NcMCEY:/C1(FV_I)+g9JM6,&Q/7F;g<D5HF1X2)&I2ALR5Y-g=K.EYKU2N[VL
1U_GBUG2JbJVYJ_<5UP:5IOFFI5IEP<WKd(@-D]C=_49f=aK\C1IH<<X/,JZIHcb
>dJ[DDZ\e_gQQ<6YeD4;QX(2;Q>(K+g/&b=SL<OEG8e^-2ZDcf4OW;/Y;)FL]CF7
F.d@NZA#a,((Tbc,2V\J[Re_LJg/7RFMY@ef0LVR4ad#U?eb^ec+0;?=MIKM5L8<
T?GJ7M[\Jgb#2J-F9NUH:ZIa0)<SZ1QMf:1b&9/1fVN1FF@F;R8]URdC_Bd2IUM4
F).^cY.V[OANYWAWf+fJd@YICPNBg_=\4FX^D9-Ag6G4-:^5U5.S^0H?4MSU.T3D
(A5FV>7C73(=(?4NT)..(AR6R=4B.L=e3Zb>H[2\1<(<P=P<>Fe_3(2-eW39.6g\
dbST/C/5ER3Y(DBG.FT3Y:#BIcSK][BfFI/+S@W6<&f(W3M6Zde0/Y;W_IRcV1^_
SE_ODI@4\/>7##caI(NcI@;X0:LC5BAF4<Q&1^DRb?/IT\C].e]Jbe,JA172L+,0
(SBR/^,;(eNJL=RBMB#A6>IXI\F:1N\gW:JgcH?Q[6Pc(@cVV@90Z<8<1778+7eU
B:b9^AB?/UKU\>OG^5)+5b&OK(<KLPTJ7INYCOF(/<1deP0)YSBC\GU>[AKYQM-f
V:ZTBD[[U0G8TP]1//MaAS4Ke4#;UV?\=Z7XMf>(-GB]_9N-L52;RQ6K+&66:8YY
a#_)aO9eRaFU=XL?RJb&Z65KA;e.F4BPQW3H^(a12gcSYIPb.6JA#HZT\E1ZJ]TS
eDd=AOWdN]UdUTJ1d5d7^N?^I7GULcMO::VV:=>G+-Q[?ZR3f#<0E4&Xc#b6)V@P
LVg7?c,UR>#J^O/P8WU,)b^[.fCKA^Z&0.^UMc_+7fb\1XRT2Y)bgd:562Jf&[]8
80RC&OMc:1JeJ>fA+^Z3@5ZKYA12.gS?eUZdeE2X7-L?Cb.Z2:Pcc6g,5XQ/P##3
eO>Z3+F38E)@VgN6>0:=#-db>L/#46=]3E[#2)96Y/2Z:a3^LGd63SU?[Q^f)gg-
:eFEK[P^Y/SK/_2.e;#cf.?SZePD=)gV.f^e4H9dHU7c_56;#QHcDUT;(E[())4)
f#T]2JNQS[_Ae(a[^/8d(--1=/U>=>@:&&AEVL1NZ5a>SL+gX985O8>_H).\HYdP
NTB)82cNZ]>59SRcH;X<O64Ic9V3#7b]8#F<NdNCQS@)Sb&<D/;+DcC[=Z#Q;&fT
76C,+&>-]^RNbS@,bFg.HRLL>HACKA&16Y/PZ)Ua,VX5.ddWU:0D=Q.^8UDH]CM2
KVM.B(/7G0ML9UeAX<5QWYP?dc3=5ILJcW48cOHIMDb@8FJG=aTG#;#c.Ag&d#SC
DJLTY>M@=IVb.=.W;+dNe)2V,NA0&+Ig1-PEFOFYX^+TL:VFOceM89.-:_Ed^P)6
R0=;e/Q<-&Y9^c1<[Na0ZL?;^LMJZ-Tf1<FU6J7JOde@[KQK),^>89e;1(4(E]2S
-WE]XMg37fW_21^@.ZK=cdTXOg\0<;7\=T=3&XLc=RT788,Gd,HZ9A7R7O0S7A[e
,3cRCe-A:TI--HJS:.a=6/JAH_-gO/7b3O+1_NaIe3+J821We(>ZDUKXUM)P6NW@
@1B./,?R21dPI98=dL_ZXO)PK^CZe27UP;.>956MZTdeLR0f][Aa]C87[(>45O0;
^SDUOLNJ07D/20a@<,T>_dI(2A)##M\Lf^>0.-GWF#R<L->9PXF-b4HR6OH.Gg2,
HDHR(D#)b5S.gUJL2V<B/:7E(H@cK_UO>W>S/CYWUD<76ZZ?aQcYMZ3VKU72W]KD
=[D<56LP>6=KG5+;7H&bR9@_7)X-1&)/-7LGbEc7e(1TeA1AP?FT<V5+GL<BZbHF
4/U]SUE9/Gb7eWaX31GTeKG401PM&J]aBWE_K2=1B]0ZIF\]K0d=4XgHIeR(JC6(
;A(<2g4fI?-P?Jgf5bR0F)F]6)/Af4d7c87aE/7X^D/L4<715P_@&b6#TE?<)XMS
0/C,(Nee14\UFg@R=U4;\SY0\8.TR=GY#aQK)QM:aaGRGJ3-e\cD^3OefaH#,7-9
_5H6GE>T;F[DJGCWf9WHBP\ZXD3c,<Q,Eb,=?TH3.V<Ygc@?^e78\I&RV):d_DO1
Pg:d.UI+XGUWS3Ge^?9URV2IA8#TY9#4&G07aF,@B(^f-fc6V-45M:8EXYR.+NL;
&TU#aGHPV+ES@8/C,-#Lda=SIX/Sf9352A8X\cD=SFf,Nd-4S^Og_cL;@)VFJ+&R
+4=3A_:FRfS48X3I,&2AD>,[T)]1AZeKRU\..6FD5cYAYBP+OV2<6G8^Bg1G.DOI
L)5DLgc7NAYfgZU>Q4L4R&TFJg,Y:F-@#,29#<HHZ;3><CHRcZ]V<QDWB_bb3P6W
DfH\X8)S=&&J-QD@aa,+L7FKA]9:#e@Te>>)gO<Qd/.JXEM_X4QDF)2H>>R89JJD
BF8PS##PN<Y9_-NN./M#Z]P39H;Q,FLOCH]I09IL:#9;N.B9AW8cHaS1P5?D700f
1WgRPM3aKMUVT3^X-<>Ae>G(X@Sc/9>=AB#8EIccQEC#&gDZc^:.+1Z&AY#Q35,.
6@DYG<;0-N;UX.4KLZDHTR3@&-GILTLf>CdT(<\TG8O:,c)IS?PRZZGJS_2gR4JY
<YZJ]K0aE:D/dD]FZbYHH[/#VO\@&TU,T:a.0G2#(CXO7EL3;&E&/5[3Ub)S@4S2
EUQVaBC+VOaU(E,OF]9AQVMLZ#g3F^#8I,e#c>@.UCY>IM90/YII@ZdJKFZDX#51
8Z-(-=]\W#4]:^Z01S_ENA?dBI9I2TPU<SNR^0K=2?#1>@;G^-4PHN]MM37D+X2,
X:DFP+X>6:^fV(/Tc@A4X@7A\[64F&dC>A.<MT\KDU[47[8TW)J78BM;,.<DM#6/
d=e+=?a@,_/-M:,<,/V?S8-I;UH(.V4E40@?fF@M\eKP;[GaNa&+M84FF>X<62cY
WC7=4(?.P4cH2g++F=[81=@->+4B+bcZB>M)<?C9df-B(UCCCMN\KH<H&DZZQ0U[
Z\L/gMQ=N32E(:F]I.HPK[S-TW2aU2_/&<3FDJNa5<f74g&f5T)@=Yc6&2BK)X4&
#/F1K+O\MR[b_2?39YO-E6I&>+\ZNEY,B\Y;FK5F<dIRAU+bAe;F]/7&Rd1QdL_N
<],VL3+>#+RgYdBT9:+=IWF]7GG_=bZ3A0EMH@TE1)(/]64R5U:ED26Pa.aJ8L,Y
.I0?;K/>a&C<&(f>LU9X/<?\5&2U3#a=/9N92Q5NER>TUDg3SR_0eC##G#:,,#Od
/X5-UI_/MR>4,][QH^:QMO=c6R:,>I]/)39USdaDH+SW:-B0B;-[IF]3c<.\fK0L
:HCfSVM<192A9dS;9aP@8U(Q0gAe7&S8LBOc-OASRG?CT3SKb:G<Oa3E:QfJ4L:a
8L6.78Z3<ef+EINTfWCdSOK0+>c=B=Z;69[^&=<6^W4RTB)UVc/PHHcUEc5O>#Q=
+1U#F/LM3Lb,1A4eXA)a:[6f]9=RW:-+J)&JSAHM)WGBM,<8^+(7e?]e@2^[[4#4
(4ga_X@UN@#K.Y7C);L-\8c:(9PKP@3g(,_61^A7A8[PP8KVa+]aJcaU-LA4F/5(
B\\.Cf8[]eH,df(6YLK0L1(:T)7A#MSLU0H76/_6P-R\AXT8UZRcKHU4O7g5O&OZ
4g:G#>LJUG<3NaEg>eELfAH-H([IJU39XYQa27WUKgG2J)E2Y8##SVBac/g0?8L3
WELAJ#)KGICeb4G_dfL5NS:ZgUg\W:^>>545MI&<<N2KM@SNc3eJg0&e+ccK6GOC
R]g+d<0[ECY>1CX-eBI1K(BR5-[g0.V_7JF?B@^RRe#K&_3_(0186>^-7]W:ba2D
3//a59+b[])-X9g7B+Ne4YcW/)K&+bf5_:MC5b[g?//]R=NOMWD[P.<LYcf[e/+L
Ea.[e/GAUdgQV;JVK^@WBV?FcL.[Fc44gK0[TR8:;b(Xc<HIc(1-agM40^/^/0Y9
D#YXA<OcX12:G;7CF[;S5<16K(_6?(&_1&b\JCdcV1d]cDOcQadMQ8ga;(a]b<BB
IBJ@6.,>cZE<>7baRO1^F)6DK_,17UG3A/#=;QCFf[TQ=JJPL11G.PaHS_<(Oce:
PN7dX_Q(6,UD]VDN-><dZGDWOQX>[PH01)R/?&,S39[5gNA+A53DG<;EQX;3XWDR
]@A@O+@&2g609B><]JH9)1Y[B7WFQ9]gZVH0KD[9][,LJ^I0f\_WV1JR=TZ<J]>b
:;KW<_:>[)<g<6H_0CC@c7M)N/C;KJYML<;D-[?,cF3g.OF]Q\f@F?Z5JE;S_efU
4CeZ<Y>KYG=0H-F^[aH.0HM8+KW5cML+,/2Q)GHNWS1&8G&X0FdRbA2M]?^HdFAI
c4CO]9a+_=2S1d+,-5<6:^bPFAR[9.4J@O3;90@,f3ODL=M-dN,bA@0LZRcE;4=>
#1+/W>E5N>_P;F(6;5UN>M3P.NJDT(9F(?]<9AW=RT=)AGeO^_9[\e&#T/g&.;4#
8Q>?9MfFdQHD[A4J47-Ha;,Qef+ZaHRZ#XKI8/R;0Jd32(/8N^G>0UFb]EW#(4c8
R@>N-YGJO7>X2B@<F&<\K@BNE&DNJZ31/JHIP[9[cg(LaD]Sfe^bQ:CJe0Y0(P9D
-M5EF,BN9\OWY5/&g+S\-M[@QDDeL)N^1&WQ.Ae;B^N3Z5d75\QTb9RdPDNP-QOK
]6FCEBId=0^RA01-UC^2bBI@UVPeHIDC5&+6<[6T=U\O84V\Y05&P0Y3U8TQUF.I
79d66L.?@Z,b4+P;X4;+(=RM:Df1L(][N\^VM5<1AI8d^bH<B2WWJXCTB1V/>&X3
N(IDb=]6d+(@Bg&K5\#,ba=(c>DH;-3GE#IdUcM(F^Secc93E?9=,9>DZ2_JZdQ-
Bde8O-,L4+I>4GZaaJW>34;,M03IBb[JdW0(_OT&A0g=,WVXLNKVg@&d:NdQ9U[V
N=Q&?J;&R##MeKYA+>bDOBZ5c@RC1AEaa>D/b4JeX.cJPc+:G_cPZ19\?AF60DB@
P[D[/8TX+^XW\VSH^HSc^+A\7<CLIA\f)2;_Q1_.=N@D6[&@61e.7-[:]gN/D=V2
+2d0GbGcDP96gge&^Nf&R5/SB=)Ge+5(:S^G\2F+K[W+\-1(?,a23,[>5]_1IOW.
WcR4R_#dW7);H[7-eMUe.SKg]e2M@U38JAg#-.Z>)N(->Nd:Z0LJ<S>I[I17\be&
E)M__P^25:3\E2aceNf)MgDa6L/22CP8UVIDadY_-V3C6&?T=@O:fFY_M4e3C=81
V\U1_^D3fS8>Ygc6B:[c=P6@<7I:PE_I@cI3^QX\Q2+bWa4>g;b=.+@PZM[43gLL
[ZIF3cE=?V#?8Q:\JVXa#2NGY]fE6#6=E_H6C+7Y@(S_,MG.D&R-O3g5,eC(Z-WL
L=W9U>5QA=,ZX)g>\4e=W;;U\+Y]5cV^K#;UA(QGX<F\b4#T3C:L?J7-e43/&;@-
Mb8-.P3^:-9L)_:2cN6C:NMKC8D;gfT.1UN5)g#)4WLcUIHXCDUM40e#QU7QbGAP
LPJMO^g+##ZRB)6)IP:B.JG)G;fN8WFO,S1\e=7>+g:dN5L_V8\TJ6V&VD\E>D4<
g])_0OVEAe&S-?GTd+^0Wb:K9PVe.I@^f5F#@]JOOOW6A>g4OFWL)d_;U(P7T&8,
6/>F.CML_+1OEeL[f>LH5ZPB]OMF@\Wd93,J34R55_A-:N#^dD#g00&fA_IO[0fL
\\U91c6[7+&;;,)2?aLQA?:a[.Z?aG<CHLDFZT\99TQ?W(B3(<MQaBeUFW)6SF-;
W]+?dZBO:a<VRE\#_b;)C498BQ]R1D#0LJPI5LC4<91#.ECLfg]@HHK.<-I(@.\7
0<If74f?YSL,f.gd>^d5N17]I2W?Sd<F6:2LaL/9V#cSf7b46J37.A4c^#?:6c)?
RJV1[Yf[@6=#LHIDg<ePTEd<V()DYYd;aH8+.P(,_N,,BKT#Qb=TR5dD@;f3(I&-
4?ecc3L>55D[\XSbQPK(XGH:b=)G1\\J^;\@KH)MM_IP#D&AA3A4Gb)7[R+:X5_/
?dgE4M\6XcbXHHNRd\VJA]<+PGbXFba,,E(;O4E8<(L#57HC-fE-OIFM)>AGWf&]
WFC@G04MV3LUQ^@0)I>V;P6&VK;:S^(99a<WEb)a87RM\HQPP33)]^84dM(CLaBI
TE)6?5QTHS2DBTgRRRZ2^\e#0+X5\-f@E5?[/GDU3J[//FV[\AN>>T,fd_[Af3TX
6UXMWNc]+1Da?fKDbR75GFO=U-[7MU2T4R&D9eE]UU7UPZ/)MMeY5.40Ub&cP#d5
OFW/1/WDWS#&\b6M9^V[0Ka7>./:?=A1[#Y]\83Yef?-XgLM6B0P-a&1,#VHF/,>
\9_3LB_1]4&3eT>E4(6IY<[<JZU\1EX@b=6PX3:Sc^B9@bd?\Y-AN>b#20aR[D8\
W<Vf,[d9NL@b3WEbV+A/,BHcPPg:SR.aYH)\(1E:V78a2BF4fHC+:Y\3&\POHEEC
[+G+_V16@R)P&aLD,)^(7,3;[1-KP/S>3R)]S\5g)Z:M+Z>CD-1V]-_-_gKg@8,6
F)G<Ha(?>\#U=J[de(34#Pe4E0eg.gYeT@SCFb=[41<=#^K84OU6@IaK-&E9f^+E
SJTgOf,IFQF_1#\)2]J2eA(IFIg/=>L2S[caA&-a6BE,9B(.9:7_f0,ce1&-1f[F
b(@dRg;^JdVb@g::R+]<#@TMB?6E/-:=C(3N.KHNSeD;<JSB-R20@6D9bU7)Z;:c
SAGMJ3U.37_aaKU(PQ5S>8N9WL/WVEg_[38/D2F8[/b2FO[0PIW?-eS#VJXbG9N\
?UXEIK>8Q6KOYD)dZ?Ibdd.bKH,d24MFcP>=YH5d(>1#ba^@QKXVaFC,I]BH\L/a
#.W)G51g2R,,H4+A0@89J/L>7dQYCXR@8_f:d>Y+FU3AgFZ8)<+82[:_PO=(5XeG
EQO.D#b=YL)#M5UAYK.NRcYW&4eYT3,[(=D?MN,1_U;G7>:aQ8-;/KCdb9JE:W_Y
;CR_eQ5WK3.(EgP?ED4(E>;MOU8_ZX>fB]HXaI&?E9+Nd&\^P^G5P6HEF4D05YOG
FG#/c:_c90MX;49]07</.Q[F<2^O#;OG&E<UX1>[W)-OQ^<#f)dY:2(=7ZDY2c,9
aO5;P<XH34I;c5Q50FI2F&e7g3aRY\MJ54g.dGE]:@.>G@IfMD.>VXDEfVVD.[76
N;D.,f>:M&_dUJf_D&LXI_6@.B@B^>NIWE;6GTZH-d0gH5<441KcF?8/_A\^LJG4
7PV8GXbfcH;Hc3@-X>e/C]SPQR(D\\Hbd>H(>;M_]73[a-5JS?cg=1SPMVa^e6QR
e&a4-,C5E\+74F^AS.OgM;J7+I(:b33IBL-(eRePGI^5/6.9\:#b[+MEcMD\/eZJ
]GUUga^)4CNXX/#/Be,Y[12=25/9M+M,G.NI1DFCSOOM&G)^S,fOALBFBfFB:MAP
.b9NR#_:d]5\Bbe?#KfE=.e?T:?J=#:MIC1W5bWeOKVeGBT?2Pa1-NOE(=?G0+K6
L.FKc1U\(71JTK(aHd==_CY?4dZHEB#@gXO0+/f]>c5C#5_DSY.WK1S5,/(L+gF_
)/HC4)/_0W,2SAU7a.gOQ#>D/=2Ygb,8Tg]b7>QeVDfBXRY=UQF2c7=64JO?]H.L
KQ@a,&:Z&V-c;Bba\c^<VG,L(ZW49&Z<R)N)#ODDDcNf?CJQ:?7O^RKFJ8T@R1F2
gBBJ0L2)e>G5JW?5DUPA\BXcV/8COC33A/&1_DH=-&X<:,#8.BU99O/#_EMJ5e5)
gScW230N=:/[GL(@WVCa,=Xc6$
`endprotected


`endif //  `ifndef GUARD_SVT_AHB_MASTER_VMM_SV
  

  
