
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NTakmIZM8mYJGlMRnAY3cw/dV/TUqwFM5Jo+3AEJIO+cWn6wWtWTQ+KiwnRE+2nL
3UiXf6eAOqTRZrj0UvXD6dRn5c/NIW3B69td6VUxm48mFmAhlX2+xIYn+/9XdX+E
BCwurtNK8XCdEtWh/tJD/dPLov1qJjNHYF7fJekJ+bY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2042      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mf1ZTq1EJqIWkIyikpOetC8omJDnW2FDkDhOECAJ0YjiqpLZ3w8D1PQKjE0dE8VA
KnTSaupx+fd3EyOrhDa6VBLBzigni+pMghxgNi5cdql9Fn5bVYWIOW52NenSy4lg
kReR68SPf2VKL1UDjcV90aQKXwl5VyaUiNH8u9eUwwk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2125      )
ieV5hD3ZgDmMFA1/Eebjr0nyWETyZ2+5oAm4egi9ngA19O8vXrh0PXDfvkziH3lF
xD8CwfWSoZdyw2pZt3hezkK8cYwfNBsgWLxwnkgCPQ/JAEZ5IQevV6GO5zCVPGtK
`pragma protect end_protected
