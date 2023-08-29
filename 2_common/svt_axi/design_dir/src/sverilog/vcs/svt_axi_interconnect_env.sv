
`ifndef GUARD_SVT_AXI_INTERCONNECT_ENV_SV
`define GUARD_SVT_AXI_INTERCONNECT_ENV_SV

// =============================================================================
/**
 * The Interconnect Env routes the AXI transactions between multiple masters
 * and slaves. The Interconnect Env contains configurable number of master &
 * slave ports. The number of master & slave ports of the Interconnect Env can
 * be controlled through interconnect configuration. The Interconnect Env
 * routes the transactions from masters to slaves based on address map.
 * Multiple address ranges can be specified for a single slave.
 */
class svt_axi_interconnect_env extends svt_env;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_axi_if svt_axi_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** AXI System virtual interface */
  svt_axi_vif vif;

  /* AXI Master components */
  svt_axi_ic_master_agent ic_mstr[$];

  /* AXI Slave components */
  svt_axi_ic_slave_agent ic_slv[$];

  /** AXI Interconnect Driver */
  svt_axi_interconnect driver;

  /** @cond PRIVATE */
  /** Virtual sequencer with reference to each slave snoop sequencer */
  //svt_axi_ic_snoop_sequencer ic_snoop_sequencer;

  /** Fifo into which the IC Sequence pushes randomized transactions for the
      interconnect to consume */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_tlm_fifo#(svt_axi_ic_slave_transaction)  ic_xact_fifo;
`elsif SVT_OVM_TECHNOLOGY
  tlm_fifo#(svt_axi_ic_slave_transaction)  ic_xact_fifo;
`endif



  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_interconnect_configuration cfg_snapshot;

  /* Fifo corresponding to each slave snoop port (connected to masters)*/
  protected svt_axi_ic_snoop_input_port_type ic_snoop_fifo[$];
  /* Fifo corresponding to each master port (connected to slaves)*/
  protected svt_axi_master_input_port_type ic_mstr_fifo[$];
  /** @endcond */ 


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this ENV. */
  local svt_axi_interconnect_configuration cfg;


  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_interconnect_env)

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
`ifdef SVT_UVM_TECHNOLOGY
  extern function new (string name = "svt_axi_interconnect_env", uvm_component parent = null);
`elsif SVT_OVM_TECHNOLOGY
  extern function new (string name = "svt_axi_interconnect_env", ovm_component parent = null);
`endif

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
   * Connect Phase
   * Connects the virtual sequencer to the sub-sequencers
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
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
BdC&P+8ZF0VS&^4CI@]JNCQ+J+&M^aR)T/MKId@ANV6&&O^McZ/c+)6N(\NC,=(+
>KVX^W_>3XEL\KAX-#H2<Z+Q1g#962b-J;]3E/02_WEQSAgfd7\W0S\[V+A(J7Td
5VEU2^VBKPB6=YOG&Fe4O42J7ed(J:&aRT7A5KR\ddX=:R75C+\5,&.)6:QCB;^Z
?F5+&:I3b>0:@G<<72P\aYH:A2)1Z#5/\:4,Sa:CcYfVNOCC;HW&#VJV]C[)[(\?
Gd?gbDW6L9R@>)geCYO?F=CbK(2LBdXF0&ZI&]dAd[aUUEQ/1Fg1-0I.J)@V;.WY
Q&O6c&eTB1.D==I1V]&HP[0H]agdZf+Ue/f:O#WgJ;K5=c1,STK+3fOMX9(ZJ(XI
4_Z)GD_QERX:HYK&c3J8/Q^5fV7[ee?aDK).6L[ZXNE#]QR^72Y1b@#]O51GC(@F
HT0(^S@^E[=A<NOAI5ScA@48e&0&&LFcHc=8fe[eF]29&Z.H:M56)DZ\g+dbT+N1
@]4K<8I\+B2McSDI@?Me)ZYZ<_GGHD6g,Yg&b/4)V5f9H$
`endprotected


//vcs_lic_vip_protect
  `protected
c/>A2\ZWaSa;]GgSQ#T1I_#=PLMU:ffbELYG:f/FN)EYLRAS:-fe-([FPVR3=_J&
Y_)60F9Z6Y:1Y7X10T:+40gB^8YeG7_eG)d9L5,2(dC9>]WE@9.:KOQa)@eDY^]:
TU0>W9OcVE:X;P693A^R2:Q\-4;_Cbe0@+9UVA>_IcP8NR)2#?B/FT=OJIXdOEJ,
WDIROUHOD.MEPITY_a</(Rae_CD/J#bTY;D5>3.,aeD8?gPX^9)c9(X#Ed4\H2^E
2T)RK5/]a998_1cEX_>5@(8]V0OFA+U4bIL\3@dT?>0RQLP;6/)72J(R,#Qc=Q0<
(cJDe:d[<bbVGRTb\GX2YSBSS)_#MZUF>Q6WIX2/O#LQGSRKUgZEZ^N8N;K+0)CW
GV@BSY>E09O0643U[U7.05X[<_BB5U>G6<Z7#TB3e&fJLP6d9JCDWeZ3I:BKQ.EU
>g=AS7DLZV.8AJBD3Xd-&9]7GK<\]PQJ=_^c?-D8PUR<Tb.Y\^^e<;cb\J+WF,c\
;^UC=23WZ,#E7.^IX(McR-)NM\K/ZPHI<,P8THRF#O#=Z.UP@U\I]>(.UcD,P<Y@
UT^CJME@dWFUbC.Q#_6=019;KWdV24&K&.D@0S[V7=L1eFd0^<<Wa@K@=>M^SF0F
C&g<,UP51_,d[+=#^^UFZ<<>/O7U4W^Va6R>Pd7E](WA0f1X9W.:QUY_[O(/\JRD
MMHWM39/=EW,8J/a=.,\cQdE_D7QdHTR0O;:O]20D@<O>bX<e-F00.]8ZM+V+=Ac
^I#<&\)UeM+bG)PgSARN]:)PWHcG)43eGLR[B3H4aBZG=([G6A,P8^F.-J5172YH
(::3:UCSN,XfS&d#-8;6NdS;/,NB-ML>]_KD).:A;Y\M;_P.^;GTQD^TD8E(dH_&
Z\WT\M5?EY91BBJL^09U/cg=GJM:Ua/e>P5N,I)+dYI(JBH&>b,c1UDUeMdaN_f7
8WE=Y)_[1VVa=?;4cM#PT1@BXTY.F?C.61NQWI=:6;fZ.07Z6);?eU>U]OL^U>PS
6]I.U4FGP8OcO\WB\XMSH7Y#<4AE4R9gI9dW(gd7?IB6HE-^cA9G>;a2#^ca646O
^DE]:QC8DD.,KDIBG8a2:CZ1bg5#-U5SW-(0D5=,/B21=;QGD3Y<?d/b\,NVbc#-
[U4[<L;7]B2TQW1>UN?KI-L@B>ad#K#UEJ(]39_O(=0UBeZ)cEJ4;:3<La+61YE<
&Z779aQR]_Ma4]a5>0MU]N044GN>]DEYbMQYeRE>DELHLgID06Eg89ddPY:+X,EY
?VJ?>aWA0U4,?;89EX0=46V54L#,<0-A892e)cY/Sf8Fccf=;gI[a>XK9ZO(f?UH
bg^//\>&;a,Z65D&XOO6IV6Sf9FCH2^K?Qcd]b9aHB4#].+.fD@[@=]TR7W/?N^+
cgFf>5)G]2XAV/^3]U4f7gU4>&8A?Re7Q1Mb+G+M/W>c7U:Ef?U^O5)U,g2<f1\[
c5ZFX[(_EFS23>eC_RPbU4;70[6,f&VPf7YLOT@<L\4([a:c3I?G3&6e1L>8+&]0
bA.-]Q;>U.Ob_Ec9&@QKG]:Jd4]2N=-A=J:X&N2VIf\fDG1Zb1AHgT7344Sa;UGg
YYScfO&+Oe[=RD[G9J_7]b(E[612Pb5(fA=T&+eO.X2T<:O#I-QYgR7Ed<gY4X-.
:HBE_&f]3&L0-cMFYZ)W[WUSWZSE12P(4UYc^dR=>MFZ\(@\XIc[Z]c^89fCa;<e
1cgTGXb@]f+CFBQIQ-92VRYUN>6Z4Y5I^EdW#^OcU9+,ZXO;89V9;P]HW1Y8@ZYG
GDABf-Mac\g#YR6_46SE7N)@XVW+W9N_9?#<_WSO3DWFW)WA/0DAD<0+0&b4<7QA
c7GI>X@@)dHBW=bUX?0:#@6M:McF)H;a0WgWNTf7EOC_e-7.R_)[8Wba8&][Y]_O
NI),af67O^:Y]C[Fg)fB)G:Y9>O+C=D:dQ]&9:XP1)6Y),)-\BOV@4OJFJG2[GTd
f>#I2Lf9@92VgP=X#D5MGa;Ef-&K843A16^+TYY#;:Tb8^(E>GX@DS?gPMG40Jg-
6<EAPNMB=-+859BV)_@T-#3(&B/J@QO[T7ZG@C.)MbYI3GX?X3YDIM4cY).Y=&<d
bIR.&<>]-\RJKNZA->-V(_9cX-e3-/HRK@:e#FVSA\1Y,fUE):S61N70D\H2>06.
.E@3RA&8>(^XcJL6UK1Q&g<,0IMNQ@Q#J\DN>@8><fX#+E8Oc^D/>S(afdT3Ud#C
=CDCNJdAZ(2Ie#,/\1X5,J)U>2b-W?_E.B/W#YYVS4@C/AUL,--4Y;ZR6+83aQVA
6G?/G^0JN]^Lb\,D3gEW;[[b.O_0&_QL3W;G=3(1#KTgT[>>LX..6NgV;(DV8)aF
)_dD3_7P]b5L[>XRY3aU(P\C<9?/T5=Ze?OC4O_e(LA4+(f8HI7Cd8(_OUA]-^(f
6N.=-?K\fd&JbAFZ80DbYUF,G[PZ(]PaL#;]];UQZIO)JWPEK)AM9>AFLX^FKQJb
]N5UR\/9]=RT4639;-XC62[RCZ5>FUKER=^P9IZ,/ZHWe:>N@ISI84?d[,D?f3De
O;b67CHR_Rde>CS>S:/A>bQJDe^/&N3Yc&5CA)NEWKKBSKCf6gH0IbMbIGWU-J<X
EV#\&V@Ae\/.?,W0T-P++E#]V/eWC5aE_/^gc_,U,)FFVb(BG/\6AQMbNB6W7?6#
6c@F88?1ed)8ZBC32O2B<0]D>K2Ie7,.--=FU^P6SVP_/<NedFZLU[7+H4-gdfTO
SBK;>C5C&C>(<Nfd?J9)f@9(2E&@5394^:4@4&I9T3a[<-@M^\gBeSWV(8U=#&1P
ddOU6c9EBB3]#.3_E<\&]H04=B@Q6>^b#7/g-0R/I2BA_E].]d\I[F_+(=NMR=RX
3f=<=HFSb2]G>6UNfT(4W99dA^>&f]f_Xf,N?,<:=G]XYg]d[11cE0-KYPI6BAFc
;7Jf^/;.[X+H0XaB+JY&Ma>ec13FUW>ULMe_37A4X^6<Hc,SK=V[;#AW,@\4e^af
fF.&UdgMA)G28P\)2HCUH?-:O7#EW4NE[#L5^4;LMG8bTHC^[JM^Z]fLG#99__\X
_fcKcNN]+cXY85#W1N=:H<,ECQ5P6I6e:+G72JGJd<dA^UI_GM0GTcTSTXZK(@YV
:7<GBLdb<6TKP?+-^)W._?JWXNV8YJ3e0.0+.291OHJ57P@BY1K.;EKRc_b1b])a
aG?:/-1BR,\NPGG6TQJWQg5-CAN^b_0(@8b(-MQ8<,3^Z\A#Z;<_EPTcXR3>&?K)
MgL=V:?9U3@;VHKSVH9[IEf<0gYE8;fG44L+?3bUU1_>QVG^;9fJ/H3)1#QK5:C,
/BBM/W,ac6UJC&/F,CP4M,K;K+fOaZML0/0>D;H)C-O64TSM__\aU9O[BZc2Y7@U
:SXN>89bJ[M50]M7@#W;(>AcI6^CP_2\@/+W&91V]0\/;[S-^UL^P>dM-F[+&/B#
(D67_>Q=G>OL22QUFa4,3-.gJ,Yb.#8SR6)G0##&(][G3]_gD_V.fJ5,A0M43@Ne
T9E^.)=XSQd&&9Y-CIW]/bMI<\W.DV27C:B(:cc8@+G4EX[7DSORC=+Y0YE7<A-H
-\K/H<XVc+a3[MEX&/Y0C=\aB\&AfdTT5,,?>Pc.P<90EIQ^&7gRSV\&S],4^P^(
7>BgU4ENAd#@,,a)TdU5M7SMHHCd#T+gHZ_EF=41UL<0R&:Q1#_33/YFDO\[.Z#9
f^Fa&19P;E-](DKLL9@ccM7?2:YCQ:8]W^Mf&W]T:g3G(WIC0C#ESFeJ-JLQ1HPg
#<+5<A5@PTdE<U=[PV/g2+B?(B+R#e.RMZ5DCGc@C@XfV7E=V2X?YL.+)@]+<_>&
(OV9ef/SI#CJ-GS0TId(KDGSZJ&cDg8X8HFcLKg:=dJ+9#:&L;f:E@KcVaD\/,<A
;b<;:6T55.U:[R&QHV1LY4e#>&eE#(;Y-EKJ_:.KZTVQ3aIcAJ/d6(><:QFFL_7S
gQN2b?Pa=2U4(U\ceRCH4[(c>?;T1#.XEAZ:&+HN3=71c;8RILB=8TVMfC>^)RMf
E,cNObPID1<<,RXSa/.JH\?UI?e;BL?aa_LeXZ<T@P5CW&G[8ME\e1:TJ>XbJV0A
\7K1X;M8.#cB;N@,,ROMOOTIZ8WN8>[5VIf35&/FI&Z52DI7W0;C]35_707+>bgE
6<=&[YJ50OGb=>(5Kb^J8XS_D+MV>V@E1g)@0QIeca=.R7@@G[ffSD[eCFJ?;8VI
>T;DW&e]W.f^OS/,4fYGeE2<ec85)AT7Z)ML_H_9<BKY<4g8]\1;(-b9(<8\],>]
fb)D#0?B-T7FQX_BA?G#>BY]5+7C4;Z=^;SDT2X.2S\RITdW;1+36YS[gSX/\09,
e1)&II&B5;,4:/;W&4M9)4XfOZ?gcd;C@]T6_JgfaIfc;R_^R9Z(PU2O=g[D211>
6R<C/BJQ[f:;,1K[/LEdGAfU)>Ng+P5-3UFU31J0P,G/G^8_)]GR^)Q]-DKD/>:U
@Q8XN=J7<c=-[c4&cR<=M-9G#VOc3eO(4?=_-([9_[(\I/PbDI;WcU7/T@-YHX-=
MgS:[(]SF38b:H+f-;OcWSX63f3[HD_L/c=:Y[a4IH0T1V_QCgYQ?(OTID)H;V8#
dGA+>eL/TYe>]6f71YNWQE_^C],RbJEP?@.4,:R2#e9gME#5.NOJcZ<Z[X<YDM[N
Z&A[fP^>\4c2,HW3Yc&BLSBG=fL3KTM_91gL&N2\,-F(@F,[E,2e=C1Z_M9(#fB>
;@HI05GbZ(&PEB+DHbc;_/\<=YOJMIK4>M3,-@:a78>3-d\E?#-ccO/C8_+N9_SP
\fM9/.H)8P,X-d3TLQ;W0-,VZfZ6U-:V&/#43:c#IZ2)35C,->=0f8J;<2?PV/aD
(3,cR,UQ.N\D&cIYD&:d32R1,/WG4WEJ4,W7:+N0(cEQTBWV,[?=\9P__CDbT)XG
67\+\&=NZ7CNLNXNUC)c#KcA3@5[=?b)B\<8YU/EFP4dS<?.RMID_<0LY3TdFL-T
BVBLO.5EddVSJ9Ld>3PHM[5DQ@CQ4@P54Gf-fP_4:ZgXAC=1KGWQ35bMG>bFdB&.
IZW:/2^K<:ZTD#cD^9OY\VSW^EV4gUN;+@d;_0W^[<1:WE7_6I=<P#:KV79+#TSX
948Y&:1SX0(];I<.@_:7cPDUB#+X][(b8;7U@O/FGOU_(3W7g<,>51408H#/=b=8
Cf4K_-f6#T)6-HT=64eaNE1]3<P]7>XD3O=O=>JI?KC@?M)4&,/g-6,ITOA;^9N2
&TTgXL7)Q+9=6^GeI;b-[<4G]6><]U?HBBb1dCIB;^1g[72M\FINY\gEN[f=4R7W
TQHU:(L&XE1\BJ)GAW=-/U;N^a-)V^H#)/P_a71.#3XX@R=H+8VA6;I=eN>TaK5#
I&O+52)X=F-#aQP00P58b+[\,SM5O]2J^XLG&DaZMX)9K.)Y_8)[[L1Q\L.QZ/D;
7,d\3?@-11-(&A&+eaI2<I\D,H.P0\MM,-(D4/a:;P][E<9]3G2AVEAWY_;7]eOS
a5#\3;OeO\XZTA:\\_V?YgH=?52FW.C\;+_?MP+Z,=P)XY=c_VT9GSMA1egK9BP9
X2g3?;\6eM-8KU/0>JXbEHG1I>.2+;BMDD<//\Vc^SI03&YA?A-PZ<0L?5YQH1e.
f;L9T_W,8>EU.Te0R9::eR+VSE=S<be2cNXU;O(FWHKS,eg+g+Ha#&51-N53\fCJ
:[DZ09NbU)P/FW][2>dP4K-^ePBG96M.H)/JB/>SeY(PEgKJ;f^/F0?e]_)HNQ(8
>TTZG&FEU=:U+\eGA=5\\V:ID5g\.PG-_:,>Ka.A2?@H)IW8DdZVe8&7R<bAe1g^
G5FF@F&9:G57[W2S>Wf06Dde.EbFLeUT]G1DT1<d&C,+SHT0a;0df:)M48WXCaFb
YO#(a/:3480S-aS72U-f_8._fGI0Y5g+MU?(K9?JP6)?c[c\OC=fN?X,L4fG[:J[
NG=/8>,R^\?.<X)CY_Wf9CeQJDY1O[<.,[=HVNLW.C?4K?d(Y>RFAg@QNQ1#+4)B
=?61AVZ=_/LF0dY<&46]L21:W.GKY1(/JI.J/HN4F^L03:=bIaeD[K(<+BLQ02J&
#>7;(:W9gJ69=eR_-R6e=<=,H)2T.7K7gIb:Eg]Q0;S>WL>@&Z1>STIOePY+H(>B
P]TE1Y>XaZW4aN2[46_?]0ENT;YQKcT<g0JLbRD),(a?WJMZX?IfGPPfS^;0#b>-
U2F/E7;4LY;dBeJJ#Q@@f@FQ_:,E?GLK7C)O[XA/Me2a0aNHL-T<N&D:Y\VG,E5I
767Gb=f>fKOT>1(C41<R>U3^7SYR-_LP+d_1]f8=EOJA_OF\#8_RJSQb.(P\>3Q8
BG6IRK2g,Z6=gJ,VGD9E[3]d2S#55@@f]HZOU6ZeQ.2QLYbTO,B:CXH+M7KD5K2H
A+/_54O.U]#6DCFLQ4R<(?b<dIOH^PSBF?D[/=(CM,b0DV6@-UKFT.^++U.5Hb(+
)3[B@>58LZZb[[bD-B-CN8KGX1P#EX2Ob/KR3.Fc[RI65KC37KGIf\&.;C.8@Z4&
6>AKb&JLJ9/<XD/IW\D(f#?B&Nd0V(^gM,P=0I[.MHA(/43]PgO&NCO.8EVd8&_0
V_O2dbGTdZ]^IE9MQ7AR:]VBDFXGN^#&\7]J@1C^Bb[046acA\Lg]6;PP@OWN]e:
,3D_WZ.-?(Dd+6@2_O8BT-ZEALUU4YN/82_)<)QG?<=IA42ZU<@W(b&MI2/d>bBa
<0LdV6=WBUKVUPb)-d/27UZX\=]+T>B8>I>B.A;X\=]S9);MDf0Q[NA)dN&&=#5=
@^NcY^0J<IAM-(bO_aDT_6K4/,e6A?NCGJB]OK^]S[29-(=aB1Fg<<dO^dY97MR1
^Z@YLY.9A]335Sd;]@fQHU#LGJVUG&G0JDDFK6;SJaB@bQ]I^-V?G)bc,>\I2F2f
UE3]02,\(KYR#_d0;V;1g?7:F^=@9[cF4T#;J+4&f@Q_<&.>5,4;0_?/Lb<@Q)e+
-.gZ0ERF^eCTPPgeM]TX/@H.Z/DL.:B)S)fZ>4U;.C>_&fOZW5,Fa_LAB4:NFKXT
3APT4#;,,5DI,CA2dA^?ND[b-;0c+[C85(#eSZ#,FWc_(f50IMd(ba&eS@N-1f6@
.5]+_0-W_[A\9M,RW??.92F>KLWa8D_]W9+SSQSZZ>_ZCW7RbG9/M&]?DG>VABC[
#fe2/B\A<+FO?-O]3/#>7E,0].@ceEFA@^8Ab1Y5+Y@8J3V>LECZ6_];O/XV.K>@
aHUTP&I0]]G6#;K/eZ1GfKZ@_<PE&bE;#.;=.BK^6SbP]OV+7BI\.8Z;7YQfQWE>
F0WaJ14Q__AC(3V10#K4gN_<VDIO1GNS\2L-RaL/^@E?DfcbN0Lf\(_8R,dV>4,d
3EOUbZ)D^R-KN)IV3]a:;5;-J48FN8U9I;MFa/D^XLI1g-94dd,7?eeX#EFdOC/C
>Z^/7/gPMZ/Y+U1=#J-D]bY-:fNd_H4Jb>fIHYCFb^;>HIQbe<J\D3GV8[cDd<3W
U9WY4O4Db.+H[aO4E#3T=B@7R>CN2@bC)H<E#7d]PX5#\g:fZD0?-DO)/?I12+6^
BE4a03#=B[GU@]_Od&ZMf=VS>QT&0cP63,4Z3IOL2O]#)MVN4==g)HGg/P(&FX\=
>G:gaZE+-.OGEO3fY(?XDCOf\X(Ic,F+R+#0KO^-C@1VJTREK1T\geBAS+WLQR/(
Qg[dCM=@Vb81YKS@AO]Hd<H7@c)@(6IIP#D=bDMc)GH&[Ye,J-fF>#9EJ20Z#P2J
VgORC0PP;O,66TQU@G5F]<4@6NX[YagB;BIQf1VgZc,/19G,T9?ad:HS1P_2TD-N
FfaDPM:.8?OdQ]Q_1PC^ZN)HI84N;QePBQ,D]_8H&cEZ41SEdI;?25#dNI:g=b1)
2:J[RL==6Ya7dJ>AKE+J<=\<2\U:c&)W)Q+gG3E/+6]f>K&9VB&.gC_Q(K8JN-Z:
F).KU>++W?fb8R3_XfO(5D7G2T09;Gf6g[?JeeJ9,Y3@FR.@JRgS+)SIQZSIDA8&
GX@eZ96-QF#.4NdS4XT?]79GI8D5,I(M^VWT.J0^UeHGg(9(SGP..#[@HgSA9[fT
C\c5.6B1NDg>aP]\4(G&/W#_4Z2OgRC6L@_Y1S]KW,#d5:B6&C3]I1Z].C\gT0B<
<#O@[6IQ&XUAg?YTgNG1Lc[F+8UV<BHDfA?/;URH@)OYFX[B4.SQ(0>VE?a16O.I
4=8JCN^_&O/K+c0#C1S6>TJ-)4(810]Ee0WfU8RFDZ0IYXF@b1M__O?WMJOW:K5Z
&d=N6D?C9WddMWH,_SJaA6UfcM#=M7<@@8]eQ1S(4F]fU#NV2##Jc)0D5bCFAE6@
93b<3KbcT21@^ZWML4FeQ3E3?aKKB^V,F3gf;4+Sgf-0U>.RKK0LE9aMfNEX?2f>
9GCEEPeHJIC2MfB5YYSSCD\-N:,:b@e.V]/H@ded&I?#^b?eJTXC)(@=g5QP>V0P
/^XFY)T0^QV3-_^-gc9fMg2H]^f54X8@>5\a69aG\&WfSD:V6\55542LN(^5:gYN
^()7ac]]S0P9XPg7EUggNe3Hc.PM4U;ggN-243,N:UTY7?M28f5ML+]68.8&R:dG
8NbKZ=;=,>b8_QONHdgT@<YA_bDPP^K&58@QdSY3L+gK63a[Tg>C]4U2FJeg3BME
=;.K93SeD1HB9X(^L5O6Md+ZEAX+&.a2[b7_@S3:LE&4c@L6OH8/:&F2(\D2>?G,
OZ;Y@X(+,CHf6IU3I[eJ5:C1g@D85N,fRF3K)6a?fWS)K&dZcFAS>XUG),M8J:4T
PcDLa]5/H2W?3B]#;8;Db<@]3#]7ac3/fVa?6\+/fC9UB<#-f4JVQc1.3cS27_5]
(+HPH\S>,AbGd37@3Y.5J,UHNc2#=4]E6T::(_JD6=9OEe);T]OQ^)>c]Z9V@RA>
#WF7/U-.I.8DU5V6cB?PX7+Y0b+?7>Q.56Ae(H>6APF,O3aebC]).UG.7J#/TY?D
P378PD&,LDM9H@PEM=Ja\P2GS@L4OQN^TUK0bY85eO0]K+SKX_\8d?Ug?V0_bL@4
-Z^K#gfXP?Q=1>DZFZ39S-FFb<NI[CJ+MM<>7<IO7/2^\>9UYGT)=5J63[VM<4Hg
-_/_IGaBK<2]5fe>EL&^P;4VCfO96#G1DSUJaP]9-XG9/S[S1OaU)dI4F@eaYD/c
DEE-@b+d<Z<7JeKT?3g;6bG)f]f1gXDJY4/Ng8cDM2-67&/YNSEE6/#Xd?f/a/f>
>TbM=dC9._FA?Je305_3=^D9:ZDN=8g(#RUT>KG2VDJ7bLM5UMRY.T7SPdfeaQ)Z
FSE6341;(WR3D7?YH1XXIL5>^<CM/\<^A<-&,GDJ8Q8-Va0],?V_f]#;/^)&e+/S
Q]@&<ABYF\MaMgRfS44+^,):93.#2NLEFV3bV65OfP#FdF7;M=1D3<_@,5b/AfD#
E2(2S)I.ALN7.\@D@NWF/@c\a437;A2TT(T?IMQ1d)4;WFO?@<FJH=D)QN-:HDS2
B(2QCPQQ<_fUKB4X@=1FRc^b./:M6+QPAFG27:We<<M5Z?T<B>B:#X:bQJIIR?82
6d;<f@dM1T&1J0?0C?cLVR)8X1NE?^0a);Jf=L9,.#G<AGZK\5N\8W_5d;)fT>PC
]g)YYB2VDLWW(>7@CD,2Vc1#H:_;F?9BgVPHA4P_?P/Y,3ZBVa[RGJD(9A-56S56
0geEaD75?.a)IU96-6#IIDLW>X/30@?[(Yc<Ua]aa?OC1,b>/ZZ)D9/,)].870J?
_,.a83#F32Z1]8HJM6=<:C=dMEb9Cd_LC[\;=aG5;N[[_]KaER8^YDa@D(g8=:P1
((EOY@>dWDSUB:ZGTXFSb&R&.H;I[+Q-e)LM]M[3PG,L8(HMB=P5MLLY3QIVUccW
<d776Jb\dK4D_W;6JKV():@;?]N,+_#dd<R9f:G@e>DfPW7.>0^>@:4LSJO#PB@,
WWJJ)b-IM3e)L80JLDS5XKB_L3+9=#0^d7d8SS5-VM/9aS@a))FLHE&?DLe\=Nd(
TBWbV,(X#[^M.P8P)0X1#+d&E.9,VIV\1<]S_<<PF+#)2dP^5OCM><H#<bUTA:_F
/884g?KZU1<=R^QU1H0H3fGbgIBM^#MD<7X)>W<cO<UP(0G+T?d1#<YfPGf\ZdUU
2=6+TV/a:)e0#NZ[Q[C)GL1)HF-BU?;_(fH]Ug0U@QG9TS.afd=-RbVX2Fe##\3#
YEf]J(?=/;E/-SDV+>7M3QCQ\<-5/U.-AS(]Y2f@YcJEZYJ\=)L9>TbV[.=G+g(Q
\_>UXPC#/dD?91&#G0UIf0cUS_/@e.NcaOK3fEOS,:@6MQ^U(MeGNeA_I&[6QJO8
>.0N]XX]B&UfQ<e&gAHe?gGE(cS7F^P#OF\aa--HZWSadN,_J]+#+@<0K5/eT=8+
-<4b?)0:HSH?6K95_JNefa^J?_eWNHY]+K@B:SZ#f)FSD>N,0Q@gF,&\?eNM-G<a
GaYI6E]3^HGXU_<368V-\W,7bL<N:K393+AgWK:N>eQe+K>712[C(0c)a5Qb33P^
Y<<T6,e@L0XbCTNY#SXGS:aBcL41PG1<gBH9Fa[]?^?BKEI+(9,gdYRFD)cb#S_0
O1_Pf<HRLNXIQTT><dR3cPLUF^F5fF]AE\gZ,+X-Rc,[4Laf/.=),a<bVX?F#MJ3
_a<b.JHS#5LYY+N1c:=_(VULH_(_?L)4UcGA2WS/H=IXgL@4a?D?EWUXDZR&Ie57
.RVK4)DO#1^)2]BB?P3MHB:ZHc=c<:FDX[-NQJVIQOZD)D6^^)?D(Icda(7([^?X
NR9XI#^F[V4V>(:TbK5aF-W_E>\HNLN<(/b7JD^^dE]d([F@#e8XKECNQR.W]\_T
fH)fS22d2G>-LND28<1;05J&/K8T>+L:0<SJ)[Y,)TY^gOY\7Ee:>\QC?_]gF7[/
0O=JC+2/DYa#eHeL@43?gJ=Z2T;:J[DH-D2/f.T\gJGTY1[N3EOI)AVc.Dd/O,E^
UCSZE0D2Sc(&+2UWC&d\Aa=0cY8[5.:XW[D=?6QRZcgZ[ND5cRO2N5</H=NgM2bT
R/P?K&-U\F:Q.6=OB)ZL5:4PR+W(QYg8399cR^9<K@_-BLD<BbV[befIL)8-d5^S
1R]7/39g@4Q:,H<>aeC:;]\\ICg\H7\L?Zg22e?Q6TTWJ3ZN3/#KdBPX^BBQKGYW
2^B9@K0T^McG3WBXI6PKE&F)9_J_.E3f\G)IV<WY^fW1;[2UY>CI.]^J@A4.#C_P
L0=>,G:JN5.+?W<6af>3YKJZ+\#TN[A5;YR6B^c6e-CAOER5M4K+f)R:L#&@)86d
OKR;W9d^6?@I^,(X+JKQ6ae(P=Z(CFCZ.aQ2&C=&U2@3b?fRY2O:^EYV3LKgEBd#
0Z[R@L6XBYeI9Fcc=HbA9TJ_e+\D/P#Y[7VJGODD:.Afg5IGL0Z8(MbVD(g0=_)R
X=NYd\52bN6\3a5I-;#HG2U1d#1#V7X5D>\e_#A(FNTc0&fL.56Z_=)9X[-QRWPO
G3+bT&^SdPNI@DG0LG+_a1@C/a?)#T?-J^AbV2Y0NRFPdOgRVOf:&F(deTVK;:AN
/<ZE<?Q/5@2]I])bTJ.BY;PN(MFX=.)O-QJ47=g#7J)?O;R[OX,735A0aV+e8gHV
4CK<P6YB:?AS9#4(LXS#0E760JbE,D#UPT)g;Q>XR=E+3BOIg1PVO,0)8[HL-1QG
8-B&2?W2P&M8a=/GON9ZUU+Xa,VQ=8K&R4LQ9]#f=)5d87:.H&;<L<]c[gM]1@XN
Q+fe>.MC;K0&_+?W?(3NLBM=>dCDb_.]SN.3RVc&(aZg/g,24,HbVNRFdH/[VX1_
bedM[9Z);W]e@^CK5EY_XA;6D<4]1[;I+9Df]U:fDLZ44GRe)_>PLU)[J1,CHGI7
84+cMaW#D[N@7E;aAf1)E#[M7._NN?0\CRc-\\@0bD9,GDG?EF4XHMK>S=0G]G_O
e;]DaCc^^++520=FGUGE4:-7:3[FB9?G1K;Af&S][b7^e1Y/e8XBK0[If._-H.7J
,N3@F@gQY@L3P>SW,]SI7We>dJAW61bMI)VDHA28&ge\?C/I6XD9,_eC^8UW<eOH
=aUI<)^fWFR>Qc<&YB<P7_^-eN@CU4D76LXH5^;._Ze\cQ@N/g9C8:X>9LbG9+B)
CdIV8]+>[]B30C4?,V7&NPYX2#.e<Z67T:-Y&B;&=0>XH&<.N7Z-88SHJCMYDfL9
1RJ-Z,,df@:L_d]?L68Y0Q7NW/&N50e-L.1G(E/Ya6A)3]KQaC-b.&?^4LeD=d;G
c@V>d-+e:g(:;FG.He-]RPH,Q#>:-R)4#CHGY\H.^A^f1/,Xa6Zfb0FI^(SB<b@_
1Db3V/:B2+0QgIH6gPJ)),b]>1JS?:#c^BQdRYV>Q+>3USU8,LLUY+>,)RX-eWCQ
[UZW@Q&8-NLNO.43\9-ICP@EbgfEL+GIcCVS)E,,V]I0QTUS>8eae4;A&a,WGL99
/YBT\F)@93U>]HZ-J@b[21?.[E-gOgPN,PJ1bSf4GY_83d,U/1BCI]#<4NB.Ug&W
VT@.5L7]9E_1aPTNKaHH6C9?54[a,Y)<83CW96G<+#H&f4GMfD[ZK_)1G273PK\a
Y82TcH3?_^4V)C.;bXHeZ;Xg.gBT>6DRR#bY.?B[2(7\9A81</L1AdZY7L+@+4_V
6:/UR2X.GUNKF&JLA,Og.TC&E0A>:_?<_GfNd[>NZ9B#9])f\DFR#W7X@1UY@T\]
B8E,]&4]?^SELYY&RK(Lf(Y(4?6fFU=7FZ6(AO7A1++GA3EQ&WH0+Q<_S/NZ2)B\
X^d_<L_1f?=&]gPgDLePPSC3TW#?9(5gS8F7<P?T09_BVX9<g@2gEa.f.Y;+c<^D
Z\WW=NCbZB/)a\]?-PC#=NU@I7OR;TP4N^QF450^:_32+>+B079TK3J36AR0@G\f
T6-#+-gM-Y17G8b35eWfSg5-4P<]FH+PSEN5Wc@WFBUP1^GWL<A,Z6c#://C1U&P
fOfN4TP+>3?[?)g#TKE1c<b@BaMd:cR3:3OMXSfJcJ4D1HRRH,&GL#Ng4/;GO,8G
(@TS/&6G4D(=aYeZ_D/<:gY=@KPgX^4#1.K=)4\QDG04E?<H:\/6+,^e4?-DE[^R
QO9C[JXdK0J[.&EISe>K0>WB@HfbV[=RXVfJeQaOU9gW>7C6(B\+6]]@S0Z8._1@
)K;I\)Mb8Q];7TQ^b/V2Uf1eI&I^7V2H#NBR<N+D2e.9L+5+=aF4MZ<?TMJ#1MVX
#Ec&XFO_>ZWCGI60G^[-TYfNJRQG<a6N,40<<Se@8H\.F?fXZ[#.=MSJPRQ]13=Z
edDES3BBX(IZgP(bTT_E>I-f7a<(=fU9A0M<V+V/WI3cGG\Z&F\OZf+C,-eb1=I\
#CL;2I&E748T-;)I6B:.<2F+P+79]>1LKd&^RJU-L?[a5a&K-;2<cPGPA0E/Ug_D
FZ>]12KHU0\#Y;M>b/5ceI1f.IZ/g8J#-_UG5Pe25OXeQ/108Rg97=Q\&6.W]:BC
gd(]AO66U,;dG\/YVbUb)HMYMK.@L1_>JbBA22d.,QQ]&[;/=WbSO?CMN]55Agd2
M-EO05aS2Y(I0==egUee1O(H>dX6Z^Id>aYCGE=PEP/6Q?E/ccBSc5A4g-UCK=BB
b0<gW>V9ab\f=3KGT:FTO/WgfN37ON[[WQ)49[MDfSH(f]M8:gKZ#0A]H1;1@\Aa
dSRB17S4I8U:S#Q,[#63R>;b2Ce62EU3RK/+ZC+;/Y7&KKS+)5=A1aGX>:SMSR>4
HR]A4M^E_?J=E\K<]S[9:#_22?R2R2[\X:0QYBVYO&?NFIaGM5=E9^@WU0Qc1C#J
(5IFQTV<?ZU[UCDUDTMUXI&55?8N4)SC^df\f(#MJHUQ#Md^?0?UEU>K>FV/@g^O
7S,N-@f#FX/?d9bVWE8C4_0Y<>E:5a6NUJG\K)C]O)U@3=AH+4&\U(+&#0eSe>\<
YXTE]gQV;[Pb24JVH0^1fYD0/EZ._M(BE#217<1E=TV:J7:-6;7Z)f8?D(RY:6S7
_3>1?8eQ62EeFHN/9SP2dIDC8ILWGd8_BE@GBE[.&>f;3/A67B&/f^CHECUbN+#F
\83TITO.UeDGSU1^P5KB)G2;Pc_L_S+M8-A^1V;4Z+8IHG6f\^^De(aMU0HHXK8D
gGE@QW5bR4GcF:;L8BGeb3>#E^g[W@aZYbQ5;BeWI09KdBBG,X)ON^aT_^(0(b@M
HGN8Sa>8CW&bW&W&Q#KPN4DN\K8B4^6?4)GNN7Y-UK6Z6INU6.;AF^5g79>PJP/,
U4Q/1TSS]&a.;@Re+\F6;?:(#E?:=<WL/R?DSCf+8eBB3250]J.]&gcG^@g1g7=2
28R+>XU.M1,,d2_97;HO1&]B2]RfR0g]]fIM:>]RGAV9Xe?N2&K3K(OF8K=ZVWg(
+V8^9]+XZQIIZR^RW57(>NRc9)/JK@(CDGXZ/#+#\VIUM=3c&Ua9,^F:LSI<)OeI
5/b=Rc(AC:^8V).7Af9KA6G_C_@BCg#S0<I,gK+:gZ-.(X;N\A6:6/A636Y9=a)5
-bS/>;33^;bP3fWbM2PA6??HLHA=?II@S8FCTVC[29bPPe8G8ZY6d,1cT9[P>ggG
Ug<:HK0U@@I=bJdg^)2.]7Pd1+M_C]16Q77P2G&+)T#.g/,NP+1VS8^^AA,#5Ug(
&N6/c,DYA@\15EDFcTCaK=QbZB9[XD#X,>KS;:LMDVKXd&;2[X1a.\9>NZN3P2BF
R+;b^NX9BEY[6L(GbA>&EbT3P@2G#]fF3NTc\[gZ-=8ASPZ\Ca.BB]5NNTc17BR1
5JBgg^Dc66+HM+GgK4:7DX+a2;d2P+T3W9K84<<3KJc,.(F?SJY--c_LQAN>HV=1
K2,QBXgV)8TZL,:/P.:-_2aK)D(J6U:?Ea1beRN7YG7JR?<ddN0OK)QYZeXbK.^O
b?)<CWDcRS?#Z;?B_O&-T.6JB]=JB_\;gg>5#CfK_J>9gBQ7\,\M\?P),1+T1S_E
C;T]7-4b[86@+[d7H9H[[.Q05-JJ5TUCL1Q]8^0/Q-XFJ4L=:Z@@aWQY/E#+5gM3
.)-3OgaGHegOaDT:]2(g/@08_SgZOPeP1Q_2^3EDSd]MX,8I14VPB8[CB/KUeYK9
DY_];_:eI(aFbM)>)3)?@AEWV3#2[F=[^)Q?@Q&SY,&LY8J6JVXI?L<C7=\UU@CE
0f:MF]Z>ef.afS#DAMa=6:;.&88D;IEH;8eIGH;HY<H.YXJS#1I[>NY(Y^8&_W3;
VT@BQ80Ge[T3(\bgFIfDDI\K16.4(K2IRTA#24VgZ^Yc;KD6<^O\N_LE4cDcJS5<
8E_2MFTUWNDI_f@ID7=RfA#5MUc:7G>M0OBYI<6[VXO>K2Y4LbACJ3(?)MfIT8^-
DNW7UYTY&3B,cM65a(7,(3^,1fKS.VXa8Vae?7RPW[g@O.FS;X>2W->92H,;4_A?
62:EY\XM#Q;V54(O;IVYa,M7D]^)S#;G285/-I:-BIMK#1cV3^IRU)RG<E;?@2)O
Mf)a8>\H[DOOg8X)0;c2McA+60&D5c\<UQC6;RO)<8T53O6+.4ME>L3)[9CC2D+8
D\6LB>.\:aPbPcTQYb]VXfce2WMTdWc>9B,bb]Gg,27CNY@g1B5+A@#ggB5CZU&D
:4[_(,CAW]K^=)fY3R@02&>QJ[[b;72.;$
`endprotected


`endif // GUARD_SVT_AXI_INTERCONNECT_AGENT_SV
