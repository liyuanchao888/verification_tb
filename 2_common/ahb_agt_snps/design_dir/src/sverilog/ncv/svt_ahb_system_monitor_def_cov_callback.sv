
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_ahb_system_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_ahb_system_configuration handle as an argument, which is used
 * for shaping the coverage.
 */

class svt_ahb_system_monitor_def_cov_callback extends svt_ahb_system_monitor_def_cov_data_callback;

  // ****************************************************************************
  // AHB System level Covergroups
  // ****************************************************************************
   /**
    * Covergroup: system_ahb_all_masters_grant 
    *
    * Coverpoints:
    * - ahb_all_masters_grant: This coverpoint covers the bus grant asserted
    *   AHB Bus that indicates which master has access to the bus.
    *   This coverpoint ensures that  the bus grant is given to 
    *   all the master connected on the bus
    * .
    *
    */
  covergroup system_ahb_all_masters_grant @(cov_sys_hgrant_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_GRANT
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_all_masters_busreq 
    *
    * Coverpoints:
    * - ahb_all_masters_busreq: This coverpoint covers the bus request asserted by the
    *   AHB Master for acquiring the bus to fire the AHB transactions.This covepoint will
    *   ensure that all Masters have requested for the bus at least once. 
    * .
    *
    */
  covergroup system_ahb_all_masters_busreq @(cov_sys_hbusreq_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_BUSREQ
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_cross_all_masters_busreq_grant 
    *
    * Coverpoints:
    * - ahb_all_masters_busreq: This coverpoint covers the bus request asserted by the
    *   AHB Master for acquiring the bus to fire the AHB transactions.This covepoint will
    *   ensure that all Masters have requested for the bus at least once. 
    *   
    * - ahb_all_masters_grant: This coverpoint covers the bus grant asserted
    *   AHB Bus that indicates which master has access to the bus.
    *   This coverpoint ensures that  the bus grant is given to 
    *   all the master connected on the bus
    *
    * - ahb_cross_all_masters_busreq_grant: This is cross coverpoint of bus request and 
    *   bus grant.This coverpoint will verify which master is requesting the bus and 
    *   which master is getting the access of bus
    * .
    *
    */
  covergroup system_ahb_cross_all_masters_busreq_grant @(cov_sys_cross_hbusreq_hgrant_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_BUSREQ
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_MASTERS_GRANT
    ahb_cross_all_masters_busreq_grant : cross ahb_all_masters_busreq, ahb_all_masters_grant {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup  

   /**
    * Covergroup: system_ahb_all_slaves_selected 
    *
    * Coverpoints:
    * - ahb_all_slaves_hsel: This coverpoint covers that all AHB slaves in the system
    *   have been selected at least once and all transactions have been run on each 
    *   selected slave.
    * .
    *
    */
  covergroup system_ahb_all_slaves_selected @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_ALL_SLAVES_SELECTED
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_two_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_two_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[1])
    *   happens in sequence in two slaves environment. Both slave 0 and
    *   slave 1 should not be configured as default slave to hit this
    *   covergroup. This covergroup will only be constructed if there are
    *   2 slaves in a system. In order to hit this covergroup both slave 0
    *   and slave 1 should not be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_two_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_TWO_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_four_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_four_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[3])
    *   happens in sequence in four slaves environment. None of the slaves 
    *   should be configured as default slave to hit this covergroup. 
    *   This covergroup will only be constructed if there are
    *   4 slaves in a system. In order to hit this covergroup none of the
    *   slaves should be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_four_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_FOUR_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_eight_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_eight_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[7])
    *   happens in sequence in eight slaves environment. None of the slaves 
    *   should be configured as default slave to hit this covergroup. 
    *   This covergroup will only be constructed if there are
    *   8 slaves in a system. In order to hit this covergroup none of the
    *   slaves should be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_eight_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_EIGHT_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup

   /**
    * Covergroup: system_ahb_sixteen_slaves_selection_sequence 
    *
    * Coverpoints:
    * - ahb_sixteen_slaves_selection_sequence: This coverpoint is used to check 
    *   whether hsel transfer from first slave(hsel[0]) to last slave(hsel[15])
    *   happens in sequence in sixteen slaves environment. None of the slaves 
    *   should be configured as default slave to hit this covergroup. 
    *   This covergroup will only be constructed if there are
    *   16 slaves in a system. In order to hit this covergroup none of the
    *   slaves should be configured as default slaves.
    * .
    *
    */
  covergroup system_ahb_sixteen_slaves_selection_sequence @(cov_sys_hsel_sample_event);
    `SVT_AHB_SYSTEM_MONITOR_DEF_COV_UTIL_SIXTEEN_SLAVES_SELECTION_SEQUENCE
    option.per_instance = 1;
  endgroup  

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new svt_ahb_system_monitor_def_cov_callback instance 
    *
    * @param cfg A refernce to the AHB System Configuration instance.
    */

`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_system_configuration cfg, string name = "svt_ahb_system_monitor_def_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_system_configuration cfg, string name = "svt_ahb_system_monitor_def_cov_callback");
`else
  extern function new(svt_ahb_system_configuration cfg);
`endif

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KxI1bRzyOotXfQmQEKOtifGrYPUzkrlAv58jjYWCd8wgp1rMiih6/7hstYiBFmni
D3LQruzCvaehtkGUe4AnDobQG2meGZpgVwzat8RO3/78BTW4xlAYLa8vfm3z2f2X
q5vNKBwQqIpOtXrGUGJ+CnEHhcSN8JbkakAi/zxQGg5gtlrDL9T9NA==
//pragma protect end_key_block
//pragma protect digest_block
dY8z6UTZ3+VNdBiZquWV7TRUqas=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
eAobHYa7CzR7tNW6tGBh+zj0Wto=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV
