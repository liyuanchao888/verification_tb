
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the slave 
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_ahb_slave_monitor_def_state_cov_callback#(type MONITOR_MP=virtual svt_ahb_slave_if.svt_ahb_monitor_modport) extends svt_ahb_slave_monitor_def_state_cov_data_callbacks; 

  /** Configuration object for this transactor. */
  svt_ahb_slave_configuration cfg;

  /** Virtual interface to use */
  MONITOR_MP ahb_monitor_mp;

  /**
    * State covergroups for AHB protocol signals
    */

   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hrdata, cfg.data_width, hrdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (haddr, cfg.addr_width, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hwdata, cfg.data_width, hwdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RESP_CG (hresp, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_BURST_CG (hburst, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_SIZE_CG (hsize, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_TRANS_CG (htrans, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_PROT_CG (hprot, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hmaster, `SVT_AHB_HMASTER_PORT_WIDTH, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hsplit, cfg.sys_cfg.num_masters, xact_ended_event)
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_ahb_slave_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_state_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_state_cov_callback");
`else
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp);
`endif
   
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4nCqIJ18NpCxzXuWjKA5m3NecD4dqJmadGDutZSyZmkWS+osrcTNCl26sy/ivvqW
XMYOIB/jHvZ0rWkSBPvUeLQ5gtsUXjEfn5wVh99RNVcUMbylbbrVxJis8DE3/D2h
Kb9Kixh/4bp0WmqVIp/SVFIAKtY6HMdxDOoo3NlrZfmX6Jkkc93d8A==
//pragma protect end_key_block
//pragma protect digest_block
2nnujoh7PDF1zFw4ixagaUU++8A=
//pragma protect end_digest_block
//pragma protect data_block
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
3Lmm/C3meRIUyFZX1FwTqA==
//pragma protect end_data_block
//pragma protect digest_block
99MgcLqq4TgvWO8cLfIehTperok=
//pragma protect end_digest_block
//pragma protect end_protected

`endif

