
`ifndef GUARD_SVT_AXI_SYSTEM_SEQUENCER_SV
`define GUARD_SVT_AXI_SYSTEM_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_axi_system_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** SVT message macros route messages through this reference */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_report_object reporter = this;
`elsif SVT_OVM_TECHNOLOGY
  ovm_report_object reporter = this;
`endif

  /* AXI Master sequencer */
  svt_axi_master_sequencer master_sequencer[];

  /* AXI Slave sequencer */
  svt_axi_slave_sequencer slave_sequencer[];

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_axi_system_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_system_sequencer)

`ifdef SVT_UVM_TECHNOLOGY
  extern function new(string name="svt_axi_system_sequencer", uvm_component parent=null);
`elsif SVT_OVM_TECHNOLOGY
  extern function new(string name="svt_axi_system_sequencer", ovm_component parent=null);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Pre-sizes the sequencer references
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_axi_system_sequencer

`protected
/Kd[TBd+KYg,S\RPZ?6MZB5M(8c)d=#4>Y.#3[N-6UEe#2[L-Q376)_FN?7S&dQ#
2>Pe8SSP>QYYcdLH<eeVJ;LENW;?[R/AQV;9>eYU]Ed9\91bRe;Q@M1[<U5W)A+H
T+C/SX35&ZZ;]]RJ<=aa;CAd75OZb[eTB]5Z/8K7[UfWIAB,A2)@2_-GZ/cO15_4
BWGc^RBMJZ.UcP\\f;/Ea]R-<9\dT=TN<3;]>J;4#(U,^9_O9762S=^3EMR6E=e[
eLcCFgXZg>b\&(H4aU;AI3N2GReF2AST(SWFFBZSJTb<bb39e.)THa=K;HKIL3f-
e^Wf40P7aY&e9EW+9,2^M]G]E?bdOS?9b73c^RJg7#dQPVK[Z.c(A9c7F-4+2Vag
c2=42M\f>C.cO<875PaH@4C\CE^Pa\(a-RMB^4b7B7E6bI?+&-=f/U^e0&7.K6V=
/I(M5+MT8GgG_fCR3S2[B4bU+S#^J0R^_D^;9G5]2]W4>]6RN97M_OBVKDcHSXCV
V?-9d1UVSZ\[ESSAVHWO9bM[;)X18,P#dY2-/N-?&KN4F$
`endprotected


//vcs_vip_protect
  `protected
f8We6:_-TLVY3KY>dPEb]PK+V\5.MPdf9.<4EY7]4Q;e//>G3Xe@)(FQS4--<.UP
\U[9MW<W7Z^3H3S@[D>e2[0?S,ZXD,0\VHTO_K/8b5G(V2ef&6?W[@J0&d@O<+YT
4+S9deF2;)[F]@B6R=Bb:aeP>cY#R\Q0AcQY-?-ddgNPCK[2ga<5gc#2].U6\8?W
R\<>:T5CaR8)C@S(PSU;bW)BG>I8K8ZcYU)YOa0LED?YQ0NfQA8d2ZfKPGE:\fW-
EPDd>O]VS_FG/Q.BTbER]U3SSHa\gX>LWXCRT_^S04Y#0<61a^@+-&4&9XQXS##f
e/I\<;d2AYL3K-&,LPL#MgIAVQ1B<X3Ld?[DE]CSb>6]MBVe@JJ>g_F2&HTINU]T
#_P.D>)G&4@(BAUfN+O,4U0RX4.SNV>:;Sd#<>Kc/C@5-+YXZL_NQ[P)6Td58^Cc
VTdLEG?-SX4fJBAX.(E()?RN?FbV2e@c_1^ZIdN(eI.f5NW54T0A=^6K[(fDYQWR
UQCVP1D91^IH^VB(e:6(LS.Y9GG;ZW\WF2-810URM+V20^,=BeE6TENFCZOAJSW0
_g0XN&]&AT3B7S]KKKZ#g@D#9S^46JC=,E_N7L<]@548f-&Sb=7_VY&\6bUMf30X
-.1TVBc#VFU3Nc^YG:?=D.MG6C[07-L;W8E#-2VFP4g1eAXG@@2ODRUS,f[5VeL.
WJ9EBT<OX=ML#N>UT#ZO@FIF]1SO]0(07_:=bd2Y-3W6EHX,8>ZL4)Z[^[=QS#GK
>YGF5cW\H79+UB.N51E&K#U1HVAB0J7^A?-W6I0>3(V3]7-7W+5;<(.V=Dd8.+Q=
N;f[L^U2?3_Kc[f7\;2R)(Wd05[S(M-c0[7D7:Z^GSFK3QbS72F#+6g^UG0^;[Of
(GO@#=G/F_e_2A)Y;R92&&Z)^-LK@]VZWCI,WK(U?3O;Z<c=\fK9GK?E0V+8I2(;
NK/-^Mb/L;Hdc,XR2>QKL]NJTCO-@cd\QGF>ETH;>;FSOd^&;\@-KI2QP9fDI;JH
=@c-Za((T#B1c39.MK20.R@_<8Z2-1Y?X.GI\>cT);)[;E/3KT=12_VX+DJB;XMP
D0/D3II#QOcJ4:dg<C8N<\S:CXcIUPOUDIHS^/[E&KGO/1;US#WE)b:g7B[[.C?:
JUZKP+5@e[#K,7.=4-a=e8?D#&01EJ_c-3-a-H29V[5S[<\?fRVbNQg,#C744HY0
6A\RY7fL@PcK[B-V]dX6LR1QRY2QXf[W&A<HEBI#4-;g[^S8e>,D?L9fQc6+D_<[
M2=+YgR=2=(O38FNa-g@HX,T_E)d..OQHDf^<X(ZT\APGYB^+MI=+0dV&.E#H95>
RcR]0/_,1R@,M_F_RT18V.11SgGR_G10S\Bg2cQG.W8SdAb4N3;@#OSaE=NAXK97
YJ\[dSX^C4VW(4)+(DBYG[M,53a3a/bS2:-]=AN@O628LUD=E5?<KP[Oa^#gDV^G
I86X/<UIH:NRA0ZTZ?J6XS0VQ2FZ0BVF.@9&I/_IdK;,?^cb7TFJ/f97DL?;Wa,:
0R67L9NK/BL>>:T@MOTXX(0V7$
`endprotected


`endif // GUARD_SVT_AXI_SYSTEM_SEQUENCER_SV
