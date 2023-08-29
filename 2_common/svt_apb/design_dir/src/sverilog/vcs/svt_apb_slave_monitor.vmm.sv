
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_VMM_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_VMM_SV

typedef class svt_apb_slave_monitor_callback;

// =============================================================================
/**
 * This class is an VMM Monitor that implements an APB system monitor component.
 */
//class svt_apb_slave_monitor extends svt_monitor;
class svt_apb_slave_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** 
   * Implementation port class which makes requests available when the read address
   * ,write address or write data before address seen on the bus.
   */
   vmm_tlm_analysis_port#(svt_apb_slave_monitor, svt_apb_slave_transaction) item_observed_port;

  /** Checker class which contains the protocol check infrastructure */
  svt_apb_checker checks;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Slave_monitor components */
  protected svt_apb_slave_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_slave_configuration cfg_snapshot;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg;
  local svt_apb_system_configuration new_cfg;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * @param cfg Required argument to set (copy data into) cfg.
   */
  extern function new (svt_apb_slave_configuration cfg, vmm_object parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  extern virtual protected task main();

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
/** @endcond */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_slave_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the response request analysis port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_apb_transaction xact);

  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_output_port_put(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void output_port_cov(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the setup phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void setup_phase(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after recognizing the access phase of a transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void access_phase(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after reset signal is deasserted
   * Callback issued to allow the testbench to know the apb state after resert deassertion (IDLE or SETUP)
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void post_reset(svt_apb_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when transaction is in SETUP, ACCESS aor IDLE phase
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sample_apb_states(svt_apb_transaction xact);

  //--------------------------------------------------------------------------------
  /**
   * Called when signal_valid_prdata_check is about to execute.
   * Callback issued to dynamically control the above check based on pslverr value.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void pre_execute_checks(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response analysis port.
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `vmm_callback macro. 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `vmm_callback macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_output_port_put_cb_exec(svt_apb_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>output_port_cov</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task output_port_cov_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after recognizing the setup phase of a transaction
   * 
   * This method issues the <i>setup_phase</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task setup_phase_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_apb_transaction output object containing request information
   */
  extern task peek(output svt_apb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after recognizing the access phase of a transaction
   * 
   * This method issues the <i>access_phase</i> callback using the
   * `vmm_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task access_phase_cb_exec(svt_apb_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after reset deasserted
   * 
   * This method issues the <i>post_reset</i> callback using the
   * `vmm_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task post_reset_cb_exec(svt_apb_transaction xact);

 // ---------------------------------------------------------------------------
  /** 
   * Called when the transaction is in SETUP, ACCESS or IDLE phase
   * 
   * This method issues the <i>sample_apb_states</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual task sample_apb_states_cb_exec(svt_apb_transaction xact);

   // ---------------------------------------------------------------------------
  /** 
   * Called when the signal_valid_prdata_check is about to execute.
   * 
   * This method issues the <i>pre_execute_checks/i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual task pre_execute_checks_cb_exec(svt_apb_transaction xact);

/** @endcond */

endclass

`protected
:D^?Z?O];:_O8VKQ_T3T8GR-2Sd/[QP(&\T=O3SV6>\A(6d.WPeA6)Q\M#=f0L[P
,KfQ#K(M]d@KcS7JY<U\MII:YD6bf^UfGBOB-2AIPN2@gI<36@PL#b=JVEZ/>K7S
WB36CV\e6_3Y3[@)dNaX:JYL^2QSPb@IP)R@_X?.[RA5XL\OgF>JP4DBQ;XT4cBC
SJ2;Y/25EPM7,]KN/Q>&LB:N[JW=M[Ffd]Vb0?a\_BfTUF][6;SGc\Y4WDK]g@Y]
MC,JUWd@9LO7c(V[Fcc31]=ACBK\VWgZGaKEb1M:Y@P2LK]VDgT7F5&.WI=#D-Sc
CLJ2#C)=W?//fE,PS#;?cTY^8]?;+)XbQ4_XZ_#ZR^:cQ]@KVgTTQ<E\4486#U5.
EFPOd_O(#_NY4b2M^0_..dF&eJJV;EQ2@6MK<UANRe93[4KNXZ<JULOK=Ae]?NL:
KGO^<d2YH--7f=]^9Y+a2@(_UdVeEG)UF(^F?[TG)KV]?JY6a\4YfH?E-.04UAZS
=&@?W-dfc).&.W8GEU,9)#QMR1:P5CO@H13dbK_-R&7#Ig2ZQ\@^13O4(+>bLK[1
fG/6M4M_c/9=fLD@5BB\/&T?1J:d-LK^Y5a=^&ZZ[63XZP/^#R0FL0#,5WLVQL[E
a/^DgP\(a7ZD^R)<;X969<+QQB^U;Q6)2/]>X]T-W81M;ELaQdc9<<@8_7Q_0\U&
.R+Z(a,c+/N]]-S(T=]IZG8WG0bY;F@E\gK@faE30@@c0.SfEC8:8b1)]L:9[H22
SP[731>E=SO92_2KAH.3U3gJ7E#UNW?\ADNJ36RR/<[/Efa]T7#.6;86.AaL6[,c
XXd49DgZ;=S01A#cc56O)<:COBBa369#.CDA,],5Vf,?],IZ;A01FJ0CF[Kb+.9F
_=(SW6Y+MA;29V;bW?a0PIJ\KCGQ_ZeMYbU\B>3E3JW1CAWKgI_RK9U)b(Y;VWHM
]/QPa^10/Ug901Og4D3J?8W#S/O:2;VdP-+].VWWO46\_Z@CJUD@GH^&AT?NH0-M
O-U:LX:TTRQIQK:/(eLcF=dPNH^)aKC<3#IP.d-d.VC19dSb<+LMZVef(UWG1<3D
O5&+E<SCFHT6W1B;C.IVeMZXa,?-fA^S6@/aM+cP]B+b6N&_]NfV=N15^[9Gbf;c
44MQ(d,&1=7,/;1?=F0f>=JL5.2Z.HW7QdHM^&G.YLDfFB3#:AF8</ZcJd;<CgAV
P>>5/(=aA(He\bdFVc4DU^cQ&E0c8FgE]1/bNe7#0\/&GP->93eKR44\_TV8[AfD
OHe&V89:J1+1=Q(3&(MB),RM8;@@?7Pa)fF865>c/[G].eaQ]Ja&M?e5c?L2O)A8S$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
SN7KdZJI#CZ_0,-IaYCHQg[2gRC-<dSVRWJ+.V.]e=,Q43-&0=@X)(8B)B&\Da)O
Ve6:0RT?1@]VIQc>\]G+(GNa-[eb,7(25ZRc-;11:]J#BTFAQZ8MXE1L.-E9Ka-e
gebZO&^Kg3]U_,>J0,b=E@]0ZNb;N,gQA#Z)JIb/@C?\B.L.d03),36/\8c70U.6
]KK^PN]/99;7<4:6dP4XVafK7+#),4Z9d_U\)SUM#bL7+(1XUP;aH)8>W)cOSDKR
Z(11HQ0V5SecK[TQ<FQ9#1C<4)S&/2W/)E;O.?\_5XOASRH,^6,fA>fI?9Q<<Q;_
a\YX_:97L\;,QCL)>3FK-TM^ND::0-OSG>NO&=0WSU@WOb;723CDb^?)_JA^Y:7N
IB^c.V8P?<GL750\OEY=-Dd&;T;T3#KKY=KC1.De2@=c;RdedE[A1WS\:)RKDE4G
dI26D>Q#HET82BRG4RgK+JM)fR\2>>>=d#R/5W<5N/2>QD#daSN#6L=g?FbE/@_Z
,(-4U\B>O0[,Rb?4)9-=ECFHFNPOW/,/#@0I-cGe+;9J<9WPZ#:S<)RUV84#:RH5
9Y]dB,A&G;Jc#CTI5ALU9HYG-EN^2:[FAZ87Q.GY\+(O34XgKOQD(R?cWg4afV4)
XdS2=[B]P.35,&/K]O]gHQCU(gd>BT@D5KSBdc)E].W]B-Jc-(YF5E^?G_Z:(V/A
9C/ZKbP)FL;PHSb#2_\+AQ6P@,W#/A;Z>K6K38/a-.+d^:&ZTW]Y@;@W0ZYIC<\]
6&<I3W)O>,<X)N&U:3NGS>,;dde]A/fdfHJ(\V)2+>,H[QKJ[;@1^.M:TF.MXdab
]LcHG#A8Q^EgC:VH<cWY+(/X#9Z\IaFae6UX59c0-4EB6)-75f/cLVWc-F=ESYY)
6Q_a-W7JI38(P6-eYLATNH54/KB4Md[a)&WTWa>9DF_YKL&f;1&W]M=#TF;0e?R-
9>I\5c1I@F[e6Z:1e_0/->67M^Y85A5?\U>+4XPKB>55Vd5_>Z&T0>7YYC>dSabT
,-L_-8I)&\W^\cGB?/0<E14R\d/)&7dA8M>d63dC#,5:SQMLF_F#?I=Z]_E]IR55
6&b]\CYTAe@DM4J_;=KaA?JEDLXT8QdSDKULV(>3I=4]078@@-=;WR;?S9[2E;.H
XWCc<eX9&Y#RX:ISH6&S7G76Y9OE(H&3Yg4\_1J?[TFSCJ\gfSG>#gR[VUMUf1@#
+8]c7aMNYOPGG&L?R>/9Nd8X,424\.4AB<2_KS4P5=HA;VX1Te_1;f(b,UZXYb<X
db=636@.?TGJ6?4J0SWU:CY4TKYF\814?24QOeS_6/RIb<9V8EP_.R3T.5BN6)ZD
C2AD[Z(ag@@]DZ2<gE.1dFH]RW6ge)aZe-+PbJDH>GTU<<R+6:K/6?\<G<[Fgd0Z
#8P-X_A803&281JMKB<0I1YOG?X[.EGd3?VbOUY;cX-/KfE-/[?gNJ[b3@E[U;;U
Eb1Z1+9A;4\Ve--8R_E6be4BQJJ5Ie\^50O]8;FG;1,eZ+aJ;Z_Q@\N03a(E,dY2
F+VQ4J]@JR-f1^bFO;\\W&G<5a7FF,5_Xg2RIM\\e^=O;+./S;Zd(aO03+f+5AbA
@];-J;.W.]UTBI<c4J(&#f3CZd^V4FMOW31IPL(#H&Yf7W;)(edcQCT,@9(_1TOC
e5J#5P@40#+GPT/GT><=\BC0HN4c_X+de_]E6_eG.c#F@P(@]Ra7dB[=G;eOKH^G
NUZCeO()EC,\Y[Q>@M)A8,be@-3IYf5?V5U[G>?J_dUE;C=J>bJ)R1P;E:cJ78c6
[YGf^cKTEWb:Q>6:S(3&Fb3GW?NJcQ,KB/P3Y9K@S]ITJQ&F/A87DITE^NTCg/R+
2#_Bab,]ca7-E&Oc<2[S9WM=:T<)(RQX^,7EUHEKAKV,SY1P0X.8(UH.K474Db:S
3B1#FCTL[#(3V/GSa6?\,5.?HRD<da6;RQg#H8VfagK;B\f-/?_A+UDW4f4H:5Mf
f:(LbK[3M[9aaC=3B5;]QBQ:A-YV[:E<e>(MY2MI/H7gJUF[DD&3JQ0UaD<18+WO
BfXAbGc[_3)9S6&&b6\R1T:88ODUM+:N7:@?a-Y.K0@GC+fW&9]\4&8d^DL=C\D[
Le:MA<dQ)]If755Uf@4@(Vd8QMUH?FRN..G<9=b>dIF(8WXA;c2J((Ee;cW2cF.[
a6RaAAWO6gC><#EP[4[F]83ZU2F1fR/7+cP9WYW.A#eWa^(3]Ba-OLe7U8P)ZL5f
EK:DDgKHV7A,:^\c9HI?2IH0Bc&QB>X[?D?W,?gS=3?@P)Wg=]<>Ae:\<M0WaFT2
G3PHTbZSgQZKIa)TBe#SSIZP?a(YHSJ4aRB3d,<,gW-,C79>FD<fNa=UO>dT)]Yf
/Y\2X0&E2JO<KD<,OI#:W?/PX27P,.G\5BJ?>P5@dad.T3;C,3KUNC[NT5HHQ@;1
aA^=e;a.=Cf33UY26FY>Lg>7Mc/7fE?YW60Q8Fdd.5];SKL;1,<:DCSd@1AXAX6I
N?@>XfW#4LB-.W.CdbM#[WB,ZE\&VIS2Dg10_c(RUYc-<,B0@B09efZ-/]b4&K.C
<\A#RELPe82E@QOfC+)R04]).YEK=8_IQ\#6]Q9&>N8WB+D7H;.2gLD4HABILC_E
6<b6L]2)NG@7ffBU&VH6-[](a6@[A\FT/6De1Nc._Z/dC:,8I[YXfIPNF<HLEWU\
_.c9#H^/gJd5RY_VP[B22OUV<N=_J]@_X0DTZd1aGffc9U&P&NS-8W]J([@7E-1R
G&OOTdJ:d.(B4+KB59V>agcaL28MW4WS1)e9^IHU)#UEHAUaPXdcZI8cK[@e#TUf
-Y)>Wg^1HOgR\g&7+?XIgJOJ6ZIE\1C(0&<SMU6OU3[#T24dE+,G;(VSN/C<_=_T
^Q.d88A9,D=WSU7GbP3[9gZI=7<E6[0&PZ/]6LLL_]G)(cLX+]OdBX8GOaJR+^Od
(F>A),VL^eG,XWgY<\Y,6/X^P,IT;2:Ef.P]V,(dcREEPQSX(HJa9,8)R;D:Sgcf
??McK>.UC</#1.a7)1V9(PTJ1C7L?9UJ>TdKM(6[@CQ=I@SgOZ/5(J@8=[/TGGO3
>EO8P]1XL[(96=T6<^_QbU<a@f3A.J=IG.AFTD8&3+6E1PT/;)7^GOA;<:8VE#M\
R-_J;\]1S^>f>;\g/OFZ9@L,&E#4>+;]RL[OUH-\@826IZd<)-5(Q=9CO&eHEa-:
,]F.d9/M79P8:J>EWVR^RO#3AZ2W:g>1I.?#&@eTC+Ab]g&<fbUaeRS:]]K1=W-:
<529QV&e,RQeQ]_?&D7AERU]#P1cOaL/>ff+A\eS1IbY4=ORHH9L,,\@19M1BG_1
f7J@e.E0dA>/Xc1U1ffS?UaKdb[_@gf=DO/OO=@2?Y5XW]EXZLU2FK_R[TS.d,-=
7TWVZ[SN-?U;/\DZ]AY=^NP6FfG?15<?>?EY):f4d?.I8.E_a3[f,JCbMc_.46C5
;f;9CFSFXZY8/)>EaXM_O@(N9#IC;36Rc_#8dfB2T^(^^H0=WGP@J9S:N?,IYAd8
Je2RQMYW48DTgWc2Ef.J0-K;;>1.842eD3JY^6.H@6&e3.AfZLA9;7-^HFN4>9fR
e<@^I\\#L2+))Z:5W)2DYMNI^Ka@5>8a<]T>bN)-+AOSZ20G1VG7dXaD&<<\e0#g
-S2RKK]VY91X]O\WJd9gZ+ZSFe<,2<Df561Q/2<1.Z.bH6EQZD+P]d6\FHA^X+Da
Q#\?\?\L6BC<3)CO&G+:>-3C@>5HdQ_KY-=-2;e4CMP=-E0#]WA]UedINIU:8cEG
D^H1.aIMPZ8PY4DMeA@_,LVJD/8d4L/F<PN,@O.].5/[[=V[KPB(/c)bGKea=)XX
;fLIO^.VN^\d]_1Yb7f2#b:3F@;^+Ad_6cL#+Z^XPY9#;A[^DP0.JGg?_C92/C\2
P5]-L(ALIXM@Md28a<[00:M.V/[IVH0L[LE&[dEL#8C>G)Kf9E2.P@SGO;0B:@A?
,<2Z+9.ba_a7@8T;?gE]e(IH@bDVAS#2:N[ZBTUF:<0=FA:>84_UHE(;61[FAI?#
)TUZ0<]=F#2+L>0]3D5[JM]ccF(^b@:OR9</;XaEeL<((V[<73fU/V6Rf^WZIAZ&
?/1-&<E4:a5)Q0gQ/&-C_Y1KRM/^+;#5[8c1a86LP,E+WgQDe3&;[8DUW(?:1S4d
S7=,G=HdT,:afS-b./J#dPUTH\Ed;M;5&-_Cdf++E-TPW&@[2E0&(]5X6H+/^VP#
4(QIP@gI<b4@c=fc?0#.2Gd#68]XU8DPaFa;0(+FbG\D4N[JX5OU\\a2+GRT_OYL
PH>&1S2?_ac20JGQQ]G:(()g#@?4bNE=+\_J6WDUc6a3TJ-U1O4\)QQ@DYQ)M8B#
@)P\>+]>LbB^[-]C.8IS&Q:c30CNeeKV09\YD-ZHUP5#ePR@KA]^05XYgVA.\_M-
OG[&/K#)fNc6^-E^&gG-a)FDf.F:Qe,JYQ-/CUE_5DJ@E9IfUO-8FfBRbNVUY;O<
XC7WN&MaBD_.]XR8Z[ALO9\W[/RC=?;2CT0/RL15,L9YA12+c6;;UX3#WH9[g>)I
9@]Rd<18-Sc;@I4HacSf3U;T&=N.bL:9,eCe,^S.6TJ-_+I-E3X16V;)=/\_]gHU
HQ6TZ+MVHQ3^bGYPBf&3@:e<g)FN>W;]MKfNABWLB_)Dd1G130Td5@=JU(<(e\;#
FO_=#O?>JH0W.=DdT@DW:A:.ZLS=1)B;>GJ=R._V;(GI\=He=PeeWYZ9dZgII,O(
OW/H@K6\U#CH51[fC7aU+BW;Bg/b=Q&@D7NT&.IfQ5T?^#Z1&C]]d-R&[fRWaV1a
&\-]]I1J4A+dW+-Gb]C(FS=d69H7a^^09OHDa7GZ&+D<S1I=_1=I\a?LM9+gCgLB
#U,/YXZ[H,aP[&^a88:RRb\K,3@+L+,4]/0MHL3A@/0\QJH6[+A/F1877Ma^ebX9
a1/[SdCFP]C^P]F5H7a/Na^:M:A?He#1;#J;6AOdWP3#Q/Of=<34]6Q4,R2F(5SS
Y:CVIX3U(<LVVdAaF;)ZbCL)XJ]X/5@A3XH]ePQV9_GgW2C6\B\>6UaIS#X9gaKM
7g\DFaAK+bZ(8Wa=047c6GEO1X)E[X=CUF18^Be/):/XL:1=1CUMJ=KJK4SL(V[-
e7\5A@c7(Y@JO:?8@PSS=;2#H:IA8\F2[A@R;c_OF=6JG4,3JWJPA&BNdP//d#gc
XK05CIS4e7L]DO<93)cDLM)\e6Lf-gNQQ(3A-?)J6_KW3SH?TVJ>F&;&e@5;gbN6
;<J61dGbM=g(#>^]Y_PVQeg(_g3abCXSBc43L7PGX4:1?/eG[&cdP&DBD-Hec&CC
?#IB.1\O1].XRFX)O09M;fV(9P:99I,&,/-1G<<eI20EU<:&gbSS4]6<XF_X)IZY
_,Wg/1ALT61YL\4Ig/Ua)#ZO(=U9dQ2aI66<TGJ:F6L(NDd_+Ea3]A3]0VNS(L7@
U[]S7^&Mc^4&N+;3^M4,G#B;_M1_NG8]]4e#&N4Vg-M1=a[2_eUTe6\HSE8AOf7H
N2)-fGNf/NKOZfAJ+2F(EgAL)5F4E>9\8PgKMd4a^H(0_)1WH7KOA-9SQ__W@B(&
HETHX=T3/@B>7DG6L[@.ggXX#gDQ+O?5=MMdSO.WJBGd3+XWOfZ0-dJ5>FY\-V&7
/@E+)_YW^&+6)89NO6-@2QV+H3U_a9N/Z:<31AQGe/.SDf3A[D08b=EOHX;;N.a)
:MS&T,LNT_S<2=5\Z0gIHNfTB-1X#&0>PN\=??C-?>0aC7Z#RUZ#^:QYeHfI_OL4
GdWDLHfJ6R>06:-SR&\ObH&a^G&QTRefb3:d>/eQ0SUO6A]LCZcG9[7F=f7HT,g-
(E5HedULX6NPZ6V-PEUfZTLfGXNE,#+>U-U/OIAI;be,QCe?dEEW_Od.V<R8:CHG
AA,_.ZK5FPRg@;eb):KOdD,,DQG;E1@:,30F3FS;]>Q[Y@R_H[O6(gUZ+\<fCcDA
QTM0Rab2EJb]DCdfDOE;a,QOK,(Pf-^I);3^S(,fRP/-9:g-Z[H\ST=>Y-DF4/\9
,F=OX\CJTRNg)K^;ZQC4Z#_>]JbQXQV(YS@78EN@4UPEZT3ON1U0_g-g3J7Q8RJC
=_)/91MRWf)?JGA.eZN:IE-0HD44<b.1H0g?I6/c4]IWZCR61eIA:1^YBb\1TO:Z
<,-R<JaS/;+R(+D<WU<P<>9KG\)@U:+[TPTUBeRS,^Q^dE.HU(E5VcHf)57IdbMR
^OLJW#];8R#G1[PR3RI3=?-)d)U,d2[51@O7[d_8-,SC0(-F86X#Q/7_-XIMD=UG
_cP+L)=9&TL]fSRS4\?DcG]P906HW]/H-7M&><PUcDW-;.&2#H4S04d)E[52Y0Y@
;<a<#M[4J,)dcg1N=U=6Z2QXFB(T/8@5V#.<1C8AO?7W43O<-.[E9N>SD;B#We\A
2B,[=BB3:S5(;H=)_F)SeXBIa,<:6VB5He>OL@9801>=,4f-bR6Z@7ANNa@(849=
(c5)I98H&A@JeHO^-bX/O+&P9K4gV81B:,aY+0.7TH:1GH&DBJ-9TgFHC[9W[03-
-)Tf#NBKIH1#5?-L&IS)(4]Xb7IXfS7Z:7F?N]XIX\@,E,g7K:WJSAg>.g61P>Ig
8+@cTVPMaROUDSBDKZYc96^K@D<9PMJde]FVTLWG@XYe@g#A4_fUFg83NYd4#67+
A9@>8Na\54bI;FI/MPR^T3Dc=G(LKbCQYL:#?Q8VYcQJd@4:B0Q4/H.3??F\d?LT
WOGW^a)/5f^(0Kg_+IOeL2/=d&d#83^YW-4XWY;a(E8L0UY:)IXP2LHgNRS5I+]<
1.1fIAV>4RS2_;bJ>,8\[[(3;PHG;S-UR/(ZP<E7HXg]L2F^;#]P)8U1/S2cK7JF
:XSA<8#_72TICX:1I9:T2214,<RRa9E>LCY,::B7<0RM^MM?cO<(@W=DUPYU.O&S
ORQ0UG=H7T\>b22Y&22)+A&7#GCD0WH@[&=RG77bYZaQB:[IQ08;DMNN4H^a]\W-
4H/Bd=GGdBAL^Tg&B1.f;Z:cABCeYC-(d&[KHW?X(Y3c?QK-R#7/188A\E([X4;X
1R1(D<;-JV[<92=+.O7b&V3[#U)Q9ZT+I93GI5<MgKDVS]-Ef:\<[&DdAPZ^G8IG
f&+0MX.>ca7-4)F_?9;#ML(&)66bc)_F<c[TZ?7ON@Oa(J[aR>2M=Se)EVID,WH2
^W6e^Ud/K<HFeKT=f4#CBP_./-.Me@F_^[f=Ef#LRX2@]PAeLD^JB4C:gLa:X]If
W2JIZ_EcE/NM.;b1C0-4?6[X0[EUYE9aTcL\(X&GL+^BD]..@#H#<PIY5?HfGg8_
]KP2J6#AY&<4UQc73&?Q<129aA]TGZO,R069-\H2(UW5JW>d?WH\GFV8FLI]b95X
fUI)a,)eG0TY2C?R3gDL48<[8S=0AXOMT(DNb@gaT7EUTYTP0\B-:-F#[24bfAOA
Q,f.;[[a.T^+_E70VQf]&KP&#@L&X5b1,KJBT=Q:&QQ/4C4)aY(a=?a<WN-HZD\@
cVCb])X[]cPMB4H5+?b>VEO^YMCVAe(YM)^0.Cd?4Q2>CAd^gf^7>LHd\E_,BF-3
e=AT+E:.WW_;D0B/Bd1eYV.c-9/U>Z>P]Ra7@1CRL-aM,:Fc:J)W1YLde4cZUS4O
&-/0d7BWIS@BQV;9>>\Fg@FEc3/aHU;>>(b>[f#?LF17\5Wf;5K1gaA=0U2ed/(4
D06G]]b-8]Zc^/=)9+/gS._aS4edcW6EW<Z^(4GS/CBT?_.(D,fbW[+,dJC#HS[K
G&]R3Gg4E/;Z/1><B/B\#M,YUe-.II5&&C_dZU&eb:4_3(FEX<6/,Rc7VJU[CaU7
c&63._P;U?Jf4NDYTFH\\I=R(MNM/Pb#JN=V#b[31UaHUP8MIE.8M0BHS\Z7G(Y-
VQ4YQPP12#E9ZMN?U;N5d-X@,-,0CcX2R9\9cXUQEHLNR,JQ4#.\fH8b1O065QF0
DSec&W]^G=HXV^<-.6<PU;?+/2(=f2fCg9R\DUA3JI@a7aE]RYd@D2M);G6H8YO@
V]F2)QUKC0e[D,_;);B&GJWV1L[EcS<S&GFV>]]:W,8BIE^ZJ70XL>I4H.TLf7<e
Y>]S_6_Ja5OdF,0BASM4>6W;DUNIJ]PV;2CQ+J)5aYdQQ.LLeM4:<90YH0@&T8S\
O<cH#&Y=Z6-3_HbQM+aW#G=;(VKILXfK?XSO0#B+BbfdS3b[B;]/+9JVZ&(;G0@@
6U)<?WC0Sc#J[-^F_C6IG4-.,>VXY5fN;4\GBQMVPF4:99_85P?UAC8YZ6Q<J@PC
T+FP)]_8cX;\O/IdHAe9XK@8\Z?>WUF/4KSdNGadW4H<.CMf+^[KM&A.BcWG1gJ@
afg9>d8/bf.0^2RTP4PdK3[b<=I+_5WVA&3[/+^</N[-?T<=6KcO1H=).Qag>W>.
U)SH)>CH<\.#bgITNVPV^83<R@bXg<&@dMeCgd4NMSDIT@?D5#K+UXJ\1KECUHN-
I<g4WHeBcC_SKRDBeQObBCb62:B/IM21b9724JQR@KM/.RT:-:QbXg7)B(c]/@Q?
VII,Jb#\c8>3JL[)H\O?5AZ4aWFE&C#LQ0MDCK^ULg55:,QH^1_XYV:J4>RcS[W_
EId15OcG>b(VddTGF^^SXJaR060YSg.f=HF4D&1FI,KQgedJL/8D-3\8+OB<)-B+
RId4Rc>^1XOVUXg@N:>G6<&EAIL>\6W6g\UPd,AB#gAD/(g<>(K#g5PE4,b,ISM7
#M><FD7ELcK..F@O:]Y)9Q]dJ3J,;P#6&_6L?AU;CWgaU3(9g&43OX_Ucd+f7-OH
LA.-/W6\JFBcF=S(EO3>1M_;.]9PZXLJYLK;2B3=<,MB&eg0D5H(79#)f&8DLP2U
IGKec/bAOEM@>cKW513)>dX&2V1Ec,c0UBcZJM;EBf7U3\Ng62918@gBLGQf8U+g
E(=<LgA>=P)b,V4J[e<W/gMY^7^-GITaO<5]^?6.EYVRP-?G?:=8=Na2K-+]W;TV
,;^.?(QYaO4TZa=?K1H76<Ee(GFEc(RFVWdaZYV0@^R&&;.I19/@#T-cA@6H@BXP
NSb6df-8aV:8]V,S&G,LCE23;CDIF:&[[[30OTgQO:HHPAJc\PD[3ZP9?C^OO(HJ
JUFD0f6PK-\&5>=[)DE-6H8;:b2?>\)NLT@b5JQH6=_VCRRcK2JK77LF2NE<-P[9
)_Q:3_#5SZ#^+WCY_^@N&7:HVF9T5+c&X+<cBJH&2MJ>c0,>aAG+P@a[A<;^L+M2
=LA12JJ7IW)c:-HH+CU7T>SAa8Q;OB2\LJ5[[)H2TcKJ&:aEASY4(S;L::>Nc0f+
e-OfcVaQ6YZEG3CXSJHc-,f21IdgYNXU&#M;663-EbG(YI:c#I)bA.<R7)Y2^dRG
@6H8/^B)?6cXIFR=STC/5-7[=<c<2L=D??D6F/TVJ>F30,g9FWX[(^W_;?U[5-bD
fTgD@BU#:Rf8/UcbW;4?Y;e<ggU;-UIY.<aP<B0.G(=#<.b_&BIUb<be<LIMQH6Q
2g@ZPfZfbS;>88D<+ceY4T.#;A&SZ3+2L@S^:QOU3IPS]Y@<f??B<]<INI,P+->0
#9_a&@<8KK,XQ?-U@81W6(5.aH?2.\0-3e8OHHU2G#O>DOI/^4ZMA[U&FO;4e)K)
1SN@M?-.Z</A2NOde,/b:VaNDX<FJUW+<$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_MONITOR_VMM_SV



