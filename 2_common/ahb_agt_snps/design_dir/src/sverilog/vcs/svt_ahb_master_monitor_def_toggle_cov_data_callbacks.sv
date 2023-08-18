
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)
 

/** Coverage class declaration consists of covergroup for single bit coverpoint
  * variable. For variable width signal instantiated as per the individual bit
  * index. 
  */
class svt_ahb_master_toggle_bit_cov ;

  bit signal_index;
  event sample_event;

  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_CREATE_CG
 
  /** Constructor */ 
  extern function new();

  /** To get the signal's bit position to be sampled and event to trigger the
    * covergroup
    */
  extern function void bit_cov(bit b_bit);

endclass

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from ahb master monitor callback class.
  */
class svt_ahb_master_monitor_def_toggle_cov_data_callbacks#(type MONITOR_MP=virtual svt_ahb_master_if.svt_ahb_monitor_modport) extends svt_ahb_master_monitor_callback; 

  /** Configuration object for this transactor. */
  svt_ahb_master_configuration cfg;

  MONITOR_MP ahb_monitor_mp;

  /** Dynamic array declaration of the single bit coverage class for hgrant signal. */
  svt_toggle_cov_bit hgrant_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hrdata signal. */
  svt_toggle_cov_bit hrdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hready signal. */
  svt_toggle_cov_bit hready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hresp signal. */
  svt_toggle_cov_bit hresp_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for haddr signal. */
  svt_toggle_cov_bit haddr_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hbusreq signal. */
  svt_toggle_cov_bit hbusreq_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hlock signal. */
  svt_toggle_cov_bit hlock_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hprot signal. */
  svt_toggle_cov_bit hprot_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hsize signal. */
  svt_toggle_cov_bit hsize_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for htrans signal. */
  svt_toggle_cov_bit htrans_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hburst signal. */
  svt_toggle_cov_bit hburst_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hwdata signal. */
  svt_toggle_cov_bit hwdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hwrite signal. */
  svt_toggle_cov_bit hwrite_toggle_cov[];

  /** Constructor */ 
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_toggle_cov_data_callbacks");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_toggle_cov_data_callbacks");
`else
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp);
`endif
  
  /** Called when the address of each beat of a transaction is accepted by the slave.
    */
  extern virtual function void beat_started (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact); 
  
  /** Called when each beat data is accepted by the slave 
    */
  extern virtual function void beat_ended (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact); 

  /** Called when wait cycles are getting driven during the transaction 
    */
  extern virtual function void sampled_signals_during_wait_cycles (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact); 

endclass

`protected
gR556VTQA=VKV;JVJG?)_-:0UL9Q>:M_Id^U:a:bfHc-Z<JgTK=8.)4?DKSU9LXg
AC[9\ID(>PL+#1Q<8+LN90=ZI.XRMg8.=f]PNK_;8Mg#WX9:5@D#FAUS1]>.14QI
69)[TaT4]6I)PXa(YZ,V:g85E9@M)(QCSafbM0AAcN;W>CR6[R>3HG]=a[T0<>b#
#VB@+KNAMTC@GUE^4E;\:L855$
`endprotected


//------------------------------------------------------------------------------
function void svt_ahb_master_toggle_bit_cov::bit_cov(bit b_bit);

//    signal_index = b_bit;
//    ->sample_event;
/** Rewritten the above code  as following for better performance as per VCS R&D's suggestion */
         if (signal_index != b_bit)
         begin
             signal_index = b_bit;
             toggle_cov.sample();
         end
endfunction
  
//------------------------------------------------------------------------------
`protected
G_T-VU3TWR(QOaBb;\cNQbAd,/R]KcGg[:&S>gMB<eFg5QPH+:^A1)R6@ME0D3>I
W[^(?T-Y[dd5&L/]LB-RHX5^ddS2/0G67I-AB\3.;&@G\O3NCMg?S\IOb[E=M1^?
ELJ42BSUI+DU]E,G@S.;6-HJ\D.&0EEXW,#3&5B&eXO6)QTNZ0SXCVY50bgJO3WA
F)@_0]4KT(d\V?O.We[AMRT0(A#JDF?E(Z#)M4RF/g3+bc-fH:WWO\F.XeLeG<YU
bc_&C/:JJcE+Y36KY;X\0I,6f&1e6N)30,Q.#XN]=PDNVf9XCM.;Q1>KZKN:R6S<
^JJ<9OQJb:TRaK]=f)NCE.V&[aNZ0>VUGWQ.0WW)D:.,PI;I.HY5fdE0gBUX+Zd)
<+W6,8ZEFHE\<BWU^;\Me^;;2#Fbb@e#4LP;dg,fZ[&Y,8?Q4G9dQ78?Y<L@>F>=
>H3#\P<7AdH3@)Jb(YHXQWD1RefE7KaW.;>_G64[a,_#I8JPCJfEb=AWBI0fC3VO
RYab^cUd4H^,/a)G2C,\,LFeU[2OY0.PN2b?._P2D&N2I=ENITM\OL5DHKTe)N7I
HK9Y,G[BK#D:g8fX3]a(,0H+7N&OR(_R-DODXG9+9(I[X/\SbAT(?E?85W89P?1^
dSb)=EgKY2XH8TZP0-6QG;eMF1&3KeL(,G;CB:1W6X)[2G149H9\?b1<X>GSTXDX
MC&2M3PV]DTI#U+K]2JJ)/JA.cMBGY05S>KWNW/C/V;LX087V:a_Z0=K@IUGUCSU
F?/7:H7\I[VN8(W:+ADIc/E74=5b7Z1R8f:aV(35IC[23K\&)>dg@aL,/+W(0V#Y
1Y_0R9Z<3.,94PdTKT=OdPMD2^#3&,gDI/Cc0EgZ#)7;+2ZLU/d8HVZLU+=JP3g?
ddAb@G,RSF(MNDR=Z+P?E@L[=6K,I_F-EK&,-<H,J0OG(_),e1^9)SQ+LLK5#68Z
8-#L2@][;,gbcg#TR9=<4C8BJ(2;&GD&7-5b8Ja1.f-GF$
`endprotected


//------------------------------------------------------------------------------
function void svt_ahb_master_monitor_def_toggle_cov_data_callbacks::beat_started (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);
  if(cfg.sys_cfg.ahb_lite==0) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hgrant)
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hbusreq)
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hlock)
  end

  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hresp)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(haddr)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(htrans)
  if(xact.xact_type==svt_ahb_transaction::READ) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hrdata)
  end 
  else if(xact.xact_type==svt_ahb_transaction::WRITE) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hwdata)
  end
endfunction

//------------------------------------------------------------------------------
function void svt_ahb_master_monitor_def_toggle_cov_data_callbacks::beat_ended (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);
  if(cfg.sys_cfg.ahb_lite==0) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hgrant)
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hbusreq)
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hlock)
  end

  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hresp)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(haddr)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(htrans)
  if(xact.xact_type==svt_ahb_transaction::READ) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hrdata)
  end 
  else if(xact.xact_type==svt_ahb_transaction::WRITE) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hwdata)
  end
endfunction

//------------------------------------------------------------------------------
function void svt_ahb_master_monitor_def_toggle_cov_data_callbacks::sampled_signals_during_wait_cycles (svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);
  if(cfg.sys_cfg.ahb_lite==0) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hgrant)
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hbusreq)
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hlock)
  end

  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hresp)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(haddr)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(htrans)
  if(xact.xact_type==svt_ahb_transaction::READ) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hrdata)
  end 
  else if(xact.xact_type==svt_ahb_transaction::WRITE) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hwdata)
  end
endfunction

`endif
