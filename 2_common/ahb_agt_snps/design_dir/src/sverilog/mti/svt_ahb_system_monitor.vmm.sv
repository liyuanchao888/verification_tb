
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jnPBO4lUYi5s8UPCv9Ig5RkHbT8XpNAytuUUZcHlX1tpoi7NHOt7KLavEizZJYBe
XYlfSI07jSwFBSDFY/BLEkFMxl6sNYbco8npCtWnsRLG7MSFwtn+J+3M0+XedqYC
o7sBWzKvKAwbpBSZFl4ouaYxTBmz3XA2j3pOtcwGZI8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1690      )
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
jTgH+ucrEXO/lELnXl0R7g==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SZXtX41uuofajEt4bfrH1OzKDaWLiP/HE154qFHM2bUkWxGlSmhVbOkQWojOZdmS
/L0VGdMXFADUeCc6VVZbOOP5GqPOa5xS6+xknpDxXIxWzMzFaKt4hJgNBVdnp+Di
OCwjsqwGWol1lCl+z0QeeKBiZsSSCFXpr+UlSh/mwSE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11077     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_VMM_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pWqa3sCtJuiOVLYm64OINQiy6rtnlqLFlQBLuTlJSZPzVxd9YqEXq25q3zv0eqa6
en2DsBPdrj+cq9nCbYf6nKa2beu/WZ/joMh7Je9AGPqmF/K1WdwQNfv6cHVkyYp8
9OE+Itt5iCJJGWWyz0QosFiYAEZLlehPvGgky1cOdgE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11160     )
j2AVgGOSUF33gW4gKcf/pAtncByvuIGEhFBmB9vZUdiFjnf7w3xVn6MSW/PMPSiD
QfbnSfLwA7jlv+mojfpMcyIdBBdSwXYZy/9/9YnR15v3w7n5vQAM97bT5n0a0N47
`pragma protect end_protected
