
`ifndef GUARD_SVT_AXI_INTERCONNECT_VMM_SV
`define GUARD_SVT_AXI_INTERCONNECT_VMM_SV

typedef class svt_axi_interconnect_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an AXI Master component.
 */
class svt_axi_interconnect extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  // Observes requests from the slave_response_gen
  //3rd argument defines how many peer ID's you can have.
  //PeerID will help in determining the actual Broadcaster  
  vmm_tlm_analysis_export#(svt_axi_interconnect, svt_axi_ic_slave_transaction) ic_request_export = new(this,"ic_request_export",`SVT_AXI_MAX_NUM_MASTERS,0);

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AXI Master components */
  protected svt_axi_interconnect_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_interconnect_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_axi_interconnect_configuration cfg;


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
  extern function new(svt_axi_interconnect_configuration cfg);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();
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
  extern function void set_common(svt_axi_interconnect_common common);

  /** Adds snoop channels to an internal data structure */
  extern virtual function void add_snoop_port(svt_axi_ic_snoop_input_port_type snoop_port, int i);

  /** 
    * Adds channels associated with the slaves connected to 
    * the interconnect to an internal data structure 
    */
  extern virtual function void add_slave_port(svt_axi_master_input_port_type slave_port,int i);

  /** Implementation of analysis port write */
  extern virtual function void write(int id=-1, svt_axi_ic_slave_transaction trans);
  
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** 
   * Callback issued just after receiving a coherent transaction. 
   * 
   * This method issues the <i>post_input_port_get</i> callback.
   *
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual protected function void post_input_port_get(svt_axi_ic_slave_transaction xact);

  /** 
   * Callback issued after the interconnect receives all responses from snooped ports 
   * and before driving coherent response to corresponding port.
   * 
   * This method issues the <i>pre_output_port_put</i> callback.
   *
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual protected function void pre_output_port_put(svt_axi_ic_slave_transaction xact);

   /**
   * Callback issued after the interconnect randomizes a transaction to be routed to a slave
   * @param ic_xact_from_master A reference to the transaction descriptor object of interest.
   * @param ic_xact_to_slave  A reference to the transaction descriptor object of interest.
   */
  extern  virtual protected  function void post_master_to_slave_xact_mapping(svt_axi_ic_slave_transaction ic_xact_from_master, svt_axi_master_transaction ic_xact_to_slave);

  /** 
   * Callback issued after the interconnect randomizes a transaction
   * to be routed to a slave. 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void post_slave_xact_gen(svt_axi_master_transaction xact);

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** 
   * Callback issued just after receiving a coherent transaction. 
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `vmm_callback macro.
   *
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual task post_input_port_get_cb_exec(svt_axi_ic_slave_transaction xact);

  /** 
   * Callback issued after the interconnect receives all responses from snooped ports 
   * and before driving coherent response to corresponding port.
   * 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `vmm_callback macro.
   *
   * @param xact A reference to the data descriptor object of interest.
   */

  extern virtual task pre_output_port_put_cb_exec(svt_axi_ic_slave_transaction xact);

  
  /**
   * Callback issued after the interconnect randomizes a transaction to be routed to a slave   *
   * This method issues the <i>post_master_to_slave_xact_mapping<i> callback.
   * @param ic_xact_from_master A reference to the transaction descriptor object of interest
   * @param ic_xact_to_slave  A reference to the transaction descriptor object of interest.
   */
   extern   virtual task post_master_to_slave_xact_mapping_cb_exec(svt_axi_ic_slave_transaction ic_xact_from_master, svt_axi_master_transaction ic_xact_to_slave);


  /** 
   * Callback issued after the interconnect randomizes a transaction
   * to be routed to a slave. 
   * 
   * This method issues the <i>post_slave_xact_gen</i> callback.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task post_slave_xact_gen_cb_exec(svt_axi_master_transaction xact);

/** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
endclass

`protected
C:<Vd#HKRc4]>SZ)1^Y?/+dRE:+;G(9LU>BHI_IZBC))5eAX]<OY5)6B8G-3P]./
C(8LVP-=@8Cf9.XV2DX<).-6KcI+JLdT4RS4BcCAZGAY/9Y.cPU&N;Ia]YTPMCHA
@)-ROESK&(BJ_YJI0_N\fbd-W;,&V7MZ=94JP.JJ>CF:XG38L.]Pa(fEG>-Xa(Ke
0(/&<5)1L/&?d@dH:48Tfe;2BW+1:SM#X,@5=?7f[EIY[=)?&>Zf[d8Y;\,L?M39
.[Bb:0#],[dMR,>UAUc5]QYUF8b;6@U3S0VY2:-?C91UKJP#EI7BPV4T2aK8bY;S
OMHb(Qa6GJ=Dg3U2JbGEcLRb46UbNUd.]WF2&^Sba07d5>HBRL0&0I,/H46=1E/d
&/&,Z2:(b)]Y0<+ZT?@K07&g95I@1b\5J^RRfbGUJ3&85N.XB5]EI@CA.9g4+:X+
6NGT>^e6Wee1<&P:eH^>SQ<c,&68481\-GER.&8&HN)Q7JP/DgQ(W)S]_QFZX>(@
=LXCPNH-VT>N7](aD4-[&Y(#T?,4D1(90S:e=1(R_-XW-[DW8\63M/I3eX@14^FT
^c:.L5dQ1Xc^_,8;?8TeUc_Kg6FQ-d-CYWXVQ6^9WM&FQ:dK20(PU1SG,7]W]0M)
G?I[>6&,IAD^#-A&<?N]VaEBB@8KH_)c7ga87R(2c1DaQ3(>,_c--]G)LgQ;9<EQ
:NH^cQb^G]_EGcD4c&M2[0^=ZIT2SXZF,QV1VE)PWN&5b/<,CcQ#f4ZT]7R@<Q2/
g#CB9dY;RD[FTD.IS(+E[/.?L4J#T(C41U(a^CPNM8((2e49YVX8178DeHK(CV^=
\cP)779JaU5KF]((HeF=O&JcK6TT4)1b(\=cT3X?[_Ge@Z?OLQ,T<[2BO-Q0+Ne_
_VEX@LDN_Lb?EYdce3W>A]()Q/V4U33S:U.A[76(/ZJZR2)GDM3(XEQ/JIf^/HI=
[9A=a+M[_MK#ZgddB@RTNOg=5?6O8.gDSO2&Z@>I.dI-=.\J(?Q[?T\50LbHHQ?6
>OdYcPELAOU_PSRHJ;[+>eAc[cUHR>Z]-MO<;)WL&[;G778Y<)Gag@b,B?Dc2=Ic
)>GX7GKQPVQH9MQ<.E^b+a74@>(N6Ic5>$
`endprotected


//vcs_lic_vip_protect
  `protected
6O9;gSQeGJg],_L>0PgB&DEU\P-9[8KG+S)KK\^QIcBeMJ]S#S\(-(<RNQcPa&>,
I,>cFR-A,3gbT?9G:/)(&7=2P36RP,MV;0F)1Hb5c9;/_G)b\VN78/F;8Z,/<&Z,
ZM_RSg74aa^O<:@[U<+XaH]Q/?:ULd&>L=fQ+1,Z]0G=5.HY]Y8\5Q^N)[(,K-,4
&&2N:[)Q^YY;=4A#RNB[f(Y_J1N]A)Y<_HSM7J,f(.-#5#]N0FK;)L.g5#+G4Z-]
Ga@HeF]<B@=AVO[_L9FGQTI(<MBPVV?6(]J3N2M:1Lg11)F.Ic&2/FQ<8]_X,f3N
O/,=>:M_)&A)W]NUMYQf_2PWcO1dUdH&.KO)\V1[CI4gC]>ELUWD]bbLQV>dN/VU
^E;^Zc8WQ]V^HNADTc746e8,c00//BB6O;.3F<3dVaX4QFD)5QXM0<,K0+T@ZMH.
8;_L@:V6Y24NLcN[)T9Re<L(GX-#&[6]b;8BbeCS3FE?9^2D_93L\O=R[9SC[X;d
W,_f=&HS@K@7V6ab8ZRD=Y\[8]JBd7G]\>F4f7:R)7ge@0NHTSS,8FOLN#:J</g\
C=Gb-=EY5N\U#;[S)L?M0fF9KEcQ?DE2NZJ,@T\U<8]BZIR3.3U)c)-f\Q6=IDJG
P3-EW\6PgfeYf4G#5U26E<cA8U(Y<B]R\_e<D?,Hf[)))GU)E1Y629>SUC?OD3gS
2OZLb6EU&,36SI86^e(g70LFW4Z+)-bTV]2^QeYDH1aDf/;S7)3#6f?EJSc1URUM
B&KH9W8,>9U-ggfUPOX@Y><ZCRe[N1N[9PO]+]:Y:J8fbT^aY&N/c=^TF7c&ff68
@bfN/K0K2(M9<<M#@&J#W\Z0^S0_FW7dU1Tcf1,Q-Y]5M.26^gUGBX.Hg@<f5NLN
C4K?IN#:;AQD9)E(D(WBdMTDGT/KJ0NccYUa&5=b49HQ1W>3.=M+:<V-SSXJ^)MH
0;ddG&.\W(F0P?gW]&P._W3R.cQf\3ge(;/L1[CH92[UG,/GaFI\>,dag5Ad>FCa
BM8X).]YMXA.JB,P]^LH@aa5?L:9#8Xa9X0LgAcLDC/)[GdT=dIaMa6=,aZ?UKX@
U+73d4g)BTF>4YN2O?[RXF[^3<2SFFKL[P&M/?NgPCM[Of4Da<R^Gg\H++K9);D3
NQU:1eEV?U2J[J/d\_T?XZf>a<^gOAX)6^L09(<;S5gdWJ?TSc+^XISa/OWcXNY2
?YB&I+?==(FU28eQ^AJ+5A;7+B2VUVH(.MEX@O[-3E,_G\>S^SegL]A^9BJ4?_=\
HUP6Q0IE.JEP?;#;a:_UHV3=1V0@Hc0+ScOg]M:CYJHg]TK\C4gIeN7^^OFY85\e
SB[>S8A-T1ARU5/gGV?X71Q@;Q-LVZ4:88T;KR3-J[X0Q8LXWfK0eD->#97]#-I:
BU>3;B@J]BAI(2BU\>8:8Ub5XVc6#c?]dY\^3S=e(A&W+K83UTAaT[M.KbM?4-90
TBdS-S.ddHVOIc]S,Z8d_V;8d4F105FER^\d+6cKYE8LZ_5-,M[g&FT3LS?DZTE[
\9(-#9_4X@ZgW7(O9B2T2e(U?5Z[>+D?1gNW:/L3+\E55P0:e7WHcO](3(/68/_3
<IQ:&#R]ANNb.+/]eP=\/7V[-J[&4f9(=>07a)Yc^)?/R-U8Z91N6C#\7^@0IbB0
^(X;.0ccP6K.9R[J+WZI]MUW?c3Y+KIWVYdbdQ-cCef0f,[^c@V702RYJPOd2#ce
b\RRGL6bT56C>?J8M]+P5UbR,]OgY)^B?6.1TPD(L7BCeO99MIfOcb6><.(]Ug(O
04Z_P/Ceb-/]N-,F4A?cN2-=OY)LXUd+e3e32@f6^<M1C\c-HM</H0\4GTF[KZJ3
\:K.D)3)a-4_G#RIc]P@WS#3ULPP>L)\/(4gUe57O;eg#]LX@De])L7QI8_S<2Hb
gXI(<A_/,/a=I&ZA;_.>E7dV27\?bTdNDT&+#AE;7KV]M=5<MH;V>T5.]F+:H0F6
b3TIP]ZM\=P3G6CdG_N-L4/#^H7-I=F[DX4/EeV7K.K4e._/aC4J>&A9X=6^8A6M
\NDaM323He_c.\SfZ9C?+,gO>Q[_&X@G,(P^U0F;A#C#geE^cg1[)G9&DC@,CDHB
7S-\A04=B6IZPE&X1<9H?[XD3J2>fWD/P;/;JJYX4c0PD?X23IM3bOgT#X1g(bSX
;^1IBD[#DF<4^d(-/I0c9VdEa]/?dKg),B_=.XUB^-RE^?<K5]SI3ILHIDH=C:fK
:HO&:&G5[<[2Y>+?Dg<H-G0VW/&]JV7<</(G[g089\N@<Q8B9(@]dCY3:&QY5H+H
HA?MMN:aY7X;[d[5f=;bA()0c0f(VZRMXEKG6:@U(.HA7S1:YLTT-N1c4^:5f^(Y
fH]@-Q#K#F#[&ADSbHQLa)FgIfJ46SR[_3=49&>+>.Kg:+a7>+3B,@SRVWT/CR1C
JSQS#7;QH6-[9eFVAA@YZ+=UHOD7T7Td?20AW5?L.:LF/&F=CJB(QQe7TRQ4[A;B
2cY7NOM-0@\a:CdH9I#6)T6U4bZbE>SY1:_C7(491<PWcZgZBRK+=0ScH6>1_2UX
JWB;CcQ;:6.<Y#_Z=ID^_74#Y_.B55HSYJ,GDd^:+ALDO[5aHA&8RUd5aKC8WE-a
9\)e2#YaDePQW64OE,ZO:<MJ[#XZEa4W^YJG-HKHSfL7+O8.I(ea>;[aUYd_;b7&
d75>aZ8N9gbC&&UDOaJ+W.[-#f(bEbA,KI3O:KUCNg+g[>(X=#:\=.L_O?Q/Nd]B
DD#FfU<4DKI96Z02Y8P5AL1I\QL\@IVI=ED:JRAdX@62[+JVb#K].R4D:X<7g=f+
3D0:c&-&.?-3VJ47:9+G+fMc2E,43CM_gT-JcHJG[J(@6[[\=D2.(-7]Y8Cc6e9a
L1L@GG;&gBK#5F3O7C_@,>7YP8),B)NOKJWUb-V1If-0]L4.CD>5IM?.VPO\+OfG
/M]A?_,aP/I)\51ZGd,.f7N&Ue\be.>O8fg_XA99#8OB&;?.M)KK<96=>/>[F:2c
dbb.X7ICQQSIWd.;BGZ5TR(?+gY\I)R5P2MOAV-MU657Y-MDD3&8T3C??@-K_2\5
bd]^^#Z_-@+R87A/<O;I&dT<E(;2PC].G.Y=T^D=bHNLA&.AQUO5=^\U/L_.]KB\
H&8JB==44_>^^6NPZ)8=HKS0HEP?SY<5[#JWGP0XXH.:efS(YWFDRES74LPdBR-:
DOWecH:f<RWZA,4R50g@]^@[?&3?PdeaWL7UQWPDU@(R[gV>cSZP(;e&?054F^R_
1#B^;GJ?QKQ?H8Z8PT92M@E<QffaA\c++#Z6()62W1+/QGC]9IYd^]4.SW)?O9I2
;#DV-aD?gKFN)fNUBWN-\.EcJ)Z9_ILDNEWdK-&X?E8V74X_5[;Ig];GTD/_7QPX
P?AL[W1AVCK(H>XTf37eV_ObB:)_3E9L&4323]=^BR,[Q<aa[DO_#CJ0)7UZ_-Qb
6H4dTT(9?5NDTMVP_ZV<7/Hf@^6]+6I=gOb@@[+ID-_\E@9&?TW<EGGU=Ld3YU^D
DRP2TLg]Sf8a2Y084M4d0c(4Dc+4=D3ZGcIZ]7Z&U-N_g-J.0TQRd3:f_(::FMMb
/B#Z=_9YBANZK:CC4YLXAAT,L6;U,[cDc;826.ffba<(M8BDSHU\ZA??GgSA?H2.
e;aPKHLbdG)GQfA(=^G:Re4V4#4#;S/=NCW#<Ac++@ZYA4F/OZDBP##X2:Nc57F9
_4G5d3VA)6E?;:FeM(YQ6b3gO8Y#Sd98:,GEHPb=V[>XWH3]eL^:]6OVPCb1;ZH:
>3^G^0b1MH&0ac,8H1E<@\BaY&\)5eH;b<7SW4c2I.+H(_JTGb.O=XNQ>b36E<^A
c,9K8[+9POd#IO9?W7c1TGaWAeLR=YJ]V+,79AXLPbO]b?b_[OX#C,,A;b@LaZ[e
Z)+[:J0JUF;P9\_.aYZW9.;X<K)&RK5Pe5d)7Gc(FM/>a/@\^?bPbG(A&+164N-D
ZOX2T<?J8K1DPDO2gU0,dM+LU1cHF-@dL-gZaCfY&U\UZ<W[<RAG)aXf44;-^=)4
QA[VDC\cH61BcMA7.A\=PZL94Jd2edfD.R<4Q^JH&eXT[&fd=UCN@+:fH9XT.1ZW
:W<CfV>^<QF8efaSB2P9VAW<,aB#[6:ZU_HT+Y#-6gg?,V\2OZU1H(N-=\0Hg)E]
dFA)8=g&[30;\bURG(NB]f4&?=]O4:<@4UA2P,N(g?ZK=P5)fcg:X)NA\>#<G=(>
S_D_UXgKc]YU4B4;7NHN,gKcI,<cEG#RfVCV8Z)f:eFLRNV?C7Ud/2)<fT4O84Q]
(OOK&J;.6^5ZO->S_f2Y=/3GP]U2O561.FJ:PB(677V?Ff]Q]8(D/g;\=UbV@>c#
VaL4L=M]\Na9MVX21C8N(H5R#-W&K.eCb(43gAIFA)C)V#&eBWeF?C2W&3#/c9c9
#\Of],SML8CO<V\LIc3bZeF,Fa9fPDTe_c\@+,;>?fM8Rc]W6-T#L\d,>M<bGM0I
1348(@A@-N5b+RMD/^BH5I1(RURHHJ-_FaG5gV4-IH<)+10AV?]a\;8LUYP/&WO9
ScW23ZHRL?>g>AS;Q0@g[(@f\JG#UHb7+2@5<-fF5e@RLaJZLZ>0+gH3JNY<<UD1
e6+/.:(LEO^dW[9LR^+#V7&EF#A3Ug)g:2Oe<a?YeANC+9[Q/BHKGXeCO=#b>D>g
G^N/eB3CAcCT90M1e)5fTb:_+-bS[^0E:08W]N&G#W?=P[eaWV&H>?A\UH[ZO@TZ
V+QW84K0c4PE2+dR^(MP>H0b-P]--0<Q5DP/A6Q?W+1)V:eG2WM9D6]E6>^5g_G8
#g5OM3,cHJRVE2d61/=a#V?TXURg/=ZFQ5a\M0S>Q/M>-;+c>@>U3^^-_08W22YO
cV#<>#\+1fH>EW?8g#(41?D4H+7c^DID554^-(&#?Je9cS)f.H-@Dg=JA8ZCF0J8
J:>ICNXaR90;PdG;7[GA^+5eG,G_=<TZNXM2F,+M3IE;7fbEBZ?+OGJ1HLS4eE0B
GK4[V2K]P,DDBbIE4?gF>a>Z8KJE#<N&c>&B84X4IcO4B5g/RZ6W(54(FXE4Y3[D
1^PD-Z057_]+a=]Qbe\dE5.X5bdFO8E7SQ^_:K)G=Z\AH(gSR<>G5NIg6IWd4-/+
\ED_2-Pb&&R_Y+NDV04@+P3+g+:D).F79C\:M]AW\LR6(3]JRB68.I>a3&M&Wb@<
ZgN7aL?O#\??/FW<-=((./CbH[FQGCG-D;ZAB8<D2>O39^;@6]&1V5aL1JKW8P#V
@Y(GD3VLBE54X9JS0SI:+>2G>eJEATegHU1a.#DSB&,]YP/eEU_g:eRf9EQY@-dW
D6H9FQ_Bc(&.,#V97&\6=E9PV?+B7U&8TfI,/51V>.JUZb)DX<c(:HNT-\(H6VQ,
@8=\VcS1MO?FW0<Z@;DL3ULgH5-.\,GQ?&JB(:DIV9OQe@;]aCI>V:_6J0O^9[#_
K+GR52&&(Y)+QRWI\B[SPUC<?9H3^XFMM0JFC2eCc4[^/L9RQQd#0?:B9&;I5_C>
cPVO2.#U#Q)#;d^R3/6.^Yb1TD#V[N.cf3:HaUD.QTJGY[7ZMZfJ_BRPC,,g<Y^Y
I@E>f96;\A<X^eT\F1R84YdN-HP8SO>,XI(&7:8f@BY7d57P:#A#d3MdV;/eZ7()
+I0)W4M#Y9#=IJ.,>TfL/V9-^JaP;^5-Q6REY5^aLPaOA#E)-&4f,>3\7#>:YA;X
1F)N;_V>2^((35#C0M^9O4Zc5_LMgNP?<S_f70J1^)ITBQ,B[J:IVg(F8+f=?O77
eEDdX_SYAS+[,-5Kd?KJAE+_K-_VEaCg&OTWE2bReA7;d4eYBAfFKC5g^H=:[<=\
2]1c>+;W3YU211ZJ45F5)_SB6PB6=eJVfOI[R[PG&b[AV,McEL>Wg@N&2GH)99-e
V;ZMC(Bb1?TOId:EdTW]XLB?Z3[1RMf2&4,R(1IJ>U8_>SP@4K5-H2D=0O;]1EF,
?[5J.T2-&1#@H?VI76+d/<]5Z#7aX;?9.K?2d;0.8Gd,PTI^CC]PI1F-gZ>7_>X]
_F&Qg]T@eND?^_MTE-.U?D-;&@F@[[=-gHB2[S3I[?VTZ@K;)(9C7H[PP?OE)A?(
;RYUL#(Z=;GG2MF>2AMR,e1./_1_Q<P)BJ<G60,4d>GR)5d2L68bTCH7)@T[1a1>
bWI])NU.;c/7^I7>b7c&NWZ5)).d.UV\/M\+e6#OC0QHC](Z6<G?8>8X5,)E1cK\
QZ?Z)-3fYON+4V_SFTX:O5_A>F1BX-?<Ca?N=KcLc1Jc:&(P&@a1[KVB.FU01DP;
54+;Fe9Y5:N<Ya5BUIF.+,ES+I._EN+23f0#-GgZC=G;,<V.](4AH4H#PG6/MAP2
a54bXC#-QgJ9M>RKUBHZDaNJI]85F5c,d_Ic4]..?:^#WN+Cc[<E][CD;UDR(#D.
bXc6B#368e)VQKbMOY\3T3cbIV/)b-U^fFE^_H9(^:^4Id>8O934CN^O[EU,E.O@
B;e\/P=f3^]/E(O@G:<F,6VL+&f0&.N_DC[I#a04YSaL<61A:3fF#V27I<&4.UF(
A5ZR=b#EA<;XSbR=We;ZCDY,=0/B6K1I@Yf7O)R]=3AUS\d:A>c<Xa,ead;YQ_\#
C:aT#U3<+RHH,I9/[]X#QM;>77Y/3+.A1^]5;d[gSARC4V?9/Q:\c^,V.bS3^SP-
0De29)A\dgX&4_[&7@E+D028H8H7Eb^bK8Hb6O[RJf>d<De9aE2N9gN1X<YMPES8
7PCS)LT48W<\:Y;AQ=@4bc5H[J<M(4&0b@\1(aA@3@SNW&3NY-=dTZSR;gK#-NHL
P#CXM@)WJO:d:e._R+<?6O/[=WP_FJ>E3&gX:_D3Nf:/Jb3M+a3_2C09Egf:f.#a
0>,4&F(e(^.Y&Cfb^J(^GIDLG7?@U_=A=R^K4/GGGJF?<+:-XEP(F;:f4cI)dA+c
BT<GXWca\Q>1NBgg6PfeeYAQa#a&f/ZM^)U@_=C+C@QKROVCH9.H2BB04Wc)A\]6
eXB8A\^;1>F,#XQa)3e#;NObZ++HOXG(<7OC;VMXQ8]J0MQXET:X,G&>8:.7e/5N
W(^=4V8:EOF/BS&1EZJKNcHML=Rg6X6dQ(4M6/4E#^XO2RRdZP2G?H3RS.f7QCPF
[CFUg3E4dP4MV3,>^RGa>6Zg^PJ=S1/&5GeG9SDKV\c]Ef=I1<WF#_NZTF9bFSUZ
.03/;:;7f)_GQZCGG9fS[_?MZ)Q_2>A>^e\;Wc9@=fZP1^g<>d4GDQaDJ<c.2dW(
M+B+?f>5)Bf#@Q9[86[1-cIbPc)]PV_TX7K_^@)?B?6DS,#^6(T/Q#I;I@1Vd_O5
MBcXcZ,)^9aI7<015<JB<gfW>4D]^6+K4bK4:F+bJ+dL7<NUTVYH>?eZf[J),g)c
.X9-_R<)fbOUHN?W1J3A?<,_ec1g^_OPH8^Y&]#-Q&K31+RG7g-4J6_#)Hd>/GFQ
P,NO#M=G\L&?<2I?@;bA<K)D8#:\KY]LT;b;-C@J:2]4X[#3=.D@2HHFUM]Q1>UB
bec7[;_bQY.AVQ2TN[B@1gTRMJ\Z478VL/C#9#&E+7Oa4RL+\B/J+gW3JB2FM5H(
A7S3b[NCa<M:T1c=aY^(>0CA=E.<MVCSK;fP#_\.&T;^X[@XEMY]W1ANH((A4a&Y
dDeIDO57LN]3NA91Y?=Pbd:A0F\3ef()Q7)MWY_8K5^7PJY>_VP?H4M>PZ)<F00L
X,[aa6\T;aYF&6@EZ3D/,:E.GMCfO/Z,^fGVT.J@BTN4GOZ@A=WNA9:V?38;03C>
3GA&Qbg_Q).@1W,c:B4aN9J@F+0cWcGGa]gC/=1-JTW.Z-=^]8186E+GU1M^2Z3,
Q0T4(D8(40E\[R[_0DCf9<da7L0<5#0cD])A;YASZZ+[S:Q&=,_YDOW3<f5S]HV0
-A,.L37VSRCPJdHH(OUPPEHa,)cb-6&.FR0:d=B57=g[@XUFZ=5RZ.4>a8fEHc\O
DE--/b?:7Qa^TN@.EE(LZW7VBB[[\?F=cWYW@<G11f&e,Q2ADK[f3Q,WKL&J:95G
.bA&Ca+&VP;3/D5]fAX4K8);^=fJ33Y#S@(+,K,G>@FG[.RgeabPG#b/W<#@9769
T(JeCW\cFJU<OOP/8X=KK_2TXY76L&Z9W>eR0XgF8,9D3X(GQ-)QeW(d_UQNJOL,
aZKfWT#NL:?98684H1bYT8OQ]RJfG[Ib25F\W</HH:_>M<VM.d\.X_&;.#.\M0(^
RK(=0K<.cKa2>@FdK6.ETK\=)S.Y:E()Z)L(+^&4\,]:)a4ZL2H6UH\LHT8>N61<
eQAJ2,B7)HBIg7(RRWf<LSMY,4-g#CV,UWA5GRDT@NFUX;C@+d=Ade:;eaKdZZ,F
=E[Q<-8CCb:IQO<:^c-/_@RMQT1-GU7S<<,YW_A#6fJ@bZ]QSRA<->Rfb7[_&eMX
d:WEa7f(EYU>]b_MA)J-ML814D-&+_U@CM.LAAe7G0<B/+K<6IXP)6MIM^:0Q;>Y
+QLbIK#;S2T&MH<[7LJDF&(.OIT)RFc.-TWAfFfRcY>6f\\Y;FL]e7[A0SRU9g.d
g,3UWDb^e^X^Y&#Le@E4>A\T/)DH-Y9e9>U1]@_&bSdNGQfd.]9<X#=HULUfKTEC
Z;45^[LIPN:d2R:ad\0;?<>T2#HA_9\_?OBN[+^ETP/3-B<O[MN^,)V>^44K(<7(
aPIGZ(T.L[;ZUPC?0f,L<JJf]Y4O+I:1.:g^a^BR3#(T9P_B&&=U::)M,6J_,JC:
c3IR-;S8]NMCg8&5#X#SLc?Sg:=J5Q4FTNMTA&,9AD:CCG5P[1#_99?X.\:8X6ab
4<gCQ1EYZH32>R_F(.&V13H_=^:2[5N>N][]MORP0gBJ=/]ZLXcOHI:8e.YUb)D<Q$
`endprotected


`endif // GUARD_SVT_AXI_INTERCONNECT_VMM_SV
