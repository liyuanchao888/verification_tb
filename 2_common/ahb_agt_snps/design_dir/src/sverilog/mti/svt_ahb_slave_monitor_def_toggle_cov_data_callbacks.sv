
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LxwUIxklt2sUY7AjewM4xL2vCwS6SSWx8kN2SofVSdnGl3l2DcuiBodWVAMS+4Eo
FDctE0aS8bed+kjohE00WlSYHrh6e9pCN6RZp0xfT9CznqvHmL/fx5e5LrBptfVs
7BXOI7BKKDBCHXyMv1se3dUY74cs5KMMRmkgFOdhM6w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 270       )
v71yQqRmCvbjYolWY4JlOYQlzHHTU9iQgc/z89Xevn8MTGE4aubM88WrJl1FSJe1
SmGxtCiU356+i4sSwU0qWPItVhmWzz7D/ZbUyq2hhiZTeMv/jSCrrbaPzvM59CS3
3gHRKC/m61glU95UGN0upLYdYYjuiXbKypLDhFVi7u/3UwZQ+MLw/eaDc+NG/Hky
6QMEH5O/jbwQ5IXltD9ce42YipAKj3NTnK6rN7oUTttNLyXjoAQu9ApabfxyFEvn
NfOp3hC6oWy3+sdMVcZHerUee5eXM0baN+hOmbBtnLNtD6Ljx63oWxO8l2GWezTd
nhYxWRuZATYdqjJvoCQ56l7eGUfGP0rtK6ONDfYTY/Y=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YS2vqh2Ei36VYdeG9pci2KrDF2iguW5CI9k10nybxi6/wJQIMcMDo9ACZ6VXZdM3
W+G3w8o1gnXFOx7c2XHnYcbHAmeEX9Q/oDTb6jb41GdagvU9ZcpmGoTkN4sAcyka
wpAKcZlBMh7HlQNlLSJNmUnsEyvpN9zx78GVbGYcCqg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1046      )
sCV4TPHLauNRrGP0vDACE4affSGKYGOxrq5P7o8400U8pWEfJNOw+1piZb0EQKym
b8KDauTYSg3peVCKtBpC3524b9otl4ojrm4CO32ARqJ8pYlVBtVM6eIOfKIfua9C
L2VtpJv9mTXzzh5UiFs328BZU7AEFiOebd/4VoVkeuV0kamh9bUsel5D8R9DksK6
9yxSARV4/YxC7oZlHHkBTv46gmwzASkjgv2Yl7xMjBxjGvajl3A71h7cMp5lc4aI
yNgUJCJcJ5SpOMGO1MerBHnXNFe9smEnn+GHHcuA6Mhcmk3haQgkMEwAENmdvFBT
Zc2kIGT+JRE0Tqhl0T6LHx+V0+hOn7/Qw5COrv32Q7npmrgjV2UVdfOjmE1ll7vD
rUQdNqZyfBoaVjcoj9B5FQpe8lmiEz+CTIe+HUUn/lhGIIwQWhWlvX8i1BixfRQW
8ABSrbMwmMJQOPDMDgVwIEVvlSQvnD8vYxyYt0GNdWBqui35G/8b74U+UQljrRrG
PCcEfXsFg5tf/SitwNnYtPKk2ER9TTLtejuixI3ueMF9Xt67f1mDjni3/Bs0j3+H
xqNvLRQIS4cQSb2IeNxUQ/1oG2vRPaSzt+gbq/L99UsgVV8SMYisbHkAt28pDhMK
HWlBKcZy7zWVQM2BJ24nMTnMvyf8ksN3CubZnMtFbvKOjtAZEdcSdULj/sq6+C9i
21uyKtRBqCFuN0UGLvjHpwSx1fuDKDHoHQewR/VWAdjRNjqbpzGmr8pRphJuYjjV
Y/72ub1efRk1pbZ7COHQcKmuOSrXe9ei0U+dg1i5WggBzSzqV9oGowPsc+K8gTcE
mM7ZjTBKWzzZY/vUpWKqnJ3RCIIHM+Ixf1I2NzL7bRsQjCTtUOn6NkkX+6DLy8FO
MLH2IVGLbr0DJjTIw4x9QzBO0NipttVGMLo3mQJcQYVel1SKnUlh0Ql3MmJNqVZs
OyoC4uG2XvqrrFhMlmEe3efrbah8w7opkw9ukWS2MOUdYKe5tF/v6aFFM80eYQ8N
cC9J8PvsPSEEsq5Mp7COkA==
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pM9PW/48MTfHqwyIOSwNHQaBBji8t8Xd7Us3b5LCHlSxOYv1XPkUcO6xqaVgr5yB
VBG1PoSAh6rt3C/05DF2J8IOXxy9/zQ40CVrlA0wvLkYnROj1MF76koshaaP9yEq
Qah8QLFVe/meioFFywHzUNSkeo5+7lUJ+sGaEjrj27Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1129      )
GQIRWW0XYZcgj7vkTKI2IWsXnbHTRdNVRI8ycG+glhutghyjorMwdJDfvCz1hDw4
7p5yxaT+at5o3IAAKWVRIzuRBzOu5vpBeKuvkyN61Sbnzf0pLBQnCTiT4MhKsLpX
`pragma protect end_protected
