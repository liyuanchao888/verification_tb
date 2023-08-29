
`ifndef GUARD_SVT_AXI_SLAVE_VMM_SV
`define GUARD_SVT_AXI_SLAVE_VMM_SV

typedef class svt_axi_slave_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an AXI Slave component.
 */
class svt_axi_slave extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** VMM channel instance for transactions to transmit */
`ifdef SVT_AXI_SVC_USE_MODEL
  svt_axi_transaction_channel xact_chan;
`else
  svt_axi_slave_transaction_channel xact_chan;
`endif

  /** VMM channel instance for ACE SNOOP transactions to be transmitted */
  svt_axi_ic_snoop_transaction_channel snoop_xact_chan;
  

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AXI Slave components */
  protected svt_axi_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_port_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;


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
  extern function new(svt_axi_port_configuration cfg,
`ifdef SVT_AXI_SVC_USE_MODEL
                      svt_axi_transaction_channel xact_chan = null,
`else
                      svt_axi_slave_transaction_channel xact_chan = null,
`endif
                      svt_axi_ic_snoop_transaction_channel snoop_xact_chan = null,
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

  /** Method to set common */
  extern function void set_common(svt_axi_common common);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  extern protected task consume_from_input_channel();

  extern protected task consume_from_snoop_input_channel();
  extern local task manage_bus_inactivity_timeout();
/** @endcond */

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
  extern virtual protected function void post_input_port_get(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact, ref bit drop);

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
  extern virtual protected function void input_port_cov(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called just before driving the read data phase of a transaction 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_read_data_phase_started(svt_axi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called just before driving write response phase of a write transaction 
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_write_resp_phase_started(svt_axi_transaction xact);

/** @cond PRIVATE */
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
  extern virtual protected task post_input_port_get_cb_exec(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact, ref bit drop);

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
  extern virtual protected task input_port_cov_cb_exec(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called just before driving the read data phase of a transaction
   * 
   * This method issues the <i>pre_read_data_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_read_data_phase_started_cb_exec(svt_axi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called just before driving write response phase of a write transaction
   * 
   * This method issues the <i>pre_write_resp_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_write_resp_phase_started_cb_exec(svt_axi_transaction xact);
/** @endcond */

  /** Returns the number of outstanding slave transactions. */
  extern virtual function int get_number_of_outstanding_slave_transactions(bit silent = 1, output `SVT_AXI_SLAVE_TRANSACTION_TYPE actvQ[$]);
endclass

`protected
-[,>PM7/;DC>bS?Me=C<=Sf.O8@QT+5?.R_X3UL)LNNXUKZP6cC@,)cV4171@Ea/
FH<@P&8_AKZ7.>a@[g0@ZP:_76OJ^MNA,@&O8@B>;0a<>YU3._?HH6Z(778@#(E(
?L.EOQ:fWe^-2@E8f2M^<a#UG,fXD.[R;PPcBR;HG0-))^GCdRO09GN+RF_aRXf<
HJ9Z=7fJM.AK0.>\cNF-G:@a5FH5TAee<2K=1?47gIT4?-H9,Ab5b&Q=1g^>O6)?
f><#&2CD^6cf@4:T^eaZB_(-BMgCL&^FV8\,JJ=^R59LZ+,<K(RQJ+7[O7):]_-@
a.U=IY5A/,PQA:b.UXC]Yf;\Fa7G-][JAfBS<2[OYc234_:>8@@_b4:US#RWXSKK
.Y[24SRFF5PAYVYC^=UQV1cgB_-.PC?_O]LG-Hb:M>&URgW:,)ZV0N)4_#^+\DbD
8VQSdC\=0cE9af\+]ga4>-.XA/c@?7)G/4DJ<Y6FAJI[Ce36e#IB.5?fR1TX?.(^
;SGW8.\0[^O3VCNQ\]#S@GT?]Z[aF+GZ7@=B:?Aa\)B_<[C<S9OK++.0+USPCWTF
Q0[FU2Ze#A<U\9=<MV1X7-A\3ffUf&65D<^\=<YZ8#a]XLM@ef?N7N)?Da6F6<U4
F+,_K0cgAF;N@0.1V=][)8<3RO#J6.bI&gVB@I<a64H&;</YZ3AcM>;fTF00\T=>
J0SOd]-Cd;+bZC[;TCF;P>5\AcIf1]^^KDfbg3;)SZ2WLIG9DHg6b^>KAd>L(19c
J2MVH[[EHOdAJ>JeGRXGE\8TfCNK@1LC)OL&MA70JYLR/g=:W6c<[O\9/@Ud.::Y
eY?6<fZY51=6IGK?XU:8cd7d[dO2.,:BV/?YUU:L?g+ILJK1\fa/YM0U?=;D+H@Z
]@?,I0+\NG;b7K:cIIHcb]8\GK<H5]L,Ae:];RUaQRAEJg=T/<e#+C[IBeFF[WL&
f58O--+@DfW^aE(b[KX3Y?@60<351R4]LE_&Q(\8I6ZE;^bS;/OZ\R;5Q7&]A\GQ
M@O/^Z2NBe#1.U,SO,(Y@.#2MFF)3H;O]033TE5VJ5f>+DHQ)\FC7N6TCO(d80)V
3HRJb>3MXGRgQ7f^EVMR--QADFTH-B1A4_6&:R&WZK5@4J0A_TafQ<7bWU(RaN5#
W0YI<<O5VbG,(GaK(deJVe\6HX8YH9N[A5Y9@fQO/T<4JI:SV1AJ&VL>&&6)cM<3
SWR4FOJTZ2\9.PK]-&^Xf,9RJS@V2\R773CdFeJPF,Jbd4@1>T7S\E[[JaL7.W#M
dL.PNaSU<X1^MdHf/TUPMONXM3>1B9BL]>cd:c<KI(#<)FcLcgZ[H1NbTe3(0U1[
/5_P&OecUTVH+7CLgI-\FT8TS^2MM05EXa,8UZ=G4/eQ93.c29V6NWILcebGRQU1
f\<U/A=fDGAbKdMU+FKeC(J^FP4g(4]57822I;9gfV<]V7C9)[]+W,cd5+O=@)]R
:S4RZ4LD>eXOS)+9^KD3FL8KTP2,-+U&6+\,M3dY8IU\LDaa4.5E.dJSP^HdfOMP
:D;9e=E(QR]/IKXG^JDOV/1@SUYFJ]7AEW.G.C4,_]SEI[P.@b=60NRH8L=K7)<@
b/UOd(?1.E0O0P])d3Ug20,L<Y<7<MM\L0g:c_E5=M\;]6M0=<5:OL[&cO[9CK<&
A-GQ+gW.MR<N7^R(3W[/>;(UNR,W=)bR7>?L[B4UdR<KZ(KE3;UId8H0f)RAf53A
2gbcbBK#M<U4R-.C#8GS:S:[V<R#Ca4=[/FY9]RF=HPd=?0AQ\eR6DJ9<bE<160K
DF(E6G?D8[[F^SMK0U40f3Q3WTFIE.6POK?U+;N(=@^GUM3JO<+CS=cPYEf?6IW/
/Hb-gS.MT??JN\c^5Oc#4@4G<2/RG\_O@T[@aHUOER-JJB<68c07V(2H.85OH8e4
JRPY&:R4:(O0T9NUcb;N]6R\-g:ICEKP;$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
/c2EecDO@QMJ9:J.N:/C;GJ^P_V/86;)9cC84,^162A0O)QQ7b9;&(?\[^PcR:/D
I(F^MR,2dI;[:(9\9TN]Y)YSSA(AI)WB,E\;#eO-<X0FET08^8(\DJ<.)NJZ1X=6
RH.4Y0N8_^BF?(7PKb>I@f=0&f.N]&0Qcac2U,7(UdFA_D<N7&7K[e/A,;XJ,LJ7
4XF[W4+7U^:bWC_?BJ&J,\QN9/9(TJVRK1A^CfHHKc)83YQTM_f99YXT;HLUESYD
[DccSHE.U?9#-IE\B7a[,&QVAL&3ec#0,fHf[gC.;(RNU/GDgV..(WYa/Z->(,fS
FP)JXVa^LGV#FG43?,^LI4/6aX4,_))OdVRZcUEd@K#b7LO6E]KWHL;I_XAQ0;O9
UC-b(e.U,\Oe6<5YXAK^(b+&J1c6(OKKPYBe@g<]4?c[UJG^F?P-SB0fbaZPQMH&
VO=<D]&I20P@0QL0gJ;AR2BL@THfQ:[3P:H[<XMK=W?\T14\#Da.UEE7D]RP77TH
63NUAZBTU?=HZ^,d7Q6H#faE1VPOcbM\3e[2\75e=R87&OR99)8HOG45PeXTYFCB
?]B/E]:,b<4BNNN#L,<8.@C66VeBSbbH9N58(JMaAb_UWF&8.aF#FKT(OaE_e1c/
96TKMeO;)2.IB=MOIEA7RG-N=H,+>H28dP8,@3)@YL[,Z:)D?E:=]B/cNAM4C7K.
V1aJGAUaJ2L@N+I5c4/U=.4X94:7X(e:A,.Z)V8A4P<>RLOQ@0C>eWSd&/<=?IMW
@0[A#D4/#;gJB:=;IOY\&6O0KWa_gHcHDd-5JNUYA=]\S&\/S7EJQT4,9#K&:(f/
I>PLYEfU>I8aB:DZ<+CBRg_6I6_JN>FE(EF]OZI?cU3:G<L.NC-8V#UL4\<:/5&/
64(4@HWF:ac]4c>\DDfAa7F2[dTK/XS[eDa&?B[;&741R\(QD9UP<F_[229Y#TP#
2JQ3KgM9H=EI]AKB1D6^+9K[O+R?76Jb,94^+>O37<>a:78cbB/DY)C;Me/N.B2I
2&]58CMa#9JdGLQ<f4^<#?5BD)b8HN:W1@JI5&9J-?J7W38]^g:?/d&5D[Z@?KSH
a?fIge.DG7+-_ef@5+B3a76/@@0A#AaAAY/H#V^A0(=f9\2GWe0=18@L(BZUfSeR
-)DK.-@;Re0&_KWT8->F841^K)0&WP)>@9H,^0JM)5:>VTgP<a.5WDH[T^.2BP)c
PHS&EFW5]fMQ?F--6fU??I=/_\#O>g?;UB#He/9AI?A\YR@H5+c?MgK\X1.E?=g)
D(D2MC;C),#?>4=Q=EEM9e1ZQ6<190]Yb[,P-T#?gg^;+6c?)aKJ/HDcIN.O4\4U
?&gfDeN3=H],D-LY0))#OM&1OdOMG#+EX#)HNLd>2VVf/8[Z,,A<^/_.e5Q0-F2X
B^(8,^7]AQ\KS.ZQI]]W9NSL?V5L/S<eQ+TG<)R]4a^H8[CZe(TcD,Z1#86c?H1:
-.,NQF=#=GFAXa(7;N=:V6<1FI13&[#T0_F&F>-]P43E7_IP^^d1cRF/U+2dV>0K
2W&B(IFbHP#c3>G1g2.MNB)2Q8((HZfc\ZPFV)cJ+#(bc?#L_0MWgIA/c(c4?g(W
@#)X5b1IK8S8eFC-1ISIA00LRgP]ZXYC],0=+.WW?a2M4,-NgK8M:6>/3eIM0+Pc
(cAZY\1J0F>6PIcR<L(^dM+D_4>1)c.TIDOM\<f+6]d8N-dE/_PT7)dBLLcUJ.gU
/]FJ+YKcJ]M]GBTS-@a4L1^ICR4Rd9UMfUHZZ7KAgdEeFBUMT@UKM?EA#O9X8;3\
N9eU5DM:)CBB^&KbYY[J39^-,M]HX)cN]R\Nac;@@5T8VeX&,CJbZbFc3Z>OXGQ?
40AD+7RI6>#f2@@7Gd8E0#cB(e:gA>[A1WKG?#0#6gTb#A?36K7gb?GCdbV;5N+M
VQg2N87c/KBOF^F(:<I\@K@Mc05#;46ga2L,E<F@&>S:BK\\M@,T_N+=<)L4+9XY
32]#(55XLUW2a)0RL6d]8;CXTY@Bf_0ZPCFY##U_\=&H))U;(=gEb<BVNAI4L<W/
?RDAQQgSd70\KZ.BR]KIMNF3)L6ZDFF\]J]=/H.;4fQE_S\T?aOc<gUM=7(8XWU5
a,-)A6(7LC:E9J(bg=Z+(5=0cgU2eb,(S4VDd/_TRc9\0X),@D(TUX106XgNO:8K
1Rc^\Q/,?HEAUZ11D#e(:KdETb7a^;a&>48e03-?6dX99g#FVR7[4=CS+-cN8VF?
Z,-gPT;_8.dd1<W2F<=@e&,<7&6=0YENFf.^d@,[@?KP[<cCDNU>]bN8P5&:J)b7
@9W&MD+_I>PXQ)G&N3(:D^M>]7/(;@=>Q_Q\(X5M&546CU?Q6V1adZ9[.XG.=CF.
]DZZCBb,c-/FL(O._^-@UNHEJ.3YVO^8K9X3SJ[&-(a,\87+BSWYEE7IR_,-,U-^
aSTSL#,YcF_>#Pg(##d1]P(HEa>SRZ5CUQ];I&RC/W<<SE:W#7K<Md;bK+Y:\O<E
DQ7/BELAf3.NR4)X1DG,5T470EZGg5-]8aH9>+f@E39N/O^Z-gE&=YD#+^&,@1@-
6\)J?M;XL.7Y^G+,Ld6#J]/-NdbC[;7C)fc;8M\(R/NCd^NKH-OI.#&@c1>YWDKV
[][/U,De>(B(@[\0fA&UX#]J#aH4U?FbWZ:F9YTWF:UE4L)R<a<HP700^&BQK<^:
3B0BadIJ8TG+&+e&.9F70_;MBe6g;\d[-(;:=1UONYS8/6U8TT4FXE9(E(<F^L.Y
4,0U9JI?[[TIA?S_Xa#QgeC[@.<5fEScILR@(Q5e@V_1;LK58CUg-<;bK.XNQ30@
E.PB=>DJE^)OS+MW+N,.G7;Z()R.:CBb,J8/4&.+=<N158-\?EYcBT)?f]5<8&[c
7VdZd/>@ECYHE0,TD[KATd.8]>3Rd(MNA3E_Q;8BgVP8/(U-5/<>HO80[=,IKV\L
@E,f)8>H).bP76MIWLF6<B9IA3.VdPXIL?NBH-N\HJ]Pc1((cA#DQ/K=FD_MdPGZ
^-F3B1&OF[[7V(_(O7OFTD?UR5+_1T2@R]9Fa/O[Ff4.+1a2M7<1?DRdAIOY>YOe
R#SOVA[;IJ&G:33Z;/,B7M,>3gV9cUUR>Q_5HMH6B?@5,R?0#]O<KI/EJ_XaCY)O
b2SN;=(Lb\VXMfX=,9+cS(4M9eb[^GA0(gPC843Q84(fR7&C^Rba^\#RZ5>=Y)/b
g11ZAJ8d2MEdIWLAeS<cM8:/c&.;Mf^H,FWcK5=9P?XZOG&EXgN?_4V3I=cLZERE
W>4f4b.XTE^8WSLcY-XWP:36D&4L8+Z)+;ZB5JMB)G>=(>f7PaCg0bS6U@60c@2_
@\=D,:G^G<+N6Z6OEd_K@<5Sg=Oaa8Gc(CY#85SISN#FgK#\KL^BRfNYADBP;J>V
_bZ]CGTX2,K6LBScF>BG[]/E@3c2:fc3F6:+82>/BgZ/g&9>VaFUZaNM?fGQKQH9
6\)?>L>g<a&2=fOA[_2O:M.fYN#BZcf:R77[g5)^>#S>GYRA3G-/ccMX>VS.X>_B
a5ONC3H?EKgQ:@b4a?:Dd-]I1-BeUa\e)FM=O]4-?;]1WJ49?BP=3d:_]gC+5\gb
?U\f4f;+e_YdIQ8=11c_W+E+&O6<@<4eXA,C:gcB\@R0+eTLCG@L>cZXG<D0dd2[
fTW01&WPX#X2Z9Fg>#V&D&R<UR_WXZEC@,ee26F(cD+?Qe8\O4:IHK_\/IJ2?)H=
CK+Q(TbRN<)RZ@6bVG>eQLeJZcNO6PFD6-8+D2IYJ:BWI7I:g4gL346_d8SV0V,)
GR7]8#L\/#M5IDe<&g3(ILD4HPM4WRLF9f?),D5MJ+QRL2eaZT]:/J\XB\OPdcF@
bOE:<4F5]T15E0[^?R-1,:_Uc2Ua8c@L+)7TP7IE.gd2GgV9S83daPTf[?57?9=Y
DXXVI\&/J53@K<1<dDI[0-,H(BcAV7dIG40A>QcM,I[9O^W(L)+-_NOUdP19I&GZ
4H0Jd,W+?NC-_YVQ:0V_UF1?MOA;3MB<c)-OK1aRP;2BA#N@+WF1+/_-EPaI\8@e
d[:#_Q<bf32#K\-K0Sd)0fScN,CeH4BIa(G=Ub@TJU(-9b0[#6bdG+5@=FJQ1.X\
JC\TM>\K:<NB4c&6I]5W,UT<W9FW:Z-_fC:-g4:?K4Dd#;[7b3He_&,0=35A:eZ,
RWbU#LZX[8FGYO80ZX]46ZO27H][=,QOM@ST#YT_I@OP&:[-&S@e.X604VMJX9g@
BcJ2&7)L&V-_eH-[:BQO5Q>-LO/M,[8O0=48M>3N:HAB1fUMUK2RN]U+-)2aG2==
cBEVI[RX1:V4a-[5C/GU<fF-?[<(Q^e&WPGHf:5^9[=IeKPOVGTD_g)?FH@1XTNR
U4-^fILGCc_,T2@RHdZ:PHW,=P-R>2YfC,A#V6A0XJJAESX<:SM[J4YeM+.B2cNd
;S@/OcfMWT&bR_/6I;8dHHV9<>0^]NL)TC2=;Q@WH1:1;A+Gb>NKB4-dWJ;B^M>8
V@3QfP,9##0HV22#N2U;ScBPR0Mf@(aNP1_:+)[gYORW]3#L9A;4LZL6\PB(@0G9
_eB.XDMS(1,B1)=c481g5AN+YK(J6S[=/a-,)c4T0MY<N3g?Ba=bW]532V\HH94W
_d]CLaE(=gAV(3ea^]#3Id[.RTIeR3I+73@BYXfP1Qd@PE[0#)M5=\T,;#HQPKPE
YKWdcaRb)OT#e<<SV&X^a:&=a<CYYaR;;JR,PKO#9=#T0#A./DO.2NdBEG\_c_DP
^&_3)6?X6RPQ,V5W(Ec3WP?.)[1T-M6?^9U@+ZW+F=;RPMC9]QcQK/=g9SZ(#&UP
,?&E#7#b\W.@JMgT&D&KTV=e9e?XbOa22U(LGg.,aA]XI1+S9&A_\QFW09d2B:RA
MWCSKBLOeZ7?S)-&@(+GC/(,3E:Q:F&d#=K]5g.;5DD9S7M&BFJ\K2.2E_2d>,?b
PU#B>0HBd-Q6d)U):a2W:E3X@d+,8RB3240#cS,1G#^De;=JR/\;K/(R1>AKFNP;
QX]OGL_NE/gZI:.)N#Q)&8,2PG6>UEV@,>e(MC.30R@\FfQYdZ?WgPd5TE.\8RP]
0VR7PMGF^Y0F-O;MRDK[H7A0aJeTTNcZ^KSa_F>[8b/c/S@6H;)9L#/5X6_X#+UI
.N8LbX10IB4AP.HIH@HQ?D0/LRd#,P48#_BIF\2Ra&5df5SFJRHRO+gU,Y,7NbA:
WRbDK4#1[YfUX40^Y865Lb34/?]#2FWW+><S1JgYR;5[O)<Ba,&1SJ^D0b4YW)b2
F^F4M.B1[aRd7)][=R][S1eJ&.Pa-d2CK;)dDFO3f9d1aD3R?&JV:VbGY@XA\d+)
PaeF,T9YCfPY5X1[YH>BKY98Jg1dL8]5<VRPD_:2F+YZ:aF:I1.(+.D\XKLc^e4=
&9]a7e4DbPH362AY<Y]Zb4V&;-;@g-]\C1^7(f[ZB0PHOf_aR3c)T[TKOEe[1g;V
DN@U3fY^EfT3/TI4>BH/.Wf8X\9ZP>K?,a:L.T.[/P1==F?[Y,./c?XKDDWY8C0U
d.-eBY>H2-b6EJ+3#7^e6T9@Z6)AY3a^Y9+)VDfSXAGf#I_2?Y7\B,/PNb-E=OfH
,991-^JID47_[P8;]##G\?1PKDCP]DXH^5>=2?^eKc@:-f.f]aZH90-Lc1M5:&&F
SQTBC96I,0+(a@LG?DN2c;+480e&6W93Q/CZYaN/_MO)G5XBT)C-d=MZZGK0H_Y>
>ML#[JeVW9HCVD6/9O)(ZW0g/aWRf<^4fe4V/2NR@E\g[@A3V(7D.eg+/SI,)+RM
5T7Ce0VO35c8.</eWWg(E(?+BE]=/RHQJ9;9GMbR&T=;KK;9gRE_4,[E)0\CCI=?
RN@U(YUA-_C2&&0aCaMgT)bHfAE8B+7;fdK/K[0f=TF=9]BCQ<PQW+AZeZFML;aE
;^MN.F@DZ+.cdb:7(/,:_GNJ96K[Y\^ONRH&\?4(IF\K<QUfMQS\<1f(MCG=(NF+
NVM6BYc4OC+UaS\:DLL9M>R<Rf6d6Kd^gCBU)61DdGd^X?.3+]XM57\MP8JQ#G\2
,KUI4Xg6N7//H+b9Z/LZ3K?O@S2@BDA(FP-JIYYOB+f==>A?-^]R]YdSgV3+-)7R
(H\X/M_Z)>Ff+H3d7.37cPXH5M<7g+T&KcPME8R6<2?Ca&gg9XRFD?&D&H(W5Jf5
8NY2,^R-XANOL(0R-#8?f6843Ba\6)G=EA#2JMe@GK[eZZDW5a\(<>GcaVI/M..Q
>];#V21T@#dO6_K5VeA,WPG5c(W&(LYF/-[IT;S#_Q<#LVeZH4P@Uf8WW<;dTV_Q
;>UP8_He1BVe?QFT.<D-)3K\@-@2;TO1Z7TTRQWC[:,9f;F6?MMfEIC#RgF282P?
aWL;GSI8bMfO7>D0L&OfS2-8AW\53#.^--#KVSG>>LPYNCV#dKB8MAgZ3HJ66P,f
Z_KbF7NIeDgJ1+EA[S<IZN);ZZf&B=gRHEfa3#+a_4C3T<9:-ea2E(:_3Y)OC7fY
=baH(eAeUgN=ScR#PdN-][0b=\UPZ14_dTW:]gFI;XF1A9XCKXG_YRV>DUE@F@<]
Q<f<bZ+B<Z8-=F9KKNK=gXXa(OA2bZfWDM0cb2(BbbMaF/XLf?g#XJ4Na6B=cLB@
YZ57+347/1OP8G6VEF&[;[Y>-Te/:92L8-H8O40EL<;=K?3Yc_6)bXG2&/e#E8gK
ag=&RC)CT\:.@UIf+0_Y4R8CaNWWI4<&@dIHG209HVS47S:d5C3UP&60Dagb:BIO
A:+ZZZK0Vce_02ec3TI?\S):)G0O[11QLT0G\&=f+G8GT_<W,,@Y[gX<XPDP2R@L
)))O1MNMLSBXX1\:0DZTeRAK/3=DA(,@3LYE@\^(<^,&X/>edY])P7DOAe,)bKd6
:-H_//KJ:3>0-cSWFSWAa\1eC1W>Z]4L3f3W<2GAVY7LJNWVRK3eRX0-.YI28)AF
e[\?Wd\);60:I2I?2;:e)XbCVffL6)K\b]6L@UP&?fJT>5T8^.F-:e2VIJX_G=(K
b#cO63g6[B-Z^baPDB#[&4A(CQV5Kc9BL#\S_B69[>7WIJbDA@ebNJc-LF&7H[\7
PJ5<QI//?V-b0H@@T^8((J^Y.W\)/[4N9Z-bOa[dfPa^BC?cMAg/[V6WZL.B+KH:
Z^<E/]BZGD_@R:XXSYa)-<VMA<]_b,9Va5Z/<c=gGXNJB,J^gK9W9@Sg##(?_T<J
-&SN-JQD8]XeR8Cd\,JD:HdHcS,Yfa_<a-AP1ULT9WVTId6:80D;U7]ZN+I+DBOJ
/bRO4TWXbdXdcKZf1=49A?=Ub,RDWJ=ed54fQ:65\?)bGS/f&[Q5Nc8b56NWLf[C
NK;-7LBTQ.DYd&+/<@>[LE))I6g:SEKC9$
`endprotected

`protected
J\Z\FE5RW<(_;E1UXM:.,##Q[=1U:Qb+0FWSL@)Y6]4&801<d#LM.)).B(N@D.E8
8>+fA2Z-<6FX&e+9EW6&<4#Q3$
`endprotected

//vcs_lic_vip_protect
  `protected
SQS[^]f??]VgW/9(2_.01M-FWEH&&C[+LH[QJ##.;/9-a)cga>&I-(KG[TBM;]fQ
Y5eId^3B](3;f=3&IB5VQVR),UAbE4d0E\KCZ^0F[1O0GQ1Vd=_@cIW(K4ceJUVQ
QMM:cVc0/FKSVH>eY-;UE83/LJRSCHX6Re9JYQc&Q9Y.1@+KHPYLV,\1\:TbXW,e
=^CA8-6=eWI@-,3aMVZIA6(A79VdXO@P3EM;cY?HQQN+EEF+G1NcgDTYV0V[+(^@
F@\XE?IVNTR^4Ea)J#-&W/M,1e0<#0Hf1U25AL?Z4U]CM4a?f9dFY#-B9[+MR^[_
&g^aP],E4=B/fD35),J+/OG7@6b<H<V+1K@_D11+<8&8SAD0\D^BBE7b^38<<E3O
3RNI(BYcFHd_=eKG481S?4+N:-c.F5a;JFKE:=3dY-8EDY,e\TMQ[S+>^D0d6/fb
RMX)GQXQDRa=,]GeHdBF-4Ne-?e:0]YC<8<5F7@_<Y&BOU/0-EE_Y,H_X23Q(-3Z
1(,:@52NGPa5N[RWD7=c.NDRP>90LGTC0#E^GgK<g_LV;H@([4YU3&B-2#?ZZO(4
:Y+V_#9=8+N6=500XP^3^-8H3KLMa:fZH,c4O@/DTF(,L=VGd[F,^a3>0V,(J>_\
@=454QP5Z8dD?PLMcAA7#V<#:N)Z1?;@^CcA/L-96ed#YbWTEI:K.P#UV_?&/3OH
b+)OaCQb?KDL\gPCU92HI>RBaaT6QX-d:@aE5QC1_DAHDIOb([bH?XH8Q?De,^P:
)bZUd4H>)W_=A34ZW0ZRHXab4cF]86)YJJc16G\_J8Mf_c)(<a4NPGYg7VFZ(;NR
[ZEeDaX)8F/3STb;#+b&XaBc+#-?aXJbZT@]A2eEZ6M]Y@7g8?O83K\f,1^O).H,
SKWUWcGWI^S@bY:53a92GDY\LPSA=WG0GEf5,729XL<6d:9P25K;T8_b6-KKO;>(
bWZUfQL)SF0MbILbH)&FdcBgHZ&H_I#Wcb07+&M2&E2NfL,-IK[IX5H2/GAeTFW?
G7B5c_5-;4]@S^Zb?3B?0SD=+f\M:+@8_S4]-/A&7TA-E=)6GK>d]ZDg.VV\dPZR
81TfZ#bUT<LS,RHHd2,;=&@cB3]e5EZ]_9)=@T1XV0W_(VO@.8\KAA03>8H+.=Yb
T-\27J_#CCN1&c#0Q57H2P&_TGSDe1CI4Q[U9:4:c#6,Q#(NBOe>G&0&^dN3QMGf
8P^<C5^(OT&RQU:.F.[5)=)b.W3I:SYGMSW7Pg?]eb4K?[bbJ^OM\KYAcZ>eONa)
OQ>W1XKP>>g@68Y/?CIKbI<18>6#NPfFO>g&,&\G;YgE2Ld6>X^1eQ2:&ge3b,@_
\M]#\/4@RO/,D2Tbd7H](_W]/940D]GaeFd,Y:04[^M)Ne?.:XKc8/\]AHaQ64H<
P#f9U^>AaYDAaHBg1=R>W^(Q3GCS_86A8KWf;aWH8MEa6R2,/)<f(6^T21M?ZV\H
EgR-c9cIL,S1aJ0(M]\HJ_JDJ)KG;#]1ENR-H\bc)F#+-3Q=L#.KL#LO;+LY/2Z:
L57TS)Ia\M0<FO,+45ESe9E(30G>WOI-##U((XV1CNUPXCBXSUaDL#dN0J(.,HI1
J5CMI5:WEV<cY-8+eOa]/E@0?3aOWG^aC&Fa>]S0eG0D,7RFe1FV4]ZEcIUcZM<^
dL]W<A5]f66BC/YE/E.K?DdW39+-YeZ,[P)fRZ7JA+91AQc^f+[;,UDdL_eZ1[;V
4HTL;BA/:-</JeDNc?/>-8+JbXCaJa3SYGY3f;e>JZX60_DT1EZTXa61TC57C9J3
3<2&G4YOV\7OB54C#Bg>CT(N&^Y<Vf>Z:)YU=_0Dd3KL>HCbVgI]+b-d3gI@U5.N
\]E/V14UJK\f-NZ3298>RB4&bNB2AdQG(c:<aQVILMO8PeQD_Hb96)CO50E:^,=I
]5,_B:2G&VV#R:a?bS\5.4<K+_Pb&A[:F4G2#G-6M2abF+L9\I/<S[Z@(fP:4e:c
017TF3I81?2-O2WF&M1#D=dgYC?eGOL?O=gc@]15XSN7e9U=)?1cK=bgd:5eJc6:
\H5DP5Ga0=>8JcTLBdDJC79(ACM\[9-A\^^(LefbH:#4D5I^DA[>gXD55ZCN/)79
T9bRH<8/7/d8[HN-0-I(,BD@)S]SfbBSPV4XL\BXdCOg(8gIgD=@dDT\^G@T2LAL
^RL>0f5fS7b[4U3ZX/TF29DE&3UJ?3<:(4)U/C+b+P_NZSgNLV]FC)D&+KR2a^ff
c]\OYc]7-N/9,eOXYDI2X_43&^b?ZWNM<Rc=e@-^.0/QQNaI8)IYC/C2(Rb(Z\f(
aT#H53-9@fJ3&e[_G36AO57;f;dQ]:=eZaKQW@1-LG\V67&-1GN;O@C0&Z\Z&W[=
=b1N3T)H[G508cY/PVJ5:65T^F-E3G4YIU<+/.[=(Jd6:(G7:c01da1cA7bED=6A
()HFTTF9fIQG/+g1BT.3DW(:Yb]\[;@#b+[QWE#P28-c>8EV79NgBac&NdTS_@1Y
?S(2de=A(7]FPLMa0&+R30C[SHD::D&3dA^UZ0V+L5F)R[A-WdE&G;54@\87J@_[
b1G]cP.A.aR98-B\X>E5,4)NM,(5L2?LU?)ReE4F(:?@(IZ((J9gZ(1#)O.&,#DM
SV?;[?1JID=\@S+fdJ+FSPb<QIR1U=6KKX11YM8+1JY_[LPdf5?8ADX=QPT2X\c:
],PO,&\-NWG9HgE&T/5]?(cPM2#FaNK=QOdebKgZ5-ZQAL0&a:AH53dcV6Q5;Na7
)4IHe)Ra8H+MeWR[W\YE.]5Kd.IfQ3(C,4BQ:]0I@8OKaObD1:V28,?VU]V_.<+K
8H?^U,:7b9=bOc29T5TFf-@X0V:a)P8=>505C#42)f8GR0-:)R7+/2U>KI)SJ]>A
5WF8e3;JMEID1PU6\AUF^.8XJQ?D/eJf-dCO?;c7\?99;N2ATc;g1,<9?HW3IL>L
7@a:H-bg5aE,<(/5LC924?\JK=4=N/E[LdN8MScXH+0;PBfBa2\X1:FI?]QEW;eg
f2f\73FRRQ#897_>a>YN+Fe=J1Ib3;<V:BY_AOU35gM5C]FHHV.P_+YYE#4?\/BW
&,(^X(f?]?<_8,>:,CB]SQH>NG]0,LfW0.aQO:V.0Q0,06fV5,6JOIW/\XMSKg>2
CO&NY.QPFFf\=<gRDM,U@/5VIg/C>#GF)J-P]HIg(S^0)B2\dC\g2_>>(HNJRJMG
?/Y>PM7d7;&IPF=31c?E\;<.cML>F_Ve[7AH/C:I-RC7=f^40]?.UEQg)ZFZ@R<9
G)Ib4S=,\O+(G/L+E@C9Te2MZ[R54:I9,CP?(^\7GQg=ed257\.IEYE_X+-&4FIX
CS-G;g=8_XG;37K3TfHZPc3,bEQ/A0Rbe2+[[TK&LL5J_+1PC1>VT=F2>>1c&+C&
IYMS7U<-:/K3P&P9PLEYeZ8E=;GJ\5B5&U12]6..O=c:9(U],Mb)4I.Hg2X)O)QX
<8U7R@)5N\Y9gId15I/?Ic69?,,N:<3N1e2f]U)2ODdV1c1L,1Y6^9CKKXTYWAfT
Jf?UZ0EIYJKVN7T+/UR0=AF^P@E(;E;eERC-bE)>gP,^WJ<K3^e7<+QcCMaJP+[L
J(T7RRI6b&](TIb;/RfQD^VB.@6;3W)_(D?0F7#H&JI^.d3[\Ce@KObb4L)Rf1Z_
UT8S[fBa+=e_5:4\NS<@?A^?_0NZNDPBFV0#12.U/94eU5N3b=M6ZM+WEg6DQL8A
9fM&@XO539+JJ:0638RI0Xf9ZHZTMKU]L<Zd:C\BL/M-B+#bLNC-QHT/+?F5O,2V
&ETKK@b^51DgS]YScD:&:@4a&a@Zb^M5;=]X?NaIPfe&:0FJGH.I+=de[Ib=,YMf
d)c_Y0D><8NOOR,[b;db(_-/g&g^M.?V8W3O?g/d6MH8H3IL&=F-.Z#Lg6TE/e._
J8E,?#UV-<e7Sd/E\0CROe]&K637X.LLPd:R02OM+Y:YFL>U8UF+Q@AeY_-H+GQK
F_WPC\eH2J057T17C2RaN??gf[F/8(6AJNgN&/8[dI1K<W;\IRP.Y1V5TDIKHTB9
U^?HMdT9_C+]@FJ9JFgc4\U,/U4];.?J7R?,^eV?\2_(?Z38[4;>GZ#,[5e-e0_]
PV?>C&U)#Z:^H>27M>(#/P4CO\Yg-0UWZ@B6.<3Q,EO3]gE8K<bBUAE,^6U2CY_C
&W=,,UA;K2Q-IJ6WU,@Y_S84[(_(TFGMO.Q0,76?K.+LeDf?-8\6N\?-0)7S-/b^
/_g@5;g:SL99Z<Z<VFHIW,Pf7f(_95P&I-=)UMK9YCAQFId?D[\J?;E]H\P)GM?5
8/^J\E]S&FC.,\.S90:ZO]D1fDfc35^BT+IC@W0-HJUMc&N&FOMF&fO^_U?\VVSH
/33_,2666/B>0GNIUT>[2M7_2>P<bK<@V;N&IKa/3cW5Yf6)GOFJ&32f;P]KV]6-
?-0TQNW;8bd.980A1/W@(OO+f4d]OV&;U;G+RFJ853G152Pf#JJNX7+(S)_Td?,H
YEQHE+@D70ddB-F0/QF],M/K7EB)DS>9,IbVKdb.9OH>E8VB&7?5.e)D.f)]U6R<
]d33R\@bYVCDF)7Q41;ONKZSCGP4IWf_Q,UF1K5_05V4_CVScPg<e.@8C&_2O&S5
cW1U^_[H?GA_KW:e=H\^)50WBQf:YST;YZ48EbQ)D1I>fV.cOA10OXXYMEY@)9IS
GIBQH(J\105Y-Z(d1b#,8cH5UF#ICVR]BZPc,He&66,Ub^MeG.DCHP9:\-N1V&=P
AAUTN-CR(1+G7RI:E0HWPY--AUD&?f)GT,c4FJ1SU[:(fJV4O<W@9G[;Db3+1U]A
Y8@O5,85TKgKL1K29-UTD@-WY4-G)RIGC3FQg/#?T0V&b(4_:GO2Y?e5#;MB\]<E
W0CRc^6\/5R=)ff:GORM^Fe\W.M>#&Z4=>eJ8U?[;dL+3Z_WC)?J\[5AZ=IZ^]_(
[=@E8STPe#K[UY5N>_/9Pg:6D&)AH>bH,1/),#ag0/ZURNeU?W0DU^W.:c_)[8:U
WL>-V;IBc+[b8_4MM_>YQ<SH2c4Sc9Cc[+PdT;-5/70,7dTJ9b>OYUG5#E2TL8I5S$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_VMM_SV
