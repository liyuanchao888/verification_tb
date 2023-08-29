
`ifndef GUARD_SVT_APB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_APB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_slave_monitor_svt,R-2020.12,svt_apb_slave_monitor_def_cov_util)

// =============================================================================
/**
 * This class is extended from the coverage data callback class. This class
 * includes default cover groups. The constructor of this class gets
 * #svt_apb_slave_configuration handle as an argument, which is used for shaping
 * the coverage.
 */

class svt_apb_slave_monitor_def_cov_callback extends svt_apb_slave_monitor_def_cov_data_callback;

`ifndef __SVDOC__
// SVDOC doesn't seem to like covergroups with arguments
  /**
    * Crosses WRITE transaction type and address when pdata_width is 8 bit. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_address_8bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_8
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 16 bit . This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_address_16bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_16
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 32 bit . This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_address_32bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_32
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 64 bit. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_address_64bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_64
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and address when pdata_width is 8 bit. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_read_address_8bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_8
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 16 bit. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_read_address_16bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_16
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 32 bit. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_read_address_32bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_32
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 64 bit. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_read_address_64bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_ADDR_64
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
`endif

  /**
    * Coverage that Master works fine when PSLVERR is low  by  default and only goes
    * high when PREADY and PENABLE are 1. This cover group belongs to SLAVE monitor.
    */
  covergroup trans_pslverr_signal_transition @(cov_pslverr_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PSLVERR_TRANSITION
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pstrb. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_pstrb @(cov_write_sample_apb4_signals_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PSTRB
    apb_write_pstrb : cross write_xact_type, pstrb {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pprot. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_pprot @(cov_write_sample_apb4_signals_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PPROT2
    apb_write_pprot : cross write_xact_type, pprot0, pprot1, pprot2 {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and pprot. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_read_pprot @(cov_read_sample_apb4_signals_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PPROT2
    apb_read_pprot : cross read_xact_type, pprot0, pprot1, pprot2 {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and number of wait states. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_wait @(cov_write_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WAIT
    apb_write_wait : cross write_xact_type, cov_wait {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and number of wait states. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_read_wait @(cov_read_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WAIT
    apb_read_wait : cross read_xact_type, cov_wait {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pslverr. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_write_pslverr @(cov_write_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PSLVERR
    apb_write_pslverr : cross write_xact_type, pslverr {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and pslverr. This cover group
    * belongs to SLAVE monitor.
    */
  covergroup trans_cross_read_pslverr @(cov_read_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_PSLVERR
    apb_read_pslverr : cross read_xact_type, pslverr {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /** 
   * Covergroup:  trans_four_state_rd_wr_sequence
   *
   * This cover group covers specific combinations of read and write
   * transactions, for a sequence of four transactions. For eg.
   * Write-Write-Write-Write or Write-Read-Write-Read, etc. This covergroup is
   * hit when completion of four transactions are observed in a
   * specific combination as described above.
   * <br>
   *   .
   */ 

  covergroup trans_four_state_rd_wr_sequence @(four_state_rd_wr_event);
    type_option.comment = "Coverage for Four State READ/WRITE for Ex:WR-WR-RD-RD, RD-WR-RD-WR, RD-RD-RD-WR etc";
    option.per_instance = 1;
     four_state_rd_wr_sequence: coverpoint this.four_state_rd_wr_sequence {
      bins bin_RD_RD_RD_RD_SEQ =  {`SVT_APB_RD_RD_RD_RD_SEQ};
      bins bin_RD_RD_RD_WR_SEQ =  {`SVT_APB_RD_RD_RD_WR_SEQ};
      bins bin_RD_RD_WR_RD_SEQ =  {`SVT_APB_RD_RD_WR_RD_SEQ};
      bins bin_RD_RD_WR_WR_SEQ =  {`SVT_APB_RD_RD_WR_WR_SEQ};
      bins bin_RD_WR_RD_RD_SEQ =  {`SVT_APB_RD_WR_RD_RD_SEQ};
      bins bin_RD_WR_RD_WR_SEQ =  {`SVT_APB_RD_WR_RD_WR_SEQ};
      bins bin_RD_WR_WR_RD_SEQ =  {`SVT_APB_RD_WR_WR_RD_SEQ};
      bins bin_RD_WR_WR_WR_SEQ =  {`SVT_APB_RD_WR_WR_WR_SEQ};
      bins bin_WR_RD_RD_RD_SEQ =  {`SVT_APB_WR_RD_RD_RD_SEQ};
      bins bin_WR_RD_RD_WR_SEQ =  {`SVT_APB_WR_RD_RD_WR_SEQ};                            
      bins bin_WR_RD_WR_RD_SEQ =  {`SVT_APB_WR_RD_WR_RD_SEQ};
      bins bin_WR_RD_WR_WR_SEQ =  {`SVT_APB_WR_RD_WR_WR_SEQ};
      bins bin_WR_WR_RD_RD_SEQ =  {`SVT_APB_WR_WR_RD_RD_SEQ};
      bins bin_WR_WR_RD_WR_SEQ =  {`SVT_APB_WR_WR_RD_WR_SEQ};
      bins bin_WR_WR_WR_RD_SEQ =  {`SVT_APB_WR_WR_WR_RD_SEQ};
      bins bin_WR_WR_WR_WR_SEQ =  {`SVT_APB_WR_WR_WR_WR_SEQ};
    }
  endgroup
  
 /** 
   * Covergroup:  trans_four_state_err_resp_sequence
   *
   * This cover group covers specific combinations of ERROR response
   * for a sequence of four transactions. For eg.
   * ERROR-ERROR-ERROR-ERROR or ERROR-OK-ERROR-OK etc. This covergroup is
   * hit when completion of four transactions are observed in a
   * specific combination as described above.
   * <br>
   *   .
   */ 

  covergroup trans_four_state_err_resp_sequence @(four_state_err_resp_event);
    type_option.comment = "Coverage for ERR RESPONSE for a sequence of four transactions";
    option.per_instance = 1;
     four_state_err_resp_sequence: coverpoint this.four_state_err_resp_sequence {
      bins bin_OK_OK_OK_ERR_SEQ =    {`SVT_APB_OK_OK_OK_ERR_SEQ};
      bins bin_OK_OK_ERR_OK_SEQ =    {`SVT_APB_OK_OK_ERR_OK_SEQ};
      bins bin_OK_OK_ERR_ERR_SEQ =   {`SVT_APB_OK_OK_ERR_ERR_SEQ};
      bins bin_OK_ERR_OK_OK_SEQ =    {`SVT_APB_OK_ERR_OK_OK_SEQ};
      bins bin_OK_ERR_OK_ERR_SEQ =   {`SVT_APB_OK_ERR_OK_ERR_SEQ};
      bins bin_OK_ERR_ERR_OK_SEQ =   {`SVT_APB_OK_ERR_ERR_OK_SEQ };
      bins bin_OK_ERR_ERR_ERR_SEQ =  {`SVT_APB_OK_ERR_ERR_ERR_SEQ};
      bins bin_ERR_OK_OK_OK_SEQ =    {`SVT_APB_ERR_OK_OK_OK_SEQ};
      bins bin_ERR_OK_OK_ERR_SEQ =   {`SVT_APB_ERR_OK_OK_ERR_SEQ};
      bins bin_ERR_OK_ERR_OK_SEQ =   {`SVT_APB_ERR_OK_ERR_OK_SEQ};
      bins bin_ERR_OK_ERR_ERR_SEQ =  {`SVT_APB_ERR_OK_ERR_ERR_SEQ};
      bins bin_ERR_ERR_OK_OK_SEQ =   {`SVT_APB_ERR_ERR_OK_OK_SEQ};
      bins bin_ERR_ERR_OK_ERR_SEQ =  {`SVT_APB_ERR_ERR_OK_ERR_SEQ};
      bins bin_ERR_ERR_ERR_OK_SEQ =  {`SVT_APB_ERR_ERR_ERR_OK_SEQ};
      bins bin_ERR_ERR_ERR_ERR_SEQ = {`SVT_APB_ERR_ERR_ERR_ERR_SEQ};
    }
  endgroup
  
  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned16
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 16 bits.
   * .
   */
  covergroup trans_pstrb_addr_aligned_unaligned16 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned16_coverpoint: coverpoint this.addr_aligned_unaligned16_coverpoint {
       bins  wr_addr_unalign16   = {`SVT_APB_WR_ADDR_UNALIGNED16};
       bins  wr_addr_align16     = {`SVT_APB_WR_ADDR_ALIGNED16};
       bins  rd_addr_unalign16   = {`SVT_APB_RD_ADDR_UNALIGNED16};
       bins  rd_addr_align16     = {`SVT_APB_RD_ADDR_ALIGNED16};
    }
  endgroup

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned32
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 32 bits.
   * .
   */
  covergroup trans_pstrb_addr_aligned_unaligned32 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned32_coverpoint: coverpoint this.addr_aligned_unaligned32_coverpoint {
       bins  wr_addr_unalign32   = {`SVT_APB_WR_ADDR_UNALIGNED32};
       bins  wr_addr_align32     = {`SVT_APB_WR_ADDR_ALIGNED32};
       bins  rd_addr_unalign32   = {`SVT_APB_RD_ADDR_UNALIGNED32};
       bins  rd_addr_align32     = {`SVT_APB_RD_ADDR_ALIGNED32};
    }
  endgroup 

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned64
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 64 bits.
   * . 
   */
  covergroup trans_pstrb_addr_aligned_unaligned64 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned64_coverpoint: coverpoint this.addr_aligned_unaligned64_coverpoint {
       bins  wr_addr_unalign64   = {`SVT_APB_WR_ADDR_UNALIGNED64};
       bins  wr_addr_align64     = {`SVT_APB_WR_ADDR_ALIGNED64};
       bins  rd_addr_unalign64   = {`SVT_APB_RD_ADDR_UNALIGNED64};
       bins  rd_addr_align64     = {`SVT_APB_RD_ADDR_ALIGNED64};
    } 
  endgroup

   /**
    * Covergroup trans_read_x_on_prdata_when_pslverr to check if x on prdata when pslverrr = 1, pready = 1 and penable = 1 for read xact
    * applicable for ahb3/apb4 only.
    */
  covergroup  trans_read_x_on_prdata_when_pslverr @(cov_read_x_on_prdata_when_pslverr_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_READ_X_ON_PRDATA_WHEN_PSLVERR
  endgroup
   /**
    * Covergroup trans_apb_state_after_reset_deasserted to check IDLE and
    * SETUP state during reset deassertion(just after reset is de-asserted)
    */
  covergroup  trans_apb_state_after_reset_deasserted @(cov_reset_deasserted_sample_event);
    `SVT_APB_SLAVE_MONITOR_DEF_COV_UTIL_APB_STATE_AFTER_RESET_DEASSERTED
  endgroup

  /**
   * Covergroup trans_apb_states_covered to check IDLE, SETUP and ACESS state
   * during the transaction
   */  
   covergroup trans_apb_states_covered @(cov_state_sample_event);
   `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_APB_STATES_COVERED
  endgroup

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTUCTOR: Create a new default coverage class instance
   *
   * @param cfg A refernce to the AXI Port Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_slave_configuration cfg);
`else
  extern function new(svt_apb_slave_configuration cfg, string name = "svt_apb_slave_monitor_def_cov_callback");
`endif

endclass

`protected
9e?fFg_a;U#_9QUa_GC/YAV4Yb3X+SN,8.c6fD+TG>O<cANA[(QR))3geARB6I+/
fICF&TJRZCWU\4#dP_&>cI.040TbT_Ug\@0@&C09WE8&F;^=&J/40a-2Je3G_=L5
@,CaQ7_Y[W<b#_#COKY2>.c>:RUAJ<-ZO7X&>,.a0AR/E:f<;G5).PF8JHRTgUOU
>72+eT(_eJ4]P\MJ7Q<&b[LY;J_dUU=O=GY]VIfM;BITgb@e@^(dI\]fUd=/8:M=
@LbgPK)]]@VB+[73H?+9KdOA283].QN>F<QK=R/(&];6/ceXBC:(X]_?I<<[RJB)
eMGHZ>e#@ANSL9KRR-N,WGY3P1<M],:eI,SCH+4W:NWZ8d/.22c751RgT,+.A,,S
/?A0JXcQV76=9MELUeMRNJE-WSHDEAQb.MI4H^HN^W]Og8GB_\YG[5/A-,9(V9??
^->9UQ35@=REP[5_US;J/:9C)YQQOK&Zeb7C&6fSQ+Y3A>Df&Q)6=A91fVc865UB
_da(7+d)FBG#HG]DXE-E_M)J&aV->MC&NcDX&D79d?F9(Lg_bf+B[=d6C,Y\RY,,
EbHK+><)8-HM7./15EBd(Q/MY9-;0+]34H.?KB,ggQ5O.H^Lb[/d>G^F,<BJf=>U
c\1[99A0AG,edND8;N:D_(?WN7D6PE)d)?I&DE+MZV1<>&#fV,OV<cGZ^^F+1Y8B
1>GCM,M9MM;bUc\FPb(P:-M>1^](5Oa\CC20Ab1b@4c#:/+AP.IT(<fUASD4gbYL
(B^7Xg,+cC,)c9Qb9.BR)M#=(Eg:V4a3;Q^Q?_e2)N18^([(=R5(HW5+D&M@(O^g
XK.J(SZ)IacV,#RV]XXD)ZP4GT-LVf<7KBSI+\cPNNQ]Tf,F2HTYG_+Z,UTT,4da
AXf/_+,+&^ff6#TcIC5gY76ZF,<Pe&BMOe)3P\<F+_-PNL&5^M@E-&-7Zd)3a&>+
9[a4</f+OY&NP(</P5D?FTH40Z)(4<NbOTTIE]DM5a2\R9X]^4@Ia9eD1:W]#@=N
<>?N76V)e4QFIgBZY9/CV5ORIQ3R<.QO75Z],O0#RFKA;FXV]ScXJT;I]WYf<c5Y
=KAf;Q&D:F)=XFaScF(b768_J&/.C4J+\gQWb7@81Ec+[_dF[=T)U1L3^b\c6^<W
\(K41A4D6#>,F-7&+AE8&=ef)_e5RZIc@E77D&I9XA5TQ_>7^H[c#aCL_G>_gFVE
Z70QV21&HJK^6XLDDJASdQM0RAIKWIf(0^G0fS4-E?^;TEe_.U5YF,HZ\Z<LfPE)
Ec+(MF&18AU4O)AA-./:C4L;b0:<]H1XaQ4ce1=2?R7e<7L&S?_7G\UX1aO/-.WJ
f(\F3QXQ\=P2VN7[]F=ceLb\06\dP.f[B3\0,#@HAC;1X,9Z8DWXU[^g#-6/g#cK
QQ/2:BG5[#7<N(-A399b2^W]E&6a.UG/EP>e0XZFSQ[ZbYGG+H[S0KO]ETKF5SP(
4[Hf^F-2E?&T4ZA0;aV>HO(B7@#XZ9a_Z2X?ILC<MWMTQ#f]bb]N=9G4Ke[,@YUU
e0IeW#Q-5Ob:DFNMf9#A4]g7e/YURb0/0[DJITFPQ=&?NJ8Wf0MS]U]@/T5Q1eC7
1@]EC-V:U.<-^)3R3g;WR^0b:5f96;3Z:,R46XCga39&BRW8))A&a-&a4fc^<N0G
GLFU+M[d&^.3JYDTW;OX+c/CE9PN)2=f96L@[Ab6?4eb-5.H3[b]cET,8F>S,6H^
1;V4QTFB76AVL7NFFEZC[EQ;<4e,\<@-K,C7E1IG&?RE6PI5cL<UDWQS0MaFO4N=
<O5&)V)IFg7O.I9:RAL:.IUT>CJ,@M9[[/Ug@d,W8/HbTBB9YP.^OdQ8PB\VLKQ&
=R/E:L:C_JVPIJJKf@+,gfP@KW&&NYKDaQU2D0(e+GPD&QGIXL&>/8FSB3)&cbA5
LdPcJ^7WAO5YRdf-Z.S:O5[G3]G.-(10J5Yg9dAF;dB<V=/[=5FS2XQe\1>LfB4;
7gM5.3aHK\S1G]<N7a(&.#g2>0_.G92M=-SY71@\B_eSHFY+f_-9#1WYGU2)XB/g
XM3dA#d(08+Td-ga&Sb2N_cHOf:C#eF6JR55;G6@9@+#JVM8S30EX:9Z6-[4-#F\
;eBb4HZCP?>MJ\@T[2_#D3=dbE]L2V@X;bO@f@TcS(_DBAMZ/2#F>Df][0_9UJ3[
3KL-QI]](:=SZ+X3IIf1+;DJ6Qfa,,ACN@+C_DW5PI@WF5E@-,bV,LN[:AK/XV=^
K=DQ#D-K5?Jdgg?L9\V<#FGB6M/E=H/)28\S+R9^Q[<Z9U98eeH3#4]DN2LJ/)e7
17g@TcU:(SYJ<REHI;^7Z3-W)OeC92K4:2@C@PEN(P/bgW1<=X/E(:P./@20);84
QL+7J,HPQeKHVLM+-D_@KJ]M;]\3dGAY5RR0W;gTS\bdQgWCc>+8A^^WZPOEC\YG
MHYBJBBZYc=d=T<2O03MOg2))\4]C/YBK):=65ED]FE(<ME9:J7S&L.e)+XC85S]
(G;EM81/V4_3HV88(,45-QOGgMVEF]5[TXb<b]C-J>;557]^KYA0S/&5@=K0,16I
U\[1JV&0-eWg-dVDKB4:VS8G\9HGe^&\J7I=C\G83OTN<Fe[0f]?1=,_AE(WJ43e
7ET344>@YPRVOLJ4C@X\;TX21,Y^IYf(?8/<;,)5O;D>;)VaEBb?>9fD.5U=#PaD
U65IIB.+A=ZA+\e:c9\48FN/@S0LLOW5b<;KcON.;P^<=4GV4DO48D5g8P;)d^6a
LAT]_;&,Hf/]_BfQ@G)c/#g<=M#a@U7G;,U7S1G6E@;c;;<40U@TGOL[]YadOaK]
[43#da_G9O&>UaLgRK(#Q&c=C7HX:N3JRQ27>,Qd/6f-Ne2MTL+UZcHSfU>IM^,H
17Z-&XB[02Z2H2PXBZ&Ncdf>/aZHfL\aECagNT8K8.R9F_S+a]-I(</2M(>PHM.8
.5CS-+#D<f++T<Q?Wa+_EYM,G<1HB)\-+;.cX\ESDKVDcE5F_#)C,fURZMRDQJU;
L0HNIJaa><f721gCTc(.[]\R4Z[W\NK\IM1&#c(2?AT2ZO>I&X5,aHEbg\/MKZ8(
d<;68G.C&C>NaM&QO=_cd#-K_?>N\DB6cO0XVV+E0(+0ITW[f^;_P60OP>\<W)/-
+LA5CTf;LQa2[63c8Z-&G&H\aeU1CSHI/6B\ER9_5#]5)I>#M-SfM>./E6:3:F5Y
XO(>7U2.:ZY]aDRH6XBb/_MbH7SQQ<RZGEPDJg_U+2,CZTLY_/ST__:fS4K1?;9P
ZVEDeRPQN466GFCWB_K^f//bMG>B#0D^fVZM:&+3\XGEC1CB&3T^P4YFefbT,ed3
eeg=A198\g)3A0^9>:M/EQ3BV.3J5P4)@XT,V)9(3>2[X_<44WJ\B^DEJJ[@;?bV
GcG;SL\B@_<1^KB^_CKHe#0Pc3VCXK(eEP>[U?)MYVgBLGfB(=Ka#eAQS_4VXZA&
I95[Y.a7C[XW;aPBU@@UP)E&EU1D;C??+FJGa/MOfUVT]PO?Xbe47^>F/F<dFZGD
Gd_g9D<)\6.b=&RRZ[_88\/?Sg_N./O;HN:.6)EagF.]f+T,7-M7.F0dO2b>L&Zd
(=0Y-=_--&7/:-2CO0d1JJP43NGFY,d3EHNc3P46M@KGdFdUU(R781Y1+#A#FQC:
6PDW5g4)]c1B^]J\BD)L4-S;&Q_CA^2X@T5OAR)6ES_],fQQ_5HLJ_Xa^g?4VP>)
W;SP?I9?MMW6[/VZ;?+/2DA@9-Mg]?f+;BL]79XRKC+]?+HS\)3-[L:>g7)5&@0]
/@UUb[^YI\P=f,)3KR^Y2O]UYC?UN5Cg?aR3N;+,F99d?fFW)HBJY7\4d3SW50:5
R>OQ_eJ;<2;M[H8WXK9d0)@K[F_(dJ7#T0U28&EF)FKRKOXZcKdZ6/NEVM/9]REW
24eYGVWRQ\=TR;QR&Ugb2;B>=UO=R&c(]LL:YNcFaE9:D6O\@PEGQQK\b:\8NMV_
+]\=Z)U[d#P]/#C@&Wc?/(a2&Af(//,9[H/>+1N>VbE)_F9>.IFN>^N,W+H0gATP
,^EFaaY+R=8QGb_d2Kf)C6J3T-GZT#UG5_3:?O@@,OYVWWNZ0/a-aeFPe1>EZU42
&);]Cd/@a2D)2=6E4gIS63f411V./_DM7-E9.PF]HZaCgM,M@<M\b<Ke19H]XaDP
+5Y<?dIHF7UVa8D[-VLL^/_Zb&c)U5A\A+.LG+XV+CYZ>Y)R9JM0]K+Z8a^eON(3
-TWH4:>U]?cA;>V?H>]aOQN>)70+LY]d9]@KE[>aRMc(@EZ;?PS4DDLbXQbAPJ3,
1a\.V#Da^D2[F],MD6SSW6P8(Ea6N\3PE#AG/)C+G2?Z<<@E9L(:Y^9<NBTGcYO6
Mf7WVND3:ME3Pf^&J.I(1-H7gV/QV@dNb?2TB#)XL)FR^fOBcZ[&JeUA#6G,8Na^
-\?dcBSSKR,8]W38J/MJ2X^f/^PQD^F>5KKb+^[8A6W4R,;9IeL#d+&GXEaFC[/1
=E2Y3H&F4:13dc:KLRg:9\>X],JRK[)XIb4>CMBSDLX1BJD4S:?L#(&Y#423S_,[
5b1&HUBGT/OXF>K+\IbOW6c6#]0UL5c^F&)=0,fIBf)Ucf-eO(++07[fNJbGGH_.
3#KJa_6BX.M?W9RgT13#^g9BWgXM9L;6TVV80-(6+d2;34-AbFYS(JQP=KMKYB_U
CC>d)^M<V7;GLfTLHI(]U+DG@S8QJ0=<P;8ZQ)\ZB)K\>3GE>F7f.)Z-U9fcNKe0
HW0AIAg>GQ0&I&1[]DEQZ+WI6fJ=>?)/+?09NSO=]35KW=;.IeMX.?fBA97IDZ5F
#[b_37-cSe\@CMEBSaGMg?aEGF5/_Ba]L)<3I0KGPJ)NTgBcXcXC:Og7__4U5P5R
E)W7=9R2K3]DXO71N,#_A--5ANK\8^W\90C2dL0\/1&=ZcNaW2L<3bG=KHO<c2^a
3N7:-Q+e1S/We-P_9WgRIdZ(g:]MVAG)8)fI6V96.dA[;b?<C1W.PUJ#a4a/daB1
S_WP^]MO.]UfMSObRaFa5ZWS;4e34=+04W2DWK0&DaAF4N/0B^_-3O]&6SI4V3QK
=9;Q8N5\^V2A^/KFfI[^(.XPG\,O)P;@N]]?>,7P0RS[VUWC+QHS.5g9)4YD60YG
Lg1B(_>g4d-57>I/F2-geV&Y5FT@[@1G^?Z59-LG&Td=X(6J(2FTfb0<O-GQ6e[E
DOZZL)DIe@@VaT]BQaMP5_W^&c(Ze]M.^>Q+<8CU)<bDPJI#Z=&2Ag_3PfDH6=(?
Ed5[/^J52F73,W&=97B8:R(V&QT?QA-60fYSc>A[39VKV_3d&]\A;FXZX=:R5QfQ
P=:.g-,Rf3ZAcb??3?L,Z,fNbLA5JU:C>T.?B9[,CTPE<SM?@PBB?eT182[G_S8[
DT,1U=5^PF=6NARL[FE]@@+6XBaJ0J:P^c\U\0YLMVH-4f<8Z@8GR1ZKcc6CL71g
N&INT7OYNIfJGWFJ:JKKdP)SJA9NdSa<.;UUXP_@LN?X/E@,NTAN)\[+I>2=HNMA
EY=UY\#>)WE_LO/=M=[9bW)_?K25(NP.7#11UB\V-++P&dNZ-X44HSE(>?RQ\(1^
C>;D^bRgG&#]CUb5D2WK07,VJQTe?IK;UZcH9058UTf1:IKZGC.E\+5:.,2Y7?Qc
<+<4Q@a\>=Q32]-B6Q]QKgB1/^e(OZK8?1_U&@QWJcd&DY.\0HVYE684&KcCC\HR
7+6^12A>/F>X27^CK?gcBc[H(E26#g3.Xag.\23ZZ[EYPbf^-ROZ,ZUfU4(=P\\)
Md@dN,W>ZD(f7T4V>e)E4AH2b+5JIg3:G(TC[XfS:5=^8.4=U(]WPfIA(WHC0HIC
K)L&2YG:1NPe1=8^?RC[,c^;BZ>9RNb/I5OF=51SI4<OGQP;DZ\__R5F.-^3W+A8
B>IZ-U);G<G].b.UKOU_MAD/H??Za9f[Bb]YbX4<Ab\F10.KQ?EW0Y54CN8Id)J:
?@]6Rfb@)ZXbSI5#WT?.9AWBC=(a;270d_:S]A2EgUC@B/DbK?@4=<^\+D8.11VP
B/a_;\e=EFY@>:<=B+Kd/(25fCM1+TQ.)NEG7320ea#B#]RC/1DOVEO.4;VK6\KH
5;?B:Y3-:(V)2=P\bEf5T7F(FZY1E^EE17A&0_7^.c)N:cV=T+ZdEQM_N2ef6Mc8
=97PP;TNKFZbV6F^QGIT?5Z(0XgP\STSI<1c+e\RI]Y5I-Q>0T\BRPIQFDW-9C4A
2c:d79QVcgK5c?e?;2ga=<E8a_b/B>S]>/KR.:b9PgG;aSJ:JPI1)LQZK?cc.@P:
>6V]9[SFO\JacHDCcCT<]f0bD2-ERKA2[gA\KU(/(DFM\1(JLS]6KDS_b58]0H<G
Y5.H8R]#QP&]?1/8&>@)4=VFD4I_0cQ+WfG3Xb-)PONO\IbQ4L[UZ-;])5,UJ-84
3NW\.E^<CZU3eZ:]OD0f5I84QcBf=3><VOg.;07.\^2(DfMW#b+aLMW=R0gG,7,#
+Z7&[+XGT7M^60DNQ^Mc1>:K:Y=]XBQC/g:)05W[7A1OHVe^TV6.?M.FYI?G?Ld/
9]LdTO4A51=<V3ee&1[<H(R^;@JM_59ZYUK3JC(AU>eVA_U=H?AL)_Z9BeE5a,dG
;,aKaF^#WF):>R9SFD.CNB&aOK)NddYgD1V0NRP:;W938:GK#DD-_/UP1/3=0WgR
bG3bT795UD@g]+XSXAC-9+^N;d2K<?/UMR>RAUB@&H]@3G,M@d[EVZCMO3XDE#;&
1<Z5+49?/U2(cBI/61EX3[g2>\Y[gI,ef:OG)^IZ\8(^J,adOa9+X/Z[8+6]d4RV
.&706T&fFbRYXI/,X#7J2QaK--e-S_(ECLAd]E<6K_Gb?PO(Mf0,f1WP.@+].5>&
FKD786V/F-K0;0FBD[FO<aKaY&f9@eL58FBF@,?/f+Ff6U5g_Vd8)f0V5H,7\>C,
WR9_(PF077eX1@A48@HYY[(X90^7;E_XOTG;aX+CO(.U->3MgZ0OaE8KFYXAF8Qb
&G6&aJR6=P15+K>NDQLb(^SVe+2<V-6f9D=G/-4_LD0,U-]R;?W7YUOC=8JH>9PS
fZHFXP?,=_EB0#0QZf2X4I6e=B\VLK1JB.S0=?28d1VdAFBY0MdG:U#+(D-GT@5Z
L5a;7Of3/0)3S3W?Q#A:?3\QcY66=(4+X]B]XG#SIZ)Wc([;La,(P&0:GQLID_g1
a+.:)=VCgWYHRXU]>(V8+HZ6/@DN.CS\@H3Cd7..BY45G<]AJfXbAU@<Q\CbAePA
7bIWSJN\I#0)PZUP&ZPVS<=(8d@b,BFS98[@A=g4S?5V\?FG/D@/MAZORW-:V36+
Z2KPJZ+[:4g.NH&ZND__1>EL@.Y(75M)@f5d@]DV&2^IcH&540?ZORVW91[?WM<2
:Hd<\5,CgMO+)A8U&<RceX=)Dc7=M:Y>ZcAfF:T>FHS09cR5SS=FHgZ,?IY/.4/R
SaC+PfTXD[O[QF6eYdO;74d1U-90W7LPRG6H//6ULQ^XKIGF-\BG>9=I,&ZGG=@2
)FZc4S.<O=WR5F\gfUbQ1E#@<IDU?0,XKf]SZg47ZHDPDIS2eT-Sfa:1C\+/bLc]
[@/8C#-27C<R)$
`endprotected


`endif // GUARD_SVT_APB_SLAVE_MONITOR_DEF_COV_CALLBACK_SV
