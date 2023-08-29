
`ifndef GUARD_AXI_MASTER_SEQUENCER_SV
`define GUARD_AXI_MASTER_SEQUENCER_SV 

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_axi_master_sequencer;
typedef class svt_axi_master_sequencer_callback;
typedef uvm_callbacks#(svt_axi_master_sequencer,svt_axi_master_sequencer_callback) svt_axi_master_sequencer_callback_pool;
`endif

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_sequencer extends svt_sequencer#(`SVT_AXI_MASTER_TRANSACTION_TYPE);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  `SVT_AXI_MASTER_TRANSACTION_TYPE vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
`ifndef SVT_EXCLUDE_VCAP
  uvm_seq_item_pull_port #(svt_axi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
  uvm_blocking_put_imp #(`SVT_AXI_MASTER_TRANSACTION_TYPE,svt_axi_master_sequencer) vlog_cmd_put_export;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;

`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(`SVT_AXI_MASTER_TRANSACTION_TYPE,svt_axi_master_sequencer) vlog_cmd_put_export;
`ifndef SVT_EXCLUDE_VCAP
  ovm_seq_item_pull_port #(svt_axi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_sequencer)

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

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   */
  extern  virtual  task put(input `SVT_AXI_MASTER_TRANSACTION_TYPE t);

endclass: svt_axi_master_sequencer

`protected
01HQ)I(^./IY#T^N6]?_7I1FdVH[N0DfDa^6G2)fabLf>g8J6@&B,)?g8B4?+:UG
Z[d39_L>M&\?)Uda0P\JMH:/]/c:f@LU0-Gg@Tg&>cG)bD80+RZ9DFXeE^c#QXV1
HC=/_E7N:1PS+W,U>XEc,)L2J4KH3)?Jd<KE=Mc:Q^6>U,(P7G98dYRPLVb=b;Pd
H2K3fM;[6TSJ8V+H_5M8d7#3:&W:D:G7?.?ZMX+2JLR0/)ZeFa.H7PYBe@9cgJXH
K(>U<Zd7)=1FHGUg7V\][TF+FDGbKK1R2]D-@E7039^RH,<+,EOaZVEU?NH\dO)C
L70]2#UP#6&/RbFK#N<E61]:C;>@N;T4V3KXLYP,9J4#&7Q,#J9B.I]]EW:Nb,+J
4YU-TK2\OG88+c8V2JI.,XEe<1Y^ae2YfUIK0+fDKdHWbIYD8;YE<?Cf@;ZAC<\c
)IWL4JVGT/bc,77+IK#DP1N=9R/7Q_HRQ0FRRcS\:+Y0\?#JgegC<.)Wc;]OJ0DV
IbRTOXJ4&)J?Nb4[R8,OZf1(3H:GU.<Vec5X@fH+g:[,?++U6>K=YL3MC=I2)818
R(E6/<G1RA;N2EGHd,UL<BV<L\VWA/>OA7>P5Q=V4&c(\F(b=FS6bG^b5_be8.&e
cfR9O]-O6SbYOQS.8?-J5[C0-[eNL;2G27^5eS(?/0+-5S^UCf-&8f3J;[,&ZR(D
cLe3IG_EE)OR?6?Oc5a2Q]T/1S?g>EEIU-O5:]8>#0?:V+]N0EHeW]&f2Xe#c7Sd
JI3NgdE4I.e,?NJO=XQC]]:_>KGDS\ZbbK6L:R8\U2):IE;E+4Q?&/B?5>Q/-RV,
=6c]3,T4:EdgV5AYgf3T5?([UI5D8^@f#fG3<X>a3Y5&^@,IPY92B3XD@,BQ8C>6
Cg]Ze#6F^R1aPbEcI.3fBfg255T[S(=;DZ+1)/G\-d]_U2?(06U#V+PEJ@Qe^dA_
]Bef+:GJ(X?fO>E,W71,AQ#9gOfS,I-[5\3cLaH5XT.R7].R-0f[1J[Q9.JGgX6]
NP)=]7,+##5f+$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect
`protected
SD\_[AVfR]F8gUK9eSF4++Y#3J[IVRO__Q&&gg:W;GA:?@&[;N?0((WQRBB.BND_
R(:I32f3Y4DA(57&gO5:#2M)E-(>A8EI-)gM_/8f7fXZ2TMeY6@aOFABJSc;CI\&
O#bCSHDDb[MS@V0d)O<AOXCF.P:\e,OGgVH1U,\KL((Ua(/L;1EI;F_>NW2NBAf3
/6:CV1]RE<fZSb]3(cW@\M>e)UE@I.R@edZ>>/+3V4>cfOgJ3MM3Ra]V+b\/VZf\
0N1QSVNZ-7a^/C^SZA,b10U?L6c+P?]GPU/4IS&d\YSAa1PZE/ffQET/GEMS4+W;
5C11#9I3W-,3[J606.BgcHHeQ(QPX>_T=b8g4-8J>DS.ZdWG/C\7-PWd:JQ0SdW]
3cFI9D1;:GD(=f?<F70C9IL;]ST:eag5-TPOZ4IZ>&V)G9IB#3d0<1&ZBXQ@/>#O
(4#2V1SXW;D]:\QJR-^8P+8J>3)RFIA@M3?d8eV3SV_+OW\J#(5M6[^/XTPTUKUM
g=?85ES..2^gLT1)VE-HbW>11#&VWDI3HfDLF1e&LfM.,2+7;MM+Z9&LUZLHaO=Y
\YE=ZXVPG4^+a8.&J(ZI;Ta&H_\ID6[MBaIZ./^XQRA5Y_2Z(YT\MgPa9>L1/6L:
D;]9-b^I6=#1EE)<?N(A(eQbJ,BF;U5XIBSWZR4_A&KI>I;U&7T;U@:F1LFF#-U6
Ug>_:?gN40UJ&CG0V&WC;A,MBD^af6_R61OfO^N.]//_1XX6a+]GNT&;8=&P<_[8
KP<>7(&0>OK[+_NO_]]--9W^3<2>,DfGY/?b5XV.QBGZ-aKO#M1>DQ^?(NgB^R9H
3JB=TMJ3,1/EE2J/1@<bOBD+<AKfQ2d1)WXg1J)&F;N;B&?V(5Hc=(AY0<eNJCU-
\31<C#40dCNT\NQW.E;Z,QO6:B1NXd^gY?H2?dTUO@28+dA>c6^K(bA;R-<UcX4#
gGJ4TOR.SCe<::IL;>:M_/<?]^X?.@QK2S2P(417LHHfCP&+\KI6MUQOS+9];MOa
5eU:2g9ADS14U\:YZK1=5CQQ7\fSM-cBM][UNUBS>&bE?b0D8PFS]JY8VQ3#Q\&;
G>SW/8\1_gc=bBD#18B&A(CB:BM7XCcg0:9\aP.>RGYCGbL(b=4&Yc6gV.D<RfLc
MSCa&ZZedFG7\.#;f&GdDbX8+Webcf2567?DY_B=DVYC_75)@6)N)(N-]XXg(?AC
BI7SDY\_]1,Hc8;G=+#Da.>OSdIMD//,@8c]/[)5VdE=<;AO:]\U[Ld9OA58[#VJ
F[:H[T1PUJM(Z]7gGM.eLEBK6445VGd4aXM#-(?&MfZ1LFX:GB-B,?8KW[MMV(YV
=Q^C#7^C2TO>bWN(AE]KbB2@:.J^DM>?g:+SV9OKc6,+bL&G<=KJPJdW\^RY&LGb
4H_B&Acf(<5>AC;@IeBfOK4g]YSI2>[XMMcF^QMMCVU,0\3fGLPTS)+^.LRe5<#G
WMd7XA8OF4Xd<Q4N(_>RaK?P3dQWc[<;B;S>A\S(N>=K/44)f3OQ@XX;3-4\f(X(
+W@8,6?89A@4GP82dX_X>QVbLO,1]Z0N#N.<2c;3dWCOC?O1f\UPa/N&fC9L4F?a
?F(E\L5@?RY=WE.\c[4C6/Y:JVZ/Q)PSH-K;eG9)H>^ga,+3U;[Z7f3cXQL=2XB+
d2N[LKFNQgf.\@EW7#eV7ECD;>5?LON,MHe;bU[>O6IV;ZPBJ\6^3?IXNWbdWEJR
-L4&C6&^H1HP<AEWC((4+gf^fO@<L@VgA]Je7?D=e0G0=:b[Z[[/#_;P\EfPP(^9
]A.862;(,YHEZ0=@O;W,Z?)+^CPT0H,feYQ?6c9^Kd8Z]EZHH:[46BA>R3b<?V5E
Ef0OORE\)eJSYY#+G=<KJa?-ZED:/=Z\WHdCZ+G6g/VC(aK7N_N.\bB<:;>>\0U(
NCSDO<d:G,ee?VL9>L<f3-CK\U5REOa_2WHGBQT:JOU0&TLJ]XL52?T6-e?MWdFK
abZ(FR.7\(WGZdPagK4g/&K+SPOc[ZEL7fX#LC&@CL,<N@g2)>SPff\CV2<KAD]^
_U,5<B\0X[P</4#fT5AY3P84-POYa7G1TCB/[71A#;d_^,ZP=3\D&R_A27SE^PIT
B]JHM]EEQFH-A(,?+-C(Q,MR?GC)6]RAa/B[fBR.P5)H<PKDOOTBWeI;KW);GV4)
a@D)E,[12E(GM>+Y9SV9If;2c?QXd-P2b861CBLBI?\0OfTI;7&1?)7Y82PfT#SY
)@)TdU.MVb-I4,AM@IQA>HRfY)BaB@KGd4:fF?L]0e+Ne0MZbL5<YD.XVNAc&=@M
&-3^R[XVZB)9gH81J/5RQfSV6\1+Cc2PI5HY8d-/(L7-&^1@6]_KZ;1U.7A/&)8O
[2G_/Og7QLZ6(<^e<Sa:8gUEd5^X-,:S719P>R]YP1=E,=/C&[f(P3L[GZU\5/(.
DA2I>46E4N1ZVTQ,)A.0S6=5D]=-g3]Og_?4c39D?CL0U,^2COWOT)Q7.71F_,^[
-EQ5EH13YGH9WB+2_C;7,<N7L2(HG[CFVb8Kc9BbO)NDf-C<H^dgG;6D.&]FAZC1
6+LXd3_)a.C5\][4;FT2Ab.a+1QgA<_Q^0Y_b&ZRPe1_AFT7LGC^0A>E:aKB>:#B
,7&P2O>2T^]]Q/&Q]MI@6FWVLHJ&R7-#_0f[P0RaG>Z#W.^Y.6YMMOD,-+ZUV46b
W3V1JJJ(]c1V1QEPdN<(T5LQ&f?@.Q=>=:N\XCI-(S=dEXZ5@RDA#>^XF_f_.:X@
ORZ51H9L8QRJ;W.FQ=5b=(X(,B>e5a)GX/F(?0>@^+8>[\@VN\,0/Q?4Be)8C)#Z
e&E4aI29Ocb9,]K?BK5/TAaf#,_M;+=)?WB_@>VO)?</c.I><K7b=T3YZUb8R[B.
31KG5@7P2Z4_2gH\M2KC:MRASKded\5)]DbNEa_HT0]K85XWH5@A=aR+E^gdF--,
15eA2;G?DTNI4B_=B9KcRRK2QXB^_Z_EAgZ78-GW#f3(4R6O(I,4-ER+J$
`endprotected


`endif // GUARD_AXI_MASTER_SEQUENCER_SV

