
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the master 
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_ahb_master_monitor_def_state_cov_callback#(type MONITOR_MP=virtual svt_ahb_master_if.svt_ahb_monitor_modport) extends svt_ahb_master_monitor_def_state_cov_data_callbacks; 

  /** Configuration object for this transactor. */
  svt_ahb_master_configuration cfg;

  /** Virtual interface to use */
  MONITOR_MP ahb_monitor_mp;

  /**
    * State covergroups for protocol signals of AHB
    */

   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hrdata, cfg.data_width, hrdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (haddr, cfg.addr_width, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hwdata, cfg.data_width, hwdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RESP_CG (hresp, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_BURST_CG (hburst, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_SIZE_CG (hsize, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_TRANS_CG (htrans, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_PROT_CG (hprot, xact_ended_event)
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_state_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_state_cov_callback");
`else
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp);
`endif
   
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JejQm4Tcy0FgrQ6jX//TWHjwKP3lbqU7DYj3e9UWJ+TrRY+C2bR5dWLgmy7ol+09
aIbFzZI+lZKrFg/mcK545rN51f626LXwlfjD5TzQxbx68GhcetTNN3EYm9OZeeIQ
s43WHyh22ulVMokZ9umiS7z6tl9jqBZWXbn5JyS2iEc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1478      )
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
`pragma protect end_protected

`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WNxwFvY95uKPvOWcfkYyLNPo9pT4Hfp/IXeNwJHLFCUVNUyaFrb9fnAUdi/NfIxO
HZ9EC6FB3qqVbYsZY7yZQLrT5qxrNhf9Mw/G84GObdukf+m6URm1cUVO2zxMPEsE
K40BzndoCwJ+tE5oo8esz3NAwALmHxmg4S0dKAgvfgw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1561      )
jqgpuPoFismqjK3B1hJuLcD+Tv0WRRAKxJm9fAGgrZTausom1NY7wBZiO1ayNtJK
my8Gdk1f0zA04iadOYYbGgh5zSBJCDUxu8ikgT+Y75lQoX9PhetK0KFoQu/cz3bL
`pragma protect end_protected
