`ifndef GUARD_AXI_MASTER_TRAFFIC_PROFILE_SEQUENCER_SV
`define GUARD_AXI_MASTER_TRAFFIC_PROFILE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_traffic_profile_sequencer extends svt_sequencer#(svt_axi_traffic_profile_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_traffic_profile_sequencer)

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

endclass: svt_axi_master_traffic_profile_sequencer

`protected
RK5&g7(Q]I)KHeZM68[<HL;J84W-c\E_I0L.OK?^A5:JP^RV5#.9+)We+NfXVaI+
,f_gN@?&/7^9-fZ@+b@5R0>WfM(SM#b>\O-F2dMS><WO.1I;&^4@1<f2.VG0;0<=
&KZCB;eX0EbT#HZ9.1K-e:e+>199/,1M/?XfP)g^9]f(\(.1P<E?-VcQEZ.?F@N,
W7L[&^3HfLb#TbA^fLN\[X&>>>#@JR,0gI4]W\_NSRBZ=>30<[@e=Z3e\Cc;E^0g
(Nd[E.#F_]G,/E@gVJO9SZPWHdgLJe8MYc+R#W4GeSQbJJ(]Ja:O<\b[)]A,X5UJ
b2BA42T@,E@&J_+C;FJf9XYTRQ;X/,<1N;42-geG@VD>-DQa_R=d>G@K8=MC^T;W
59dB,M@H/PSMX-P-WM^QJ/]B+.]8?]L-TDD18X(:4_c5U@LKANg@NJ<D59[Z]a+T
\-4UbT)[09#[\WQ?8,Y=gV>TKecbN+=B]X/3<.T;L<dIOW<OG>UMZ8#WPA.<NGD=
N,J_6SH<Ra7[-[=),:=fF>-;3=B)@e\b)c]JFaAHNC[1YF]N)C.Z(,/4063V?+c0
_VYH[,?ZF>^KA;X==7BJ.PgH8b4;E;[gW_QdP]Z];(0VOK;ZJKJG7TZMT7?#/gSW
Fb3@R;-7X4WA@HC/@EcE5^8OaCMFUSaZS.J4Xda]0=IaGL<aD:G=8FP#.D[#[KXR
+B<\+BWbFTf0+,UFLBE^a.C:WB5Q\UND+R:aH7cDFUa67g[URfM[N^AOadIV52E[
YX18BBI1EN,-MQ]&/G>B_/.K+L9X5dbVJ_dce_V\T4I\eXMdf7W.?A[\5(IK[.:g
+H27fbE<8H9ZZ-cTR.J>_WZEA/5B;;7I\\HA\MfGVd=D:>H8dG2ECP]S>@XgTb)e
-ed#Z3^JZSdgNB\?3gIa2:,Y;890P-)?,Wbef:32/]\),8Ya8D=eOTE7B>=\P:&3
-<YeOC,LF;Y;D4KUa0g4g03;0O)50K#bK^EP4<#](3d6,D.:VMD0:J.)S24fGM^C
Q9PZ7Q0Ha1GPV@NL9Da(Tb<8gVd..W0\2NKKK1;YWf/VTZgS9/?LI@L6(g5//#7g
d+1XR=cL=:cH\YV5;,dLAfN/W(]_M\b\1W&;Ica,?N?SPSBX8)-XZ-,PeM=:Me3+
S((K/1eK+RE1>4JNUO<>#Z#0&g0>GZ[NVHGLGO^CU.c&dE]RV.N7cUe#AXJP:U(Y
D>)YS7I\?J-8VTLC7UM>;(IK?BX5.P<MLXP(J&N)+==d#5fV5KI0Y_R4WY7&ZJG;
Zg.gbPUHDX&C^1>G=BC<Og@3d[bB&5Ud:UO@\/89#c@b@X5]1e</T4;K.CPH4)N7
V/)Q/P.Ja9@LM9dFK]-#9F2[N.CHBZHU.59;7NLf#^K<eJ6&^E40(eb[G4Ag1.ag
SQ6M\0EE+KO1@3=d/eI)QL&G>L>E81@aAV]e]HSP-4bFK3F1af[1H1NdBJa]TTSF
_9d5OFFNZAT0geMY1/QRU&CMUI,G2bP/fGT\49A_@,8GXF.Z[ODgUL:,.]3>g,W]
X?(4d\1Y76eZ,(-8Y<[0];#XV3Ke2SXGbLVAWX6=S0HH<C+S;+-X(7FWAe/J^A5V
(GT2P_1a31YCP7?c[(L//MT[JC1D743f[5N,;X14(@?6MB,WEY=/)YG1-ZYDCfbd
_]E]EDQ3@fF[HF9\A8T.#4=&g6e=YGdVbF69beENg/DXYE)GLIgWFcPQ1,9T:6VB
+_9;1[>/g&597cO5=c\5P4Tc_Wb^^8<DR##TN[.M@B_BdY10cR8AUdNe_e?Q3.EA
<9MOQ=ZGDfYN>,7Zc_PX@,#<2(=F902TC2V\U8VQ=QKYX>;<dSfPVK<7SPKT[S#7
0.(f/2#dcVb?aRH>I)eWX)U_PL7EMY/G@NYN6:2:A<\AgO<Y_AQQa7QgS5X]:92A
]a^]:G+)XBZd>QRWA.F49@6/e^X:N]\ZIfQ[<_cDWP8&,@,]AbBT?6BeOM<54BZC
KZB)5DL/?A9S-4:R8V\ZB?IbggA>Y@7g+Qg3TEeYL..8HcK5Q5#QEg1Id7,KfGD3
[DG]-]MT]S@.GA/M7X[?f8OS>UTScMRE>A7cOJ6GA[8I48SMX(DYGCHg#^IR5Q-_
13SUPd?PAK=TV;^<+=3ZR\(g?PaBKYXd\;K&+A37/e4F>@V-;005)6RPD_<BM:QX
_2<UK)CP[I>8([2<F7/#W4NPDF[2^P0K&Q?WUT5;IA>g)I+aYG#dINRPK$
`endprotected


`endif // GUARD_AXI_MASTER_TRAFFIC_PROFILE_SEQUENCER_SV

