
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV

typedef class svt_ahb_system_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY  
typedef uvm_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`endif
  
// =============================================================================
/**
 * This class is System Monitor that implements an AHB system_checker
 * component.  The system monitor observes transactions across the ports of a
 * AHB bus and performs checks between the transactions of these ports. It does
 * not perform port level checks which are done by the checkers of each
 * master/slave agent connected to a port.  
 */

class svt_ahb_system_monitor extends svt_monitor;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_system_monitor, svt_ahb_system_monitor_callback)
`endif
  
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /**
   * Port through which checker gets transactions initiated from master to bus
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_master_transaction) mstr_to_bus_get_port;

  /**
   * Port through which checker gets transactions initiated from bus to slave 
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_transaction) bus_to_slave_get_port;
  /** @endcond */


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of AHB system_checker components */
  protected svt_ahb_system_monitor_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_system_configuration cfg_snapshot;
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_system_configuration cfg;

  /** A semaphore that helps to determine if add_to_active is currently blocked */ 
  local semaphore add_to_active_sema = new(1);

  /** Flag for reporting master transactions*/
  local bit received_master_xacts = 1'b0;
  /** Flag for reporting slave transactions*/
  local bit received_slave_xacts  = 1'b0;


  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_system_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_ahb_system_monitor", `SVT_XVM(component) parent = null);
  
  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`else
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads that get transactions from
   * ports and monitors them. 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

  /**
    * Report phase
    * Reports cache vs memory consistency
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase(uvm_phase phase);
`else
  extern virtual function void report();
`endif                               

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** 
   * Method that manages transactions initiated by AHB master.
   */
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_master_to_bus(uvm_phase phase);
`else
  extern protected task consume_xact_from_master_to_bus();
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by AHB bus to AHB slave.
   */
`ifdef SVT_UVM_TECHNOLOGY   
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_bus_to_slave(uvm_phase phase);
`else
  extern protected task consume_xact_from_bus_to_slave();
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_system_monitor_common common);

/** @endcond */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */

  /** 
    * Called when a new transaction initiated by an AHB master is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_master_transaction_received(svt_ahb_master_transaction xact);

  /** 
    * Called when a new transaction initiated by an AHB bus to an AHB slave is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_slave_transaction_received(svt_ahb_slave_transaction xact);
  
  /**
    * Called after a transaction initiated by an AHB master to AHB bus is received by
    * the system monitor 
    * This method issues the <i>new_master_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_master_transaction_received_cb_exec(svt_ahb_master_transaction xact);

  /**
    * Called after a transaction initiated by an AHB bus to an AHB slave is received by
    * the system monitor 
    * This method issues the <i>new_slave_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_slave_transaction_received_cb_exec(svt_ahb_slave_transaction xact);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * @param master_id Master port id which got grant.
    */
  extern virtual function void master_got_hgrant(int master_id);

  /** 
    * Called when atleast one of the masters request for bus access.
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual function void master_asserted_hbusreq(int master_id);

  /** 
    * Called when atleast one of the slaves gets selected.
    * @param slave_id Slave port id which got selected.
    */
  extern virtual function void slave_got_selected(int slave_id);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * This method issues the <i>master_got_hgrant</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which got grant.
    */
  extern virtual task master_got_hgrant_cb_exec(int master_id);

  /** 
    * Called when atleast one of the masters asserts hbusreq.
    * This method issues the <i>master_asserted_hbusreq</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual task master_asserted_hbusreq_cb_exec(int master_id);  

  /** 
    * Called when atleast one of the slaves gets selected.
    * This method issues the <i>slave_got_selected</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param slave_id Slave port id which got selected.
    */
  extern virtual task slave_got_selected_cb_exec(int slave_id);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual protected function void pre_check_execute(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * This method issues the <i>pre_check_execute</i> callback using the
    * `uvm_do_callbacks macro.
    * 
    * Overriding implementations in extended classes must ensure that the callbacks
    * get executed correctly.
    *
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual task pre_check_execute_cb_exec(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** @endcond */


endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Z6/Y85NgQHnt/jkM95fWvQrjIB6yRumLwz0lKaSOhTOrczW0AyywxXklfMVrqvJH
DlI3Pc2/81z1zgDNb6AY5sP51OoQVpVQB341tnJyM3/TrEOPx6R1lmuT5xgDFloC
gNM+P1mAr9eDYdLgZ3RMvzhNjD+5rg3huOA9xILhBIM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 398       )
846EEH/d7MdIx3lJ5Pic8DgbRtKx4he6/mAZdzUrBhNN6l+M/MaqhIeItjUZJvpN
F+Q19HbGF4V4UT6mpcWcyzmHaWBY6UFr8Ee5J2xi96WYP7DZtexyaF0i/L8RSxW6
Z4jPAq7msNTJ83Wd2g3xg9285y4uXeYdDgi058g1yCpnHku8ptNKxMk7EmG4cVR8
OG5U4ME2skZrtUOVPEQkgNFYJrdTpVTI4wNRx1g9NeWP79N9yFiIY7L+isI481gX
khkyVUDXKSWjGYLQvgqT4cW4IyfNkq7VP4Ps06+kl8CCE0Oj4xgTky/6O72O4hLD
YFeJW5r61VxGGfo/H2duL4AdVjiBqFWQDJaAdyByoLxCMb4RUGguwZHVKnLApV/J
z+eD8VArDH4bNEbeOMshGgGZZ0kjkA85/kP7Si/NqrSp4L/A1OxNdNbi49nYDZ//
4OJ3GCov9XbTUI6AUtFeSJH2pwTS40JjxWmhD8zz699NV3sHKIECMDQMKchqPxNa
hZR8uZ3twACZsQAQnsrEHg==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dVZEvlAC48YVKjQYePtV2y/G1e55ZVxQIIz7OTnZz8sxSih1t64SHbBXuVHgA3Rn
dFs2+xWVPMeduK1hRWSzrIu8yT1YYS+ZDSSTkc5jJv7EiQukSMqDd6wpHSM7RYd6
YlhfCwOc+p7TcMM5T4P2zd2PiU7h/sl5lNc1tfBgdN0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10864     )
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
/1tZUmasqIU7ocaikbrQcA==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
emhtLv7KVRW+ZT3UFJ8srFLH4bHmr0tTkbKACtdn7pYETsSV1OmJ5WKZdvxj2C+H
/UgSYua18QD+rxWELztiHatYFAQoTsxT6fJx1ZX3DmMwfbyw+dxsmcJ8J/Nl+Y2L
OVuyc3BZp4i9XpS+rzDtogyUx4vOuMeEKODaN6dqmrE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10947     )
8jXpdP6ivN/5Z1OuGDD6qgjuriqyUwtj6Wd+vQYoMFR4yV2uGWdERZIWFdrzz3dd
p3fP9sEuh0nqnz3RcqB/IKqoK540KRgRMbVHiBjdPqrpgoYtgU+UFO4EOIVsXfPU
`pragma protect end_protected
