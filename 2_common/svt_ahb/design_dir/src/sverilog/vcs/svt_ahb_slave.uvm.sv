
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
@EZ(5gUaaA;M>Z?eg+0U4648:EK2U5F/YKd+-DY8IAF+[5c\?6b>((6HWY8PNFE\
&IX;J1BAYd>W^U]9RJ\D4&69=0?(fDSG/+9)V3Y,B[DHg[>8d.RTUL,\,E/1a3RS
L4H?Sd<VU:.d3OAB:]U)@D4^1X#I[60fO)0O\Z/C<&</LG_8+72&SB5.^.SVF5,T
=5(SC3/8I1&+?_S5]IT0>X6K#KIQ[YMH0RYJ1=L3#V,+2RR/?SUX;B25cU/YF@c?
DIRBRdcFVADcF^TLaW6/IIF+:W+E,>=PC@gJV]XN0T6E(Y0RWgg-)]=E<@BP87(<
S,FH)T6&g/X9e3VH[f.KS)a=J/c&DYKOE]H9V=3JgRV+Z39)GV+:U+]<a[@H1[W1
:(fDM_Z??>X+gCe1L(/4.CFLF#+T>R40@JEP92eHe4;;3P[LQGDS^0W6IF)JSOcK
;bGH#>-]d\_AM/1@/>;4Q84MbG(M?ObQ(e=L3<?Y9W?b>1>W-J+IMWf+4bQEL.E<
b;aD<?eK;+/Jc8B2^?d)5Qg1fJCK^XN1>M8aUVgR<5]98D]&CcfMC-9#SV2\Fa5Z
;5Dbd<T=A.&.VOD<H1JSf8L:VXZRU?I6EfQ>d9CS#J>B1RObf;Q2AbQ<7BIa\(1D
7.]UQXSW81Bc_W7;-@e-\U]W\ff2@f4W#N/d\^E&4?#V](AVQaf_+5RR\N(fZ>gf
.e-[DR&,S8#RQM]>/DKR]O()g0G0<<aa1:beZc[&_LeZ5c.#P,]fE6BPfdAYKa@=
HFfF^H\@MI+,V8Z7e5/XO?84g7b/-_:\eIeK9A(A3,O:02d8D-WW:D^IISK&^VDc
7^V2A0Rf</NRUGAa>@bXe[:&1cN:MI66&6L5c=0M/b-/@Q;+(:MQEB>3.0,JQH)3
LF,YU\@]5^5;)J+\B:)<5fHS6LGG8D3-\aH=3=3^dYg-].B3_W-]ER>3L$
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
4C;3.d+O]1^YMg+JL6D>HSA;XOPV&ZDbD943O#ROcT9EB=FW=]#E3(1883@U?H&-
d2;CCa)=_6)e&Y\3aLW1406bb:+D8KSZ+B.IFPA5,Z-3dF1O:CWDPLJ8Q](4aYFY
EHXAZE,3^GA25NC\&=gN?^c4SPP6?/5;B\g>U8@Z1^/&@&;:=.MS_@W[BN<<aRU#
faaR>?BS@+FJJ;dAW22TRWfFNe:D.2M-U.d7)==P>Id7Ld260NaS\X\/>?7_UX;Y
&I[9>eU-]-3,Lb,)cV\32-fF4$
`endprotected


endclass

`protected
/,.60?Pfca@;>LKe?38;@S;H;93Q]E\[(Vf2aAF33G+g3#8/EB@?5)TD&K#TB]Kf
]Ra2P?+^GS<F5]:.@<_deDMaBYHN/6dce;I2J@TcEGDcYMA6OJ-cZ?25Wc<<WBCg
09W9b=^T-B-L2S[Y6c2<]<5a[FJ-4H63,&3bdIG#=XCBcJ/U0,B6U:a+>@M@/R(a
L(I2;T5&fA?NE[PFacAaQZ<SJ:?Q_O7G1Z#g&/>cH:I>9Y?F(^\)EcI_Sa68,C:>
3RO^^DE7=(c])J205J&6<d<M9R;Y6OLYJYS9;d)2EDLdZORd.UMHHCZXUIJG0/G)
/,GY&YX&YdKWQ^cGg5/5JdGRWg&?cWGK\+AGeUOgNJQ@aWZ&7+c>U_R.QdCW,bR&
)Pf8Y4V-7R8Xb)00+1\6[H(JM)OceM)6LHY?PDQPb1^@A$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
[29&4L3dYQ^ada??d+]NI#)<S.:D=g_1:CA(P.5Le+#N[9:M5?e[0(0e\=4[@b+[
67Ld/QQ+@[A9\&;R7JL[=eRMdIL]U1b?OeZ2?5b?@Je>TP>I]ITFN(@g5Q22G)FW
B\?WM[b6c[ZWFW4\JRH+0&9<;Q=eA]TV0fWW9,:?@1)Y+T,^B-Q:UL(MP._VdX(+
Q2\fc@S#K<CI#FB-?_6PKg=BbK@IH[40J37O:)/4O\^,L;REa_EeLR3;JKQCC8dg
d^T>^8TH>UI2>C>5.GRN,^PX1Z<G9L,Y+cB1a?MIS+cg+Q4YDf?e,0B\Jf^6HSP\
_W;,(;Lb<WM/E]7gFHH^9Qd4(RS2:/(9;(AUR[dOPIR3#WD_/e7EWSWFBZe;Kda+
95)4@V[>:ONZB/Jg5PTC0X)2)Ee9ebIX.41+[<DP,37eLKAL[;<1RZ6aK4#S##L3
4O:1H:d[1Y4HBUD(#BgF6[(BA49g-M=g:]>U<:7Y/,M\3JZ>+I7B-,5gCF9WR)83
03f)F;eP,;,F#dSC[I#QV9R<@WRV[b0Y:3f)##9]Z:VZ\0A58+CF_)abCK==RCBe
F71<1_JA<]ILZ+Y0]I/U#YYeC1@]AbA^+W?)(T4egeO\E\J<?G6T&CaEPN;g./>A
P;7[\3S3=65IffQX:9.Q#b2A?G?65XM@_/7]KXOK_9fX,Q?B3S#\f=WV:)1b,E<4
P\;LQTO/T(G79[=4V.VLFJ#gGZ.\L[>-U0.H8AB?fS0AA1Q@Jf=KR0TG2gg/Cf>I
LOE.__J1[U+S70C\NBG=9G>+N)1e-,E3SJ_0=:_g]8XR0.E-dULT/GW2M[2LcfJc
g;cHKY:BSV\FJ93b^7N?cV+@P6)V/PR9>YT8JE[-(1eCMUT(LFVQZOUc&6O;B\>F
(AEg/2AdLP+FZ/Z0gB9&1U<)g+f]E3<&HbTS0,R&UaVd#H0B4NHY;S<O-Z/R[M0d
WcdP]1F2Lc4:YW]3a29]IX@cUCO7S#HJb.3+]TdAccdV\:+KWMU)5)D<^0_F2Z34
XOSYcd&>UD/HR=3C9;1A#8#6Z</8,#51Ua_(,J[ed7D0gFV75F5UQ-a@(PT&U3fI
;.3?]eXM8W4d83NGL<+R._SPd17DW@84&:)=T<TSa/R=AU0UJT-&2J8f6YdD(:LI
/LVY?PG?C<L.;Mc+a#&F3LJXdc/8<#W?FeD<UY,J3+)\SAfOONTZ9dfcH>=abK4Y
6>)8+@2c_ZD-cH(<):G75>/U?f@dFb7<;Ie>)gYY;0<^:ScFJadPPg,<<=PV8Q@V
X4HOZ2M>d7U=[(_Wa,0Y\)O>C=]0YS/VY/2VI;,JgY1U5]-e35e[M==(^8NFRXDU
:M^?cE-[>Y-LBS=P+aOMg3Y[IQLW2K#cCXNgTBX5L47R10DJFVH_Y+,O:bfQ/Y<A
Od9N74MM9[9F1eg=HF&^H]NM7KWM\/-JgAHM-K-g+G:a<[(dC#WKKHA;U;-6SfKg
.=T@4K#;UP5&<3?0@IffC(10B>NK]]D\d11cZYRFg8#=2;5D=6HW2MVYa1TYf<?Q
E8,d<QA<CXHTR4PEfEe8a.N95c&c2de@T2>AM\&_TWA3AQ=_;#WH?;=)&6c(,&3=
fZ1dPD]fDV0VN)X87-[9ScMdDVALT8d/@8ECLaT:#4BVS8YLLSZDZQ6E7[/c)(1-
d2G#X?(_LMaaZFO<+a7LS:+)T2Y37Y#>G/30Z:/bFL,Q5,X(;Z#g@-K\,c:@^;BS
fIaP\SeFdYQFF21,-.)ULPR@FO?cW1HP^D\YLGJ:EXY0Wee0T_=N40cSZSD/@B\D
OSJ)9KCABI&C?8/QCU5?],6]1Q?1U=1M3-4#AG#[:83:2\9,(?1;<\V[5:2&R7RD
_DWR/8YR@]P-?+1ecC);S]WVPX0EV6O-GFQO>K7_PQ;T([6HIf=/:=TdC-CF:4QS
]WTFMV/gc])@gcMd?BIRJd^+^2F]b4H]B5fM.E@BQ_beVCQ8?^B-/<gHCFfP:R5+
A[:+J[C/;F0BZcYHC80BPL.=3866??/@SL_1>ZO_Z^N@UeG_/N9CC8QJU<;H;X6K
SCKNLTcZ5fSCKF14B#PV9S9025NLHEa&KEMDb\A<E6R+6.d5WBG@39=9)JKaZS:N
<3W0H8WHQOW;YY3JE9IA(X18_#R4_dT,EFaTXFGB)1f-IW=Y@eRV@fI\a-.0_59E
Dd;a;(,a^&BL^dYT</4GS6M:^P4fgaH9dCR),3=Q;gE?A42dVTZG-)f8NJ;)\JGe
F]R[DRIG.EfYLaYONQfIF8<gWRVf[MbH<KN1U(b@eM-3d3Y^\6Re->@gUETdFCWM
Rf7))-/FXOQgS91=Yb]M&d:4B.KH-2.\3PU@6g,>/RbFeU,dcSN@I2A\\/<cdA&Q
U;3HE[Y?YH(N].>:X[@^e05,fT)]=f)]LI;.YB;UAYF39]Y4Rd3/I9F?-fI1=?Kc
-CaWU<=L^\5d)#AXO?8:H:/^+^L4CLYYVQCQb][;=eFST-T_gBRJE6,\-1BR(2#a
=2A7YdMFK2cO:+]VU//dR=acC^^6Y,;)6.^0/dK\WNd6G)1e0;8Wb(3>>]L4,6(d
IQLd6I(5aCgPNMT12?.BeEb<eSAI9H:5WHGaG75QJ]6^AQ\5QFg170M:-Z>.,CS?
6F/7cWGVK_06&7bBT<E\S=05)RW?.JCacI]P8^:,LP&BAL;d#LO6d+AH/dT>RgN/
UJTTA06OIS-(1BcIJTBH)7V[1N^18J]RLTd//T/c^YC8.:,g@>_2_LB_U3:6RJT8
K(#A,4CQHcC;.4-e=5g=YNM;4PWJ-ET3dOCQU@<#F+bON5084O-[g1?d10(CR,:4
Je.?c>Ue)8dMOY2eT=fLTg:M4WCAHc-5IO7R<5DVIOUe>EHEB+PC>CNP:0<5\P5]
^N[S><f.JOE7S8,0[e8^:8IB.99G9I\+eJ3b_V?29gK97)>X&fR&XJ8fBS2L&CCR
<MTFV(d8;MX?IcF2LI[;7Y_>D1GLPV>P](Hg]KN0T&;9K&GTL,[VVcJD>?fe6a0g
PI(LE0#f0@?+N=Z-BeY?+e9041I\/X146/-CJ6OYbNWQ6Y8&R0NH9=I#PY.YPVJe
6XDQ?;IR:WU1fXc@2P<J[KU(J?FB8B:--.PF>a\VCgQ43>G?BaI\;EMc6(1F(cW&
MFEYWc/)7OSGETDLd\I1KW:[&._NB6feHFdKCf4O6?BIZLg,W)#WKH:0U;S=:&O4
KeH.HJ+9JPGQN<ALd_d4P3BeG4XB7QA,RYUQeUg@b4;A=,7/@@U9@4WDc@JGQfDY
(;FUEL[f00Y6T0HMPMSG>T^RKZ@@#^a4VYPC?WBMgO.7E\UUE,_Gdfa/>MO@49XN
OgJ]AB&[eZ;&)#-B^4cXTDg[bNV..aQ3#9;K(Z]MQ>I,^b;U<R&NH:,B2TQ1&aP^
1,S2\W-[NJ@:gRMOO,DbSO]#+W<[dU\\f8,e(ScS_RO8ag9.]bLaOJNYHX1VT1d_
P<YKMA87V(5_AZZ(](\-g:B#=:5Qc>.;\3S@eYZcfPZV734Se2S&P^5eYXa]c<gE
TT,SN0DV5NFB2ffUgaIIgF#OdT?Pd:;>3O7)V\UQbBfdB,.B\^O>C@OWH?OgE0IP
UAF:)SWdWJ63TM3R4[P7c#>YQTS_5M6e:cAXdN?B&1d?S6(S/Bd<DafO3#\J0GZ4
)3<CDEL,>6>bQ)b]D>YGeKP_LTES9:BbQH5P5UJ-Be?&dcHdN?3NM,g[2XV+&BGK
SHc1_6K_<,O1?_[+Bd_<Y:YU8D7)=:)VZXY+19Z#XS,\Vg]VRT[.9XfCgEK\,HJ\
)/K(R#);fGBS-0XKb85Yb_SAN=bI:CN<bHRbRCd)Rb.NVd,FM35@M5dKcU4,Z9a@
HYc(@a/,aRUL.Hea4dgD?/EKPSgO2B[F/gaZ<-5M;#6.dCG8Ffeb7\\fNG2.KED(
Te/3CO10XDGG8REG7\_d9aF)GCAe>RU_;cb9[WQf0W;U,>W9RLa(7[af?TKLY6I=
L79Rc,\8:a2D0P?5556)A+c?,Z.P5,2O_&bb1RAJUCK7PEWMNR;#1bXfb4UL;(K>
+We[:CM[Q([,9KG8N#;3J5XZE#K?QC(;N\)Pa,#Ld+)@\=N)(c;,+>_;LcCHR)WU
X)aFW9T?FEa-S/2Ufb3+g;H6eU:HY60NB_=L91]JN407NPbQ\A,BE.KJMIN+Y&GX
S.@MbB=[ITaF&,N;8T#>_7K6c,b0Tad1RRI<W<H1.E<CBf_N7]9f(ZL3:;7=73FA
HKWD/UH7.Q:4\G:6We<)XR_SEYe0##R#:9W:RC^K0V3X0D2fFeHRa?]#(O1dG4)L
B@3.XTFDE[C+6LI^5+b,U081G+X;gIQY+YVEX72[,bW;:J.\F.?NfUX2)33+VV2Y
H:RTLBcTSPFJJZ17B>V0RV?>0S]7.BaA;d3OORJg3[=d,CUMDIWYgg1APNfR5+Z+
=6d.=)bgNWYLD4?g.#O,f(_F(Y6#ATUa+:-U,6FAHP&0ZOg7]><4M_+f:UIe(SV-
V([UY38JB#1A7#^;9FKVDPZJ-<b\B#gX[X,TO_HA17IK_@5McC.-E+:dJRe(1?>[
SC>AR2_(EDOGPdW57WW)N7e,FEY44OebVZf,S2^HM]V.Hb&H]_Y3;fWd2AR^#S,U
M,1L3[[#__YYd(6M3\RFPHUZEETd,a0J=R/,L>L8&B>19<1O@,-<?N;bLDWKE\Cd
;NPaT_c+B>@3H:3P[@ANP20RJ&-Z=U0>)^Tc0&9+V&_-PPKI;IX.EM]<#6.cB?=.
VgD0B-DQa(MfU^/8:)S4R?GDJ0RE^F6A:/=Z]_DYb+@3KSaLNd,V49ca#54C\T(+
1?9+Xbbg:ENVR:9&c1.0=B:&@)/)f<HS844Zf<2ZHc\fgPG4[d.A(g=d;)4:UZGe
;<?-=Q];J=F4DaJ_XVE0-FIZYaFYHNT4O.-\WeQ=ee@PUZ^N63N=1@1c,S#S]<B\
1\\dFBff#-VZ/7\?RHD\H+cRbD3W#eN-Y6^)UHa/>?7#R/]g7dG,CL+6DU&LM+Ia
GLbK:&+H;Q58CFG^Q]DNWX&F2d)#L=.Id[R9H\2bcHA]H3I^HDJCU-EW/7&-dXY;
_dc>WOMX0a)R+PHL1EbE6]\.[8GPDbM<S.E.+9BGTEGOX?^Q#4f-;(XcPE>NJ(EF
297Wd]^d9HNCI1L7&-)+WX-VPaJV8FF&c>[dKb]Y:5FNFL39:K:4,IMd,@FODG9O
E6ePPE.ZCL3?.4VEbfX&+#,M5,NeJ>A#)J[C<W0fP3cK6\;c9_NU;acdOSe#B&2?
OR]a5g.+HEdacO2^_(c_a_DBSa_0D?:_,-V.Dad62#F>]+<R0RT_>@W5LD:(ESW6
7Bc_,>aaDPg=IC#O=V57K#UUPL1UaV_L3gAC.I^0DNJbDV?>QI3&OR/IbQc:]bI?
1E[A8]Q9NKZ(;QW=]T7cHY<L4@&ASg>+bUVHL<E8fIKOf^,f.V?&T)[UZCYF(5cC
PQWNSX4BG/LDZ<JO-M<CG5#Tgd>TE7d:L/UD^bX,=B)e0>J)[TgYa>A=V,[EQZFe
D]#C-X0@YSDXd#O7eL;YV<E4+:AMS_WKU:KG;RR#(c4:)U>#=EME(D],+F2JXE^@
a(P]MTX<:eK1.e1FgKe<T[R7&R1:P,D6S5Ea+)T:>VHgZ,P;8\b(4eVV\YEEGP71
F,D_M2Yeb(C8c[0-/+<fG68:,gSU[AF46a3>5GIM2S0)DVL;:WQa&+Lc@I>dKZK5
TGYL55#cJ/U&HKI:@JYMJTNE8;,J^^bODG>FdTH:.+T<??#4VN0D_O@aa-Aef98e
cUXaQg=AGGad,1aD+Zf=DF2cU1L(N62A09b,/O2JJMgY07=J6@aX/^b1#F^G;[#T
F].;NfS:C+JLMG0V5]#SM/T=;U&.ae-Wg\\&K0R--<L3O3Y^PBFfV_6c,QXaAbPe
RB@+7gCaVWK-JIbB+[9E[\NG/Y4[)Jb)AZ)K<>-\:aVTcZ)#0YHKQd7cfA9&YMbE
#)c-;Mf^3gCI/XcY0#?^aQALI_VMdH_GA6NG[U8M4.7I[;&3DCGUOPN?+1Ng85/(
>[-AS^&XGR@#GC0eQI\Re-=YX2.0bBR:V2c[:Z31@]Fe9_<d53>)0CIQZNf(,VDd
-V8JNTC4AU:+b[7AXP/\PVKfC1OM789(\b@8L?c@U3a^W?Z)N&U-aF20IBVFWC+/
IRcX5E5W=K,4940VS@<Zg)>d5DILQHX&L,d.bIc5Adg4-;=^69J#_M_&cXcON,#A
dS&JV596AHUGAD[2J-7RX9(,:&bE8PTdcVTSQM-/.BFPKaDM,e0K+\@EXFT8#QKb
;DF<WD#ZIGe45R+;Q:(_aJEKY1R];<S5PX(#@W:C6GU3SS&_8_U>T&#_V-dd3(]C
T.)).YBffA3/b.8K0NCCW-A^>L]c-bI4+-26D[[=Ad9C&NJYM-e;>U2Y:b<0Gc6b
#:?>66fVOUU&YQB[?Cbb5=)BXTHL?2FI3N(JH\3-&&A\^g^[9S(U3QFa1(X@<2[A
:2[;#W.Z0bT2H2\XG;:U>UZ35EZ0g8#KN?;M(FLTVJXIc+KbYTK:FZKW+:O,fbfI
6^\_;4/4P,V.(?G7K+[K:L\eJO=,<5@VH[De6E6c5+I8/R.;D<QU6PN0S53d]=,3
ZVY8]E@&bS88d8]df83/0(=^728c;_8/#,\NJ?bR>aKG/GV+8QL4PRTH9CU;O4<b
,WP+(=]4AA@,+&6>AQWX4?:KS1_?e/6(2SN(D;&TgEP9RK;ac0G;cfZ3bU_E[F#0
Y#.FE<0QQ]>E<Gd8UUZcF0Y4dC5,1(@(NY&=-10-aHNHIbJN^5VHg]NTJ6Z]EHBZ
d9&eU<?D0BM5/d@2+,#?,S[4,OR0_aI&KVCbDKSH0DV<#?b:2X69VZ4Ra_18=CQV
UTCHYCCc:_bI<ZG?Gb&(a.cS\=H&A8.^CJ;[=1O)/8U^[J5fIL49]cdbAJ-)(K(\
^#^U:G3(.8W=Cb4^V(#>VDeW6^EGSOc[IMeg246XK>-Y_cLQae&(O^GfJc0896bT
YC_AFc;9N)H>.\2[5E]7YVH>U54;TV_TT51afWF+#Ge0N01Ia58H7G,ZJcAIFQ/?
NB_2)B;RbQ-86F0OgK/1D/N@K/UPCgDWX@#5f>UQ85Pb(U)dJ]XXB9-><<\3^N.E
CQRXE=BCP:,5-V(+Lb&);eU8@8NBg/d+BN#^OD1=#J\Z:4A=bW(9=^ZO\I=1=H\L
[S^d-)7>Y;2?C/(F_H^cK4d_YeO:@G-cOU?1eb-7c9,f=;XJ&=A?<8fL.2YAN]We
g4eAZD\_C+2#/,#ZMPcEP=1W7b>@ASS[CJ^L@JN4aR8C]L.NfMBHIIRN46F0PHcN
H^KBUdV/^>CC)+8QUC1=a;I40VPIN[\gdKV=MJE)P0bfP]fBNSR4>Z@SaLd,B62T
6O9DcbIIP7<:1HQa,:\AXJP7P7--_VYBCd)/TRV0:S(AO)P5<L,<)[LCF>ff3;a5
,O3#99fX(b3N\)ZS==1RRad69e4ebCOR^.(e)>Jb0LPO<6(UX-,AcPK^2=UbJ]1@
c<C-G4g5AeG7W[SY;V</0#1[g-:;3eb@50;#\U3;RcW3eR;,,Y/\S?H5KVJ^CfTK
&N;0L8OX;/Q,=\SfWGb)MJ:@DE^R\<^f&_ZA[\,3J8a2;gAUIIKZ5fb\-]G\7b3.
:0AI2KDS9^Y.VK5F6g>(]YC/_EV#bS)#VJ+[I4B;XH/R[4EIAB5RVc&FA9b:NYc9
=@M]5_>TKPTZ7JMGPB_Q<+=NbE&Xd/9X:;7-YK&e@Z19dZ.7a3\_?=K+C,+JIf7A
G3UC11d&D4##4dH,79B50eFF8-8&L6^-/I8XY?R]AAI3TP?O[AZ263I[a,c9^-1W
;aTf#,FHa1a^6VU?CETJ-ZC8MU^_0WbD8>48gHI_Z&PTZcH(WRYR<<^g#F2BGB:3
O?a\^#4HRgFbX))1U/QQ46L,ZP592-CLI(<QM;U(aJJcH6eI>dYdDL<,40dN:/IW
@]&?<(1ARPUd\>&R)2CLJ-b&0&^^&1+>:S]d,/D&Q[WCHUDFIH.eTUFD)C<6aF)U
C=+P7E-&;2C.dXX6T=4)+E_]RH5#KLV@CT^Eb)XPFPHTYWcROe8QY7fSAOYO=6?[
K0=\VPfWMR/[Yc>O6d^2U2K#ML2#^c61G#&+7?FeO-J<]8;INY94&B:_I8P6\UTH
Nce@ZL\2ge^3-d_8[#H&DZZ1>ETZbX#79AK?M(B@,;=fE/V.cE2C/-I[YX@@\NHd
db_g,D+^0YDQQH52L8,W^DTg?M-8V:JF2V]QRWDgSXJ3?L;KN5g0N.0U?HK9e9FB
d#MbQT2DS).Y)SED+,MIQLM70D@2BbK&/D[=g(3_8+Q5X@;S:-C9g/VOZJ:dGQNX
f/bKYY&Y-?f+864b.<P.X+]8SRA9MT2OcJgf5_;@<OFWdB5R))WJ^T7AT>(N7TD+
?#?::0)@fF-I_g3GL@:cBa)MQ1SR_\YZa5gPgIc]0F)\_R;c8;1B(68?Af[)eTOR
4FK^\E:)=WI?RAVL81SUH@B;4Y:>6E\I?/(d--7#=(:F]2XRaMCb?R\JO#3\=,H/
WZfRaa15cLf=[3MVWG,)eZU(K]9-[[:>NPH20Z0Ce/#.>gfJ^;::FGKK5gP_5T><
-U_Ab^M9[7agb88WVKdUR^R>8fA#9CWF,0[<^UfcK54K&.b0NL7N7\][#[)C=;Y7
KEPEC1#>BT.AN5JB,)0M]PKUQ)XBf)TgWI\A[Y1JYa]+U-W7GO@@NOO5R--BF@KC
]N3g:9H>TgZ+cGMFdSY41D^,Z?_7>.SE;A/d6,-N(&JOe[14T8D_dQ)bLM6PMPdV
DW4YD^4Eb[C(Y0ZL^a>X7,78A>5Q9++DW=J7GEI@,Z=^,[D6<\9DX@ZA0CO_YI5+
926F0(ENO-A1=e0\YB\=3#9OAY;bN-W6,dE?LfYA8C8I>cZ1=\g&F[RLd#2#[R-1
PD;5O+S7PVHDI:fC-DSI,<fg@f1[c1\\G+>OY?_TR6b+PU9\/a96R^@=[eA3d\AS
5&ZQFAJZE+.Z0GR)Z;YcHG6f>OfURA5g<&c/L0<8XEZ_6ZN,GND=X(]LBXG_7LRb
,9#P3RC@8Ke0)=PG[,/(4,,<0;(d.fTg;X^X4Y<R7>d_-KRA+eMRT3e-\]VOE^/5
91+=W?EQ;^VM_Ma&Fa665V#_8;cVCa&8&#V@D((,&cL9O8U_K+T64WV@12NF5#H6
J>EOV6=gPSf_5X6QL;[9cb+[F;g@T4@I^R-J#U+)RT++S?1F,S=/,cDd(GMASSI.
90)@UVYLEZ^aU__L8:120_<53@/\U-T6@6:RNDMaGC(?_J:??X;5D-Rd3YS^.]AG
_PdRKb6KDT#:#;Pa3C44H]T8WL@_3If_-]H[#Y&MUH]E5+TU@Pd>F2#CY1W<U:1@
N+gc?R6YQ/5=2W9N8Z@B4^)?E[:/]1@LI8#Id?8\^&;Bb)YM[2J_NM+AJ&Bd2T;F
Y[;9B4/]<I;.NS>E6g6^CS&]3\AQ>/)G[BCe+<>fgMGR)PVXKb#]LJ,Rf:/X)=^.
;:_N#3HWY:aMO5ZKc5Q6Z[g3@@MRKHXP#c8#MBE4B3b.J.;T)T1dY1<,-U1:V/=Y
5C9NTAA\_FP4&]FeY<e\:b-\<M8/N&N?\-5Y][<9]@VJW0b47A@9KXI3U^3HP\<]
DEdW_H4&NX7ePDMX\Lg6)YUYP3LO,W=7>B]Da2ZW53VH@CO;N>;R1H5TP>Z(,4JK
=>0+CQ1[Kg3I^LW(AJG/2#+XH3)+Y_J>LWZ5A6T;+ZO;8J&01:2;CMM+;<F8;/4F
Le1=S_Ze<-Ef?K0/8^=JN\TVf>(IdX2aA3Rb2DY6@#/&2Ba)6T>##LFQ-A[H\JO)
X-DY1^a^d<N:MC&4TRfQ;.K:2aN_?02+2cE-c9:K/O7Y2.B879&18BgZ?,EZB0K@
AdAYJJb&S+_W[-_AZ<NYaQ@>].?<b./IHgYI40N]0VSKS8[67WG5a&7YITX;NMT1
B0KEQ58(/#OFWe])LJ]dZc:Z.Rd<;E,EJ(VF3,T##9A-.b^.L+I/eB1g19W0(F^f
@\5bFW2bBF/+6&X&.)TYT>OF29fNIO1VCMAbA=9V48(6H<dK^-D^=-#S/EReICg;
]dc+5)g-_2,e;BI4fW44K2OXN))5d1g758BC;#<JFEb\C58=Y@\82[:G_28SHS(M
NJOS9:1YRCd(Z(aUTYVFN/LML4/I[FH&_Cc(@JddY<E)ZMb<IHB9U=dLN9;K4N#>
=eD?UQ;#\(&+d.H.>?LIB)+Y_;#^:b-P]6)g:;_-=2BIg^d2D26(9e,W7&?G,[8a
50H,U0^NgP3Ybac2Z;N:QO-gf]OFDV#:,5UZd=g4<@]7&da0D,QgaV]\.BZg6D=e
A#6^Zd^=B#GNRdd0B1fEW#<AR#,#gKY=DTG?1^5U1Tf?L5\J\2&]a\C\5^eWMIRT
S4(.TT)Z9U>Z/?DcTaF)a\]3QX2,L468a>=UgT+;^N,4GbNCA0HY9B;>&aXYb[4<
V/:UE:?MBBH10#,3)#Ff7<==(=G#a2R/CVJV]W4dAcHP&9Y.>>6:QN[Hf7]ZKgf&
[7W)PM9fa@^Re?&],L49YSN@/-b)P-JPIF_6OS1[e\bT&6,+#_eQU^g:N&V6N,ZS
Q)f&^I^C[X0cB_@3gUfc-8<c?fNeRF<Q?_fMQ7Q5A8da>DHa_]>UWSf1]Y72KS?.
,60EKe+T2e+#HQLIfT1<LKfS6Z+gFSd;2SYMNQVB\1Zd\MEGBgIe>W\54CaH=.d(
P#4E^01ga=)45dA6J9=+33Ge?5VJ:e>+Y\d=.1/YYg3\,V3LKDZb_6^@(&__0g(#
0D1(-+16,8,b>>NDI^?8YC9ND>g4f5&1NUT\&EQ[:d8Y-YTB8cFf0HU@#_&g<6MG
YAD[],K<E.I/aJSIZWF[87-V2F.O(f])f0M>DJ6TFS4(]^@IL8YH]&?SdA=6aBVW
C0MP1#=c_<#<;+FV3.;F)IGLBU:Y]Jf0[2RU2C>O-=E58@G2A0.H-Dc^DW2Rd@Z0
<b]?D6S2EcPb3L&_:@P@bH_P+ISf.U_GPQL@&(#M[dP^EZI<b1#;NQdPDB2^E=7O
CSGab5C&EC?EEHaRgS>#R3[D8a[]>XL6@53Q@1#QdXFTBLC>EY9=..OS9.TAUM2\
4KfOCFL3H6gG9e@UH6QL;DYS^LRb?WDBcQL87LD[BB^:9.EIML)MV<[<QKQ7OM9V
OC9#20QWVd6)<ZJFA79dO7,XHfX^eH\VC[HGfC7Z2?O+YbVa(13^IK>N,D87BLS7
][JI-T+[5#TO\KOYCTa&Hd>e9TDcV&2W#Q0Q_^#)fRCFXJ(>_3ac[fOR-06:K0XD
65;H]VX?5G]R5YOC_4\?)_f2W6cf?I([fX;:V_E-[R.f17Z55DHcYGH392]TQA6-
;XMOEMXWfEJ@N^B/KAYN7KF_<Lag/=E<LC4S=;8-8Q);9TRK\Ge1782\>TN/@[&Z
2?J8TG-B0;DUDPHfFaE&bf_:S]9ZZ]Fd:eIPeA9,7PPa=fGA^cU9L(<882K^R,Pd
3MPZ,77dO_De0GU]X3=a@fZ8c5Oe;?MIHB[:BaOZG.7[[5-UK0:2,.CS16=@K=DY
.,U3\4XdEB7\E]AW,cJXF)3>,JWZBBR1F7f)g9_/f/=Ec9_1YN+2O)=SA5VH6FfV
YdTIJ2<e::aEdRH<@VE)eDCe.fDV<gBBJb/\[9N-bLbI-/QDMT6HHVZB<Q;fd=2.
+4?[_T&a+e]A:L\E\1&RH@+2G5LbPI2^[dN]XW=2D8e6CQ0HUC79gCA8J+)g[F29
X[?geM_e=D.]&/-I9NeSO0M>(g@4_(MYZT)VSE#b.#?B)_fd+Pb[c]b(bU5]E?)]
1UPg5Hdf[0\G9fL<IVZ2[dP[D?_1C946PNBC/_<+7\L[d]eb,AX^-D_1]G=@#5;#
?-cI(P;a>e7,,dL->S<CRB>(DAU>+_eN<DM4H;YbCM_-/J;IX67gcg[;5KWK,N82
_aTDZ/0d57U6,5D\=J(,0MX&DI3UVW:\451N/_A_M8/d]4K^+.,=OP2a#.7#6\>K
d7e6@1&(VgKSdL+e8L.0/\IE+53[_H(9FW/JSaG3G_fT7NS;TP\dY0af9E6UY<K>
+26_+7IF2G&NRZ=D,P,.\URfW].Q\AbDF^0(gYDa(Xf<e)N2Gd;W)S>18=IIALSR
_<J^1^DXgE#/EC=+3P=BPg+<TJ>_:#Q/D>N?V,eS\F;G7#(9IT(:FVBg3(-/+XTT
EO^,Y6H/cOP>6)V4ZB2K@;a(IP2f[-4_R^@YOZ^G,CN>PZ#cg_IEWJ=6>PgIfBUZ
,YD7[?4C8ARVO<;UJV,R2)R2C,(DQMQ8I#O[B1?7)Y\ggF<;K;_.7T,dLK.PeP0T
L@\(.dN(a[6/T<fBAZR\O_+VWgf:cS3cP_3SE=<3,7AW\E^\b>g4e5cB:2&X:=\I
ZAFW,RNKHREX0&(:^V:PXE<5?(f\cg<5TJYd]V+b:>e@8B2NWU3)H[1L]_gJH1</
/b2/>7IbaB^1bd;/\MF,=GdNO6[3U8B7a>Fd5WGa@&FC@<]NbBc3.Td]6^=,8):^
g;aS<JK:a;CVbcR4Y-N)W83/AK[[e(dQ]E)LICEg=7\NO<]?R@T4VE))VeScLO_D
)V_I2K0=8ZYL4C2^B(;AH.N4_Z#bK2M0;I=P3^3Z=bZg>K/RW>_R;D.8:MP;g&AW
S-2FKAY,Y98bVgKFVa_/TW\R28RH3>M?VOK:1I:._.4-0:?a#M#^(\OaRJ:7IVGU
b0V#,G5=#P6E_.M@;\6T569#Cb4F.CT0WWCX);Y7U?11/;aP4=H]CeD5Y]YV#0HG
Q766<36aB9J_9-(MR5R>aDe-@TWgF/Q.#)^3B9V5;UK:D#^;L2QJBEUCKJ8_S+ZZ
F4CdATNGc?P)92LM;ZS8<;2RZabUeCPAeb,S-3CfB]F-RK1>AO5]09=>X.-M;<bY
/0;08Q^5Z/4\&Q.e,:;@aST-96RO+X6?5Od;a85GT3c]]c/1FM46##=>L$
`endprotected


`endif // GUARD_SVT_AHB_SLAVE_UVM_SV





