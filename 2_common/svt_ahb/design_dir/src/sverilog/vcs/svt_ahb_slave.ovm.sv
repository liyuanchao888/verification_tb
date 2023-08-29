
`ifndef GUARD_SVT_AHB_SLAVE_UVM_SV
`define GUARD_SVT_AHB_SLAVE_UVM_SV

typedef class svt_ahb_slave;
typedef class svt_ahb_slave_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_slave,svt_ahb_slave_callback) svt_ahb_slave_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_slave,svt_ahb_slave_callback) svt_ahb_slave_callback_pool;
`endif

// =============================================================================
/**
 * This class is Driver that implements an AHB SLAVE component.
 */

class svt_ahb_slave extends svt_driver #(svt_ahb_slave_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_slave, svt_ahb_slave_callback)
  /** @cond PRIVATE */
  uvm_blocking_put_port #(svt_ahb_slave_transaction) vlog_cmd_put_port;
  /** @endcond */
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of SLAVE components */
  protected svt_ahb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_slave_configuration cfg_snapshot;
  /** @endcond */

  //vcs_lic_vip_protect
    `protected
;aA..gKJ;18B.)/9V&DHUdd:4M?U;78B=P][CgVR92:PL287&:OE+(0<#G2Yfg-U
G9SgXJ>:NJ8DHBcbR.3::\f(DW]YYe8[[/>XSHM#<GMTFG])8PII2aEGR37cQ^Y8
>7GDf>&f,BQTXPR6[<=C_cR2RU[5:dF3QKZAgN>ROgTC)K,VU^?ASKfXd&]Y>(M9
DAZOCBCW>,8>GU>&9a>B:##c(U3bb2#&LbX_,4e7N;#^(>U9SL_2RTY]ND\B5&AS
>3bd>A6Q]e=U]4[2+THZ-6HDQECVBYfP85:021UP.&HV#:IG4G1X;cW7O4?E\35^
042eI#c]6fOFU78:fgKHLZD;Z@I]@[DfC^-TY?[,@BFPSS6Z+D?^f,<G7824/]d)
6:VeCb/Re;0K39RMF@^A#AZc&RR:^BMC5N0<#)R)[-DBU^B\6eFY(>XY,K?B]Y@Z
Wc10(S>0b?(>[QbIaP2SfUV?-7F78-&&-O>PE(SB)&G@VgMN@]&JTQ+NLH5:.RMa
U95G,b]+Z:b?O<4dgW,D131_5b(84KQ<@WBQ1>ME1gE=DNP)F,70;HPe_SbA7AFX
=#bF<cHUD5XKBXZ#4WL/2/1,4>,:2=KL#9HW\V19&7(_=LQ?f;=&7@[-2C[/AX\,
IV-ZGFLS;I7a0Ff:GaHV.X-I]R&]:cW9A#U3aWIceLAKR1E]EMFO_9LV64U<8K3N
BH);GZC[(R;Y6J4fVSX>.Hc3K.YgLUD;BU^NM?_?6YX@W(2;Q5T3/VSZ-WG=[F]I
/N5NF^#+:<>4EaV^I[LVR7eF3I\d)S2WR>[U<QYf^8BD4e;KKVPP84;FS<]U;C>Y
@:Ob2FSbWQTDBTeV#+XQ#Q#g#8P>0-eS7@AI9R]95bE42/T0-FZ<@-VYG[TF.E(@
b=587&AHa\M807,F;OI<TCO5RG/-#M42GE]d2F\<#RQV1U&=aBRWPPVYL$
`endprotected

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_slave)
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
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * End of Elaboration Phase
   * Disables automatic item recording if the feature is available
   */
  extern virtual function void end_of_elaboration_phase (uvm_phase phase);
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
  
/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages seq_item_port. Sequence items are taken
   * from the port and added to an internal queue.
   *
   * @param phase Phase reference from the phase that this method is started from
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern protected task consume_from_seq_item_port(uvm_phase phase);
`else
  extern protected task consume_from_seq_item_port(svt_phase phase);
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_slave_active_common common);

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
  extern virtual protected function void post_input_port_get(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual task post_input_port_get_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   * 
   * This method issues the <i>input_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_ahb_slave_transaction xact);

/** @endcond */

//vcs_lic_vip_protect
  `protected
V4T-XQVe#)R1:3G^,^Q#Sd<B1Z0Jg(>Q1<^[X+^a^XMBMTD5?9d]&(P?F.D(8f@<
e&@gaC3.3(fOT[/3X-0&?9S,<V.a:K/1F7ZHZ0_A6g]#G?M[abX#/d&_9-HBZWc0
#S2=97d1BI)6M#BV&X?\?c7=KEa;OLD#PF\4U9TUDGbYSHaV8g]ba[<g^;7f-_-Q
,QA9/]WR7MKZXY]#8Hc<1O4B#J<dA;PB&32Ke?6NY]HFdBeCNT22abN08040992Y
B#Bf].<H&]Q&CgNadOD#a+4B4$
`endprotected


endclass

`protected
1^&D/94O2I+P/>GE=68L_W+P]03-g&BTcAG1CAEI?Ug6Vc1aK^P+6)OXCg]g[JM&
F/3_@K]XN-DX&,0aXQMba>D[&&c-cP3BC^X\cF9AY_DgKKM=)[FUTH.(2HdI/N9_
W>RJD4AUc_;Ue>0L?JT6(/#6a.^f6:ga>HYVF?EKJN2K3>^+9)2XO8J4+#VG<I]4
C=bT?T9,JB#2c2G5dT3V0aL=&YdH2Od1BfA.W2_9H4(/3)>@+.#0R8F-e//^Ib[Y
KL=5:cRMW?gV;(_@:_0d3?OI.U5&L6;D6^65)5b1K[e>Rg=^#VdR,^ITbcdNJDL(
A\9PGegVb^S^g4W9E5OAEC^9JMD5Q.Jc..)^(WJ&</Lcf&._AN;2<T+]0EYYCQ-O
_2T62P@_SC9GXEBaLEdfQHT5:=,_@50SG/9AMP=<,)3cA$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
L.HB#O3:RM/-f-HJ4N4?_8<-.-6?_<Xe4-V[M+9?>-L&SY2.?@5e-(RB#F8NG]Ga
b)J>B7F4G[&Q8JX,f0G6#acB=(MJ,+Q_.G5\PCgEZHHG7g]HN#0,aK-^PJK4\U2K
K;UA;+NR)dN>)VB2e^Me[@A<[P#XMQJ0A1Q&e?ZQ9WC<4=K5:+K)R^J82a3e[[T[
6#9WA4KOGA4dB7e1I5[T5O#-.TDMcd6_8E[::N\/W:70_N\]3<]W&AA,9.NcT^AN
3e:(S\+,&&FVU1Y@URXPHN1b+.@d+O6AbDGaIZaVH^++YO(WF^^;:4-\1=/aLg<+
2YZ,B4a?DFcWb^-(^Z?78MVF-M\C4<[974=GU3dIA>e0\,&X2G&]EFN0)V[X_^W,
G>(0/XYIRAX_E955&VRPgT33<Lc99\fG0ZF_=(OV)XVU6f<TA@X6FO10J@R]ZX>6
,GIQRHe-Uf<E+J]-KPAe6NT,Z17=Pcd9CGD,R)7R8]43]:>VN;^]L4J=-TDV_TOQ
\Dd01d_H(GT]@;5,QC:5MYS8U7;[C>cFfT;N;2B5RDN106.C]3PE=^dc,4#(=(d?
9<[-be=^T1dKG3-IL]H0K48V#ONQ47K@/8E0>7cB<UWYC2,MD^6C=/GB<9<#[fB8
gf_WAF9+R))0(YQ>RE31\?BP8(,a@[<Sa>(MbN=8egDC7@eR840@Q+4cDfMMd7<=
)@V,[#87G#UMQNNRN95X>)W=4+EJK4&C_?@\X3ZND7Kg=-#0OA2;ZFV413=X2O;2
XH2fZILP8P=>6O>@AI[\FacGOg8+#EG+FcMH[K&N_7&1DSPUR1TB1eVEQ0Y)IFUR
.1a.YI(XO:T.PC3Z_NfO7U4[J5_eIcF_#[P@EA37bLe6@MA>WCb)c6cUWG;aCU;K
6^XVacZZG_PbG+[F.S3/.^2V\:HWNdb@fY-]X,=JZb,eDgWUd<NZC&Z,7b[2c?IO
[gE4</PGLXE\8>33)?:M#f@,;,gJ9D<)(_3C#\abI4I#C.c2V1B@\&8FL-)[C3MM
Z92-Q5-S3_7:T,&^KcXL&f3?G6QT(PJ8JIcP0MWf0M7)706MOD<[F]5KX#@B5GF;
C1Pd/9TSHNI;f\5#W,GJM=QG7GL&C.Yb#QK0PA4fY#/(^^;U77T:K;8-^=H[VP]M
3<Tef^2A19J_YG@SWgEHM<3AK1/Bd2;:E(N+?JYG3(&@-5J-J/1_;.EJ.6L1G<@A
A/V8DefK<D0XU2C:U999+B\&e9;->U?J&Hc)3P]f(f2,^]g2Y2.PM\8M&Gb)&;]8
Sb_d/_2.>+7a_;_@5K(W@ecKfU08C/A-NGAF.4=+\7(JZA<f.YE,+NN=RMJabZE:
#?e=KZ]&#]FT,R\c)\GQH(N]+bTS(.NITZX-Z5NBXH/=YN@-Kcc<(?,(E)<:>.2I
Na2R6TfeC/)92UX\,-g7;^9K7GbFN+aP;MM:OF^Pc^?dd=c,U:0Q@P]W?XCg76X(
+)T[8SW6A;R.N@EJ[Oc4HP9:QVF<7:a^/dMO+a7ZMHI6RKE8gGU+PT>L2-#GXTT@
Na_VFWB6;5>N:E+MaXeC,/ELXA+32dY;O[I+Vf(;ONATT:5H2^g?@(IAK13ANOdV
3P8,MF7B_QP.[@AaETKP.Qg>d3f_Z?.;X(<(&5:;:5-KKCU#TFT71->:9OTbIW0+
H(B:L,_1\7+cKD]Q7(V,FC4dDS]7)3S3.==DT.]:)6H\5CLRFXN0>cQ/LfO0V16R
,f+2<I4LY2\(6e3SSY\Be@dE(R6#d4,@(-NLc39-[[-0NLBHIX1+5N2fTe<[)A\4
>9UM/>Bc[d,]bS:+aCC:K<C:]L(9Q:BE:2-U71B_<]J1c\WRffeK8cC>cRA[UYXX
=]?2b?\d&+9DgB)2Teb7+YDIKS0^=.;0LPD<1]75&?dQbKCd+V+XLa7Cc&<XO\W5
LO_7--A@)=H)1U_\BMbg^WYa,=V&Bd\1/UZ1GQEa5ZD3gI/BE,\^<)2JV6]^WB^=
X>Pf+W.1-)EE?^LZ\_IAG5<.:[D,^I3:G^Nb=<KJY9d4AR?/0\KH7)I_^\OS^=>)
V70,ScDfZPDIYSJI/<Za&NY42Ve4;Z\eD>4aG+;cZgA_LAb+2#F?70U8IY+K0NLe
+PQ-bDL\&-bI57d=,dUfaD>\cW2ZFAR>HTT+BJBI9;@-A:a^f&]),(CaC<N7W?bC
R9RA-TDe2BKf<YRAVEEA9_6^9RW&)ga/A0>.RYAdHdN3fF4<b1<4PU2:@XV?]7OD
,0E-(ZI#^>7)KN;BMXf6>._7]GYEH-3H[+H.H8=11;c]ITA4gYeC9>8:EbS(0RLI
?K<BaMCg>fMSMWF2ceK^G:&U+0\^]Pa5?CM5-bR-fK^2^\B#];<3]G+U_+U=(P:/
Fc#@4IaB]S&1c:cT6;CQ5CEK8HFf9BPJ6OOUa@^f8g4\fb@,e^#Y&,H&38:WOdX=
7F=>a[373D)ZG-7R#gYYI7bD9QDME32)fSJ89^==f8;J7-?3J0U8+^?^^8I92,b/
.0;..SCg)Q/@gX(.c?/KLGU_UcFeCCa(XYTgLId)0#+:+JJH@D]UZPcD;R@UdPf;
bf/bSJT^4^99#XY^DNC)NQ6(NM?f:[>/bNOW<g4-Na5FA7RSe[?YZR^&5,dDJX[,
TNafL<d8M:]#JNUDJ1#,B3Y<XN+>@N923:V:@(+,JMFdX5?@Wc\;V^,W/C\:V(/^
/:+7D;a&W_5:(:U=YE^[aX)A1B5B+J9G/\7=bT</IX7dW9Sb50GVJMX03K&7HFFa
K[IZ^fCbdRgBV4Lg#V+#gZb3O8c2g/J&S+<aTZ0CXQ?Q9Ng&A/I::0MJ(6AA<OLf
?1#LSa:;5\Y_R]BKa)&\/FDf_P-=A[COB-8K8CA8+(S,A_49ba-U,48>+<)U+(?c
06B<EX<fBH+;F;d1(DcK,gJE-4K>Cc:J@8+0=R5NIT5HSgLZZFHU6K:35^gB6(@c
]J#[2-EC-5aY=;0GRZ)DIN(3QKf4>4.FP#(E>)X5WV)Q5b_]_RU2M7G=HJ6TB?ZF
ffOB((3JFNbJQc&U2CXcc6.#_>[RTO;Nb]Y4>TAgEaTI9E>IcE-Z(5J0gV6Zg^8S
SA3UdD)X\cd\#J-P^[9K3/KERPI.N6f;NP-MLARP4LTRMYC\W9(94O8F_LXQ8::J
cQXNH6Zf0#:.RRTdRV^aMQ:(3Gb(D>X+ZI4-M2#[N4CX-^H(Z)8c:22I>/=?[J?+
_4(EV47462JHfY[aE3K9P2?eA;JKd3/61NgMb9DRT#U_V9@EJRN1aTSA+AfXR73I
Z8:D4A=95V+7GYOY:1R9_7>/::LOZd)]^K+Vc>W?eF4;?5C:XEKEIf)ZHVS#>BJ5
V<9H9<(F[F]aF-f;1HdX<aeB6g8#XdEYcZWC_M(.N4Q)N0P:f<A06?AH+?JZZcD1
PNBA^Z9&:(B8g6?1&K0L]@c-FH(O7?gJ1/H[>2gd,dg=>PY0Q5A_L1M)/_<?a[OF
eK.34X:R@US<W738C<C)VAe2W&>C_EV8=?7_@:-B(3LCS1]+=dSE9#5c^UHe_<4:
Cc7dF:RG50N7K6]:/Pa273_#G3(=YGBgA2_X;>[bIYH[0+AK:P7+7bB+D5/:.9>K
EPY?9D5S-c;.JRV,5I<>@BfD]5KO.U^I67-Xe9Z&gXD+LI3?6I]_=V5Ze8GHSY]B
#?AWX8cP^.VQ?.U,9GAS@5\TL;2+eDWg42MTLNB,=2BH09E#@f(&;:gY0@8aI+-Y
?EV.6LQ^AbEM&2T-;<N=R[52C3=K-7V6^=Z+_DFd1<a@E<,Y/_,H_Scb1GR63M:7
Yc2?50GccI\/Fe6gZC.HB3<E^>;4QNMO4<W\\P:eMCdGYXF<18&]KI1;PPM3.B76
2&d=<1YTaXbYWF=5CYW::f<_<(N7)C=&+H=L#)\,6)X/L)Y:@SZPWOa@?(4+FO\^
UO\f@7/(?Y^=6,eOGMUWQPNE;8_Y4^9P?]DLMH+AP,eYL3a8dXYgA)9Ba\X>L2:T
RRA:2AbdW6_SgYB4<a<MGKN:@9ZVc35.aIf-\0TfTA_fN::I4Q&+KI.+7,V0NdIZ
aAJB^:X\QL0_#D/aP7a<4gL8UZO05<dYRS/PM[E4VOD2AG8:_KbFELf7E[cEV?[J
7ZZ\>bA((?;(;2-a1E4H3X>(gS/>L\HL=MAF>8Jf;@5B5EVS(:WGARG4eSZ((T@7
]>AG.]CD(Wae)9X>)(^34LSd6XATW]RNGc(ZcVGJfI<L,:XgTINg6:17e0Ng4eZ#
&.?fA\0]OISRJdZfNc/R9\=4)Z&HAOfLPIc=Jc\@KM_>gFRB;@8JV2,8W\RKcMdK
Q3-/^;=6W_6(9S3N:XM.2/O]FX52OVf/d2XMHQb]4)?:Md<I:+<N[^A>2CI>:XAU
a->-;6C5\fgZJG<4CJ\^Y\@T;76Za92<6F@eZA/W#BOQHddS:^\c6W:B1-Fff36A
Q_GD9]ZaD^KO7]&Y\e;CV.@@[X@(/S.UED<Rf\cBN53dFT<2OBUL4#;L:KH35](D
V/HR#YABM1:b-[a?C<[NGS[V#,N^WKCMa#BW8;ZPWf\D2KG+35+FXRV(-A]g8V^.
4YJ9@fVD0+EG-D]4=X#9[WY9#3S:04_6=EO?O/;?>U0eQHg]6gU3eV<0NLZ7JQ0a
R9^&Z?@dCeC@0>XF[XYTK.f#S]9=I6Df)WRHA)SZGWBMAM>#,ddb/>D)bL_Pe=dF
EDQ[6?#Wg(Wb/L)<XT&E9dCG&KT8>PFT,_(O]WZ97]X+0A20SAX8C.Og5?(@HCNN
UQ09>6.M>QXfd\C.b4g>[PW_^aESV]VDX&(>E2XO5\Wc#=BLdC321(1fRZI[-ZVT
9]Ud_)-#HbT/f_?CJXF&CM-eVC>?GR?H6S9c/(8YQSLLF\X3.Q/D&bVgZeNgV]E,
:^C5e^g3=5A\NC2RRJH4/NcQWFfa2>Q#O,,#bWWJ[5Y+deP.O#:)(0>dVV1#2D9;
VK>C)[EfEG(-)?5\f&C?=_7-Sf_5@gY,AeUAdVd+<:KBJ(&+O()OCV[B23E(K<[X
+Oa4S4,F6BRaAGPLO7@#,AKTHT;@V<JX+dT6^+790VJBJY)O5=Qba,LNa86Q5K><
:OH7T&L+QJ84c)).,0+ga;YVJdc@-\N[JQJ1P&DN_>.8&BI6ZZ9ec6W5[dP;>aD;
,X91CU1Zc7A7Ud:,]<Eb9U2\WJ((2L7+?YXVMC1P^5O4KSaYL59A8B+=X88aHLc5
DF<0Q>M8g:b<:-+4\\&?M&S,3YPeA\T[6421US5X6]/O+E3KSR;6P3M++8,0340W
c5d]4T2E247]KO0]dJ6DV9Se32GcDPYAYE;Edc7ZH&5W^c+^2(HQAA4XDGL3^dgK
@/2SQ.K<2Ze,EQE[FJESO(W=>7UQI,U:0\AaV:\TZ.eMfA)2MF4,UK3&X_6B&#&P
.FKY\F0^\W0W^2T+Yc6JQ=HW7C0.+8JEeD8_Fd\C9>M_\L<IS=3UL14Z\Q1,_[eT
CJ)X?C&a9J^7(ZB0AI7\2MM_-F^V2WB63HRW_;fgD,FHeSQ(O+B=6[g0ba6(<C&F
(H4AVNeYL9^#N;+D5NSY.CJY5c2X^S0(E4>2BEUH]I#)L9fb1\60FKN#[MNG;JDH
&1LOFc78BOBdC#f#27EYUYHLc?U_.\JH8XbVOOYTIQEaCJ=A-\=GRb3)^C<T+7OK
8a[A]UBe5W?>5EFGX7I(1gP3cF-e:X31\/W037?(9C8Y?S+0K/GU[3)A[Y6_NGVW
HM\+TgCKe7\Z_2M#=WDJK>JA34Q:.4ONb3\VW:@:ed;@2S_MA>9OdP?SH;(AHY>M
X56#Q>?]OWdTLML]X/8RQ:E+VA&B2VDbP(1@LK28]f.Z3EFQISf:_?+0F[3)e0QX
^2OU,g0H@0\c<[;OVTWa_0B#U,Jc?6Ag<c<C\,fgU5)dCFUO+-dA<2A]UfU3WB51
W2HdV=,f5:JLeQH3QCM7cg4W>0<)S&<>+Q^BKR0H.GVdGCRVVfMVFG;,@2</3J;<
A;20XLcYB-VNO8#H(f&5Gg;-Xg17)IT,[&)B=BVKIB;XY@J5N8#]7gC\6)ZPDT+7
Y@Ca[3,+,Q/4N:b=]C_;XfTUgJSWWVK]E#T-/SQ_QEa2gd/3[aNHNf?7HLPf^J]2
-@DaV]UeVe7.21N)(@_a0+K,^eUc&G^LJGOSDc_@J3U5c6[8M7J_:f>SS=@V\d6[
:>[)#JZf)UE<+W=-KZ5XcX/(.RZ1dAY)BeO,cFFR.>d=FGV1<78>ag@Q5A0/)_)2
[\P?K^4#a]@X724ZOK]S2.IZ-B:X=))fK]V-KGB893O=YJ^0+]5Y:8VDJ9/[b[@>
O^)#FbS9Z-;a44D.3e,A8LJC/EJW:6I8LdDKMd)1cHZ9.3FA#T4^GBZ^?C.?RLdZ
Nc\A>c3]1P(UJBQL53V3D+1R[]44MIB]+K^_4JU.LOY04R86>(#I19f>(^1H6D?0
@6G6+bDH4d[2>Q9YUZ2T.d9F,5G4NC9F3:.O3F1=O1#^7L(>43:b5-I7g&U877YG
6CBVAa2a&e-:M1S^E]V7=[)(:,0\<<POF]/)ZfP[)1^#.H2<P_.2[SPNg&BXB7.Y
aaMONGEb#2&WQ7I@?EB5F.WOBC1CYd[\O1<(.3/_S^:+^F+=@:O?\I2L-,gZ\-XM
^-1:@=N45^::E6A,e)8Pc=(?1U(_)@g<E^+0(bTd0A27NQGL^1L5EfV1\:)Rc&@Y
F(E:QOZ.83.b2bRXaG.X4d\g;ET.9@+/GY80,H92a);G(E\6T6=]FWN^JH53RRTY
T;92X<Z(YH.XKN@ON2-OKKD>Oc0B:SHC(;9<NL0\(FPU@56HUcC34d7M5^^YPF>N
O&d59(5PUAE1aZ>R09=<Q<&XFKO]\1LFCO+BXA#12G&f:8d@)[QA?NP:>N_0^</[
=2ST3XI[YgVQQcM]D/4;?XEJPW1W2fg.#[O-3W52UK5=Kf;XPJ^K:g7+:2;B0VF0
[]+D9fB,<<d=1LRA2bP((BWQ?P#E1a)5^-I\Z10/-LJM]?6DJ]VDc#>\Z<Q@\:5:
_?+7Ge@[??SS4TbGW.H;2cC26K;(X\DK2Y3f8C[?(^DJ#d)/B;;G[<Uda^EgD?6E
TVO[UUN&?OH4@@AG99ZS_g#79[46A?WdZf._KZX];g-J?A0_VWK3SQ;[A:=CP#2+
L?K[EPMX_+U3OHcRN=I0_TEKB/RLd)?_YUUSZ1]\9FMb<\>3?_HC>)g]XNQ,Wb.O
W5&QZCZ3A3(:AgSP=[-RJP.&&4L[=]@O.YV<,K4&/7=HM_@\SRXWJWF^PJX:)G/g
F@a+ge8c6\)@/8Q,O>(A7#QL+f?(L@<VNRKIg@Af)e[K:?[3+5_&U4&49gfS_Y01
1Z?U.[<OP[,Z<CPW23:]46N@5dCRcf;c7\R8GFMD>+g022gL(@UPLR?5e_&N@4A,
b2.D_N.bU]B8L5X?J@[70OL6b1f;e6LF.)\WDR;3;WHb>0LaUQ7R]24E[4-OIGWB
B&.FX13c_2G]J]fF:=]#F/I3N^,G1I28_^R^D83BDPf2Ma4=7A+.JEY0\Wc\50W8
6<+CX]3Z#V<:XbN@LbQS]T[fD.O6:B,]CA<RFNN^91+d4g_+D-aWCXNV[M(F3T^S
)U46-GNZL\a6g0,Z@0ZZce6;<S@:]MQY6@_1&>GE3WcX;Z70E-XLHM(Z:S[aMR?N
BH6b&FYNUVMfEL_8?[;6N]:EH3U@7.<=2;I]5-4c[0S-1c3C#MLd2ZY6J-dd:V>0
T>(6f@Kdd/]FGeGJ0^Cd@::G3b575L#7A-HS/dNTMZ7JUXHa#R2cQ6QI?HaKIZEJ
2[0aMc9_6[4J-Z_<_FF1B\N^1d?BeH&Z0&RJ:TB6S;^MT?MeUX>LbY4S7DDDgf<D
Qgda:)Dg6Pd?gJYY50:a8N9L,[KRD5dc=5/#6NeO^D@1I?&@0#/]RW?aaU3V8@YY
7@CC7_fQ:]3<M0[ME1;6U32g7,\#D&_C)XHL/8_V4]S_/2C,WV6CLCC0176=Te0M
_TA95A,E9ISVA)L_QKc4R0KdgY.S5L&JZQ6VS4b2NK1g)G)&Va:,(W.>PdV.?GBK
1YE_&IT(f[+EQ?\L,\/-.(I)cG0J>4d6-da4^E+#Oe[0G^^)Y,DQ?R(2Be;,>F<)
b6,>g<I#d=GF_XH\g<.Q1BKf2]GKSI(eZ;a[#NRgJ[SX6c?JC^]2[E(a^Q[7c(a_
&G3@A#5gIX&]EZ10+3=6F8YA/)T(P0ZZ@EZ9SJ-)4A2K+=^:LY]S>-4aD5Fa&LG0
;&\ZeFL[FY&U92XCN5\]N2OT<P_)R?#ST):-6/00B6gX1Z)B#:[FJ&@GL\JVI=U6
O+AaEfIOYE<Cb=P_Q1@^WVX(BeBdW93;G5>.)+eBcS]1804_>D=HdTFJ76@dM7NC
G,ZFA>@GTF),3BU0X:_If,0a,1^RT#BHd3879HQ:@bc0=[.LY;^+JC@-<QKJWTCg
=@.W3(9[RH5;c&MX>6&]O[-Z+E?dQ9aAWRG.S[.ZI(\aA@2>b+FY(cD)+D;-XHM^
Y0U>T]]Z[8f;,We;E4X@7I^UB^+X4c3Qg5H>L\2JCQB@4PA(9)FO7b4HW=bDTRWS
>VOWa?fOTZA0#\c4;;^Q17R#L6EdJ@WM[M]L3311_MCX1JG)#YL:\63f9/BcR,)I
47<.[6M=WI=0HD=;U\S\e@RZ@=-bWBbNg_EcWM\J,7R49O\=DZ1A#ScZ-E)F_/=f
C1ALbS0OHSSCRD:BBW_57&3-1:Q5O#BO?&JfAQ#:ZIQ1H>.5;CB7^.D-/-@MCa5B
ff&O[fWV4Sc\J4Q&^<&J3+0Q-,\gF4)g2_,GaOEFO[4c9);dD04cY4IEH<=9)B_b
+96VK9V7gZ3GZgU^0RKa_P1V.A8P5TEB\SVX(CDc+V9gM4L+(?S.381O/999=C[F
C+IKdE8a/ge#V#2e83\7L@5K>KA:,SL3[d5Ae5O7TgD+:4,JAZSO_R.bfDgS??-K
Ka2#->\^-Ybd^#&:F]S6)_/P=\U6&aK6V_NWa9RdcH(.F&3B,afRR4G[T0:7a5bO
M:45R9K3[].K:(G[IA?9/dY]LTEQUEfG1/Eg&/RaK]0<-9W]B3;1V5;(&e@FM[Q=
XR>B\\&gFg-?U,)4[6ACc6(VGNPCZV^R\R#&]D\c905,D?C8[/G,=H.FY>=GcROE
8c:XJ&^M?D@=U.1F1Va^-#f=[>4\O,X&)_+eY2NC0?Mc[3S9G#;IQ-3>(bV^QX13
1TI?+]6+L7&;A#cA6g6-Q[&Q<Fd.VO1/8.Z_W^JMIBYcYfaR#<MR?QE3Q;3D=\JK
WX<4#GefU0ff3B^ILUL[fJ=K97IT8NNg6S=R>59HRcd,0?;b2Q0#)QVdQE.^I\;B
WNER2O-@E)OW83g3DZ4cQEc-a_IKAUA6,+02^V4YQbPL?6X2SgC;)IZ^)cE<=7Sa
^1#&EO)VcLBYb0SKD@Xe=BL#FF7RT3,>g5cZ.I+KNY[BPTVfB^.4WfX8<):M/,9_
<\C<;SLFHNSa5JLO:)AEaG2?.5cdJJ<>F7TJR(-(6E@QYLa/S+RE2MD06)d(L=?#
fWA#&Rc@aZ>DcaK]HFa.L/8X#C3<EPf>9>A3a9XH-I[R,Gf.S@GYF(@S-XVg\1TY
>ed4G##d=+@Z>L>B)bR5OICYV;d:&gEc_)?^UYg2Yda1Z2ag]FSe3+G5>7W#5IZF
IWZaPZJ]I@,[aF3ePa5.Y\)6f1,A>5-77)9\9La6fP4ed54BRXLTA3_?](W@)\=b
WH0(=^N[UAFP1]6.gS[3VLcL?V\2XX=L#ebK7@#1+7A@DZ3##c+CN?(,5FS=,B)/
&?\\GSG9MJJS#G^Y3Y=Gb8:#V5ge_+?GaD^FdK+^SC]-46:E+C&JZK/4IP[@gG&E
CHHeMP^ZOLZa;eSK41@#W4QS3ZOM[WJL:RWHb0J05KRTI\-+XM,#Z0(<FJaDA?;D
2Ee2TFaC0REa)3.g;a+ON;,;?EfC15H3\A,>@9<CTfg<bZKXA^/1];_OIDg(.KQb
A\=]SWCZYZWNg_:>4KWA]C#12]^MHa?)=fBTW:cWU0H7=A(LSI]M>_BR6H/S]HLT
?f+VG7L9f)11B;=IG?E1<^K;G=bIb</efUB;f<eQSKY&<Y0C5<R8KAM<+e>3_AJ<
X\<K_.Z)gVG+:.NS&-TdGHW3RO<ZF>1>,cdVdY)A)BXN.4>Yc/g3c=HS/C-NCG],
^ZYY:3D^[QGAQ4dg-9J;7Kdf.S/ZaA8?fL817Q)2e\<.Eg8MQZHYe=6c][]Y(3K0
#a>=(#4dd@A<RZT7ANdRVeIL]<XE&X+UW--/H=<<O.))X=gK9&U8X&,5L0QN8@U.
Q6aO==;1F(&MQO81;@PaJ[OH/4b6?Te-6721_,K<HP08M7TUe@<-\aZ9BMeC]2VN
W1;0d.[4,J?R\0b3ROc?[+LT19M,H9W-c9SFfT1dR.:f(f^A0<>(+4,Nc9AE=L6S
;f4ZDc_DEW/:1\93KbOPYXD;SY7PC+f;3?EF<bfbG62_I2MFVN4G7(V:>CNcFV-&
^YXCe)/8+NNG,:>;N>\EH)[d..6.e8P]3UR9IJNY91A>aZ6=CU<DeNMYB5BOT8&J
^266<4<QLf]/KF(H/Y);K\U3bSdA:M9@Q@2,RI17F?I4,0Oc;FRQ7fY(FBV0OC]S
_?cQC)9A5\eJLg==]\OG,\&/N2d(^a+;]Z.;>e8L60.Q?K+70COZfSbcZ&#1IWSE
/W+]:)Q]a_)[AgE([c:08RRHK#B9[@1K\GeHJ1]H9e)V(&EcJPLHU[+1MD],:1ZC
a;U[40G17C^PP0HA\MV,<cSY:bW6@e^H0Z1R4e97JT\6M#H?]N)R,5_eceLb+FA1
]L)U[8O,2<ZT?\,aS<<@<J6_T)]0I?_,H(4aN<;+ZY]RfdP>L.L4:_KXc^aLfT(,
Va;JA84e,Y5D(4UfY;e&a;ZQ&M29a9a;UYB4T:RG#VA(@3=IO;+MF_96]Z0O+Zf-
2R_[Q::43BgRN.?+CK[Q(ab06^0UMXL^3G2(]f41BLT(^S0+LVH[=e89PY(C+(NK
=FF^TNK(ZMaI7gV;GFP,4>f^WS^\O+abF5f-HJ853YcAOT=+#+P)^DN<4&V286#S
42N]d,XeW6(d\R2Q@I4)?&+[P+@MTcT.EZ0,bSAU+cADEJ5)XLKK-9;HbBR.9Y\P
7L4^_Rc+2gF#UEL^+SVNe,6,D<SNW;VeDW=HJG6.S@(]&E<e+dL_D&_GaD](L]&6
^bJ80U715^;#01;eHFc)2FcAC2.TA,>&82HW_UU#C?AgN,+._6gcPHM-,e1/JbY(
>7-IQWOJ_;V6d&TJ69:TgS4[Qa+LfVL8Y\JQ/=)M1c:_64TOZR^e4TdRU-NaO-W:
baOe6D6KW(BEVGIYLPOG_J;_9\.)4)4>cg/-)cGOER3QP:eKdf[3@B]V>\RJ0f+<
aH<L[]ZIcQRH5?4@)/G[DC>Q-DXR4b=:@,I-]fY+(L)64+NPTDIZdf359<g[BF67
Za:Wf/d@P:0ZHFAQ)5S4]X1be4Q0CaKbRPZYHFWGY/PF,,M6O3GD&5Ge6YG?\,<e
LHOaf/bBfM=d.fIgUFK/+8aLN.SCXB+5WY@2NeaO#XC,Y9(U?W<^&CCZYX]341.G
LPJ3=eN_8#?,_/d>7NOLd=K\<>.:,cD8)5W_NcPf(EW64fI@4@d64R\7HSgO/)\H
QP)\_X0>dI65)AFa_ae7ZG[2#0a0-4Z:>.#K4LEc_C:fN\B^#a]1KDO>=T-N:ZaN
?XGSU)D\AQ5CaU:F,2X6?4c+DKfHd9/;B&X[L<KH#\O[aG(QA965>77-e,<^b(d)
]A;=9B^#[.Xb1;.@Tc7LM@&T&G&Xgd2UeI(RT8=:+RMD[N#Hf(7\df;#Q5NT-M43
5(AR@O?/]K[=,H2+fDE,^4c-/5]ZXPP_ISc7DNY@T=T??eK^_FNG=-HPC0c.3AUF
E)1FCC)C6_4,YT8^^ZR(Va/UKf9/84.cf2Ba5GJ;V>HObLQb_U.cc6DJaGZ5J?)4
IUe-(F+[Y=NKe>&IQbPFH[a=PCMG1ZN4V.)9fS+YV(c-9Lbg5+^&Mf.;\6I_8ICd
V(Hc-I2[N7PQa[+H19MKCS\-/FY2<[SgWWdbE,<+5R45E;OS&<)7+C8;-M;U:GbI
Q8BF:<b0f<QSd3_Zgc1&AQG^FD^/NF#7K?](N+^\9A0a1LS]/fR[I9<Je:cJ[Z\?
-X9K]7/6_+;cPfJg-SFO[Q-aU3+C]4GKOTN,DZ4\eS)]NV-c7YD;&M,[;/))+^Qf
g>-WP^a69MS:/N(#eT;>#Z]/XO&RNT\&9Y>A/.O)IWc#bS&GSfe_ALcUcR>H6f:+
G^BNNgR:aV\Q@,#>eW5P;:C0L\/Wb[BI#cA&SRf_Wd#_Y>Ug@@?KH=?M2I,Zf0QB
M8@+-Jgg03\d)g;)G=0/K-5-BRHAX[eOT[#_N>O6ZT#W8<\JF(:?5Xa?EA282PWU
.=/<gOD&#B&?RL0b=GXKI<<&4UM2H17<3Rb-f\L5H4dgT.6=F8XaTAg73A?&_#BD
A\89K6]^(1\a6fQ,/K=;U1.]@V=NX.P;6_A<G<O-PO^,+QUbH<cJ0VGAa8LL1GKB
\V5fMB@(<XER)[gOCd0f\;bYP:&0[5]BKf9&/ST7OVLdMK]e:>5ER[HK=AZ(2A/T
c2.7Ze[?WA5Cd5Ze[0c+U7XW40JP[Y)-0c[c.NVL9H6?J/)(-:W?P5>Hd7bJE<PJ
HFL5@=6gV?cccCFF0HO[I[eM3:BT:U^[JgLRS\&9,V)RCgU1A_FRAVJd=Wbg[B@6
C^4]bS..--7YI>4[3=aG06)UI9S7:>341OeA-HH;68CZQ)RTE&[_-?T2R0TVcLI=
]]7eKRXHDb._6#3]RQ&ARa.3\>?@MXD:6Kd>R&+<HV]e]W2GGH+TED[ERX88.=I_
)<J=?++:AT-;f^8M>04AgdEV9)(A5XUP1Sa6fN/9H\<+U<]\/=NGe>=Y.cW9TG?W
?PdZ1(_J#;+#E@R:g_F]#N60Z1CeE6N<#PZ<FbKdJH(Y=E:N3HBY5J=YL$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_UVM_SV





