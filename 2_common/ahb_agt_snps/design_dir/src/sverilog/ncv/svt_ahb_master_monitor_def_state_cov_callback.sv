
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3AeoARKaKAJv1RF0ZjgkiyG1SWpkymbwaWlBbtVKRk7bBVRBgT6wZJefQf6uTcmi
PfyXgHoDXNw8CT8EpW+tC+2Digk590CO4hEidSdrrK97UP1voLuQHq1f86e+o5/z
fJzDw7uz2vg+s008HaTMMKkNMEuCeHfvdEIOLYAy9VUV4LHhiYWNvg==
//pragma protect end_key_block
//pragma protect digest_block
3l2rct7iF/6cEoXMjnq7F0Rn0p0=
//pragma protect end_digest_block
//pragma protect data_block
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
LsFns3BzudGXFvLcqIqrCg==
//pragma protect end_data_block
//pragma protect digest_block
/DL2XpNHWTHh/d6WYXhzZguwKY4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif

