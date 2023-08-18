
`ifndef GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV
`define GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Snoop Sequencer that provides stimulus for the
 * #svt_axi_slave_driver class. The #svt_axi_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_slave_snoop_sequencer extends svt_sequencer #(svt_axi_ic_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Tlm port for peeking the observed response requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_axi_ic_snoop_transaction) snoop_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_axi_ic_snoop_transaction) snoop_request_port;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_axi_port_configuration cfg;

  /** @endcond */

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_slave_snoop_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
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
 extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
 extern function void build();
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

endclass: svt_axi_slave_snoop_sequencer

`protected
&\Z^0<eH&(fB^I6ELF9aHLc+.,XC.K+O=40#\&2XPS_Y2:J06I4W2)Hc2:e3e2I.
[B@X^e:&KOC8)YTc2_]:4]57cV)W#X&:f-:WeVDRGRHN[WDWX&XCHN9-[@a+]8;e
EXd)3ASf.-&HaA\>9e[T9H=F5S)gKB?6-[KJ6,_Be@OY\Hc@/-SY@DC-L;U6/:(;
/;61G?00(QOH@B\R5B@ZAb@M:3N=8[C.e@07@fb\>0;Yg8_6EE<(;A3gM=1L<e7a
_HV96f3&COd,Y+:RcPNPd((#4JPRB;PT721bCP,c+WC_WIN\agRO9gbZ6N6[bb_R
BMIE8]a@.27XRQ2P.a][VLH#\K0@c)M7<PJ&W_+L>X+H7,AB:5#ZZ&8I8Ab@;L(<
d/gNO.=f<02B4EP@ObVEOW/9&A2\Q>aL7;+#WNOVV9f3/KcW)L)(Qd+/_c[6ZOSa
]HB[,>DI^De.D?>YNf&>_[<+/,MbGWM8K\0X0;QT,.HR:I7;ZK68?9W/D4@),J?b
LRB?#;OEKEJ:G^XGTb;B(N8GC<?/9Z:5a.6Q8LX//)@bHV>FSU.d_BW/N$
`endprotected


//vcs_vip_protect
`protected
^;&NEEKQM8Y((/<1S]fGb2IHeXcG=FYfJA+c6L4D>RU1eOG_Z@f(1(;U^H0S3g93
&#g.[=XbQJNO#WP_<;N6Ue:gf22+_#g:9??G4I,->Y0P5+3V;O?P4>,DC([/OC/Q
[YLVDJ-a#+\QD@I+P/H]G)eY\:eCEQ3Wc[@^M?\Pb\8ZM3:bJXcg5ad:H1M/(262
,fK#9+=Q=LU?))>cQ\Be<C-Z:JIea+P)VDWT4<7fV:?U^<\A)O,aDaKVcg5=;gS(
(GgV_?gDH\_(Pf9]G9>M(E+UC(YF.e<3eQG^EBg44MXCPXKfN_K;MR@a+>=SKRF+
23\3L-GR\[CbPe3+WSJ0dOBd/E?[B9YY)F.2,XNe(]A?1,?2dHO/H9g>1HY,2>:0
cfXI+9]Nf@H2VPWGC?H7:&0@[8GV6Fdaa+U7YX0I.^a@)D,D_:#]2]#;@HJ\44./
M>@dJ(9K9/+<WF<H^U&Z[=140;FRb<T\#=fQ;2,7[f+XPFQf6Z1X&dP>FS:2G-OZ
]cPU_IfMKd15aX39VgU]M3S(;=)SP[a1FV5F9[G1+\;0,ZRHX<ZEdM#?M3_YNTSY
OAeR\O0/RKP<f_R&L22C5a[4)E/EIf:b293HM/S,Q?OHN[])T2C_23fVLL;NJ9U?
^7BFGQXgX:/F(<&VCC<7UTbYV;Q66\AN&4C09B,YW=6;NZARfGgVb#3>A7J@P:L&
)O/e.HIV]4f&)(CC\+d4JWF+8MK&YTU.2@(DHYL&:0Ccc\&-I4R]SG7N[eBeKJN#
g?4,1EM3gAQIQ-1fVXf_EG7F)<_]_+WHIbOGE&e,^8SZED&.X::>50[86IC+5OB[
.0^aM@UAY?<PF[<HSA70MC9VB=X\A\(R?NDMIb]_NBF,Z3UM?O7\H^:aC6.+T\a;
BFM]EAK.9JE,9WCJ0JaE6LT/HGV4S)-&;P1dTBMRH#]+X34:K0gH7b-?M3+bJ(+H
^YCZgRdCQe6B=;<b.O0fO4Xa44A@?8B,fWL^adU7[D)(]NPJB51[^@9GE5ZQea/I
V0Y1Z[F5]ZVLP@Y6./]:K5.)E#?^R.ZfSW^DO7NF,_T#[9TY&+O#X>FO7ad6]\=D
bA\IJP=JZZT75Ne/W:fA7P,c]L-3)@L\a]/.HbH/)0F(Z=/=fe@RbR_/\SQKWL?U
gIa[\63(XO9_-(5)<f2#a+X>b@;QXO>DaKdZQ@^+7:L_KB-T?EW^:g42LcEP516P
BI&,:@UO5cTKU?/A[CRdg_gJ](03]de]67K])GDacMJ:;E3(1fUFS^+N42J<+JDC
751O&0B[R_AeT2Y@11=7R&J;4RFG7:B>[JZ=7\2A9a)ZLbX8TNW]ZR&VW)GWP2a\
V_[]^)L&dSGG2^@&WWK-_:e_MMAI&W..I\0.DF6ED_VRed#USfgL,-gH+_4L9RHS
aXf\5dgX5d_&IYM6)<TBSe#]?G6,M@N[LH<JVf4_82EJL/G;P9L6/5:L8ge)\0W.
A15U9?ZU/UE7:>)M(K4EMa#T0cfM67RC9K,a9(CZT3^V8(Wc..3;SbR_B^Se8@[A
6JT8=_[CgdM/.ffC[_3eNHKE#4-?2V&cgZRQc,TGa3ZM-MLJS(X=cX0XWEg.@@ZN
]eRe9V9GTg^+WOa;KZU\1#AN\4>Z4X&SdG]e-00IdX/4:\B46/ZG23<6V\+PI6?c
B(aT\SC.4;94.aJST=e+TOBMEF8>5?03U[-Y+U4?c:-a=O-0JM]Yb]fH.PHRLRYO
N<1TBTEBdZa<?FO?BH639cF6I^)1E2c+.HU7T;>_N/O+<,Ld>Q.aIATMXZDgd;IZ
<0OTSO4B#e&T1&dQL)^FG_4H1T&0(]e^<7,3E_=TV#R_+LQLYeR/JVfKBCOZ=HNO
YT4Z[44).SR]Ke<CK)6>-_W7G69,TE9W0JFT1+6_H4RK>),ZO+>ceK68[bNJIO#0
B+;c7>f-6VN;2427]U.Kdb86<D_H[I5Q94W1<+?6.=YP2-:V.[OcPRf:^Z_ZDB[0
^V?MAM21&881_:8/X<_-DXW7<YNVf\+e>a[?g1T@9-O7):1bZFeCb#+WWWI8eXH?
8>&)X(\LA64)6?XW]YH]93Q.VTK2Q;,Y4<N3O41K^@J_e-<W<MCP>KPA^-,=9CYS
8.##GD63R[Kdf8<GN1S&7eXKR-gGLd/+ASb.T4@3?O5@O;Ob5eVBcJBL+99,8b7K
JF7JcTX_WE4cM,cOM,9;A3R3I]Dc^_0PRW02KHC:3NJ6/J0@ZLN49N?FcFOWTO8f
H+^f\4-[\a6-(<b^Z6JFT.,:Yf,OPV&&4#c8_<F(0f?Q7fVQWaG&]Y,ObR#MB:BA
FWCY/dPL4:)/=]Yf7PY7[RGY,:F-_E<TVAI^@EX(3&Vd;442^8F9B>(W+[SK,PZ&
>E0UO7#OFbG]1O?-KEWB-Weg\^[cA@L-(Z_\/K(B[b;dF$
`endprotected


`endif // GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV
