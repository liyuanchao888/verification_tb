
`ifndef GUARD_SVT_APB_SLAVE_SV
`define GUARD_SVT_APB_SLAVE_SV

typedef class svt_apb_slave_callback;
typedef svt_callbacks#(svt_apb_slave,svt_apb_slave_callback) svt_apb_slave_callback_pool;
// =============================================================================
/**
 * This class is UVM/OVM Driver that implements an APB Slave component.
 */
class svt_apb_slave extends svt_driver #(svt_apb_slave_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_apb_slave, svt_apb_slave_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of APB Slave components */
  protected svt_apb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_apb_slave_configuration cfg_snapshot;

  /**
   * Event triggers when slave has driven the read transaction on the port interface 
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

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_apb_slave_configuration cfg;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_apb_slave)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_apb_slave", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads like consume_from_seq_item_port()
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
  /** Report phase execution of the UVM/OVM component*/
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void report();
`endif

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

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages seq_item_port. Sequence items are taken
   * from the port and added to an internal queue.
   *
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_from_seq_item_port(svt_phase phase);

/** @endcond */

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_apb_slave_active_common common);

   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual protected function void post_input_port_get(svt_apb_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_apb_transaction xact);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual task post_input_port_get_cb_exec(svt_apb_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   * 
   * This method issues the <i>input_port_cov</i> callback using the
   * `svt_xvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_apb_transaction xact);
/** @endcond */

endclass

`protected
OW>17&)6E-d5E&_J,FS#^G79H227VaPM+<=GZ=1-D2Y<\bc?422+.)88W)TbU#42
YF&:<)CLK,ZMC,=:UBLQEf]2O;Fcbf,.NTA-e04EX5)4;LNFSDS,cYXQ14GCKR/V
c>J/;=H^5<H-/&PAPA3<PW-M7AJ[R<2>#VO\2U1>FO4>#3U-[6/G+S?=&G08H=TB
C9]TT-8B[\;.CgAf/]1;PcC<9WMD(Z-?WQL4^1<+9NeGbPWdZ,f7V0<()5c>,)6O
?I6TJSJeE0f8&^9bLZ_D=.\D.1aa0DgAV>2(d8b1,QfDX1E0C]d.FY<(P$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
F8T[GA=F-6T8GE#?DJ)#>31+P/D9+HdG3Wd44Q\@]YQE=ZF6\#(:,(Y?7N:?:FFH
4=L3-.>CN?U/YeaD&H8;:2Le9A];)+9_A]I@-WIVK.-1<b&^8af@XRbc1NPN:K^5
4-^6D,LEcQ&VY[_eIdcR)-WVLeA;Eg0>H)/^6&35OYTd);>TC;?I.CfK0e5O8a(?
\7\a8#_UWSTgG,QL484]caHH[;^UcOFgYg;.]a7\O6WPJ_Q7C(2-4Z,fF77DN=CQ
FT_Q\;RKad9YZ3\;-Q]<Y2NZI#CPJ::S03S@;6b2Ec1):gKNSS8O[X2Gc^]Yg4ON
9ZD;/d;NfDMcYf(6,Da=1LOS==P5O=Td-/Hb(IdKBaK)5[YOE_N+M:-ZJ6P7+R<c
X81SGRE+_535-/b=/THFa\8XfSAVI6cP/2fL\9IQ@6b1BUS>;R5O:I(QB]-H;OSL
9CGSf.=L5#HgLNEgA[3O/2:a]X-2]19N2e4\P^b?OPT>#bF7Y3cdAc<b3Yf4;ZX;
JRaN^e^11,C_?W6U@TB+9EK05.F-;L[UUc:PVF59Z:CT[I#J#;FIf<TY+Z815CAd
0A+LJ4TZfDCJ;:f\?g[<CD&E2eP_9fHEX,4^;AQ5gR=3,/3bFGZ:^0@gFI(gV54\
GJdTc-&]F-g6(.TZ/ga/SWggVZHgI3e_762OgDCLT1/P(IHU(;<VO8YF2X=UH+HF
WF.,3e<)FdbS]W#>;SW=M+/E<;LW#=XA.P:H?V0@e&(J81.d?8I9Q/,A[a&6:_2A
Nb5dMeadT6DfXD>NT@01L6J>A:;/E6Me#@)^.TQ^>HJ.TK(];=TId&6@+H)IT_dI
<[g1D09N&>4LFNU?<1V^0PVF=d#U2dd&3,b:NGNe.IAFTBaJ/7]6CZA^\eE_R91C
g+Q;?EJ,XT?+TGdF=edV,MI;A8WX/L/E&56YYC0eGTB39ILDO6QJgC8:4[0@[,Q5
RQ,\64QYBTP7D]^>VBSP2@KOC]64U=3KG;6PGB];f+RJb7c=WUTaR/6:R,QA.^cP
X4cdXLKR)G5f^]-RD062LRJ?0Z:,^9UT8E2NeBC[>.=PHR0V1W=ZTSLJb,)PZ)<T
/H8YM9bJgN^bf6YRWb_4LVaS,\6SU55&]FG9M?5CFeD(693S:P+Q\WO-Q3#1BH3Z
6;cb0:b00<41_c?g]dTG]WQ^,GGOL^@)O]^;^eVC4>7@=L:#a<R/NPf]<STUfHeK
=(=#Pg?8_20>SA_E;)7Yg(c0AR/9IH=af6:BVCS\-.?eLZVB^eJ\d^0-9:?E[d7E
^6@/FBa(/W6d#.=^SE9S^.#\f98LZ+gKXZ>)aPN)M=#D/P.J7?JWNEF+FYFN_I)?
<5cKfOR6P5UT&7cLeB(b<.9]DPdW0@2NN?2Q9AUC4R=beX8Kb-<Eb/McLO<S[Q)-
,a3U3Adc&3:P=(fBN3^[^-X9cGS92-2#=O=OGLDO]+8Y@:\IL<MW9\T+E5^OB:^Z
c\_3E^2HO3Pa2+VY/-@&NPNdMXV\DE,>]LUU[1:aef#V6/Y369HHLB].^5@+/3:_
3;9V[=G4&:O@29dJRdcOVUV=XB)X8]+=WQ^Z0U412?C?Pbe4e/ZJLX_[?UI\S_[H
&QF.0JX7[=T;,L-7M:L#0@XR-\?N1H@LY1<dO@F:P;D+f;ELV4LX_1Y<X1N=<\Fe
B:RRQ3?DbIZYNWGO9@g.3fIa;a-bH=A[eR&6_1T1[77S&4\L30R=6E)I>@)\FIH[
a0UC^[fI5[=,EG7HY85g3c]Zb>EYF2g=NH@aK\X\,E<VX-;)=gR[J-_5C@F8:CZA
Z(L\8D7NE=UK,a@/Z->G/Ka6[@)X>9aG42#3_0>g+@?/GHLG&>aT_bX@ELR(K39c
)Y(a.TO_:3>JW+7MPOAgPF\Oc=1e21a_7[=[T3RKB5eC>fCX&N_A/dUdHg>d/f(2
0^MaWeNZ6)K/@2W&1#<X,I<K0_TbD+MaI@D]eXW/?W5GF64VLW0fcKgH8;YR_a)W
M+:0F@FbD\=PFH2[?O-FfX/Y#AUbB),PXQN9bCa--=4^Q(a91&&?R]=]c#cf\,Cf
;c^#EUe4bK>PS8TP><7M&TC+Q</)M17YbZT0:_+bH0_Q&c/^3_90)G&E(BF:#H]L
U?O)MTe]R=8^,I/:5Af=g4bd1_H>Ic4=2FRD&JI5OP2<&Xc:77C5eD,:bWLE-GJ,
[TE[APBOBB<R)eNS]a>,47,a/aERHY?#@#]S(.9,C^#&&E7eL4;<UN?+=LYd[dCN
,eg(OB9bIQU8(/,ZODQWeS_Y#bJA@]f)6&D;d0COU13MTc?I9IL71?/V,b@L6GbJ
/J;d9KFKX3B4>L:)=T-\1(fDfB(B1DPQ:#3J;NH(Z4_XYBU-Db0<ITVPY-e1]QA?
8E(<&<8TVeTYTcF<deSF9#C)X@]BBgGD\PMMdZa8(6_8[c/M;NC,La(9\G;Lb+J#
<@C3\ZVFY0<.b6Fa+H]#ON.N:UNM^Je)FS-N-Z?b:AI[Ud7<R4T8cZZADQ#K\e2V
#I_?=HNaP\<K\8FN;/;M:<2?<4C)[\P&44g-P9BKWBYcK7dCFB9[371CW,>THbW4
J<?+ZSS4RZ8?,a<WO63JP@gc0J=#1(=^7=X(C-HTJ-Q6R9/B[UR#U:W=c5YPS>Ra
?4S(-O&=1\c8_dS]W^0@MC.QaW6P)7Q-aLRS;:X1eUGc1Tb[3R_78W+bJf#\^ML-
gNHEE3aS_^5S-9WcLaXI^OI8RE>4L#K=D9,M6N3V95XAK836.5d6H^<]G7^-fDS@
,S[2VAS?1\^NR+\dZI5eEFb:,I2K#-?6<=,MO__0:+K6IU=(I08Zf3YgJC,PA<Wa
K4]BZU^X19fR(T1@ECTHPgOO[06<[>J.e]=0Q@70KB()LEDf/e9Q0&RW>FbPZ/&,
/HIcC1+3G?f2DYOQZGIJa]O30Re537EDA/_[SR-_BAVA@d-O9+g?7=^cF&:8/Nc]
85\.fT7TH#472^D0&gJ<F:26;.F(,:=9Sf5[0#5@DRf,8b[Eb?)2\Q[^cBgB@Ig#
1>gD?83M@5G]>I=T-_#8OGL8POMP2F2/Rc<GV(AL,Z52KW1WN<-EMF6SHEfA9JJ&
:+.e#\Lb:6XgGIC7Ag8L]@K+TX3&7JJ+cL+&;OEBNGQ3KCJ8)+;]P3Ta\D6;DS16
I\Z4^gfQ:FgIAI)/B)2K0<OH]B-bK8EP;,3H0F:c+MFY1-Ba@P/QNXX])CQVNb/:
P3#NTP+ZO,]X9&>HK79OACee^a32gWPY>FZZKCK1AI2b]ddRbg2LBU+\/FSPYdI+
YCaAUUVLI,=<T2f>N0(2F8f0X62XC;DQLIP9-Y+_7NT2:[CbS@B-;A4a0a#=c]-3
a\3A#DfP0gc3e7-Bg;JK.>F53[,(_4GO+S@7(B5;.f<+35:9&7CQ;L8F:9R-)8d1
:DB&@TEIa_#7-?:V71)0]:Ig<T]W??g[L?J[]KQFCg_P3F/XB)[I<6F0D?GS;;@\
bQ_a)P+S=gBAJ67-0c5J.(_=9H^+<d>],a=OGS<IWN/?]PfcBe/U[-;/OMP,aeL;
f@[5e__Y)?c.8>Bc#De5N#;XK0]#;F^&bF7,DKK0)>Zd?A_J,6<Y)H04]/<#J(NZ
8fPOa(O[PEV4D7C_.1G7LfDcN\YPJD3)\BIEJUK1GY,ZW(2D9F92TQM\&=L,U1\F
6cBS1SHZ-WL3YST^X<0\\e:H(D?)0GL?YWCD1IT<^@GL\X9(d;Kd-HLP:3?XOP]&
/52Td.HV5&Yg/.&TJ,38.H);[J\).X6/^b&L+CFP0/2g[3];WF1FVd\>NT<V8FK;
CNPK;\E32Sa<V&]Wc6:g>fDFaRb(&3M.@<QT3D#PIWP@W)3a9e>;R-ad8Naa;6bS
O9[aZ[S+.4>.Q#&&7OIW+S=F0.?OYDF_:;7=?@T1c54Y#._??_]bWZY]^JZWV>?I
IMe^5AL#V-^<D^_Z^GgNMa]AfU\bPHLYLU;3K4H00XPc\aL&Z7;H)-\#_c@X=,V0
gIJI5b.fVeY1Kc32YQF<A2gbP\AW@FQ6?,],Y?.\d^c,c+4.[#\UPFDMH:IHK>ZW
+85Zf1<\e+PRJED,?-]I<)25ED<5=&:gXd@HZKH;g2ZB_(Y&[&[d+F;2>4-=e3A;
WGaG^C=>T?C2HE^(W3f7KO6\02cXGNA;020U6&GK&,L9;9E1f4Y_b0[#]V;:OR=E
X3?A[>NUa?(I+_UHQ_H.]6#6SXN98]2,CXSf6?@U92NG-_bLF4?FA,EAA^d^gZMI
.:FV)8GaX3b,+Ec<+GGSM3BIZKBT5-Y&:7W=dP:-@cfX^LQS>^>bRAV<V[[0<?;O
,E>TIYgE<Q#YOS:d[_X8b[-]E4>UD&C<SLdG+UQKaE);W/8/T+4T\,8QML/3_(D\
32GQ4G);2NU3O&36Y.77ZgSbVNAS6LadHDMEY_gF0>&OS)80]dIEPQe75A@4L=F4
?OUUWB-2DdNW9TNaJ[aaZZe[5:9(XY>MD&+JS-,g/fX>#/HVQg?4U(Jg]aD9QOT<
3d:64Vf3b6;,RM<[B.FR_aU/4CJAY1X)VDHg5Je:U()^:UCE[_70?L[@SAPdd1aQ
HgZgI.)7U(V<FY5OK>c@A0).Y-RE:]fVK.OIL(2BEYaHfC&?3Yg9IJ53X#[QBCHC
P,V0ZJU>QPDUA2V7&=eU0BTIGIbUD\S+XgA=#.0W>a9\:G=7J35@06+E7H>+Q_EA
ITS??80?Y5AKb)43HA9_@)=#+_[E>WLbgQeeGZfLcDMdD#@5a9^AW<fe_D834DIJ
-?1\@>.W6EeeCO,=UJO##09;PS+_,]f[^S1G\Y5D5Hb;IWZc>B(0[K<0ZNBDfH;#
<g&IdICR]49TG82RXe03&fJ??AJ[5bQAaR#XbQK\2U/b0/[4=3=,Kg4I\LG<@QJ\
YN]5Pd@O6B0<W_NUbaL05:UR#+Q5H?JTPKTd&)fYB1>Re4=#2Q-<IBb=KWAbIE>(
YYKbTe#cPOWS;3C12+^-EHEL5-\O?YJb\CCT>0#1L.V1)L^29+H>ZK+8N/J4cD@F
a,J/1c_SBE(]O-dAR:/,YG^YgVX\=J::\d)Ic3?[?<GAKY(gP&+Y/X_D9U?f:8c0
00&Af)a7]KVX_0BeJ,)BDLV]/S]&WM^LEYaUeHdd9]HA&)+3QAfJSQfeKbF0e6(S
DTEU.?CO69Fg4=ED-KWG7@)7R8\a[WB6I?XV7=Eg6>>-YRB^;a4(@5OX3W]W#Q-&
J&f6FeQ\6(5HGF><_F^6DcgA,NWIG^/Pd+g^VA#6<@/U]>c8<c+Y?3D2.X<(<(0O
Yg4H.dXf+b\YAU5XY-(US(0dWKXE).Me#WG>?+KVW]7?eY]+<0VG#^7O?-XG9>Z,
Qa/1W,EK0A+G_9@K#;^J=MML?Y=SQV<;5ZB+K:Q;EONT>f[PH4d0K2gTg8T+#TI=
Q5;848S.8L,.Lc9STB@<PVQ0H<8]T7PNE4/,F3[L\>VBfUPU1YHV+.)6Lec[(5a^
S,fQbGK;,G5ce9PK&ZL.L8^W[[KJ/:=1Mg_0<;(5f9C7XfNLO>WFO[DFYTdB6EW?
V45P^YKU2D]LGDMc9&Hb7:@Y79DTI#(#g)XRJ((;[H1&3@[2K7DV.)L/#3dS>4fQ
W5S;6MOX<GGYJ,?GQM7V7UF/W=4OV/H=@+)9Tf-A,4cAF<@M&WYc1_F13]?N]+_4
a6Q8&L2QbV#(DK-TL0C@#J]A66WG?1G2)#+L^:\^HL_0AMS1:[B_?8,fg\\:/B;a
(;S@2ge@6>ITg,;87\)B:HP_J0)5E_cUVO]cP:KJ#[M8f(JI:X,DEMa[@M>SFbf6
^P=;2V^(QP;YTVP<Od&<g^1=)A0LYDCUCd97V3d<d=SE)>>+->[IX#M+5?e0_XWQ
<;+G)ecTSK[TJ&=W?9BY,abYI-6=3gALa6OOQLFDXVf0QO86NQ:8J(a>R8LPgaSI
]>;cI[LTUHGBfaX&.-ObC[e#=LJ3dec,KN>g1D,H&47L=(6Ud)EG#BW[_3+#X&Z6
D<KFRDG82U#CR4A7-Wa[C2cDS7bZOOM)Ze95-Q5+>2SH>@CU/#QWTYY\,10VT)NS
A?V>#SSG?:bfIL/<KDNW7L^0e>]6?N:(XVg]/9R=R-b:g]IU=.;9;+L6M32S@eT>
F1QSCV\TOR=+f6W8O?AMGeJB/NaV&V7cR+CDB1ZN3,@V-aI^P;(KE<?Bd1SU=8#7
SFJeX/<Cc7,HA4204(ABf0_]E+&?48W[dCPV7TA/N[aaOYe_5,4eBM>+&=/PG4FD
O-TCJ/+J\W7?<+WP79SB^/1))NA\FH)5L>86aaAdZIaSLZ[05cTD+O>;W=<)RP03
d.NYJG5^WHb=3X[<-E[eV[WW]Vf^09DfB)[S/D?]aPG+X37CX&:cV?5V/fJP#P?U
)9JUN=[H=>f_0cZ9_[d:VTTU+DXNc0+M-cH0C1.T_I/&QX?&5?aE[d=TC<ZF5AZY
a8eSCUEAC?_BC0LL(ZA7[LZ8I^8#>33TK^IZ\N0KY9M2>-.\M(gU?MY4H[#349B#
WT=.U6<)]=[&A[.^)A?5@>9I0&D,HRTcYU3,_:&AIXWD7\a^]5_:0DU])cAe8fP<
&ZJRSeYXQ>(26B?\2YGXQKEF7,=g,HA9B-SOdV[<N6U4Vd<./R,BLgGgRP?&QW3V
KI6P7Z^0eG4ZCKGZ,)XETB:YXIL^GM;C].EK42BH;G\6K_20M\?]a5beEYGb,Z4a
3gI]AM//c&LZ<+1)ITU+aW_77a)K;/RK.JS.AUH9?N;Y:M/GC>ZKf?E:J+@OT2=5
M3W?KP;<6[LA1,M&eQ+Bea0>b1]Mec]ILaQHgT:dX^VD\fd8)ccBe4K^QPE,Bf6.
O>0)P6:2ZCFMR_V=(?dK3:G:VQH&3fNZ9=;:@D=^>If0AX)3JXfTbVRNgKe+&I(?
U(Q\cZZP3b+FGa]@LA=E/A26EHKD^Gd>dd+_[0gK-)AA_?b[<VBCW^V2aE?RS(_9
RTg#2g\A42-5]HG0;U?+3/)<0S689dZTgV7#a_d95YV#256YJ\<^3W6,S,CTB[&G
HEB>)ZO/_Zb3Je\Ac^9\ICC.4^U:G624^\#S/FZ7Q[8?>EDQ\,ceEZ^6G9#S[c\a
J\V@=>/E1b.[cZ3#J18I>PILCY/#1^Y0=BVb3cJ+AA9/QT=])e1b/cb^HKTAg>WZ
P&Nd9K>#8]XJcVUO>Kb(;Y&OK(QML@P>>4@&\01NCIIRdRdVJec,c]9]I@02g.BB
F\B_=XWI=[->gL+ZV9XVNA7cX,F_@8UEL?XLY;-S5#USM,<Q#PXY&K+NGG/QNM?&
H^W?VPD:5V[W;#?HE^F@HC85O@ZaP)R(Ec@&0]7:e\9c4<<41#;#/WQUDWAD;>[3
DLD^/<74^C-+2L_55H#<Z]<Q.?9QRTVN^Rbg@#N>Oe]RMX&P(R,V1d;WMFB-]BXE
:53_gB9Kf\.I6#ZRf.I=]Z19Cc7KE((c<&.,G[XTZ[XF<J<7P4OYE-I[<.W?d3BV
=3e?20\ca/b3Y3SYPJD?P4(4@(d1@,.08_&-_SJ<eYLH-G5H42YPEXA/a/&SXf5)
cd5D5<0LV@C>CL7f,AR;;Qc[Uf&I5Ze#H3&M-OKa9&UN_RfDT?KH;+ECDQJ>().;
SgF#A:-+N\QVb:FQS^E\Y5=g4)Uc=Oc=cSJM5aRObJFE]M+CE0#)C3G-Z].+,?I+
9S+#AV_>2&QZVK:1;Q-#.c6Bab8/MK\6cHN=#&W,)G-J,3Yd]Q6C9TF<W@]9^[C,
5FZ)c:W@+76O;2]+7LH./JS2Jdg(cBdC9@V<W8>UCPFBE3IZ.B.ITJ\0(E8]M;,2
#=<WRU3VN3:ZS0c\gMYcC:bB^[WZc^#<?SK<D.#e8LgF(I_7FLf@327R.P^4Y_Af
Bd-7W#MPB_D:C@IfbF\&PG=(@2cI4#F\dgORZf]PTG8BQ(DLMR65UMGHW(B\HTSS
=?\J\)/.H;1KD\cR@X:KECCOA<<^F3+P2O>R-[&<XM2:4NUP##TL,fbD-(U?M;/Q
2863X+^.YH:UI8,>]]_G5g=2PSPER>g-1AWW;GffHE]:E$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_SV



