`ifndef GUARD_CHI_RN_TRAFFIC_PROFILE_SEQUENCER_SV
`define GUARD_CHI_RN_TRAFFIC_PROFILE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_chi_rn_protocol class. The #svt_chi_rn_agent class is responsible
 * for connecting this sequencer to the protocol layer if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_chi_rn_traffic_profile_sequencer extends svt_sequencer#(svt_chi_traffic_profile_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_chi_rn_traffic_profile_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
 extern function new (string name, `SVT_XVM(component) parent);

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

  //----------------------------------------------------------------------------

endclass: svt_chi_rn_traffic_profile_sequencer

`protected
JdbQW,,e[FKb]7DL6Vd<84K[6:5W(fF_9M@V>[5^I_I7/55#(^N-+)+(HAXd-UcF
Rf9K\+H>LE.1><W0<DA8TB&P[>d8WDgNX0KTZM]b>-B_R^]dcR.<892P5&eIBGfA
a)&D1VdbP^0.RgO)HYI+@:UF,EMB&aX[d[Z[Wb.)2V=HRf2ccJM?cFCHHe>.D5LB
6b(7XVD_5:<O@57^0=UQ<R#@GCKG\)PXA^aV[+EA+4ZCd7L^/g5P=U7cb#[a\IXN
+8IK&>#B)+XO9]Y7RcB^:FcbZ(4GTJ/#JcYNK+V&4]>C_-O@SN\RcZW-IKT5(Y[/
_]cMSM)JBMBZ.W;d5)+U+;7IE(?Q6]5,8_AV5YC)=Nf@1#TDGVNFdee3/H4g_cT#
HSH=6^(21V\=<A)?OW]IK1#A;L>7#3[)??SO1&>3H&bH,<10b7J4JgO5QS8<dL5)
PfeU:fAOXUZ#0S8eY)/cBP87Z>2=Hg__);5O3.0(\2+Yd?-<YS&KdQV+W0US/5e#
UF9L=IeQGVXH-C)#8_^1,>\IR[Y)T^CD_3HZeU_5XGK-Z=#@@8Vdd;XAfM/3Z0b_
D69>O:--.=?=MD,5^_?2/^F=:P@,)HR4##H?4>;#F,94CUO?Oe0]99:E&L4NG^<;
5d+YFSD3EOP)dIa64AeLJ[;gEd729H2_+69DHQ^0#]#9(UN^RW18ZR\EM=GZT#1Z
/J46P5^/;IO;aA;dB[8<YDH3J79_SS7[]Y_<3Z#\g\W)YaUI^.2M#U)LA=Z=)]-4
HPE8#G(2?QSXZ,IVW8dD>>&6O5?=:4AQQ/PWKgKfCNaYaF]eM?&0dIC:-Tf]e;Aa
P.((9(e,0Q49CZ1631@V)WeX5=S;M7IANUL8+a40\X0G7-?]WD-9bON0\g@U.N^T
G9a]5;9d?c39X,=_C7M],&:=9PYbKS<LFbdER=D@dHZ0b]O=)(L[Ge8d;?21;<\Z
80Ja/\7G.S^EE)FcfN^]46U4;,[e^5V/Ce6/#69HERO?02bF37?AKE5c#TQ0ES.2
Xa^c4DA?>ZN]WSa:,+f,=:f&AHb\6bP\+]gD/LQGRA:NO+_BUBG:S^G<G^Bf,S(0
&\0c.Y.SA+<aWgb:Ke=EfPcg#cHNP(=8E4R,,TDB-QeJ&042IMF#4>S4,:MdbM>3
ORH=@UGde.\O;e80cP1S<g=6(=PHVR91dH-CfPW6g>W\d@;;EMO(Oa>EHO9#>R^Q
X]GC]=:CXGBf<NBe.&H[+;[\H,Za0\Oa:;H&eI:AX:1_UV^0#828O=>NSZBY2-Vb
bF6=IBC1b.IW4I>&]-KZeNR:5;LQJ^T)HXMGLI1;RB8P3@>f@6#fIA6U^eB3dTL4
<^:@YO=ONI).8#V#S=Hd:MJ83T^Ne9UW/[,,a@C\>=\V:(CP_d3f_Kdb78AQP/MJ
I8cPNT:?ZfAXPaJB4UX=5.SPZa;3R0</OEL0#^@0+(,b<<:J(Hd=O,]B+OD+ca\H
DG][^&Z>3A]cY;]JbVL]B?U]:cAO_2,NF[J6/19OPVA@3GN439[UR0S3GUA<H.=g
J-F,eC^c_HaEY;+B9XN;?aF_S/#OLVK_?BLNcT8TT[_\Qgb4A>d)_#BOKHXKY:PM
E2f&.AQfY(\;&/QV2ZLTT_P9YP?RL-#,WN_CTBK&\X.O#(Y5#g3Ad0JWc57P>dL:
15b2F44K,2g9&PR\d/3.0(5?H6XLGXQ)]WP5X[G7NOR?5&ECKJBY,S\S3N_@MSQ8
4V]4b^G<9G-L-dY@_cWEJG>XfTXZU^,G4;1&U?1&5H]58ac+<\82@Xg7c+>W<_20
9ZX?GHSXd/ScQZY80HNLf4E^N6d]UX]C.?;c2#7DFR>+Pbde&gg/L12=CC48/47V
T-VCU:ZMCF+5U5+-O8>=FXgCHLNZL&Y7.f]7ZU0AQD&&&\\Cd=::?&gF(.?63X5(
JUe\g?GcOCGZC0L@XC+1(9eYbG-[gF+c&5I03H3PccgI/U^8G2?bZ05YALNL61XT
b6VK=5O6FS-Qbf?=F(^5,^e@\Q#G<KD1?P;L79fGT^,Q4_,eQW4]?X75:X.=b1aD
He]7MZ)f++.+7gNSKJC[R4HCP749FBGGFWf[f9>&CfEY^3SY:,B)J-HM-@0QegQ0
9P:+T_6(8VRK2G#Q3VLaH6H,E@;1UIY)SF(5V5S9gN4;3EF\=VWONN:.P&)Za-CS
E)AMNX]1];YSN;K6(()188H,3$
`endprotected


`endif // GUARD_CHI_RN_TRAFFIC_PROFILE_SEQUENCER_SV

