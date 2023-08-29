
`ifndef GUARD_AXI_SLAVE_SEQUENCER_SV
`define GUARD_AXI_SLAVE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_slave_driver class. The #svt_axi_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_slave_sequencer extends svt_sequencer #(`SVT_AXI_SLAVE_TRANSACTION_TYPE);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif

  /** Tlm port for peeking the observed response requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(`SVT_AXI_SLAVE_TRANSACTION_TYPE) response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(`SVT_AXI_SLAVE_TRANSACTION_TYPE) response_request_port;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_put_imp #(`SVT_AXI_SLAVE_TRANSACTION_TYPE,svt_axi_slave_sequencer) vlog_cmd_put_export;
  uvm_blocking_put_port #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) delayed_response_request_port; 
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(`SVT_AXI_SLAVE_TRANSACTION_TYPE,svt_axi_slave_sequencer) vlog_cmd_put_export;
  ovm_blocking_put_port #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) delayed_response_request_port; 
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

  `SVT_AXI_SLAVE_TRANSACTION_TYPE vlog_cmd_xact;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_slave_sequencer)

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

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   * NOTE:
   * To be added 
   */
  extern  virtual task put(input `SVT_AXI_SLAVE_TRANSACTION_TYPE t);
endclass: svt_axi_slave_sequencer

`protected
TFfb9)@fWLJ.0)G:KJHe6b-&c()OIY4O>N6O?NYJY\M0?H>>b\&]+)PBe\2bZY,f
TT?I+6:Y/<YE8W<079ESZYBIY<;_b56XK:E0+<9LBO\b?LCO4YFNG67;D.;K2=EY
-R,D8=)fd;>.X:ee10,3R6Ld=>QM>MWP;9ERVS]Z4&Gd.38c_XUcSM2U--M)5#.N
5LXCF@[?9J&d0Y<BKZ._2Gg>2;aVCg6cO-a,bHfDdBO>&b.=]dY12E3YfU@^>@ed
MKC=W7&:[DbGGL]gPK.dee:TP^\-0;Y\,:QK6;[@;CGa,_<.c+A7HVAEH1Y[aOUU
\E2:5GJ].d?-K65>,>8aJX,0a7Z3DXD5G.DQ#YbB.WBZ7eS)aUHY>I.,ND<=?R/\
L2>;\3[D2@]>WcJ]b4?W/3W(5E@[&;-]8EPg\>ZTK+C<S^Ec-4AU,NKdC.M:O,+(
P\<@CS0A;C8#1Ce5TFL+/UV2W1^BAZ/c>QX;_[aZDQg?c^7MTR33FZ8?@_^^@6:Q
AcbY]MbaP_V7TUBDVJbMHW4+_V];;BFDTR_B3])+:U+g0c5,-@a[ff^F\f,<8M[3
.cTSKYeN6C/^>bJIb@ZeEWePX&UbPD/(FFEFFD2We)TV6(N0@(,;Ud52-19)BP1J
6+/;)0FN>HFV_2N=1Q)=5SeP4$
`endprotected


//vcs_vip_protect
`protected
LAaRNDd&.+0@#Of1[2[[2eRVO:0<Y5Sd1PF.3I70_G@9WUU_IddE2(+?5151;d2[
=26Q)J6;F+^;RGO,M+0QFAXC+#;E[RO8Ta=W-T41ZW_FZGIfSf.>E<a&/agbI26d
\a;X8(RA4O=69T8J+Z?Jg1PC#MfD=.-J0a(,fYH_146gE=MR:=C\dIMQ/-26E8>M
/cO44Lg<Og;d&1[D&(A@a1-P^BU5@bLI9<&F^88H6a7J-<c4,CH7Z)We+?>GE<8C
)EST\^D@F+.WN1K[@BP,Ab2ab6:f8-0cST?;XH:#RO<g-=)5ISP:c2[#R>(4TeQ#
0AUV)R3;d_1TA\B:2FfLLgH42ScZTfdc+^D+X(,4B9(<#ZeaF2_>9c7XVYa8N?2(
O.#?WYaX,].E3e9@2^(E-fTWXddaG\Q\B2^NedbZ=7GA7Z38\0-LJSB[2Cc>/>91
(faJI\2O&Fc5<FL_9LI-0-M8&1C@2SbI&&JP_K[.SB;YJ+)@H<K[L7dM6T85F+Z9
<U6])b]g4I+IPUT\(#PcQa0UO/e?GB_dS]+,A[a-U:MMY5OYZ)9U_R;<3<SS96LW
/1X@UbBO:C6eX^5;M2AFHaB-f.Z<ZL_WQS:F,^@J7+E;;5Iec_-T+RE:0F^O;0FF
#<T;POCdWK9GHWHF)MCbXg.;=CMAPfH\)M9.AJ,]=g(\[TE:Sg&]Yf6FMTfWHBPE
3EX-_\+UZH#[/U=JK>WB9<^&;I9a0C3,I>N:LcLg97]EV\LXE49b^4BG\>N20Yd9
[7D+S[eg)02#+C?24?LV(<#fC0+^,?G@&f_<(TX1WSZ\H8W-XaK4E;=@WF/),>X,
XVC?6_5LDWFNK,?[96cY>EKAcG)OCa3]1:9CWK;BKM_>J?Y#0U]P6-^,R0^SP@/c
@YN9)VKZ5TUS&.O_]E88.>S<c5],I/P0bR<2R[#+7S.(I=PPBeZ?F4#)1YB1HQEZ
LaT&3Z3Z6d5@6TUJW[Z=U&43?1J&#,/QK\N)\0b\#-1_4C<</E+ffSAMAF8JF]OV
]EK>7/OO5bX(?)6(Z;(TGf4DCP\gD-+?TI[f.)>+<VZZ1XE[H/LUF]2KQ,AI05S+
CC)/<]L0.BQ+38)3>NgL[J4Y?/4JVd78._Wb^1TD\83b9,cNeC99cV>YNK)M-O^=
aG_g?NIUa(Z[BC5+M5GR\D-(N[bA5__+?_Gba>.f7?^FL]K?DE(G7<[H.M5[Z>BR
&Y,c8OV&,_a\DZBG)MZH&?e:S?53BNM;<#XAQJa&g[9]1_[XDNA0(YJQC_A5X+>b
A(W<)>^,.gUL/@D+K9b[e\>V<D^=1[^\V>2R5HD:<S<WOS._He4<&NN)S)O]<XJB
U1Ae,M^N<Q^D.EX8Rc:?RR=O>Z=OPLHN^3TQ]Jc&T@Y/_7LeMQ.2H@7LW&P69b8(
b@4,Ie&UF:--.TI;JRV=Oa]E(UNFO;f,H6432W;)<<M9;^0K+84NO,<Yf6P63K1Q
Dc2UJ;B?1-P.2K?/\)d[+AbTS)76E\)=8J366?M)ULE,bUTa:[2Jcb15T\R7J8;<
a6Lg4I\2E)cRb&gaWd/V0-JQ\7J5HF]UAT2fSQb9VQ_S:aa4.P+g:G7cM?5#D[(A
;d3QLU9c)Y_NOZa]8RBLa/M^cZPa_8g[W19Td]MHH[3g)eQY<KcL/:-@T\JRV[e7
[Z>FM2)U/#9cOXC)fC7A=KZ+,#S7VI9V0d^:=XV9P:.eE<07>0>THc6D:_B&HJgZ
O2G@e\F3b#8,?J:e,1Y^3CR:KJ\1CC7W.d:;7-1K+LH:(Q?2MfN__-CR[ae:D7UN
beU<#/:/V-E5,cSDOX8/4-c)6<c4?I6GPJg/0&?+bc<2b=E0&->QV:@dFXF]K_Ca
XP18UabPVP)a8f\6J<IRTOCP=9]X].HeXJ0-e<MG(Of+3,b0#+S+^1>-A.T/+fN+
=/J,c26Vg,KD(cO3M(O?,DUQ0IcS2RV2:3MaA=a-fHDLP3c\WFcHOSR;[;:[N;2@
Z3Fa^=e7aYd]DI0bB(?Cf1_d,>cH3F;4Ed4[cJYf/^a):1-//^2OM23PAR+D0.V>
A@dIcSE:DUe0cW2Z+V94?U9GLW31=5&gVe#_#6HW,.7)Y557TfbG6K,:7f<.c;UU
23=IW-HE0?J;VZP.f)43:H_YV?6#7:A1F]SaQR?9SXL#UREaIF];D&OF22(-[9HI
aebB/SK>db^G4&-fTJX\4\eBeD3S9OK3-4Z+8K]_KO2LQa>BGVS;DeH;7N5&6H0.
XZ>Y\B)8Z3S]2>UcN3g\RJ&-+_EQHa7NXFC&TMGdR4)BEVVQ-dIV2;=HX)QI&H3P
H(34@)J\^3LO6S7&V4H6R2K.B^[^^K76ZdMA+;3)#LBaSb5R33>d8?(38?f=I@BL
J[-^c:U1bf<+#;6>\&KL0B4+;X+(MJ9C@=2GOc.eZZRg3,@VC7#@]?6V&D-SC_Cb
K0R-Eff(?<&PKJK[K#7&>\-1<0)fI7:dg9f/V;54ETGIPEM4/WD:OFD[#0AaaIU\
GcJC1]&?6[@U_2&I(A:4&(]6Fbb;__:]EIOHD9)1H.R?J^(0;M@V1gME)K^P3/9@
JTNY4aD(Fe9W,KV4gU3V@[;])(-U/^>,5JIC2D;JIF&.g30-W3g(&:3)Lb]<37F,
Nb;_PK(L[dJgW5_/\S8@N/-7gd:7>]_6dc3>-5+CP=b468V@>>6<#F[cP,G88R37
?Pa#8[dK3=L#CCLA&[e(,M4357,&./0Fe?7NJ14?#N,O2D.<bQZ.(Q[+<=K]<3^H
5(#,G>I,b.F]X&_fY[CU&dQ.GBIM/E4?63_VQV[T7+NP=WLb816a.VdfO=g,&\[=
BW\^Q[0/.?4YU&NEM(=XTDWJD?.&1(CV^_4.N3(@?9MUJMe3&2JW<]^Lbe)W#FMI
P.V^W@DgMWJeQ-+e//g-4/WJ8$
`endprotected


`endif // GUARD_AXI_SLAVE_SEQUENCER_SV

