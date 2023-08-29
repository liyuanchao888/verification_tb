
`ifndef GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV
`define GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_snoop_sequencer extends svt_sequencer#(svt_axi_master_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis export that observes snoop response requests */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_axi_master_snoop_transaction)  response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_axi_master_snoop_transaction)  response_request_port;
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Handle to the master cache */
  svt_axi_cache axi_cache;

  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_snoop_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_axi_master_snoop_sequencer

`protected
XD+B5RRMfXM+[T=E?dUT28c2eQ0\gS&d071BGQ#L:F49#NI^O\Pf0)aU#J]A_7,;
?e4;DL<P;3T,J_Pe_UOYY/<@B7fgHe/^9E=E:M;f0RcZgM<O>(RCAcQ:1^#3R,6(
_OXWI\/9\[)]UP-SPXOb:ZR_HA)bG>-_Ca;c(-bNM+fbLD><U#6TRCXba/cOMSGB
H5J4aHT1>32KDHge0K4HD;ZMef8Z/[g:/FQC&+1c>A^1S3S;C6,gK>(.WV;bU^B]
J-[2AS\KKDXKYXUHT@ZUIWgOJM[;dcdXFNEG;OQ_Ufd7DBDfC<X?W1f-01ZQ</0T
P7+AQ)CT:U^f:>1@+]+(-^+[^@0U;XI8ZQ^#Ea_1DW5:E3]Z)=L9HV0M2??^WF[L
IN>Rd_ECOLI,XdCURa\O.II=]HX5W?Y/=AKX3cZQSM3bAR[:(R82f0A<0<L)9P3^
#d)1Gg]U\01cZW#OUEKP86@Z6f./4PP-Wd>+V<H?U4HRf_PM+A0@(WKKb46Z:C7S
,3U<T<I_g4d3KKLg-^aYG9L1BMJ_CK#A-S1B1F\#3(6I5cZMWN+A80,L^./e(9.XS$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
  `protected
#NeZOQTQ[21NCI7G=.Ud\RWeL+Z2UC_+]0B_bIPb3\@>^9UHJ\-/,(]\Z[bHZWL7
[(EZ=)OM[8TR<3<d.#H25OFOM[YTO:-_a^@V5A1>P[a&NTH]:TJVA#b&Y=.-2PfJ
FOFf8e04B^eb8[<d/\KU0VUAYYUO=;4T&S+SW(f;Tb]4#KJ=,-V0PB@0Y-&7DX^<
<fT)_8-^,BTIba>)0_=gCPN5f4@f-3_:_DbXV/8Z0IOB@DVX([eT,_:X6JNL.8IS
A(;;U&aR@UFPg]GVf_Kc4gKF_EX\@cGV8Vf=L:J2_dI#g-UfcOAUV(adB.H,FVYO
OV8TK(Z?c1]\&=RVgJ4aM;+5:H?DKHCH57?Sf]JH(52DUH#7+AJ;b23SDGM+L-DW
Wg3F1)b2,d^3;G-CN[P.DID#CE_R\UKY\&<IQF3HD4T0:,A\Nc@_Tg.W)a^ZDP:R
fDG#-b,3:CgYQK(f:=eZ[76B>HY>_70#4AKAJBR,JZ_V.#I&6#EGB9=&WX,0e/16
bAZKV,67YD/K:V=f3-R0<QWX\&Wf5I)T-P;C#LBQY;RZL]IQ=ZQ8>Y\/f_>dC06,
5aJ[/=3OIM85UL@XV.e&PT>06J@RR]Q)93PP\QFcDH9YUF8)18;W#+_ELA3],Xa>
1Q5BH]bWa3/.):/7M02^+-FYF];/gYGZ@18[N_3-)=e.J-3M0^(D/b2gXf(b\Q#C
3CE^6468B^N@@W6D+[[)D#=IGAAH+bXSX/9C&L-7&e&^_d@)6[F?fc.6.?[AW(O.
a;Be,.TQL.cTXWUb[gOVc@OUT^D[G@X7H2)UdUA2NA_>7LRc:TVd\86BQ;If,OHC
>5P]?C?c87M7,3.?^&3OZ(>\XZ>g9&Reb&4_ZY>,<NBN)ddHWCV\=0))4B8>^c_L
YV)NT\:7O7A[RHC)IA#(^6dBY-]S\ZgPa?0VSFdC2<5b];.E/&]2B)dffF/P_>\Y
<EV]bFOb\\@a3+;4-3MP[69.M(dF=1(-SP6;OB0O<RBF?7C-W)UL5B8V88?b-1Gc
LQ[Uea#(V7-P/e&7>@Ea@X)O]e0L,c<H74A#WMWR;Y(L2CMV717@-:SJZD8)+KG8
CIIULBF>ZWRZ(U-U](-.O+\8:6AQG9#1LQUQ?3SP9U/7[S/:T(<Nf,NBWM,)A3U6
C@<XQ>R0c0KO/G8VFb,E1,eLRG:+OWV?aV_1[FU#MH/.<?/4ZHYA_RI]3_EZB?EP
FW\POSNP0\3ALM[G@^JA/1NO,2FC@dXJ69aLdUA76F3a4A5=KFd?P.M56FaOE\G<
9D=:/fD:C2]HMJ?L\7e7Y.eY91U62<cCcU./+Aa/\]3GW84A:f()LFZ:RTY;I7NL
dD8VF#LFA..[83e8MDf>0^TZCD@9MSS0gW]2Y-&a(@5FX2#R1UcKPc.6=#&2K#T0
CF22>20IfKY?#AN[S](X25@d--=I#W[GK5M/,)=_0C88YA7>OQW3T3E8M]H>OYGA
I@37:aNdF7Y2.2CSXYSZEd+?&;]a;9J\6&Q:=KS(#:HAQJ_D[49:dQZb<e(bS5cg
<AY^TP\XXGc>/U[B?e5;-5d3V7aWN[M7^A/E]K;N-&=0XMQ3_7N\NK+(W;UZD9&8
eE2\L>aERgF^\Ne\AGc1WF[_4OZ5gJL_\2[:F63_.05d>-YD9GeOVV;V^]N=-f(P
<E2/^G.:E)3Z)-a,Y;(E(3B[>2gU;RXIUY2I+J;I#Ma(CGT:MQRRM]BO\S\](,Pf
/1Ca7&#<(T18I+NRD:^a<2N/_\O,8d0NddQKLa7[U=PV6#K=T(G@C1gMdd9eWCL6
+Y[a7(8-0_.>OH;=ZG-TT&bO<O:CKX)eMLgODW<bPD+Pd.HR=UI2_4,DeRNWZHWd
^:f<F.-SeP.H5Jg+EgL-dW]gLc^O9f8<<]:9g/(/Y[\VLM:<:IYD.I@XJGKBY3LE
(d,Y#FGZ3[RaO(b)H\TUd=g>AUK@7>@SQP8f[/)6G.@A>YMBM..D770DNGAP4U-;
V4C>)G3>[UW[DVOP0@5GP+K^57:W@deLJYgB:3\FW)^ZR[NYHPG;bL@8Eb3=&e4Y
#3dd+6J^\/MOL_?V579\2<?a;)/E5#0:9W+gg7/RFK0Wf)R?]HF^FD#-);T6/V?b
OJ\<TQfZR#e5M:>WddNY)D0_-_B).Z(\#DGWaAdRg4/L54f-EFa5#>M+\1Md#e.S
&d1>#&M32SAX3M:Q-YT(-+&,#?a[a)R(#bRO\3))4D-b6@@]WCO??UGQV96O.Z3L
TCeUUU&WMF[84g(J8?OYDP_0]dMFSf8J-g1b-8A:YO14S?dBSEW6)]3(#MSI4^N5
a@/@2Z18-Rf=UW7HA_g]<fG9>C\MZc#V-?USaf<YX8/R=(XLD=H/F^+dg5XKQG&Q
53&R-,5#VK.fF8)K)T[@;[:7&R)ga0>GS6GL9QM=_U,R,0W3Bf.:7^7HU=_OHZfK
?Q+&&A9-C,.84,-L-EBKS\^[#2Z/gTCR^+A?M=b;,3[MF=-fY_\O15JASAPT_c-D
gG0^69>TcdB_ZR3O.QJ5=BN2R7b;]]PUSEaCZdY(1N#11TU@CV]R@Lb@Sb1[SWYP
QSW?VQa5^\c<NA4gJ?9>fNMSK]:7fJf1He(2<X#4aJ;1B$
`endprotected


`endif // GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV
