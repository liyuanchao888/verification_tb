
`ifndef GUARD_SVT_AXI_PORT_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_AXI_PORT_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_axi_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,axi_port_monitor_svt,R-2020.12,svt_axi_port_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the port
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_axi_port_monitor_def_state_cov_callback#(type MONITOR_MP=virtual `SVT_AXI_SLAVE_IF.svt_axi_monitor_modport) extends svt_axi_port_monitor_def_state_cov_data_callbacks; 

  /** Configuration object for this transactor. */
  svt_axi_port_configuration cfg;

  /** Virtual interface to use */
  MONITOR_MP axi_monitor_mp;

  /**
    * State covergroups for common protocol signals among AXI3, AXI4, AXI4_Lite,
    * ACE
    */

   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (awaddr,  cfg.addr_width, AW_chan_sample_event)  
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_PROT_CG       (awprot, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (wdata,  cfg.data_width, WData_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (wstrb,  cfg.data_width/8, WData_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RESP_CG       (bresp, BResp_chan_sample_event)
`ifdef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RESP_CG_EX_ACCESS (bresp_ex_access, bresp, BResp_chan_sample_event)
`endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (araddr, cfg.addr_width, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_PROT_CG       (arprot, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (rdata,  cfg.data_width, RData_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RESP_CG       (rresp, RData_chan_sample_event)
`ifdef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RESP_CG_EX_ACCESS (rresp_ex_access, rresp, RData_chan_sample_event)
`endif

  /** 
    * State covergroups for common protocol signals among AXI3, AXI4, ACE
    */

   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (awlen,  `SVT_AXI_MAX_BURST_LENGTH_WIDTH, AW_chan_sample_event) 
   `ifndef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_CG       (awsize, AW_chan_sample_event)
   `else
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_16_CG       (awsize_lt_16, awsize, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_32_CG       (awsize_lt_32, awsize, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_64_CG       (awsize_lt_64, awsize, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_128_CG       (awsize_lt_128, awsize, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_256_CG       (awsize_lt_256, awsize, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_512_CG       (awsize_lt_512, awsize, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_1024_CG       (awsize_lt_1024, awsize, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_GE_1024_CG       (awsize_ge_1024, awsize, AW_chan_sample_event)
   `endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_BURST_CG      (awburst, AW_chan_sample_event)
   `ifndef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI3  (awlock, AW_chan_sample_event)
   `else
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_EXCLUSIVE_CG_AXI3  (awlock, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_NO_EXCLUSIVE_CG_AXI3  (awlock, AW_chan_sample_event)
   `endif 
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_CACHE_CG_AXI3 (awcache, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (awid,   cfg.use_separate_rd_wr_chan_id_width ? cfg.write_chan_id_width:cfg.id_width, AW_chan_sample_event) 

   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (bid,    cfg.use_separate_rd_wr_chan_id_width ? cfg.write_chan_id_width:cfg.id_width, BResp_chan_sample_event)  
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (arlen,  `SVT_AXI_MAX_BURST_LENGTH_WIDTH, AR_chan_sample_event)  
   `ifndef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_CG       (arsize, AR_chan_sample_event)
   `else
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_16_CG       (arsize_lt_16, arsize, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_32_CG       (arsize_lt_32, arsize, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_64_CG       (arsize_lt_64, arsize, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_128_CG       (arsize_lt_128, arsize, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_256_CG       (arsize_lt_256, arsize, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_512_CG       (arsize_lt_512, arsize, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_LT_1024_CG       (arsize_lt_1024, arsize, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SIZE_GE_1024_CG       (arsize_ge_1024, arsize, AR_chan_sample_event)
   `endif   
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_BURST_CG      (arburst, AR_chan_sample_event)
   `ifndef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI3  (arlock, AR_chan_sample_event)
   `else
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_EXCLUSIVE_CG_AXI3  (arlock, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_NO_EXCLUSIVE_CG_AXI3  (arlock, AR_chan_sample_event)
   `endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_CACHE_CG_AXI3 (arcache, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (arid,   cfg.use_separate_rd_wr_chan_id_width ? cfg.read_chan_id_width:cfg.id_width, AR_chan_sample_event)  

   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (rid,    cfg.use_separate_rd_wr_chan_id_width ? cfg.read_chan_id_width:cfg.id_width, RData_chan_sample_event)


  /** 
    * State covergroups for AXI3 protocol signals
    */
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (wid,    cfg.use_separate_rd_wr_chan_id_width ? cfg.write_chan_id_width:cfg.id_width, WData_chan_sample_event)  

  /**
    * State covergroups for AXI4 and additional ACE read/write channel protocol signals
    */

   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (awregion, `SVT_AXI_REGION_WIDTH, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (awqos,    `SVT_AXI_QOS_WIDTH, AW_chan_sample_event)  
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (awuser,   cfg.addr_user_width, AW_chan_sample_event)
`ifndef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI4  (awlock, AW_chan_sample_event)
`else
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI4_NO_EXCLUSIVE  (awlock, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI4_EXCLUSIVE  (awlock, AW_chan_sample_event)
`endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_AWCACHE_CG_AXI4 (awcache, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (wuser,    cfg.data_user_width, WData_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (arregion, `SVT_AXI_REGION_WIDTH, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (arqos,    `SVT_AXI_QOS_WIDTH, AR_chan_sample_event)  
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (aruser,   cfg.addr_user_width, AR_chan_sample_event)
`ifndef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI4  (arlock, AR_chan_sample_event)
`else
    `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI4_NO_EXCLUSIVE  (arlock, AR_chan_sample_event)
    `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_LOCK_CG_AXI4_EXCLUSIVE  (arlock, AR_chan_sample_event)
`endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_ARCACHE_CG_AXI4 (arcache, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (ruser,    cfg.data_user_width, RData_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (buser,    cfg.resp_user_width, BResp_chan_sample_event)

`ifndef INCA
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_DOMAIN_CG_ACE   (awdomain, AW_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_AWSNOOP_CG_ACE  (awsnoop, AW_chan_sample_event)
   `ifdef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
      `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_AWSNOOP_CG_ACE_WEE_EQ_0  (awsnoop_wee_eq_0, awsnoop, AW_chan_sample_event)
      `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_AWSNOOP_CG_ACE_LITE  (awsnoop_ace_lite, awsnoop, AW_chan_sample_event)
      `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_AWSNOOP_CG_ACE_LITE_WEE_EQ_0  (awsnoop_ace_lite_wee_eq_0, awsnoop, AW_chan_sample_event)
   `endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_BARRIER_CG_ACE  (awbar, AW_chan_sample_event)
   `ifdef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
      `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_BARRIER_CG_ACE_BE_EQ_1 (awbar_be_eq_1, awbar, AW_chan_sample_event)
   `endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_DOMAIN_CG_ACE   (ardomain, AR_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_ARSNOOP_CG_ACE  (arsnoop, AR_chan_sample_event)
   `ifdef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
      `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_ARSNOOP_CG_ACE_LITE  (arsnoop_ace_lite, arsnoop, AR_chan_sample_event)
   `endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_BARRIER_CG_ACE  (arbar, AR_chan_sample_event)
   `ifdef SVT_AXI_MON_CFG_BASED_COV_GRP_DEF
      `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_BARRIER_CG_ACE_BE_EQ_1  (arbar_be_eq_1, arbar, AR_chan_sample_event)
   `endif
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RRESP_CG_ACE    (rresp, RData_chan_sample_event)

  /**
    * State covergroups for ACE snoop channel protocol signals 
    */
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG        (acaddr,   `SVT_AXI_ACE_SNOOP_ADDR_WIDTH, SAddr_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_SNOOP_CG_ACE    (acsnoop, SAddr_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_PROT_CG         (acprot, SAddr_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_CRRESP_CG_ACE   (crresp, SResp_chan_sample_event)
   ///`SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG        (cddata,   `SVT_AXI_ACE_SNOOP_DATA_WIDTH, SData_chan_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG        (cddata,   cfg.snoop_data_width, SData_chan_sample_event)
`endif

   /**
     * State coverage for STREAM protocol signals
     */
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (tdata,  cfg.tdata_width, stream_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (tstrb,  `SVT_AXI_TSTRB_WIDTH, stream_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (tkeep,  `SVT_AXI_TKEEP_WIDTH, stream_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (tid,  cfg.tid_width, stream_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (tdest,  cfg.tdest_width, stream_sample_event)
   `SVT_AXI_PORT_MONITOR_DEF_COV_UTIL_RANGE_CG      (tuser,  cfg.tuser_width, stream_sample_event)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_axi_port_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_axi_port_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_axi_port_monitor_def_state_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_axi_port_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_axi_port_monitor_def_state_cov_callback");
`else
  extern function new(svt_axi_port_configuration cfg, MONITOR_MP monitor_mp);
`endif
   
endclass

`protected
_ERG\#-/[;.+GUTZG/<\)^,R80KR\BdCAV4faQG06Bc\KCH2A_WA7)I;ZFQOd:ES
9-KM\Fc@d,aC=XcY\&1;.2-7);NR9&@Odc9YY-U/BBSND5(f)0T&(P([B@F&Z(]M
5D//;-[U&_b?)N3gZ7R=C4#BTJK(J3MG9(MJL1>]MfA?K\9S=A4a?07Z96-L(KWK
X-F<[)8^\DN?HG[VP9X6faW>+N\^;e7A_+HN;YP=@X[HZSObegKL^T]:>LMC2f7;
eM8Ac05_3K,D7TVT:@)+R>,NN46XQa2&APN3>)9^4Ac/OLLR[eg]XTVE9^3X:M,0
J?G:,RdX1(A@Z;2bV_Z5IM<T0g95ZVIe?-?a9>4I4<HF@PQQVMIU:f-H+SZEUC0P
?Q7+92VYW,:PI<c5WgLO?@J7V>M8g4Y3\(]YO[,#@LaO,45:]W^JSf3-6I[Y,1GW
=2gNVg4eSg2NCQ4.>e7ZW,Fc_V[=cO3]7X-E+S#<VZ>><Sg(407)I]J,[UFNRZgY
>^LTTO#bFEbJMS-c]HOD7BPGg6gY9=DId24Ra)QYI;^0Xe?R289MN^P0ZU@+8&YJ
b&A:;S=^:/@+cdIM_U.5IgL:K#03cYV,Sa09(b2_<dV-<R_LD)a;8MM&QdFM[-G?
&<=e\^BQ1?7I>.J5@7C0+B5B5U[-=GDJ\),=4U9?0@X;f4?:b8]Df^>WVBbAe(Z+
4OITLCEP&>FSWUdA+37D;Y7,@IFX_@XAeIcV4);=R\\J@]@=.,,@TQ(W8]C8-TD=
XgB/U&eV@..(1&A5W5RE3[8FG7J3XL3D[8X:,_f8KY6S<Vga3)aU6-bV&T81H[D0
2f@7b0d[Q95+H0,AS:I9E&?D0Ma3TeO78F53RA##S.0-f4,AQKG7c?[W^f44Hf2[
^BNd]92/K#J<QI,HX..3>8?YYH4SK.Q7\2<BY6QEM6&][H,^<3ZD#IC62NLPI<11
:DD=CCd<&B.g)(b[#V)S?HC2:#J#,R^g.9\1PKbdJ;cG717;01R+5F0PLOd,@]GK
KALgDg?M9^MRBEe62>QV,ZT>3O-O5c/9D2(BAe7#Z&QZ)V^c84c..C08e#&I#N52
D9WPQ)/&A-VYJdB6>SMUdbe;^ETg3aHIIeS0e:4Yc@YMFQfJI,-(3\DQ,.[F\3)Y
Z1-V6gIF-C,&cX<-]Hb?aE8;I7L#NJF(PDT7>93B.2_8EW:=&7F7)-O6#T:bC6<9
NKL4B4DC5fHEKZ[E@9>9_7M8UBfO+Lg=3<#.X52&+57-^a6(.4PKD.W6S4BJ:VIT
B_XJ8TP1GM0\\HB,T/\P_ZQe.&(U0X<24JT9)6[Uf6;2;P.fINWI0+Z[ON.[8JEb
?9bgKQPAKe(\P<O\dYYQ>G\]CR=;&J3=19ES5AIX(Z8GH>T+,9FC/<eUDU2(a7]]
JGDN:[R^M@NFEP^bLMA-:aBc&=J4ggM0Z(B_3VeI&2:=^#F+_fT8.\Y.85bScIKW
5,F)B(@O@-L?B@?TcRA6])T^UJ4bP19c-=,d2S07S2)F/IRSc,ZS>(2I/D^_e^<2
X=>4aVc>BgOLZHS]g.Bg=?,[=?S(e\AYM^FTM#ATb:e]\_K/O=;E3H>FI0./g+WF
Sb-?T=ea&FPO\<IY(M.bR(:c>&PF4#,NBCUG&R9bMeEQ[1:gT_PgLHW3&Y9A?U+d
5NKTHag8H]:dcZ2<IY4]WHD0Na+_W(^0#.dVXFJf=:1M(XD#a;<FXZ=eK?1_WTCY
C4He(e0_8P.O.PKW/B=E#KDIaW2O4SWTVG@?Q75_27W5:87GcAFR-<4/7KYNLQSF
2(9O)_.,X/c954e66?R+@9L1HI;HY1;QNTR2O4625dC<f?\4<7?)V(\,,Z6dXG3/
^E7Uc[A8?P<DO=P]6aWf>#;4=RL#BUM)ED)EK)4C150VcZU>F<;f-H.2-GIT:D5(
-7dW\4.J=d/DU3bNEX^C#BA>X]T/,F7ST.L:e]>PKJ[7X7^ZRZ&=aP2f_(1=VaB+
8\<JEe+eXN\/BR1UG0:6f_cT.@Tf=,#5R>?+EPPPA0CQLH^IG/JYXSYISN6FA5IB
H+I567<_\E_@==IWV[U#DWE-_YdV;>eS(2bZ#DB;^,._-ZZSJ-e29KF@BcU#RH2A
IgbT7GR-KQ-YQHdZ0.^WUF+VEN6PYPT/eHX5eeW[<bbOaa1/A/Q>21gb+5/YD8[f
OR:f?IB0FYC6J9EK9Z?]U6S[P0D#V5;+3F;TWVaNdV\CHO91eb4+aH5Y_L]YVKQR
aTI37[KL])7KSK][3QeKPG\TZ<KW__:O.2-bbcg6WR&BK68XeWOaD4B\CX1a[J0\
9<^/4.9;&29;J0<4FFMM?3=I9dU^M+_daVcFP_Z2gA20,AD=FY:gSSZ^+J4Z/b1\
e0,95?/T./]J=M6<BfUSI).S2MQ68)7OUSbUO6(YB7PV:0G[Mb,<KL08M7\24bMa
gf3NCGE^,M12TE_R]-Ucf,_.dNG;TU:Pa^_@[-_Ea<\Z7ae4?_;c@2JMb4BfE_LY
B2XH3H:Y@2.GAL76/T42,\(96;<P^>?VBbc(cc4)7Z/A^MJ+JS3.,,:OGZg;][_X
7Xd@bgD>G@0R:2D\GUT:.+60gL_Ua,/E1D1P5NXN2:gWec0[(#C<A7-8N#7XH4<K
2cc9=;85adFg0\,7gEY#F42(Fg^a\Z^N+_cG;BXcPHC^1L\6O=#U0IA>WEeD.Ue3
dLFE5S8UC[TM2O\CKC61[H-e,=-#&.&Tg#[)d_4):U5U?G]D/#I(5<VIOJ?=MD#3
Maf4Z&3PA77U3=Q-ea/2ZR/O.I\IZ)CJK>f)]1G;<FFE_\D:@EgP,2],LN6?3R/C
_QQd&8)4N5c_B\,3R;b+L@Y:6V/]?aL9^c1VOS9P]\A6Re.<g[RX2GIZO^^3QUfa
dFfOIP?L3?-P1X&,)=ULT0K3A^+[=HaL=:VC#b&G[LI_X0#C6c>.K<e7[1IW<_7<
-,+Gc6MBRQ&g_\DFO^<>ZB.O)8@WfgcW</=ObET(aM)Q;9FfEU?@1MZL;O=?PD<5
WXN1P@Q]d;JRB.Z>F[V7+<KUVH2B5g@^RKS-<XPWR8ASZJ<3bA\+Q0X\O0,f?MR.
4^_FBb&?f4/U-)&b\Eb9#[VJWD<.9Agg:5(#H>,Z9YC(2<[DTc2)b:.L?PSI^5Y3
b0gGE<KBGf[2X0ef>=fM7R1):b,Vcf3+WO.;-D8546\7)Vc0^4c?,E.2cL\B<(AB
dKdLTY6MA[MQ3.D,H,f<&_6]-\PD3:Q[?FEEfO7\R4UM)S,B1F^,F_=X/5^T6^10
J\I,gA5:2cK7d#M)C:+]>.>ERG_gUGKF:cGg_4@1VM?PA\#>(@.C>-?]D.dWB+af
45aZE;a^PR,d3^^\=a0+;UP?Bf503eg]@LX]aN33d8?9Z1/SHL^e.>DZ-fP4gD8G
\NIXVCXXR:BUMA_EA7=<,V^QD8Ac^<SYc2#UB-GLRA^]Rc0D4^>da;SZ+CW,883e
J_]-HBR8A=U,84@Q7P:#4_:9bVI42^6QQgT;AbZ<dD>/BS:D=CP;/()U#dFCN<P?
cdCQ2G1eJ8<)Hg/-N__T;fLDK/\6WFfcHPAF00-ecICg5E,-97.3?Q+&LFVF-VXN
,(c5<R#8_[NQ5P\Y&<bIO8TQN3a+3E.:GbT:#/8:BC/e]L05SGS[LQHS_C0Q0,Ma
\6?ML7@=3G(@gb]c7XM/&4>R:Y98UIW/I/NJ7;41J4W4E\6<P3:c#-X0^[K_.Z;+
X(bU+]]?5d4(_F9:NUGacPF\a4>>E_:R^/X<2Y7?\@,/26:];APM&[V9F&=+\7US
cD;6PXB=]&)Q^dR+#OdUYY_]aYf#@&WF_Qb[]ae<f.FWR<H.U5fQZ9@GN.XFX2KV
S&983K5?Z3?:EdD?&H8=@X@DDRf4>],EB-_=X721U^\]OXAEFG;Z(g9.ZKVKCT@Z
HWEULY^N-Rb&eK7#=F9?08>(VC^3051;B&_GVXLZG:\Q=f/O?O[;/.7M6#TJf)N8
^2[T.^G,&44^13<&-9VYZ1T0]J[-ZEXCRW.EAY+g).fg9Q6Z.7[>0BHO<2[EJCBX
&Y1)b/=&3LY7T7MP>A;+J)+cJ\L4dK^U/VVN2M\M]aXQXIG);&e<T<gW?gf_A\I_
\.LaR,eIH0@-3A[:Rf+e/R,V1-^D@:V&7)XHXWDSB+8[#5PfN9T?EU,HXf&,&CF^
TE<H^RZCK&2]D^FX.:-BfZ/4X;C?V\G/Z1NEO)7BAFaWX[,1Ta/U(OPXB0@.+-.5
DY7J(=^5X>WcEbZ6TWL<[-c^U[PBa\I;AAG3ND:JLU?(FX;gBDSSBU[YB>5G^6a/
^3O_3)DLcI5H5gJC])0bdT68AL[VSI,FXVG[<:.TMG,+/ODc8E7B60K:A6FW.\=K
ae,E4V^93C46FQ&bcE<_ZV=L&D(<DeMZP\T88.[BQK2gH-5K)9PYM:#J]R[Z#YZA
5]=8;Z1E#W3&cT<caeZ9ZEKcV+?RI@1A(N^,R\5OG7@JBVeJ-(1-.>7+B8^2/EVI
652F9XaVQV^LN:RXM6^>Z2KV]C\111SbU\:SZ_\G)4DFVUAWX6G)-]LP(QcEU1ZK
E6^S^EMLf_>\[^?/4X9agX_OBJ2].WdOe#Lg.@6BOcS<#Qc1_N4[HBNcPOVGMT-#
?C\QMQ/5S(XF\>-(cgHe/\-OaeLGO,6Z47_H80cSZc3YfRFdH<TZ)CM.1+GP^A\P
41<UUb.;&e?\6BFSRM2aafO>6G09(cc.3eNM(^PfcPF^&IXQ:2dXPF6C)RdK)#.&
_9_?gHZ@0413&dWfL\S41e2A>##[U]bI#ZI^Q&_[g4=?.SV>gQP5679TM-fKW1C6
FVf(2&6@6cf_af,<3FXcBePaZ0J<^aPgMG]>;R.6&PQ_<DO7-g>RGg(WNWTQ8a6,
517b8(L_YW17^G9;KW[BGISe[S2BJAAP0O-X-1g-<7a7ACQYdcaC#D_a#dE,5+B.
[[0Lb@e\02AF?;?<[6L?Z2]d8-cB)g],Ba/cPd5\O;(NFGSDX/YTB5<>E9-;O,fc
BIH9MU7.S70N:dEQdgXZ813#/RU#c-UWS>#bg[UdD/3DC4P#.gL@X=(acb/OXE][
H+P@.H#cYSB&d^:YVfbUc&Rb(5R,4NUb]KE;E.1\Vg7-G8CFA8B0/2]\VH7L71W(
MR+6dK^Mcd<J\fffe36_TaL8W=-Z\5Eeg[>P3UH,O:K1]AY/f1X[)H=+,Z,;LaH4
:Zc<2#/C,gBF:F-(b#O,Uc00CeBB\:PXC4X]5?:+F,2PfSY6&N;-gTgQDN@8I8dV
#6.8XHSf_B[-Q;RdVA?.&VX9>d+D)>cWT\/ST?DgE,^BMG&_+B]g-UFT8<YfWGS_
SF+ePCP,IL\N50bKf5Fe;c?M=:7B]c/8@KQ1:aGOSCZV8D;GG[5&<;5[[Aa]/0aO
:,MA,d.IK>e&@WLV(-J4(Q41MV#e_V..QI9LIK@4K;e;1RS^gM]I2=MA2bMX>G-/
X#G(/9//6^fX?B3N=/agZdR=eN#^4G<MSJ<RM-3e^^.D440S-(b[&GKC5,H+T/E4
ScV2N<3@](KD-0:^\]b2G5G4;#J>2X:gN32_eZJ@=?+B/<g1I^2;U#U)P9e]&1\H
<).G5;MDDFGRf.eA3KFWS5VXc&cKd?TP?&,d0cM@ZOebe6TE3O,8#XUH_\8.J_6c
]H^?6XMP_,J]>Q4D6Z29_TI[4FM6T].WUd.;V#Q0cGbEOU1=5L@:HZPD?^OJ8<XN
YJN2/NX)g/A1V92^^^+0=IdcV.bfB0>5S9)@RZPTF,9dD]gAcE@]fWdXJ^f3CH@\
.&A/;a>>D4AY+YX>79+7I,K9D:C7PD][Y:;+&EBX2?EI&QgQ<WX^J2S<Q\gK7)gW
6/4QFS3O@PUQY6S&LS]4LZ4dAR.-9YabJ=3S;G\2Z)B8A#?9?6K)V=QbC@;23-_@
IIS?W39YJf?)&9J5(DZ;]G#J_\655A0<<(N7?QYa_\cW>#,GGgC+\Y#(Ja@.fgU>
^#P(a^7QL)Y5L,X>P2J;[\\_TM[]ORBR7@:HJ):D.(1.b:&NKK^;?:C;N/KaRL3\
AKN9TOcNcG9Pa8HTMELePIC+0SIM_;dYR>UDdYMI=EY^W6O6;3+b=K?\BX:O]0LH
=[0^-_JP;##+((O<C_>&[RM4V]FD<6Qdb>JL#fZX5S)27,f_]]>@e<4ZW/R9V=-_
Q5M24,DaGKI@QaGaT.gZLDPTAJ)UE+>8)?#6<5ce>T8IZ\]-K&8D/G4RWQ=_^\R:
5OQ2SLH\aY_Y95Q7FY8F)g9\FX2R>0)5e8,c[K6V-F?IVdP>FGIZ\IdE3\;cYBQ?
G<-[9?/RUD+Dd59UV8gNPg66EH<85S;KC?A-Q[X5-f1^aDC-0X+)3.Ge:O6UMG1B
&V7Nf/cOf+G]:-H0&W7B@A-4?dA^S8G[=QNa@K@dL?37-Y>0>HSaNHKI>SWc(H&H
RR=9A+?9_=73[1f?=I^#7KS8@&c5ecdEd>O/YYWZ]X3PBDcTPQ?V(DAS6(]ffNL(
<<-BIS87a:^ONQ/HEYT@]G.GPTH-WT3&@82ceS3[M,2>RY\[9^2TUQ>7bS\L[OZb
86OHK2A^Sd08T1W0:CF]7C,68J)2<GeB@c,KWD9J^[K#UE]6?1)AN\<NC&=6bC4g
9N3G?Ha3,a6HT18J#WPI\dGJEZT100O2)TSaW_G^=VRN170,2:VB[OV38[&43PBT
(TEW#2I,.#L[/L/FRYE;)V\=+T]5=P5eT36;N=SWc:C8PXBbI+0XCM0#U39\P0BU
T-MZdOJ_TR?g.c56e9F1@.Z9dRTB^B:V+B-;bN9:PH=Q#MEZPBd#6dJ5JY[CHH,O
2bW4I?-G95+&2W=/Y;;RL8W-,c-]Ob@9SL)(NbO;8R,LYGK8<NE]JL/CaBD^Y9D;
f@I,^3g5H)cVeH93f;@JH\DCP?:I#XTBVI2C.eGfEe9T\G2W?cae)Z8]+3I\6M)S
/5F]WQ:<MH<6f#&7@aIO^a?IXgT?M(,/JU2Cg:MEA]KJf^4QF:RaB[^3@T[5Q+J=
+X,E/+B:K-&(;a2A(1[L^Y+@\K45HD[-O(V]OUa^WD775V))cU+U^<+9=e[.UH1?
R].DD,YQRY4&S\=IGU+bL9TAJ]eX-gU6I5.:[77:M\UK==A&TgX4C562cT;.1D:\
@^,Q=5^R7OWX51+V&2Kf9R)cB?U0ReAcSDg_@4K(8Z=8;^Hd4>Ofg.LT_?&OJ(Bc
>7a-BDfKPg8\L_GG>.Ud)X7^b0SL8G<(,O/SVU0c9bB4f)G6K&/XHb#3f>OYagaX
5Ce0^Df7&D:NU1g6LE7<&1.1QK,Q@WQEQK9:SAR/<16W[=7dSM86-LNZ:-b42T88
T;,V/ZHSSXD6\C(g>S+DFaNF840X@YFK??)6S8B.AYE8>X>g:85[2fFXOAQQcA4.
CEIKUQfgY/;AIN.G442>A+a<(R.5:_THCaFF2-Y?Va.>b35)@[00B(;a\PPSO+8Q
.VR\?8T.\B-)@Rf0[(]e,9,&+A_51A31aBV<1bXbPTNAY<M[Sb148EESUZW&LL3<
@HMQ6/,b=/L?-P4[9,4X3/5B^e9J=[A,g93[aa\^G(:Q;FA7J,X5JJSI6I=:K@2e
^dHA,>0PK]W+e:<P>X3&G3g&PPU^,d_C((,[@LT)H,)Ge1KQK2Jg8#)LE?CLG(CO
8,^1.c9]+J3AXRPBDMRS1<K3S(fbd/ddB3dCG\e7(><)6R?5UC/(7S(+WV:\T1I,
NNXUYadA.L@JEaX?aCOgGJ#D3M?@S6:A,;+VWFK&0HTUE45;+)fabZ,Gc&=>6cOa
0GH<?AMX&A[XLV6C,]35)2?L&GK=<FV5MeYK5LK2YQVN6WZf9;T[N#TZ?>RRPc]K
Z_)EW.+N,IZa<<PfV_1[+DB1@dd<NC9f94T9LZA:XR^9X.c7VY8XD;/AOTG]6[5e
.6T)<gL0[V?<P^cEW&]@-6U+>7Z:.SW@^NPMG_;?&a;KZ/7K>@K@L?>ZFYO-)>@1
_FG+V8H3:ef]WCPJFaCE,WQ=EF1=(6cgQF6NMSHf;2:OA)@Z_&SCU]9KRfWd@X]>
2):J34W@E;\7e@5J7SPFIQDZ,I432a[AfZFHTRT)0]R[8S38<IeS-V8cRB>#_#QA
E-753()B#UK@Ra/093Hc<+68e9\T/ND/QPEDQa?Mb1+Q>])&9a\gb>5PRa>9J@FL
Y8^17VgOHfEcAR6\3Cg#O0X;]b/>9.^Eda>7OYg_2TARB3Hg[RQSWN:A(RZRC>=d
0G,=7@LS@gWML/BCda43Z581(W?<9S9CM&U69#:73/6e>BdWD+0M9Z_]HDYU0d&<
T=U/-g&)5U[0E.gG>IUBZ).1^a_DKIZ).JbA@->><:Gg\A+&@4Y+f^ASaZ8=S=^Z
L:8QA<K??Jc[+@XL+>.AD__BDB#;B@7=C?#gbB>@[[9L:?1RgP,@=@eCWGJ6Y]OW
bQ+O@99NSff_VeNb)NT6(XG]7;IV0K.U3gYB?DD=/.99.+WCJaaV3>P:X\>@J--#
TLKg8M8+G)bPCQ[V-M7AG.JG?A8c7Qd(7G(=6bIP+\R9QO>0RUDI-Jb/eAP@;,,(
([:^Nc\HNVPf)VQT#-6B/&Ae->g[e_PAdJ6LX?D(I_Ze\f9VJHSGK<)Jb^0ZZ:(?
g5E4()7SHg+d_96aD0^;,9MMHO?C5?,5TF0_[JVB=)UH+M\UKP0X8UL806MeFME3
^>CDCD0OU8W6D55e19T]5C@Q:>a+@?;7U[1VU@9W>0_,F1-=(BHO,(34_Y^:YR2^
E?aH#(VW7,V2-N5/.<Z3E#H,5H4HMEd;)O,OM(GdHMV9bAYT]V2A)A_3dZTC:B>@
ZbNJ/VIL8A>_@?0gP;[0S<f^>PXH9J&a-TJ1YA[V:F]aac62D1gXgg,6a[64-[Z^
Q^UG;VO2DV=QX2\6TH=VQ,XcN<I^(ZdM4WCJJ&KRTbESa?-GWX;9]:MaC,fBG5<U
U2;+L7^PUCEfc#6D?V3:Sc,8NU[(V4_)J4->:8NfgE<8MX8BF(2<ROgXPU.I&LHd
7U5U>8=WeZ;(+51<@FI.Fd7Yaa9>\J&U]?UL6OX.@(6cKQRJWW0Q-KK0e;SU@e=d
F-HS>>]3^ZeM_ObQ+cT0IKMD(#3BecV:,K7>OOP850+0FLEfH3]K+(c@^/R_B@QR
W\C.E8ceX&dOP@S=KU>V+aS3-CS6ab#c:c5QH2H3;OZOTS+_>J,R?#>H9>0,N0#(
,M-ITJ:52b[RX@DgX\R?0O4c0G(\fR@L)M<NbN^#,eNdb_g-2T:<K>_KH6VO2ZeH
dU/1IM7TES2g1AU=P=8K7fUDMT;a?7:(ZVD,TN/6/S3H-EV6S<=6KNJgSO&7[U,\
Y:OO6J2PW^dfXAFM0eN3Z9XDg8[/:_T+/>XOX)0af3J?9&2J\C/1K.g,YVO7AERX
>aGAJ&A0D<PbdY@;#]I[8021ab))C32\IT&e25f21C+MN/,(7]e]Y&HG7[AYB2-&
+U]25.M1)K2aF>^P54W(,3fRea@X?Cc811dJ;c3Fd^;9(J#:Fe^;#(,gA<HC#B91
-^O>^X2&F>>7OeQe91?;@bE(TgLX8Gd^bEE4E,V_<e/4caPUTBY7GIAW2TJ?Sa:Q
P\47b6:=)R;H^QP(7BaM?@6bMQCU0ZGL7G[]._2Z)5;1P@V;F-O3<[b_>gQZgZ6H
.9)AZR_LC;NF=TV/[0<2C@fH)EL3_G1QWDV<[72BP/>#]<Ld4+=._ZCGR_[JATEY
=#/#=c8Oe+>+5dQ=^SA8A[?C\gG?A8<TODT4/9gP4W451g#;aO.@&5a&RK@AQ^(W
&>\T8\SdJ4[D#d^?4eMXI/E[\<3IUUa7.XI2&I6E:VF@WQ(6<Sc;e,)3G4BS=Qa#
.Yg=b45ZKC;&IaA.=0C0>9c,7DO&FPAe5\M(XGa&>35U?Z;cP6/6++625\JCaD+B
@EYLM)]ZJG1LE5bE^@FF8]VF)D]M5EFH4]+,2MN@HZ<6YCf05KXZDG;NfLWF1ND=
AKeAHMZ6[)7NMV5LTJJM4771QcLJ+AV39TcRH2fYaN.g)(9>9#P+0.93Faf0ObLL
EV+KZd_2<Z6JO6^1LX[7,)_^gU<4f;#[/;,>XL(aQ9_TNI:]?(MB/Dbd;,I0>2K0
8d2e:USPX?&G0=Da=KA[0C2Sc]+O(Y;I7R&OUIc-M.P3_T\NLW7#F.Wf&,FJfda2
7:MfQUOb?V:WEb.d][UHFHfA7@#A;a\L80K,15Zb_ZP3(A?^QM0)D_g1:c<6+W5@
YK+43=P:;?F2]61dc(>[BZ5fT72.G0^?c5O107JR_3Te]g.:<TT=70M7dJ?:edZG
Y._A5-PNWU442R)J8<WT?E1SFPX=RY4L@BH.HB\R_(VYY&-fUI4J4867Q>Ca<V0f
Y=c(H1(E/F.>R+95T?D4=-G=XY(SeW4?aC4508-5<<4?R>e:@FK#dJL3(]F:3BfR
E43c)a3bf@2\5GeAL5:@\&NKD&KQ#T=5B]UeaSLa5>\KC8]W#4K_C,W##c1RME7#
aNTb?PD:YN<Ff-30We;.J:De(VU\=96.BL,aQd0SKYH1S?V+MSRXSY^)N]91?5a&
W25^QW485E3).PN1UL(JECDKOEPV2<]=AX?-03Y?&(IP>6ce+M4^gdAdaFT=c@We
8Y[BNXZ?ZN_B1T:NfOP&RK,R^^TD?/Dd)-PIY-&_G[C\Y8@<<+IJ8-+#W\5>]75[
:LcY-#3c9UN8NW^U3T)-CBAD[R?dfB<3=LBd.0^82+F1YS;:HJ<bKCdU4U/K_,]P
2\?K?])ELM#NJ\e@RQZT3>NNO&e0O\M&gcE0Q#NL574cYg:D)3\#_[_:d?IaY1Ob
M8#YJ063<A>G01W=+7b4MPb[(3)/dAX\7Of=B=L<R)3Q8PB:gHEEMTWH@4X^WLbL
4KNg;&f<fWAbSP];DXV3,U5#M9J-c:<W:fU):JZD?;<gEH.V;G/Z&Af\f7^.Z]P-
#C0?+P@R,6KL)e=1C@b2FZS>P@J.@A,1OK@d,=T.0IO#](YPc;4#4>e)5@7G\J0<
^5WYLSCKK5dL?K71#BC:2H_&e2]J2&&3Z&WK2e\1N&2g[,&:5X9/51YTYX@D4[B_
.L[[Z@.a8I[J2aH^O<14U?E[c#_[Gg5MI4Q[^ECHJ<F93._KI>LR1>XE(SC3:X^G
X\VCD1a@HfJ9<-TH-1(&7CN;E<@\gMHEPg>b>G1aPI04U7b9VTY2):D2SC3>R()N
FE#(E_OHTBEU,gc0,8/RRCW9BONJ#OZg6>0&fb5dY<5V80Q,,)96g_TgHF)B[84;
YDD&/HM+fg9:]e35HY]/S<L+[b.9A9g[Q;I9Q6W(6O611L>>SP#GD5Dbde[7BKG9
THN\<IIOdVW[PG58Pfg/IJ;e^<NB:UB==U=B>,8^V_HSGe\e-Ka#gS9]&=Z1DX6R
=WGVB8Z)8/9:JD<\bVZ;^_T1K#W>##^caQ+N0NNZ.T;)@T9(.Zc@M.G4JK<,\1;_
5(T>76:UJN<+ESbY=F+>PXO_VIAf78:7Tf6#0Vc@[;^J^6B2=KYAYJe5+52D-N(D
Oe?IW<JcE&]U2b92g9W(FTI\_>?ePa-R9f5ZR)BUQWD^3PMW=]4eBJZ9/5V&GCUU
(GJA[@.9A&+ZJJ^WEY,cQAL?YV\-YD>fO_TT,[aL[3M\ee;&I;JTRH<eML80&[4@
408=e,9C+F;SCNP=(>76+.97P3[E;C@[VW#46_/6R,_Y40f.:+)>H9X(1V(4XR<Z
WbP(Y6,\9aWH-(f6(0^UJ;B-+-I(&/Ta<RF2Z+N>KW-)>Wd;3N[;1S-ZP(8ME5bd
G<SV5W]O(UaBe=Gba/Q&d8?<6(BD]Q4[BfZ+W0J5CgP-(X2H/-\B8[[]9^;f<dc:
d5-/_YH8;aC->O9@94;ZY+LKKE[MB1S>V^#dT^<g9?-@(F-+I/d5O7b8UPcZR>).
@0[:M]<KJV9^#-30C/V4gD9>TC(1:]f11J=Rc#BN]MHP7ULN2<-6H?@2]K/2=]2=
9aPZIX#C2D7D0^].2TH9bZC>fYKGE72:#c@&Z32([<H7J1-_]9=M91/X::RS56UV
RCZEX@,:-TLBGSbRH<A+=5ZWW)/0AbG6ee3F^A3@)#6O0]3W,7^@&281,^QZe:;T
Z)J4MCJ1N(F8?=2b:F#X-3<J;<7/:b6Vc^Z?3/g#EYB1/A#9e^/]fO5>R251S.2b
.@;(Lec^K55,7RgTNGf4(dJ3C4\HZ7MG-S7aRb4Z[MP&WZUb5Q&-Zc??0#bX^bL@
DX0K-dB+>QI9b.,6;H5,MP\?OX6L8=_7J0DI+Q)^=YZDLDNPJ[]4QWe;658A]#O=
P,#NT<DK[;KW8ce;Q9&)HYAU)4-7b,<6QQASTU?NaPgIIF5KgIG8/.H<60KZZKE1
UI/5dL4U8J0Q2D=E4^c70_NITQ.2M9D@&d0+XR_>/_Q,5,XCH-TU7\.&]>PQe3^2
ZTHS;T[LF@V[+[5ECMNdC#IE\@1:dc;73cLbVcW,I[@?6?5NU1]eHM&AT#_dVfO;
f0W&4#^-G2GbW7gPI3@>Uf-JG61&#Y+&a)7/+\HC7,JM;<0^_Vb>?MdISDO)5b-P
M8Bfg-?Nb,U8_20(OX=N^]^9fY#8-H9H#(f06#(JFfFRF+^c#J8,UVN#0?B34PCE
<=3;&@VP.V7ebb<aX-WRENd2VR4]e^O;/Q-EfZIK1D;<@g>JM:0-H-e^S+\7@=&<
&d-@_&HNIF?+B1_7A(:;c@PUG:S(M(06W5+[=>OKbcV?SM+gS:]9PS9QT(eF,Qc^
g]N-301=J@YSD]Y(Z;1<e_HTI@];>eb(G;8WCQ8daH>>-1]a=#V8#7WbCL30S4c+
YR[c^Q26O>Z6#>ggb+90TR5[I?CM[\-=dQ#<8S]=N?C#\>K&@:[URZGIdPJEdYTe
K<IJ1b)_8;>J3)9^O02/,:Z(ga65cVXZ1XY7.KQLS_VTCYc4TGA,O6=deY(6XND<
URbFS9\Q.5-QGIF[LXVG(071ZCDf&UPGL?_CgZTRU0=YZ4DS,:XA3-FFG?H.<O/R
cTbWW]9#:?U:/R>60>W4UR5ORc@/B0ZJ&5U;Q^abHTL.=G8&YRKG))LZO22@CcR_
/AWc(MaE[a&Z3W9],>;V9&J>_B<HFS:)O4GUWeN@d\A(,>U[BeN@?-.b+?2\8FA>
YXH(MLX,U-5a68A(&HE0g_W1_IUE=GS^2GXb)d9A\a]W3/Q8EK@JJ?bBH@&\dI1_
9P#_[DMXRJ6VQ)6>@&&De/:bDOK=H<gJQ4_Yg\LJ8RE^M:KO=G,;W<:&OU?DL+&=
CNI0F&fdB<O?X;_VeQ:4U78450<4NfgOU4TI(a.A+M#A:^_O;7IXHJ7L3/dGe/Gc
K5QB/Z./CYa_,TF6086AQMf,gL.ZK?5(_Y,<[P03N^AI2MPP=6bQ2(AZP,\M><B\
3c;bA:8eUUPX/G8&/7>D]#O=\.)&b+#;>SY[9/X\f:&^ZXTKKN8^O]Qf,g&>(?GI
ZRRg;?f8IWb]YOfE[OBQ.\#X/#(XM6^S=0ZeS@0X=e&V[@VfQQ-DH54bFTO_]U4J
V&eB_)YT72<\XfVcL]_A<09++]OJH+E1QK//W<=c?VZ15)CV&_\DbZA@E9M:N^II
eCRKDbV5375[dM1&2Z[<&ULX1O6C\QM+Z.LA&8YY_(726^)d[bfGdNWOI3:E\6f8
CE_\/JV>KOc=O>,PD;fL84L#[8;8S;+K-V3;g._6CZb/<-D-a0?Q[]V-f--SFfcY
F^4,FM/,NTAC43+X1>eQK9/#+dOb4:K9L:O:WO](B]76]X\WPH@MB?Ye/fW)Z]:T
EYSAX88LL_PJKE_e?(=(N6G=QH>BC@7-3/QP27CB_OR\3#?ENSa2F?;^W7AUBPFL
R;:GXP0NF5?>Y406(Y+[5\1&?cU+J@#W:ZCTgY9-0WOC(c1_6(a1R+7g.E4fTM:d
T<&_[<eV#32?(C,PXDFe9e>S+7NK(S<EM7ECT?6cUSS+&aX7QW?6bfa7W9:>L<Zc
+=Q7\+WVS/KdQFdaW<4TZF;\QD,^8]K6g3Z\ad6#2ga@dG8;J61T:2e>VHC.@JNP
I8JLV8Q9UYT&UMYEJf:=FU(KSWE6bKEM>Hd7P8#d\+._B:<]<#CO+]bTFZA])1/e
MT71GYg2L\9L0GfB-5LR5RB<dMZ+7N4K>_@9HTL(C\fa^1+KL#?&1@)Hf@13_=:J
GF&9b3R.Y;a0Ad2cD-QHIWe@dN3D(<[\@T&e35EXK6IP(XLM]U(OgGHK[T;4\U?U
J-d..I=EW_cdBf7@Z+-E_SME<UQ>3cG65;5GDTdIQ5PD^#egIVTZ8ZH7aK(M6J#9
B\/NdQ(MaUL4S\-V\+Y&&32IIYIKg83;4;ZK#B]N0Q][4BD&e??Be6#\6#TR(JKO
7P7Q1>O)KMSa4+_441.+e]X1=bOA@DCA_+G:>ge93PLGGZV;0WD>B&_BY?[VYg8-
\7cP(cRV0-36,KHd?4]O0-H7Y/dbdGAS]3I/Ud\Ce(9#d7=Zg:RLQH<19L&<G@6a
P#24MN_R>MZ>\^JE)C;QcOH+f<7T+PGfSH+QYBe]-Q.f@7gRN>C.:cXD[+UOQ7ST
X)CdT[9)>LQ^40\5DW/D>(:3F^8A61T=;.\@L]Q(/_f.R0Q\:S]8:Ia4@g5c42YZ
USI;7NA,^&L9C\E=./;Tg+H3&CeB79,)(gH&baEH1C(F,&V&9/=Kgb,V_KLT><YG
]dEBcE=XT12g4?Ya5W+2-D\S3&(64V>YY;ZJ;UFfM)ND=B96#.;Y(CP^b?)FZ0=9
EFRO^E9;F11a:XLXbb.13-XN/]cg1:e?[bO:fA4P&a:[>e_T3_VEg+7(eBFV79U^
I?3M\F+b2U4,R30EER1Ze.(bMESM=7EYYJ[Ncg3dM9>>D,SO::-:=G/&.(a<eF&a
+aW.Z+?.D.?3:SEZS2BA2GJKaRH<DYM3I9T[H+UZRYLH(@1T0&V)6HMJVSLY<0B8
LDCSY<)R.-0)].A<>>^:[J-BC:+W(O)RSV\3cc0;I:Tb_Q7&:>XbZSe@cdIXaM/>
#E/@+@@Tg18#^>Z>D.-gMgB8WW:WVO+gbA8(37+.[][F-YfNW?Z]SIC>)XAPP&=<
)ga&CL#2dcBO_.[5]-ZOYENJ.1fLJ)OW_9G?F#EX]>FVK44#d2R7@61X0ZG^M=/F
dCQ,T\J7V8\HP+TSb6DGQGLbI]CM77D]?-T=UYDYUWD]+J@B30:2R>a[J/PMIAKH
[/6aLUT?geZ1b8UgJ6De5\0#,&YY&SKGSP/ML>&ILVL^e4L7.O]T7]>:O-<O>b)B
OVbO?WOf68:#ed#e_fMJNPA]d[NCP8D0d#8;]7IEYN>/IBdBIc&<3#8=d<:aQ5cK
7b_NO.+,?DJ(CR&-J/#;c95^@#069]>IVbIP#@Lb_:6\-CR6QO0O.SbbbTS:1P(Z
]C8aOfW87G2)g.(L5,[TM/AX>6G3XSc.fM3YM_SW#)@)3BVK4]);^E27^3SPe2QP
a7b@cY/=<EfYA?7THaUMIG=\U6bII?B@>-L=Y;MdEBLJcaP/XMJ<T9Tc(+L9F&Cg
==MWZ1BRB+,@Y-e[013a8I;D[B;e>),Z7E3DbA<V9K>BO/e=GaY^HQ5d]d).0-3B
?Hc65GV-Y:@OX=0C+PFg;^-J<;ge839+Mb3NCTY0c5DL)8Y>\PV,P6aMg-,:8W_:
7eJ=W9?UP(&JL48;[271BU#>+6c_GSTNgELU>@M&Pg\d5#@QX9-<#[[J0a,G&V@e
/bX7d;Vag)IRO-3O@AXOI+-\H6P,L[UBF;;\F)W?0MGa0>KB9G(/T(+>7GT\UB36
bA&eRf):4Y?6^D#..9KZA[L.RZ\5Q54.[FN+@d(D/QYG91H+Ub4SUFM^_d;@N2Td
0H7d0_S-/1L^N9a&J&CZ]JeB3KXA1;XX>eON/gR&DZQM=NB(VWd<a>23:f@,[a&Q
b2599STS1FZH@Zba_3O]Y<.3LaMJ]ReOeCfX?D1>_aMVe5O,e32RH>;b&Q;J]VUX
VdYcVXbGB?EH/GR/Q:TQZH^7?UDR]I-79@Nb)GM_AKJE#8Lc4OQ#1Nee>>3gg.^.
d:JY9b5R=VD.FI8>&gV\e(YU=Wb/Z/W7.A/,f0XB(VS\BHDB<(#H5<R6HVB4T<[Y
F[)Z?J3)8NZ4+GL47Mf1e>@Lb3JgRg9U\43@:9F4&QM40KGI(+B9?e?O]A6\E^@-
fZ6(AN,S,XF@6OKI3dWg<7Le]VbI9Q&^aV4/1I(;]\[##]>>_aIdHUQYSQQJgO,2
P\)72(_W_d:\M)-S9eGE99_Uf]+90LcXS&A#LJ4MD8;[Q3<VI3T#]5&]-4XORV@g
)1^S(0aJA,0GII?)R7UG\eH1(VO765=aTJ86A(VA)NX]D7>\F\<BN54JO9JF-60N
eDBFNB2YQY8ZD?eM<^e.VNS5RI/Q,XR;eeT17&N&_-d+:X,XP3BR=2G8O<EMKN2<
RJ:N<_;2F5g?>9-M-U,=F[\c[L^62b:=G-?&Iac@?8NBQBEP:A(DAEfG;+>^gc07
I5A#1B/W(cH&]?3C61X>TSL99E@#P^^D?M#WcDWN5&\VG,T)JCgLQ=NY5@(XC.f6
5,KR&Q=fb_5[eU/Q&/V+a]>@[]C2)1++]<IHNEV/LW0&.AKcc:Y[M?9?3:F30P+@
8=42BIDf[27Ac.AR_JVd;F-T\VCFEGbG?c7BR.<X-LRRIA8R39^>P1RE<+6(51AL
/WS5ERZc3HUYMH:W.+AU^Rb_#C\@9+Q-e:LBPWTM=<-K:?ELK=@&-#(+3&.B^6S,
^8EHL[4L]b>XOO_W\RUD+\aF5cY79g&M16OSSUc-5+L#G=^#[6_Y9g&-F9bAS>V=
H?&[C>/))A<\RZW[#Z5J2Ld[KL1gFbH=Pc:+=-.\L&J-]W@OQacG[W+3fA/a_NJG
(?:ebQdT;.Z>_PXV-6f7)@APAN3VG+O;XB_21c3.Ye0Y6JPS<6,5BLE.Q@b@=>/A
UOZ9+>L_\3IW9HC[[:L?0GT).M=\)SeW@QDCZJ(.-U<]])5M2DDTf_ZM>UTIPZWP
2)df2(-1\?+J82DP+C-/X(5&6(?Q,&69[W?WBYAJ7@)BVe&F1W(I6)/6=(HJ&4S5
dIPe^/B>9)]RNb4?F.DaP,;AM#2FP5X=AW]-/LdFVH_W>SGA+K:8NG6Ye/[;INCA
WT[H0bX([^4>CY=U-F0E\JDXK;>/(=AC/-cE=<I^=G/A5+#([TG,&Q.g?A]U@4AI
W94eAK&TcZW>(U+L33F,=/g)&cCg(N-.A&M]MO_?;,9Sd;H]<K#2UD2F#ZY.,G<a
37e/F6EBMb33U1+0,,X>^g9IJGL3>OLYF,X86fg/_cSH]>5f7bAO8K3f-K4\7J(e
LG+2#&2,TH7K=71B?_YbMQ49@AQgCPbZOAU\e1_>I2P3ZX_e<L@2^TYd(=<@/+N/
:6+,IK_930J=B[bQKagDd)b>[(4,c;LQ0SdVV5+fUIM++SA15XF9NcYdJ$
`endprotected


`endif

