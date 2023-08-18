
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
klQoejAs4nTltrSb3+jY65qhmeBICvO4WQnKsywkKTgNzj8FB5vtIfKQclUuly4W
g2mCHEMLdd0ENXP9BFYxtJM8XR6Jfp5XvbzPKxWXQXzktSwFNL+3KOGmHPGtvnvV
FLe76gKAc+ZtZu+9uy3Tu3pUXE5u0mr07tpHtU+17yXfzcFQKpKB0w==
//pragma protect end_key_block
//pragma protect digest_block
ZYoWnx+qE00aJOo4G+QmbHZ3aSA=
//pragma protect end_digest_block
//pragma protect data_block
9LmLTAyd7xYkodXwYVwk8NX4vhqyO39V4ffrhXDSyuimOinHez6lQeEsjkYi5KS/
RlssgeeFPXMkMaVb4aBxKbhry4fTSHH+lGjsF1QXPxj0FVF3+ZgVXUifEiuLkzCz
1+/t3tlOFWx2DvSVqg2hGdJl6ul3KSHZ5xTvDeWyNfM5OQPO71G4vhC/piKgpnH8
uJsQMWOsNgagXFoBnsfUOOE2RHy8XrVMuOF4rHh0fH+CMX2HrciweXQfNx/3Bq/d
E5y/IuVqPVWBGsMaSUP/jQvr6yawqCHUMXl/5wDafUfGcFAhr6S91SOhjFA0MaRO
BeII+hW+UBHcx0TCw2N1tFFj1zS0+Pqdm4SSI0IS5iNo7BYZM7t+/yjL4D/gSamN
qe3A6qOkRCd11DbCQiTjHfQSYuH1jsbOPa00zSxHkYoUcOekwwsvgwd1GS2qn158
XK9Sw5xgNGCzeqVqysvFEAQ7vRbsgnghQCjKS6mEKTK2duopAddKIfrcSymABmFX
EAgWni6jmjj41sQoyHJuaqwJc0vz4jVvC6bZR5wGF1I/fZkFFDBATFi14r5ojV2j
fwFSqbqeMZAvmZLqs60vsg==
//pragma protect end_data_block
//pragma protect digest_block
OQxbwTw4VXEch+3EyZTAMDnZKT8=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1S8HcUSNh5qYW0Nzjhqk6ntU/Dw/Zp+/RqLrqQFHV2WOyHDWe+z1vtujH4c9takR
3am9hu6ASHDzNwMKrNaoXwwRpSBtMbg6u6yfRuCYva19tv1+CjiY+6g/CRVxME7h
6eLBPH3nQ2vkuuy8p4QOMNjH5UG1HwKARSiXjhNHu53JnO000lHtgQ==
//pragma protect end_key_block
//pragma protect digest_block
n6wdSxT4VkKLj/sZ+m81d0Pn92s=
//pragma protect end_digest_block
//pragma protect data_block
3mUuDdCnewN9kQOr6mkjAKHiosluNXTCC1R4YakeNiMPwTU361zNTz0qmMmS2nOu
Ozxxv2iMRfIYKE7qNoeYGtLRSV9OaaIEjZOmryfCYCv1zSIYR+Nlnu4I57AaMsSZ
lBX4ub4Bx5RXy7x2ndP8+ytsMSkaz2yLQc8iyCDB+2h/944SoIOpxHw+yN/Ary+a
dBA/OLO9IFbLTpNLf5kfkF9GdEMPoiOmVBNqrh0XckDmR2Eobu/GQdmVbDW4IiNN
dZsQUuyDFpXEHEb/UH2HBRRR5wrdlAH8XlnZiWRozYlvn+jJo6OMxesFdakS+5AD
DDS4NoNRNIacrUf657zrkAm7Q/xnfW424V19/0RlH0corrsBDOgclDf2rGlh+zHl
q8kHZAbBBSZhfe8hjAgkCgpjx1xdwL0j/x5cZXO0O+rndzyHEibl4jnRYfNy1oqh
jeJ5M17W9xrDlVxhzmSt4/0LUpLkwPUffSc8fU0ZVqGfdgyNlMLnvecD395U6c6q
msyhAIVgk9+p/eucuJhQtfXp09yS/wX/dgBcuAcaLhGI2Ylz/X5MWuw9qd/dRDii
84xvy9/Bv0hsb+qfJBATAunGCpwonlHY3OPNUtNc4yMsZ0Qf4r9KcZroP5+Lsu7/
0ZaXfLuFtjymq1hl4ILu/5rAqWkX9L2xh/tvmN3GquNFkwPZHeHh0iw6lEw2d7w7
BZfmT2f26jIKN6F2Wxq9PftrHBWuTG+lHQNEmV5efFEFU950eqdu7uvKXmLet/gp
oMnJmhg0Qe3y+Rizniv2vsnF9fF2NKzTJDiQthrzVN0Eh75xxuMCZNUZcjVnOZdy
SNAvSwLWXRvmrStl3dwCZv0k7Ez9yg6axOkJQyfdZKzJFJL1PC524SXF2QkNEaUM
gOTUmIqiIXdNVXdc+RwQFQn4LLJYw7A0f5mgDFlynuVBSkuNkz/LiHr0fn+L2ejc
PDWg4sZikxYfg/AKcWOJ5G0Wnk2jkvvDzi9Efn2vYJ5w14AJSx3uHrBXiNBYsmjg
wGeE44Npo/va2GUb0CmRd3y6WheNqI8bDK5KhjKiSNjmmzZJjIbMSmJDa70CDluI
boRnFioteHWrzeXzP49iOh0IsBRSUYUfWnhbWctxRusgMnGhYwup3yheyF3RUghg
9ZYkuAHBzWtg8vriWPyA48UcfeMPLB32DXeVHGYUdxr4J7IMbHH+tPgRElT7Bihw
+mCUgBcdVvUC6+7Nw4InUub7X097VJGlD8hJfg0DOEVvQCuV8S6veHAi03QasVzt

//pragma protect end_data_block
//pragma protect digest_block
rx8N9Iio9UTgKHVzbpegzaxxMcA=
//pragma protect end_digest_block
//pragma protect end_protected

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
