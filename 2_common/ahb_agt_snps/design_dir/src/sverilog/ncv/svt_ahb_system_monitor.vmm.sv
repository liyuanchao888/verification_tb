
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_VMM_SV
  `define GUARD_SVT_AHB_SYSTEM_MONITOR_VMM_SV
typedef class svt_ahb_system_monitor_callback;
  typedef class svt_ahb_master_transaction;  
  // =============================================================================
  /**
   * This class is System Monitor that implements an AHB system_checker
   * component.  The system monitor observes transactions across the ports of a
   * AHB bus and performs checks between the transactions of these ports. It does
   * not perform port level checks which are done by the checkers of each
   * master/slave group connected to a port.  
   */

class svt_ahb_system_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Channel through which checker gets transactions initiated from masters to BUS
   */
  svt_ahb_master_transaction_channel mstr_to_bus_xact_chan;

  /**
   * Channel through which checker gets transactions initiated from BUS to slaves 
   */
  svt_ahb_transaction_channel bus_to_slave_xact_chan;



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
  local bit       received_master_xacts = 1'b0;
  /** Flag for reporting slave transactions*/
  local bit       received_slave_xacts  = 1'b0;
  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   * 
   * @param mstr_to_bus_xact_chan Channel through which transactions from masters to
   * bus are put. These transactions will be exercised by system checker.
   * 
   * @param bus_to_slave_xact_chan Channel through which transactions from slaves to
   * bus are put. These transactions will be exercised by system checker.
   */
  extern function new(svt_ahb_system_configuration cfg,
                      svt_ahb_master_transaction_channel mstr_to_bus_xact_chan,
                      svt_ahb_transaction_channel bus_to_slave_xact_chan,
                      vmm_object parent = null);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Reports transactions monitored */
  extern virtual function void report_ph();

  /** @cond PRIVATE */  
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by master.
   */
  extern protected task consume_xact_from_master_to_bus();

  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by AHB bus to slave.
   */
  extern protected task consume_xact_from_bus_to_slave();

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_system_monitor_common common);

  /** @endcond */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** 
   * Called when a new transaction initiated by a master is observed on the port 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void new_master_transaction_received(svt_ahb_master_transaction xact);

  /** 
   * Called when a new transaction initiated by an AHB bus to a slave is observed on the port 
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void new_slave_transaction_received(svt_ahb_slave_transaction xact);

  /**
   * Called after a transaction initiated by a master is received by
   * the system monitor 
   * This method issues the <i>new_master_transaction_received</i> callback using the
   * `vmm_callback macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task new_master_transaction_received_cb_exec(svt_ahb_master_transaction xact);

  /**
   * Called after a transaction initiated by an AHB bus to slave is received by
   * the system monitor 
   * This method issues the <i>new_slave_transaction_received</i> callback using the
   * `vmm_callback macro. Overriding implementations in extended classes must
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
    * `vmm_callback macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which got grant.
    */
  extern virtual task master_got_hgrant_cb_exec(int master_id);

  /** 
    * Called when atleast one of the masters asserts hbusreq.
    * This method issues the <i>master_asserted_hbusreq</i> callback using the
    * `vmm_callback macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual task master_asserted_hbusreq_cb_exec(int master_id); 

 /** 
    * Called when atleast one of the slaves gets selected.
    * This method issues the <i>slave_got_selected</i> callback using the
    * `vmm_callback macro. Overriding implementations in extended classes must
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
4NwD6gZB5V92heguOSE1Aj3o14fkoshoZrmHVh7VIT9Dl3KLdPHBA5rNc7vuIuI2
RCAM+k+ftmkhm1AyXqFhZcbPQaMcOFbtEWXiAsI9JssUzVTyuSADkqvpiTUGhM3g
WWLkkLRJwhoLz0fAN2m1R1bKJ9nzwk4GS0i4exIjLhjMUbvtklr8pQ==
//pragma protect end_key_block
//pragma protect digest_block
mF9+7A8bPnGrj50xRzdqHUHuzjk=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
wruiilQ1shIHiNe9ddE6hA5iXk0=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Uosrjc6iOLy/1FpgLNcMmE1O+PotPgm2vYwv3M9p1L5I9XInXn5sTUCQR0HQ2j89
7oKtrfIbqP++1lQNvumxoY5JLoDtmbAmQPjUL9bCgm/hTsJEQJ06UjfMysO31AX8
U7/RmatXSTYwWL2PD4V8Z9oh2RaAS7qelJJrxBMXe+RoPCzD6//FrA==
//pragma protect end_key_block
//pragma protect digest_block
NhIzJeuy9i9TWv1k7ABM3qTym8w=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
tz1vEDbbLc/tSnoqTU7utxOiYfc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_VMM_SV


