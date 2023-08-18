
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sHtJISpHcVug/MEiddxXRPdVBRQSC33ct1q0vcZ/2k8pFB+aGtKhFUGISN5oCqQB
thMWXD4RA3sF40Ha6YK1NQxBMgE1FkoDPfRxaQuk4QmrbyoEkYITVTJRqSQsygdd
De9Ja0NLrAAmqNUFn3i8dB5Rb6X6GjreklvrFrzHpm2LToyqtwpOoQ==
//pragma protect end_key_block
//pragma protect digest_block
gtoAPMOnonwhig7m1rIWX3PI0ts=
//pragma protect end_digest_block
//pragma protect data_block
m9bERDqlPINixhYClSxKFVImWQUtGR2mCEuPL+VGJnWhjDKivV3I2J1bUGXNWmXo
gDQngUYE/7inVl5oasVzLF/owrdDKu6UxZZ1Xfq/BflnduOlNr5BuQt82EpE8/nT
XH6YCyrR5oCCKv4j/i6buF2hBTpbhmjaRt1RcjDA50KVAMiMqp5puKVOc/JMDppH
QAE2xfU/Mgqi6N8bmjweXcQrPp4zYvIpXAp3CNa3kVwccrr55Gfv7UwXfW4IyZU6
pivfPeZ0JvYSh/RIzYhczcIalpawmhOwdcajHy5DZ6jomjl8rvrX2mBwJxuOH7v1
fGPIaS2ETN6G8Xy69gNOu1gZwLvssPmv4TQObJ3C20UpmgqALWBGmlgEql0r0gBc
8ykTLDCVjENnKT1XaSzNGG4VKZMFpgcf1Bd0YchAk+4fnr67rlia6hvjcQjN3O4r
x7AoO9AYJ02jzJ43PszJQjkV9jiTzxC/TDtiM+rdBQ0frSMR6RlUast6fo+eVvO1
KBxYbx7MThJ/XVd7+QjA24E/xT+8lFU1Mz48SGxLpX3IiZRv6vn7BMCRGVxopp1g
d6yxo3Bc11ZT9pdSdrkBw9k+laMdLDW9fbKflTq56i8wYqG1v1rCGWD4hMBsHrN1
1vrIO2v2xBXs+0uV3ulvg0yBJGOvk6QRUkwCsNF0QssDVW+ZiwI3cuKTVfKnVKnk
L66z4ZkJZCVi/T8YcfvVLAOdLvO7RYh4TFYpD+DU97h8gFgQH54s96kd3pOscrG0

//pragma protect end_data_block
//pragma protect digest_block
NR5lQ75I2qZGd7323sAhB+meZwE=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/xDa2YEy6igtnnBN7emBc0+ZqNqPOI2FYcVGri7XxAFIk1+ltPA7nTEiLUuIr+hI
SFCc7OhYVqwfk/csb86K2AHt/6gzrvVUk2AHl6ZWHk8hzUWh0wuJz/uRqwJAKcnn
fT5ar7SXjUmx6yhQ86Ny0K2NbGvb7ikQGV4RFcrUh2ai0p0qv0FzoA==
//pragma protect end_key_block
//pragma protect digest_block
8yT5P4s7d5HM8o1l7EygZGFZzec=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
eec0bomC01WNMIGZAJiEE/Ggogw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV


