
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)
 

/** Coverage class declaration consists of covergroup for single bit coverpoint
  * variable. For variable width signal instantiated as per the individual bit
  * index. 
  */
class svt_ahb_slave_toggle_bit_cov ;

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
  * callbacks classes are extended from ahb slave monitor callback class.
  */
class svt_ahb_slave_monitor_def_toggle_cov_data_callbacks#(type MONITOR_MP=virtual svt_ahb_slave_if.svt_ahb_monitor_modport) extends svt_ahb_slave_monitor_callback; 

  /** Configuration object for this transactor. */
  svt_ahb_slave_configuration cfg;

  MONITOR_MP ahb_monitor_mp;

  /** Dynamic array declaration of the single bit coverage class for hrdata signal. */
  svt_toggle_cov_bit hrdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hready signal. */
  svt_toggle_cov_bit hready_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hready_in signal. */
  svt_toggle_cov_bit hready_in_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hresp signal. */
  svt_toggle_cov_bit hresp_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for haddr signal. */
  svt_toggle_cov_bit haddr_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hmastlock signal. */
  svt_toggle_cov_bit hmastlock_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hprot signal. */
  svt_toggle_cov_bit hprot_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hsize signal. */
  svt_toggle_cov_bit hsize_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for htrans signal. */
  svt_toggle_cov_bit htrans_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hwdata signal. */
  svt_toggle_cov_bit hwdata_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hwrite signal. */
  svt_toggle_cov_bit hwrite_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hsel signal. */
  svt_toggle_cov_bit hsel_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hmaster signal. */
  svt_toggle_cov_bit hmaster_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hsplit signal. */
  svt_toggle_cov_bit hsplit_toggle_cov[];
  /** Dynamic array declaration of the single bit coverage class for hburst signal. */
  svt_toggle_cov_bit hburst_toggle_cov[];

  /** Constructor */ 
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_data_callbacks");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_data_callbacks");
`else
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp);
`endif

  /** Called when the address of each beat of a transaction is accepted by the slave.
    */
  extern virtual function void beat_started (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact); 

  /** Called when each beat data is accepted by the slave 
    */
  extern virtual function void beat_ended (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact); 

  /** Called when wait cycles are getting driven during the transaction 
    */
  extern virtual function void sampled_signals_during_wait_cycles (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact); 


endclass

`protected
O^-g=V[b1d1?[)W8T._V4D[cMP]S6/>)@E>,XHM/+W/S&+=cc=C#7)^c_cd[+Q@O
BeHGdEEVDM09#[)G<F.^:-<[8,;7#=XCHd<YS()gIRd6+Q;ORO5+<D?N(YNJO[Q7
/0Q58dTH?I,@JH;W4Z&,8e5JQ2DN0DHYLWDU>B29553S=QaF=)c&SF.CIDMYJ6)X
Gd@-e\=O\RPf[.<+E97ZX=5J4$
`endprotected


//------------------------------------------------------------------------------
function void svt_ahb_slave_toggle_bit_cov::bit_cov(bit b_bit);

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
^RI^fLHT702/9<,S;BZ0:D?5O]R&0+=#Be8[AYa3d?T6G5^S0JPO+)7\T=ON\E,d
1d;]bT[(T;JC\B0[WCaAY<)V8;1>KgEW5Ze-(YQ?0U9Z5G7eP_KQ&5:0[._B3AbO
2fe0E-TcGcL(4fdGJ<_H-)M9FOY#G244@Q,8(R:][RBRDa>U<4SC03]F/&X=QK:c
g22T7-._UHKWX7XR4L)U11QNUXgH>Tg9[AP]gc2L=9IK+<Me&;K_dWO76OA7>EfT
[?>eP?R^9SaTc56\5cJ_f(5JAK1dXgM:S=&KQ;K1:^&Zf&XUAB+Z(YQF7V0X.#(^
[f#>K63NVEOTa2XdW0@5-;f>@J7ZE8,CA<_bAH><([d^KXgQW1aPc\IAQ:D@JNJB
)AO]FX2?Ib^GD,E+a/G7(BXXL9L.F<XL(fPfaM[[aU;-,aJ)Zag(77F[A2TQc8Ed
aI:c_J1O6a-Q0\:GVH_b^.8CA_0K0SGVS2=>0Z-Af99_,5A6V;RbK)J2-ScG8YOb
c?JVd2dM4U.f9(XCB75P,8aT)GbBQI(:OG9X,:FQ/aG&Vc/]N[G5dJ+X2b5GbMC2
B(Ha\K4D?SOQZ^OQYDa5=:YNg4<&,,OMfKZg#fE3E0=S9;275L&B\HJ^NaX@FPLP
-/:2.W>,W,[E_b3c8TCF8NG0R3#dI]>ZeQX\1ef]E?D+^7XWfDcHgKQg1)^\PIaI
XNB_X_Q\S&(Hb&5R:?=Wc,F/@;WbX9+D7#12Y;D;M=)EZP+1g7Z@:<Ua^3;QAR^g
_YMIAN48YUNDc5P-=-+01+I_g+L3NgNbGS+72BM?MR2WaAG+M/XW];.\V(4K?)#_
<X9>YJ5)6O4D@f9N(]M?(>;(_d-_+_3,=O_aMd>4NcNRE&6\\X/?X)c+8MC&:\\a
&KMD0MX#[C/9<A^/7R@/bPf,EJE6(aJg@];@ON<Y;]]Bgd^[PQ;)Z4dL/gA/ZU+;
geFT.[/M&-&B0^@G.P+2QGO+dI7:b-,^>$
`endprotected


//------------------------------------------------------------------------------
function void svt_ahb_slave_monitor_def_toggle_cov_data_callbacks::beat_started (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  if(cfg.sys_cfg.ahb_lite==1) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsplit)
  end
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hmastlock)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hsel)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hmaster)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready_in)
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
function void svt_ahb_slave_monitor_def_toggle_cov_data_callbacks::beat_ended (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  if(cfg.sys_cfg.ahb_lite==1) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsplit)
  end
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hmastlock)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hsel)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hmaster)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready_in)
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
function void svt_ahb_slave_monitor_def_toggle_cov_data_callbacks::sampled_signals_during_wait_cycles (svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  if(cfg.sys_cfg.ahb_lite==1) begin
    `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsplit)
  end
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hmastlock)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hwrite)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hsel)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hburst)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hmaster)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hprot)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL(hsize)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready)
  `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_COVER_SAMPLE_SIGNAL_BIT(hready_in)
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
