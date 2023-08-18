
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XRTAiFskweGwUnmB4QgQPXiGZ7Z8jhhmHRlWvnlxaTJ3I7HF822xr+7mG/+8eKxp
xdkNJKbqNK5WPm2n1Y9u3K4/R+qYWCxAab0zwb4uhVJm7k++j2kffGH/wE8KVdu0
/M1eM9EXOgWm7/QgZGxDlX6QinPrBvCGDHwCX9tEVXs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 271       )
bCUeNOkU1CPQNdCKBkJDTtUUtOoliLIvsXaxrbqEaGgI6LCm255w7GgLwhexbWM0
xeZYmsfytW2hjAjYA8F5A3/0WLgNrVnxZohbLCQXGpLefVMg0Ar2D3exBMkTlA+a
QdW1+Bv8yiGDoy3PzrhA4L/iI0jCJdrfRu0w0tENKVPgQ3xTnWMcmrFO3phgS1E5
jLgCj2R2bMnmvmRNijYLQCsPWjqiHRf85sdRt6qFe1Xpkub+AcoS7gc0yfMtPc1v
8E5kVCtj2QvbQFnIJfDoPynDMvjvam4tOGwjhWLz9rjFEUPMQCL77bY+HqI1sFag
IyIYZSshpdzyS6BPhhoR9ISPnzsrVRM9BzMJPhrBFXY=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e210XkZiWWZgd1+6xK6PlPJ0HQ0KT4y/IDjG3mP+UD4MyzDK8cQnovZ6WnBCDrp3
98qxi1a5TUPEJTa0/FEaYnkOQgCH71QPTB+sngbK8j1yCaup72TaKr8v6G4ngbGO
VieRrkBX6izsTxIewIhNDgedr9SezARir1f1UmqfBbU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1055      )
4j67oVeOYoAYXUMjLKDqjN9wTEI9Pj27vGgYL9LG9qDti2WUnTnh6FQh5p4jLj7+
rh9aXSOPXaFu2BDdr544efNsrYs0LSncHb7tP9C7a7gfr3A3ef5kOcMkyNN8kLt1
+UsR5j79fa6gsi1k2foPS/R6+JmFvp8Eo2a6e7i2AO2FCNRDi1RXazETS9FG+/CP
weDl+m7PM8i39S9OaNotlgvYENzkBa/MAJ0uGhbQst7Ok6cbIFhb/sYrxCwlvTK1
wbuQBF7fTjqt4V8iGfdf4fP1vlyHDw6BxVGnsM2PcQX1kgj/zagHQCzN+2gPVoIA
e4cB87ztYhU7W9sgFXF+bRq5jQy+904Wn8giaKMrL1DH0xbN+NTrQIFs0QJncWXq
fL4fgRsbR6UCCgzomxcnlC1AEnAfKnpQ81TCIcmUZd68ltmV9+OYk+oYCd+i4ty4
cePb8jOpjmylZ3CBCzf+KocSviAHzJxGYvFurbQFnXIAIujFMwL2Z1XmEVuw2pR+
Rgk4QTt82kTprw1RGsB+7Xax2ir+jOz6csIsYa8Ly+dNODtwyBZLKHRjLIEfhfdW
OEsc3QWwkqqVpzbep9gXIiNoFSJyXJfThtUZpxpFrFqlIbIwCscgYvKqlmJfrV9M
iRtwyU38rlTBnUaJBLmGAUmieb8bdnGdiJXcuyyNlTJaYfLc9if3DRtllK/jnqlh
Z43btKmwa2a68T79yBsKDSO31dxV30LETWKXY9r1XSLpRE2/ZTcteuzST/3uSgIp
Wb2G4NIkOjOnokknEcrwjxscEsrUM6tbF5Y1FDCv9QXETEZRgK6ZJuyZJH9ETfUv
tjT3JzLvgQp8Zt2sV//5glCQ0qgKD09kYBTtDgpcUsu/JOcScrX0AnzVNMkjeE4B
OMJ6sg7HRG0aYhGbAFm/3Zmt3z6CfHZt8qG86aztsKOx+QxGD/e7ms40KzynbeYo
5+aRAz0JbNetSFdCrq6DEsIzz5EFCOCGOGZ1TbZPZFFcwXOy0cCzhClKmtxjxdsY
p1PdLmAtJvuleWGqGbvn45IsdFId/C44iR6Tk0M41rE=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bJPyf85JBtn7nXvUuSwcCzmF6mb3yY8jGwNmsLMF8KhSw0XFqX1IbzdUDA8DMrWK
Tb80vJCTaOfxPwr9gB8O29lqNzrsEIZIvSOsxRfsEIS/nlSiUYisS03bOMx8HwZ6
fSme8pvQfBTSK4NDf4Lo66s1eCNChn05X1/xLW1gO/k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1138      )
SPxd0VBGv+dXLmjS1CAuI6q4r8cjbgnkzPCA4xWVYaIzAAvg0uSrXTFFZyfod9gc
q7LUTeslGoWSKYvir6QvNv3Z65CjEZgfx7ioH9tz2J67YqVf0YyLYCr1Sop+6FlE
`pragma protect end_protected
