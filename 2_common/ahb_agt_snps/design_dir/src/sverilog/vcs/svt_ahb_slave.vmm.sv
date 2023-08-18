
`ifndef GUARD_SVT_AHB_SLAVE_VMM_SV
  `define GUARD_SVT_AHB_SLAVE_VMM_SV

typedef class svt_ahb_slave_callback;

  // =============================================================================
  /**
   * This class is VMM Transactor that implements AHB Slave driver transactor.
   */
class svt_ahb_slave extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Input VMM channel instance for beat level slave transactions to be transmitted */
  svt_ahb_slave_transaction_channel xact_chan;

  /** @cond PRIVATE */  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AHB Slave components */
  protected svt_ahb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_slave_configuration cfg_snapshot;

  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  /** @endcond */
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

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
  extern function new(svt_ahb_slave_configuration cfg,
                      svt_ahb_slave_transaction_channel xact_chan = null,
                      vmm_object parent = null);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  // Below methods are not yet implemented or not required for users to know
  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();

  

  //----------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  /** Method to set common */
  extern function void set_common(svt_ahb_slave_active_common common);

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
  extern virtual protected function void post_input_port_get(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>input_port_cov</i> callback.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_slave_transaction xact);
  
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
  extern virtual protected task post_input_port_get_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

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
  extern virtual protected task input_port_cov_cb_exec(svt_ahb_slave_transaction xact);
  /** @endcond */

  //vcs_lic_vip_protect
  `protected
J,<5@:]?(bMf\f&X(edaFI5[T+CY9I^.]K226A.#6VD8G66?V@4f1(-UD2)P++K\
ZRZ9P?W<ZWfCSLXB=A.2FR-f?^GP32L2<gAK2;JTIFdZ8VL4D^R1d2W>5GW[<JX8
A>0=.J<#Sc_fY3H8ICcX)KD2gXDRLY#AH@a5bFc-<]8D,4OUTPY[2KTI,W_5\/VV
SGJUMBR5dT>bF;W@R[:J>R0e],g3<2A=@4[[+U7e3^:@g3Q#dEZ_cA]KdM9[25/g
\\XZXa2G@@5SFWE(<1@K.)0e4$
`endprotected


endclass

`protected
4cBP,]<KEO(8:])=3UVAUX_G/H;Me1URR^^ScE#6g9@We/,/YBFg/)YI(5E7<M5/
bHH\_R,2U=M=/d4<(UZ1_.6P>-?OHWZM85.>2RTE;[CfK,F6@)J?L6),X9L/YJ[/
/P,K.?=:;0bIN_)61\T,^XZ^YBS59@<7f-U0VGQ)5DRE,;D=I?V7dMR+58WTgd>0
3#.3+2]1#3[Q;3X_\8dIP36SDD+5-Ed;0_D8/I8]EMc+;/CB<+O7:-VO3JN2EBA:
-_21c_0Ra0LW9&7NdK\Y]?+[-;KT6B6C(c&;QC=Q\#C8.Tf6IFa7UX3FEeNOO+FZ
16T)P-W8V3bX6I[aLac+0(C@5&X^&=&dePPZIb_Ea@g4ZP>RXUR9W7^AU]04INB0
Y;RL25dJ((SCaL&9I3^KA/@7(dF-Za<\0=>:7:VfK77X,Y28YU:N,=_>>B;0fSG^
aO5f)Lb)3PD6b2/XJSN#U62GR+C8RAd0UTUXc,f^DaXNa.#?LR&aUC&.NJRgKV<V
18FUb+;.<5f<2;b,?ggLCSaRX#EO_]=FYNS^27;JLZ\aZYbeLZfdV592b[[gUZ]M
@.@:B#&Rcg9XT;\+8TfXAGNA&@)L9Td^8C-H@,[Y=6&>>+4ZegONN26>2&22Hg\W
CAY(T84OfCGN/52T3N38G#]S7(a#5gEIV?dG/L+HK]Z>]^9?TcDXD_HX/Of+-NO3
<.XJC==WEAEIV6a.&):A#=3.&_0[gJ3;4T#&2.X9EV[TAW6ZS&]);;LK7LB>a@[0
ZXK?K5OM+bJe/g:U+QZP0C+Y^T+dQV:4.F&@fW2G:RWCg<MXIeHI6SO#<bAXZ=ST
b_O>VU/;R#R4YXEN0D(2XX;S9KQ6Z_1HO;V35RQg8N(ILLF,75gTY0:=P#AB.3+,
5^J]d[X=KUa.L#fV3fJ6:V1M1+>>0-cY,D&(MV1])O,CJV;T300d@#CKCb0<gS23
T7M08KK;PG_EV_5_QA0G?@L(YgcZV4)3;3E\?JQD<=<H.:Z-SIGBbVK=_4I;I7P5
NNHAK_P#9][6/=GHZ06644eTC]R9WB,;C#OJ\cU9;9fG]OBZ99UQ9Mfb3YMUABEG
?&TS]+364W&bYJ9K2>5gXdE&.Vd+)_Y&bF8^T0,@P,AeMW7Z+S/B,7?b@0J3)__0
4LZW4)73?Qg=?_523(>FR2V4@46-<5S7FM,PJXg^FG]T=E<[(S+A37LV0TNP^-fG
G:MI,SSGQX]&/HgNY5><0F&^^U>Ga6ZR61VgYWaHQ0gPaV-Z+>YWDA=<)NdTUM@5
&c6>Kf;VXeJR2ETO&gO#-A3B.==dDJB8gg2?RQc7EJ)S6UCU7f,4UO,Ic^?]dX2Y
)d?N..&\M8PD+^_ga=H>)M;YdeWPXaKGN5a,(bFF-ed@M/C@H\FE=#;>a>2_V2fg
YJRHO#23,Md2IX65fe<dMGVIO[7/13?_/--.K=<H?4-?I)95T<KDa/Ue[)aQcPbU
0DJ2F#?]EDc^^N-?MI]4IJ5^A)1aO&AU>8:.W9#,,X_gN3gA><>/]1_X3IZ.AO_c
c7><8^g<DEg>NZ^)9P650U1G49-YO^668R0@2Sg@RAgggVKGgZc>^Ye]J?>Q3<+f
Y6Zfd1Z)U-\G+<6\Y[eaTPME2Y32;=-^C_=M7K277YTHbK.30,X.9E6#TM@>=1@B
_SI\>=NZ?5bU_3&Ma<7+.GL;VFE)SZaAQ=\;UP@^S2/9>d\JXEIQG86Va6X#U9V?
g_KJa@6ZO1UW(c18<E4K.fL;3$
`endprotected
  

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
b^1[WH],?F=cLf/[&4AG;fbWG_HS?@@C5aK#g//,f5.-]_JG36;U((+<JB7TS#5N
:1+AF<8Wa<<F\/a0>d&U],;F=I>AD4-Rgc@:4Y@E@7Re7QZ=[Mb/f-(Gd@9G^Beb
U9Va6PTQd.F#@RA.+B,QUY)F7,X35S8Q_c]+CMBG;fdZ):f/3Y#_;95QD:XZIW)C
M-5LRI7SAH6/7B(BKV_/X<6cRe9,T4Re12L30Ve6VcM5/=Xa7&FRg)<T4+aeaLB?
S&@#M:O7O]2940,1fU94C(BHQe1CL8X;gEdgC&\FY,2GXc3/FH3[7+^1QKA1E7=.
@1D?7RM0d6EW&WQER0bMS[SGV:>HSf+&8\]4<EV:YB2bE]g\>Pg=XWgaIY=-e^@e
9&I?@e<fGEH5OT26TKR7X\M^UX53_()H[57@ZHX4ZN\)[@FSFD2]G13(+G#?(Rb_
b.9[:412O(4b[a&MJAE=\7N2P0N>RZU94&A&-&JCXM):6X,E6GYd>9;W:;/M-C>H
#J@E,,TI,@@KC5:_VUKA1Q21Mf\6G<1#cBR?RBB-d+GVWeR?+_D>0F7;[f]2:4)2
P,fV7/PV>^GG1b@XJL4(2e9Z<Q9>N#&)D>bUeE[^8:<8\;U&fDWa+74N)WCcTf@2
3:b0O3Y+/\S8TVJ&L6Z:SV>g8_3cE[GP.IT+;.6=IQ.1>P?5bQMK;JBde^eNaZf1
#&=J:=<\[ALFQ?V?O.I4Cd?:39Kf:=N#A:0WbCAN7_YV@fg</UDF8AY6W44FgBF?
MIX=GZJ2a]Nge_<5aUS6Sf1d#62.\M3@@HMc<#D)d?:JZ=3dTdU0fBe[>BH<KQY/
6QGUe>L[PT&7b#1VA=A)2SaU&+:2f29]6LY/KF.Y=G9e#ZNYD_6HHVT>b@\9&1eU
c6)4?&9^fWXa9?)2?0PJAYJ2C(C17]WF^<JfN+D+LO+Y[/b3I&)RVC^DeZ[3C:c6
[-A>YfE;./O?SP/HaS-0H0(17CcPXZgKK8?(cA0d.I+e)NN,6eS^)@9Wb3;I+dPB
OK28aHM\;e\YPJ0_;ZB0WGT8U/(>D-\CP:]8S/>\P;?<?/](PQ18-(TEH0XA1^PI
PX;#f8G3#V;4AL=L378Z0UTY&BeU,A:DJLEMe(#R7Q<-=H=<2dE_DGEdO&JB3>&F
]8GB9P2_fKF=gV1BCY[c1I6a+3<L58E#?@125S,;.WHdcQd8a^&8#QR2F&e475JH
SV97Bec;?Nc3UXWPggNMPN<<>V;Y\&N#4aEVII52^S>5/?,NZ.X3Kb/b^(R0<&CM
f_N_SIfFL5caAUETI2-Y;ULRYUMgHfC7][O>0/][Ra3CSMJ]PR4P1\16=:Q+:[LT
\XQEdVM(cG:fD4AX9#b#O_?K@MJ(&:RJb3DAFZMg_U4f\7-df&JD?LTZ.<>Y:a#G
:UP)G7U>RbeDUHJfd@V:VIE4_;JO2aEUSJ[Z/aJ(Z==;<,dU.-U;7S9D]8LOc/:F
[G:XKBF1M\QW.7-?ST:HJcBBg,NP8#X8DVS8H9<4(e<^8aC9@f<E_g&6cI;8SD2B
8\b4?.-]TH;1#[bf0P\KUe6M@=1KVgdZ,@9;,+<XFI4MN3Q5?b/I]-T,_Hf8_dT4
cJEXSNZ:5)+D4:UZ/He4b<4S3N3;fce9(YDUI9]0]g.SX#abG;9G7?_\SE:Q?d@7
7]&8OMQ6cK7SWP(@ZW4?4?eE&+U@_YddL(DT>dU97[2IRC)03/^;3(gZPK.?>(b#
#KJe@++Z53.[#(2F<-_U@^12Ee[1\<;cU:d79bH553fR[]73eeacL0QUAZY0L.e2
L=cWBJC4Z/)5SWNU;:Fe<(^&J4gK^RH6eD5\:1.aCY4)4;4T>gNDLa_Fg/8.N(eJ
9b\7^6>FA[=aLe>d]MeC-A8(=T/JGa_4=.TU(a@cTSGY+K))?-aHWH3GLLL9Q,gE
a.,W9R[[Z\NPJ6JPQdL\Z&.]9A]5^Ta)Y+P[&?FSAeS6fF@E\ffYH<&cTCa&/BC5
O._1&&ILI;[If_b[RFL=WAcI#&EOXc9050VVC2VM1MS))65NU[K@)-YXHSS(46K-
JK^9RNY#>U7SI:NXKNL=.QR@?NU+^FE)75JS=g\Rc^O@eK\/=QF)Na]D1QN5K;0e
@&&HB-<1IgC7TH;+9-82QIR+[9_8WdLJM/L]A0]aFN,KFY)T1Dd\T)(X#0OK,L^U
RVE;X+gZJ7HFebTR=f4aTgW_dGdc,E_F6<^7NRTX/68cfXSd8&\dRV.;d\H6=5c4
UBX9V4.))8Ma/HS@HMMa[d4Y7I3YT-N,8ag[.]b)9N<A>;VJ@M<(ON_R]a6&\#)b
D)W:=&BL/=\FH?&&BB4X^2.B.agL;DdaL]:FB/Og7\0c(#N&&LZ8YNe0^:IT/We/
6MQNP0XAffK6Ud_D+W.cEa>3JYS-\56F(8fGeXGU6-B^YC7d=OPD3.2T0JVFg/Sc
4H_Z><3B\C^P7(WAH[CUHSLC&6Y@<W4()NL.gV-)L>+L>ZbE/EXX3SWd)OWTI#G/
eFHOK:&I6eeY]KV,JBP^3f=c2#P)1/4##XRPSc>#F9S9.=.^b<0Pa3Ec<BNJOd8e
bR,848I&B\2B:eb):K@=UHJb)@6a:W8L=<JR,9,/?.PU&8;X<]aH+X+F>KbQgD<#
>VA1d@@@B:UG07c@WX)-\6NY2daY-B>GI@Z0KS6&gA.>dCd_0+g]eY@Z^7-/U>=:
NN@O5758bMST>=;YRQ]G]TI25:V7fDL_D@[0c=]DXEQa^D25(eP<<PH8_79EGQH;
5&?Uc2Bb=;bV5Q.<HAY:25f.C=R\Eba94E:gEFDL2;-d8_6WbRED4e)U,T2(d_T_
Y])5E-C\W.S[7:3[>5a]1E15Ra,=a&@\O#NT0\IQaJfM:b(RBG@)/?:d/-dIGQ,T
<\(G<1LR7P@_f<d-HcX=[c3UA1;^)LBCJ\HDMGA\aAV=66?R@be#(\_OA\bUO_ZN
ga3edKK6^H=<A?=e8X_gI7P_gg^Gf(>5<b/KE54[IQQ2V]Z=#\:<cd6Z1,26U2MY
U[eJ@P,5X5SEeP3g,PaZ2,4>b6VCdNC9?<<Q)1^4\5,d5.24#L)7f&aU+eSP(W9)
MN?ZNKgUd64[a0>_;P+/5^5>(PJ#(0R#GL63O:^^6XS>IeF^XV6GR7=Eb=RX:[?(
P##=M&=+;:E:4)bc/^933-4eS>=4:eFa4(X6\e7L<<V1e8F1gSHUcPc[c/?_47?E
M[Z]_\NV,IgTF_X+D2#Ld;2G\8Og6?;_:]O,40PfW##ATA&4eG3:[40Zfd7SgeL;
8-9)dA2:cWXc_Y5HMY70U@c;CKJDQO;(U>a-S_\JO-_TXSB_B[.<4X(8FA0a#Ff8
L<A=MOB_VTY.P;29SZ09bDc:VHF5fDI._04H3dL43[K0R?E#@dA-OPGDG_WIdTS=
\T\M,WbDgO3@KA49;b_95K2?#=R-6-a<-IC6_<;12]R]UHE=[38/(KN?H#>X.e_L
Q_+gb9/fZ39S#cV_8BX4:J.;ED)]RC1H?:H?RF09KW^:[-7d+&/+2PED3^bQdf<c
L_W9RE;20gKWF.-XQ:HBJ1EYc4VfSO#Uc:W-0VGD).?<aH4/e7d3OE(Id@#UOeW^
\X0P7ZBI3.#MXT4Jb7gAPR[g>eQQ7SYAUK_..F.G-Jd.)\SgM^G?-,DJ\QW<(bd[
)6Ge^9J&egF^2E82Hg4QfLd=e3BYDf/.X>8?YOHBdNN-OQ3)/A@E(N-6e>bRRZ2=
&H6LV\9B9-#@-0L:.&A==B-FT:,IX+4M-@9XQ\a:B&G3OO2?b,FZa[F@1=YLF=]E
U.-e<b?PUdX\4b@bFJZ3(\DPC;32W08)I4&_a9Y[LQX^KG+S\=OR1G+4SNEC:Y+?
8]f7;H3,&[,[eXbV#?g^KV9e[AG:-B+=1G9N/5T:P:AOb/SZ-D/F>39IX\4TK2\5
I/-\gS722\<:_^RQO5CNGJfXIbXaU>(WfgE_,EN;WO^,f?#(CKY;RcfIKVN8#@#T
TI+/0H]0#.BEf^K7+7M@B-M93&805B0>P&[AXSJVSC.SKPB5K70REd:f/QXP;0>O
342b5#;7FMRL=R(E?:&8-WaQZDHV2a92>#9?[=FLU11)8R2bQ>ICX9S2GKZKGB/H
>2^&Vd_BTD11P3)RgY3Zf1+ALB]ZULS2M>R:]@U&=V^,]E-Z9O^[\/:eD]Z6J+I<
T^2_@@cRM^VM>6O3aL8EDeXL9Ea,.bJY7D8LX2eY.5[LS.#;1ZZRP\e[gEYB4)EA
N+fJXTb?aQ#e^ZTPSX=.BM&R&SI<:E9_\eUH1<8MOCZfE#-1AOgA?=BPR:M[#-4(
4cdGfb[F.,662O79I#>\XL<<&PBIFU>8bLT<YC1LXG8&fNXBW,7AdS\Ic=H5.UK^
3B8@-WeBV^_TX+-GUJ.SFS/1D5]Ce2gH1YS[f7>8])O6bfG91=?.<g1bg]BW<FHS
PP)LDV>^:^gAb3?N,.-LT_7R7]IOI1L3bDYI@c-XB]F?T1Xgf_W,L1eHIU)LMC93
[H6=c]0LA?)U8P:J8_:^/XIWZc;K1b>XI#b68:7fMEU<1g4+XIcWU9,4b5]BMJQY
CbMbd3C9V0,FUI7ZOR28&(<1VdYFc(J,&&9SW+E?]412L\0A]f3\T))EVMA_T?Yf
.6?Q#D6d8I1XTVMeI7CQ/Pd=aeU=7>b]UBAJLYd]KS&,Y.=BGc#WbN+Nd-90^UCd
Y1Y=Xgg><QaMDQ3H9RQT:Q;V<7^S#)Q+LR+/X5UP\Rc4aC\<e9\9ScH0&,>7D20;
A4J67N)</6HdA6P?9E]PZS:>B+PHgOa7[PW8QUSUeU8&K3]OKF^\T8NG\3?H?[6^
AGV6#?:N62+B(bV@3].SFYLS+(Xb5JD=RIQW0Y(b)Q(bYLU/:LTbf=a(T^_R+4&K
M;1,A2)UZXY0)^CV1G)C^dYL5dYXb[;;KHR@2fG^),_@.b9g7/.HN,3OT=#1:B?=
9VT6]G,(2+3RJg\(>V:Rc2#=dfJ17&>bAg<29/LPLSS/W]AaG-;[)UATY\#VVCda
9^1-bKV9LK.B>bOZ]:PI0B[&<LIE)9L2aHYKd.c+<E75HXMZ_=ge1PX(Ie7Q(7g^
+N64C8@H;7;.BYV<U#R\Ue1X^:=Dc#GBW/K:Mg7;ZL1<A<U_aUJ[T._g78_eC,^D
-.8J1UV0f(0M^U1H-JO3TW?GM?07DXY&5#0U\=LETDX[?6\;&^;6SV,,QX>2e)Qf
E<.-HT0RB<.,]TQY3bZB3D1=&5#I.:IfX5XKG^?IYGa2YP\,ac=QMQf^(XYJN+J(
Y[Eb27>NQYKHHMWN7_K39GEB-NA=c#OCbgc(cDa8::UgdbaN<ebDDG)P#-AQN5EN
\D9HIN3KNAV>#]7]Fc>cOUJR],#+6XI=UA2<9__Y9P,32;DIOCN](?67MBO4+e5W
V_\-NTW.3^;Ig.QB\_fB0&PE>,0KcC12<fFc@PCU/PId=&Z[Ef)d^CDZ]0-G\P?^
2@+91T.TC&R:^<#.X/GREJ\][f17]P[IYGV7eaNVO@c4>O-C58Y:T,7b]4)_X>WR
&;4:g\,=4W3W8?e-680.RAUH=P66d/2?8;^,c&:c6d,DaR&-(U686:=&(^WIaaT[
bJS862[AE0+(dD2Z8+,=5ZX,3PW40-gdCcL,JRP7T4Y^<M:dg6NB[B=UIg_g\]P[
Uag2<HL?.68(-.W]&9@e/ZbY?S#2A6g]-@g+H7-&Qa_d2ACIC@B)2V^(Y=15,1a6
DT4=\6Yg+4)_]gCb4W97)10[72A94E4TIHQ<,M56)dC-QCX1FU[9/@A/M;D;)dIC
b#960HJT@)I^d_D,@6_IT@P#<ebXGOJ?PHQNa^9Qg_eRaU^Q=\\VNTL9Y^Y(A.cO
>^._HA)Bb.gAI-a\H1F43>8\9W(D,#V=U13aU9=dTad6@Me.Vb2^6:f)L2NXSUCU
f8>S-=-2eWW,<30F;A?Z0HIX>PdZ+05ed=/f06()<_HDQ:-8YG?[cg#+c0UL7G-6
e8N3e1U0DDbA:5[Q;:T&>OYa21\=JV\>1?N8G4U_2HFQLgL^b_Ced2:[QNY>WH?(
:TeN\=)C)(Tb3UL6N0&/@L0BE9UO6IMG&294dO,WX9A]b.GBT55Z?R-ZaSD</:@T
HUL-C441T5RHb?J0Z+]1XP[f2_Q[3LF9^FdAPeM/Q(#V_\af[)WgHCO+9E7&b0La
O5D\Q@,+?1+@SJ>XK7VH7L9G/(:3R30b\TCa-X\__d?1P;>@cbZP206\K^gcBdQ8
,;J5B]/f@AJgOd;f>d?AWLPUgR--22(D7:(5YCfTfB5X8EUFNR13D/53D@O@<G(G
5SAgK--(8[^X[S8a^IHeI/OVT.M\.X_+L2VE4Ye5PM;SUc9^>2M<IK.(S89?T0fM
e9N0^>\FT^eePA/-DP+a2A_EWMHC2?FeSA&-K;:_1^BWbD+dPC0-N;]:RJ=P6Rf_
UM,2b\1S;W1FW@L#=Q.]KcI#,2SX6Y.Rg0-SWM0\.&9a4[eZ<6/LA6TM0d,)<IV]
+M03:=gZ^-/JDLP9,3Y]1.ZbV(DA+4XWgI)^.86:NE2J;df\JC49?&A/+aH_:I&?
_EEW.eLD2F8PX&5ec0<e1f0Q]\QA>X&>bJ\>-A)\)TBG]7/AcLZ=@J]aZ5\,1P,T
S?>DLUJC[M#[:9LO0PPMb20M0PJAAXO7:M@(?EZJWVLIdKHDK(IV^Y72;)g&#F/Z
+LVD[E;M7B#AR8e1KZeR67a7X3ZTC\)76\+11aa8A2cSeZ[K?gNSB>5a>N=:D-4&
CG6E^VS6Y4ZYeLO@JT58-6<8P;O65FFY1)C<5BZRG.3&MG7c[.?52IaX6E2/^QG1
DGEN,6Z^P]M^,BM&\4L>,e1^FEcX&U7NL><WZ5]OSQ5)9;\c\S12TH=3/2de@B4A
3V_A7QAR5#U9@#70T[,K,IU-V8b51;5S-UKeOZ,ZEW8IQN;5XCG_+OU++G6TgAcX
2Cg=O/g0:2),(6eQ.3/GZW<UA1U,eAVB9gT;[<?KLN&]Gg_+G/c+5YgW5BdfG:?+
AdeEB#LVNfSM6W4GGH5#WS69^<5d3ebQL4cQ\/;d-f_f-a;8@M@Y>+0&WY_2>1E&
YJO=C0IJdMc4Ia<<^5).I_)BcC=)eKJYLU,;ae2)6H^.<H3bODaTL]T=-]Y/Hg6O
_UY;X&g;L=9ZLccQKd_566/,U(+5;d2;]Y4:S-7&=:T/P)a?E/9eT#MQ_/SR1HUd
[)@N8_:bWPa+F2?C#FST[=DaFAK0#.4@M&ef=d9.(.;F,H516(=11<B63Xa5]Q(L
O3V)f.]06+AOJ9#1I9g\S?@GbD&0MGeODSU]?b)<3Jd@C^FX:L=Z-#0/gL]AR6\c
ZO0&+S3WNS2c/B0#&RaMHG;V<@H9E#924MFE>>000A&1546BgVWD,&G84=Q6d\)F
15UW?A..4X[6_G:ETQV7dWHDc1BSb@&K\?MXS[eBAQfD#N:X8ZK,8eVAB\?P7CWa
2&D#Xa=XW]MB.Y841PfQPYXYW;.9/6^T,#I@4H4-22Eecg+b?eR^LRN30La;8Y,5
EGK?C),JZ^]d&MMDF#3<EZ^X,:7?DP+BX_;T8;01N2MH1O/,c2823_]6C]F3=cD8
Ba)c^5N,5<g3^fZ]>.+OB:/MZLc=6H::DD,ZKS-)=)D1FfH)SD=(IEP9^:R#3PLg
8JC)@d3^K>^@<_RNHWJCa,Y44\3M?)<eU0bN(S<DeQab^UAfM9EX>R0-MX\ab58<
@#fcSCU22_QG>VLd)FYA&^9E6#1<gI[-@de6++gOU<HI2?/]LH_a1N,5K]8WX8a5
5^_O?OX#E/6fg0+eYAef.F0#DX&I#]\HR-C-6HJP:0QL1CF?f=QX9>cL1/+/b3MV
(0(1aRBO(OG#JD#UOcT7F;[:6&-(K]3AR@(g3F1XI;F>(6.Pa()0M6a4c5^YKT+-
ZS7>(e]A&Vc_a=;4eC0EDJUT3^Y2\,.<NJXG+ORZRPR)<]J(19S]\6K(eG-&QDVY
6:XW(af,f<Dd3c,f];>BLN2V&@K<HB[LZ5+QcK_6+)g4Q>?OWH^A.>PQ:-VD_O4A
WgO.S2C1S@[./I)[3Oc1cC&3g</N2YI@+gcNXbc95)dCD2e&OTcI4SKB3I)#>)8N
Z1PK.B(FGN2X]LfLR_.E#1bQ#EWe1TT;ebTaYYJ_<TK0K,<=S.RXWX3&6-@T_AN\
_C)V.N:0(ZO&X@#.+(>&GG56Z4;?)0NSW\\8?UF8F3BF2B\(,A<R3S2#+^;R3PdK
_A&^K&/J^NG/bK&NO7B?LK7B[B,2NBCV#>PbOQCJCgJIPHVd]&)K(d\0RJ(^7RAZ
KN\K[#+c19J@3A^:;&&IbJX+H+&J(c=-F7CAJY#W,8a[C4IFRZ1J,EK]/:_gA,IX
Y;8](W(J(=CZPF,HeOc@#]MK4^4ZD?/P=7fFMCSXc[AGD55N_:GMJ0)#2J;[;OAD
R/CK/c>&T)0dggXCbI]+-I9gb@#d:#JD\4KR8b/Y89QR<^fU,a.X,Z(9#C.a=[NU
b1+#Q6A8CYXAO9d^)#W[X4^8:7@BR//Gb/cf:e+a3@gWM4QJP&:]ZQdRa<Z?Z3(5
F+IF_RG<IBWdK/[\(]]84FWSbfU@cbfR+7A9\27SRa\2W68-]QVMO1\WP40@&7(-
eGY2WP@fUS]3(;R6DIOV?N(H8)6b=PV?_2:c&+3=7RB4gS[fZ/_13U5Wg&]8^@-2
g.fTS,2_AXBX^GSfHDJPX)b8-[MD:_E5PM\C>W^K#JGXAOK,XRX4aI(fK7GD@eY5
/KXQ(CM4U(&C7EHCU8F^9gH7_XK@8a5BQ1a8(#MW8OHdg(^:1[cJ>3LaB]Vg4Q9+
9MaV=XgdEaVee=,U04P,F+=?=7McXK)C<<+MNfGZCO+:[T\eTQP,5J,N\H[^(.<7
8[/-L-=5&&[//gA\.HY6:c_@&FQJA:G<2fP&bOLeCHGcF5RF,V&+.1e_J&O.7]OK
aCAJ<PI2(g;Yg6S&Eg>/BR_E+c>TLNS=Tc&(]>fTSdfdSFE6F>^V03#5G9<&=LLJ
HUL24B[b/\d)UB[EdIAK&dTdD2-3(^H)WFF)B94-g&(W]2)5/Q-a&9HOG3#&F?KT
TVJ[Vb;;;]O012)6If5DSP86O;50G1N^?V>;cZBN,^B;Pf:O(>6A(-2&^Ba+(7N]
2@>MR,C;QVeP-Rf@)>F(OTK)8@^@CT-:2\1d=>80);;TcE.bHe?[#Q),\IND=@fU
CdS>J+=6MV@LXA5@b7K;E\L<;Q56YL,(OZS=G=4W\&S)bRD7GHdZ.^KWZA43XD8Z
:#OU96_8IJ+4:B/A3T./5,CGZ?THT?ZP,13c5V?(4QZDT7?+W+TVGJf.PB(6AFdH
45^LHB:BGbeV482_@HLZ8</5Q[YdC7<cDHf3FRR@/85VV];MF^F9,M0\a&JC[Ibf
^6VG=D;[0P]>WgP3XX069.>UMOQFgJ&G\\LBT)cXE;UALDD_&<1I_<[^/fOb5K:X
,^D&CRRD-WQW&0c^cO>+GQ1M48MI#gD:PW+6P,J,5H>?;ZJ.bSOba(&_45-faBMS
<9FI<@E^((cX3C<R+=dXC0;K,4_[_##53#eUR5O1FKBDbO)>L6HEHf9@;,#TDbEJ
fU_(cNY3)-8gaRQ8<@IOc\Cc3a3/66?g2e4Z^#K;#UK=/S>O677[5N64CDTGg47=
G<W&=XJ9/K<C-,/E>O3&-RWSg9UZO.(N)g/^ZWUe8^^1+:Ag(9/U#[:(I#\][4#K
CUF/DBCA>(6\_4&-?;MW@]_]-M4=&P@)D..IBdO3+M&=LN)1@[Y39\eZ\8R,VN19
NgPE(cNdVLL+AUe8,<<I<YE5^[SXPZ13T[FM8X(]-T64JOc<XR67:JV.ZB9&/dLE
[+P#8E@S;&][f^2I4)c=]N[ILc.\aZ/JJS-40=KT/O7dUK;Rc-Ic.VNPJ[;eDeMZ
)K&Ob1B0.S#R<[:W<6J.0Wg>(2.eW@,<fCGBY.?d-?\T(T?@]N:1RVX@fSLTSXW=
d(O5E#;BB6LJaGRacJ@Q)c7da^)-/3;E?FXTMN^=G:[;/7CJ4gPR^;Ee>Q<L\0;>
?9MWg+W,MEWEfQ4fg3?f3)07(=b)&#LVfe+Ha&&SJ1[^ZIL@d4:DR8a7>8PVFG>N
ScPF;PU(JP7-DLIg+Z<[0<f5_[_f[VcQIJb:>@/&KE-]48f;0e5Y1@)C47>Q_^S;
WOe1DHT6\U?gWA-ZDG0a+5][ME8.\dM58)T=a1K60C-V&.@-g:]2M]5-F)Af\-gR
7XNO>,:HaA.V4S<2=Q\HKYC9A:V9\.cV2T\1B[CD76_7M(ED7[dUX;;#>G;<5<DG
f.:?JQQ4@gE/4RK@S(3d3^EQgQKA;?5c_CVdL<FWaQ5U5/Q])R\d_\VURcI5CI,G
3=R][IJN3&_:4a[8>_RNd>\QEK<P@T]^(bEQ/+GH99OQ^?b&WGYIP@b3R3D]R<(e
8UKeZ<6Q6_fR>E\/?M?2D0NUO,M(NWVV(<+TVFV&PGGEHgC55b_60+W,/ca<dHOV
KVe-#G.8/NagW9gH?^(503YV+W#XM<Bae+FHbW\#RF#W9^ENAJ5XBJ;5ICV4[eUD
[Ng?@bYKfG)[M;SH]R9+Cba\a=L?)Q-O&KIOF,[a[d1>:??Y]#N#V9@6HD>1<Yf,
^?_3(b>7)&Y@KL;FcVPJaD#&1-I&CcOfCJbSA-\IXU/V&bAO2:OFTM-^A/^UFbIW
_gA1,1MX?d9L6KIP)&JeFT?SY-dZBN1/Y5VfUZ5RJ8[eF0_VN0dCX4@HNA8<#O8A
2bFBPK6X+J^6,FeVFQ<c#R@9+X4.V8Td@]JKZ]7I^dFVHc.HSV=04#-IP3SHS^8e
cdUg\V>b5A\F/gE76L7;C.B<6:.+PBYA;R0@TYbJ0Z(Z]_AOPd/FPQ:-3@c8f\I(
8#Q6J^9UK3;DB3E.S2#>G]Y]0Q2DZH=0.8UDHaT)DRX+AY-Gg_YBWU^6<7NBcP^(
[99(,U)/DNcC_f#0=9?@3K^0@=.2#51:RRX>13ILQH9@O8@FY;RMQG+8PCLL<:;>
E3+Q/Q#b<LVg.Y+,P3ZdMJeZ2=IW[3:\Q/3IEIVR.<I/>IdJe4:J:7/6U54D@MJJ
C\-5^L_gIZI>[J(B[L;C.2:Y5GT_e(W(7)gWXT+eZBb#Qb[SQCO028-A_A(0e/BF
O<;CN3D>Oa_I^.PCOU-Y:-gH@&2066gG]0F3I8VHb^(RC])HaLaK9cDZICA-(IR4
(+]=D8XWYXY^:,/cN.Q)FV\S(.TVD)fU/2eY-a,<9=C]1G2a0e76Z:KU\6I5G;OJ
G0WAc7;Q:][UA=&cU(8:[P?+RE/bSXWEg-90eb#==)BZ(@+(O@VJV]8.P<#YUYeC
.BLXR,N;gC1bD[Kc;0bB=<PZ.+O^<-_?<L\B,=ddK\WHS_PV3=^]f>/gJ/7G+CTE
BY,T(R\G0FC<Y;fIS41C8JPOQIaGHS6XeI82Z9E7Z>&5L+5GI9/T46^?;=\&A2^G
B=5Q1b/e+.Ub;OI)G0:-C?<V+W>cRM<aT+4&..HVSg,93HF\3/;^K^P3CIWOE:NX
2[7A5IJ(O8^2eBUNXFdAf,K<L2RC\3>Q0]N\5^g[U^GP+_5HQ_LOEVee(+.;V>E,
gJeM]TVbb,1^3KeW[LRA7Z0)(XOGH=ER?EU8CWYc>#HER=<;X/I_B_-B<Z(89-cd
X?fMYT7#.fg^*$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_VMM_SV
