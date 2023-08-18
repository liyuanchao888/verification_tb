
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_ahb_system_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_ahb_system_configuration handle as an argument, which is used
 * for shaping the coverage.
 */

class svt_ahb_system_monitor_def_cov_data_callback extends svt_ahb_system_monitor_callback;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Configuration object for shaping the coverage. */
  svt_ahb_system_configuration sys_cfg;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Coverpoint variable used to hold the received transaction through new_slave_transaction_recieved callback method. */
  protected svt_ahb_transaction cov_item;

  /** Coverpoint variable used to store the master id which has grant */
  protected int master_id_with_grant;
  
  /** Coverpoint variable used to store the master id which requested for the
   * bus
   */
  protected int master_id_busreq;
  
  /** Coverpoint variable used to store the slave id which got selected */
  protected int slave_id_hsel;

  /** Event used to trigger system_ahb_all_masters_grant covergroup */
  event cov_sys_hgrant_sample_event;
  
  /** Event used to trigger system_ahb_all_masters_busreq covergroup */
  event cov_sys_hbusreq_sample_event;
  
  /** Event used to trigger system_ahb_cross_all_masters_busreq_grant covergroup */
  event cov_sys_cross_hbusreq_hgrant_sample_event;
  
  /** Event used to trigger system_ahb_all_slaves_selected covergroup */
  event cov_sys_hsel_sample_event;
 
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new svt_ahb_system_monitor_def_cov_data_callback instance 
    *
    * @param cfg A refernce to the ahb System Configuration instance.
    */

`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_system_configuration cfg, string name = "svt_ahb_system_monitor_def_cov_data_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_system_configuration cfg, string name = "svt_ahb_system_monitor_def_cov_data_callback");
`else
  extern function new(svt_ahb_system_configuration cfg);
`endif

   /** 
    * Called when a new transaction is observed on the AHB Master port 
    * @param xact A reference to the data descriptor object of interest.
    */
  virtual function void new_master_transaction_received(svt_ahb_system_monitor system_monitor, svt_ahb_master_transaction xact);
  endfunction

  /** 
    * Called when a new transaction is observed on the AHB Slave port 
    * @param xact A reference to the data descriptor object of interest.
    */
  virtual function void new_slave_transaction_received(svt_ahb_system_monitor system_monitor,svt_ahb_slave_transaction xact);
  endfunction

  /** 
    * Called when atleast one of the masters gets hgrant. 
    * @param master_id Master port id which got grant.
    */
  virtual function void master_got_hgrant(int master_id);
    // Assign master id which currently has the grant. 
    master_id_with_grant = master_id;
    // Trigger event for system_ahb_all_masters_grant covergroup
    -> cov_sys_hgrant_sample_event;
    // Trigger event for system_ahb_cross_all_masters_busreq_grant covergroup
    -> cov_sys_cross_hbusreq_hgrant_sample_event;
  endfunction

  /** 
    * Called when atleast one of the masters gets hgrant. 
    * @param master_id Master port id which got grant.
    */
  virtual function void master_asserted_hbusreq(int master_id);
    // Assign master id which asserted hbusreq. 
    master_id_busreq = master_id;
    // Trigger event for system_ahb_all_masters_busreq covergroup
    -> cov_sys_hbusreq_sample_event;
    // Trigger event for system_ahb_cross_all_masters_busreq_grant covergroup
    -> cov_sys_cross_hbusreq_hgrant_sample_event;
  endfunction

  /** 
    * Called when atleast one of the slaves gets selected. 
    * @param slave_id Slave port id which gets selected.
    */
  virtual function void slave_got_selected(int slave_id);
    // Assign slave id which got selected. 
    slave_id_hsel = slave_id;
    // Trigger event for system_ahb_all_slaves_selected covergroup
    -> cov_sys_hsel_sample_event;
  endfunction  

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Qyysmk01vWy8To50NIWd9UASxGoTW1F2dwhZ0KhvGjpG69n2xcQCluXnWTc1sNJi
Zo5gboHeWn+9DCj8QfgFXRQB4DAMvsIcLNg5V32xTyw5KHdXPDHbqvKEjbC7Y1gS
emR64XB30UPFuRtfX4/UA16a6lmkqhIdm1bVbRV2L38IB8iZPBEJow==
//pragma protect end_key_block
//pragma protect digest_block
/t7y4UPy9nH132fZRJEo0dk6284=
//pragma protect end_digest_block
//pragma protect data_block
TpnADu4UwZuEUhf6u06EkUXENHWHPMqNEInap4/QM4A3LVLZIMIWtM3Cq9By4lx6
vbod+zu13rIB9Y0HTOh7rKqd1OYWva/70Vu1gGgZrTCllSigkJ1gxY5tTstycnCV
YpaS/eBYvpyjsIChvYOjftGOxEvN/xSwjoBabQrwoantAOHvhRauQ1JeSxeyF1ir
SdZ62m1dHD2Yz3/N2j1jH9XBvYEXVBRIOGKIcYmOEewpqca1voLawsZ5VYirdFAQ
aqhOsUyZFGHA0y/TBvBTJgQUsDu4+yvbc8HiueWmgS9Ko21VEdzcnRMAw3d+S1rB
SaHCI3GqGTIJ1hLCfsdLUPqBcD0MwJsiL9qzLDAl/5IW7uA0JFSWfYMqa6pTi0fu
8KHPuXXVMKrXyahnMPJ8lJqUP4dtlQaF8N4OiI04y/YjXV6nCoa40Ez+5ICIpZ0b
kV136g1MDq2QMGN4VshsctIN8n9O9LgYDvvqdKc0Z2CjvBJ04bHHpJnDZHakzXvm
1MHehyNAhm1fI0VzNGNyA8PtfUgjFR7rrwOTnDU1kNdi5G1kxH90kdAbizW+QT8c
jjPVvp6yQqnXjYJI58nzhYpunEgK8HR1NKlhf0qHxvGd8dnIKw+rQ/RvlrWj6tne
Iyr/nBp83zsYlXELZk7syuCsrxACWQva60v9yR7X6IXy5xcEJ9I7CiWsIFtv561b
CznD7kI/Ro1nuGUvrhtkOYrHy4kQNLLjW+c42f4T8Twh2d/omirOHxE/vb81EesM
U7rsJC7bSCxrtqDM+2q7Tu89BSXITk+GweVVF907gI773fVmvvF433T5n1ye/PIj
p7kBZTLVrz40bMnBR8D4EOdLefoQ5lp+Y888N6hzI5gLMUQisGMh/N+ABaE/aNmE
EYtw2wN+ZrxnIJeiXOlJj4SwrJiDMTJhVdux8bG4cWnPRFB+IiTaBg0gBw1EZARF
hGnrIkPatNwXg9fLyhfQ33MRFOT91m8Qb2tdyamSf253HWaEE125c+ahwxyHrsu9
9pJ3h5HQerIGzDLh48/3HABq4Ule1hzf1Wh8uMPj0LQFv2UP9RH9p+I/bKOgRbRz
Zg0XKf4+UvOQXO5Zx5K6QAkdM85mBSzaqxpu3kMVx9X6StIKjQ3RZM2PGkUqcYo/
3MYXMxzihkpxdVz+4ApLAqnaYi1AeueCRW/9PJZwQwg=
//pragma protect end_data_block
//pragma protect digest_block
14IBkeNKc+wR3hpeqM7Wil4I0mc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV
