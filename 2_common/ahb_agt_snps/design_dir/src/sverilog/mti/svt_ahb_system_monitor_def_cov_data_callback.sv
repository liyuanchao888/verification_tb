
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
J2yZz7vbTP5IGkVigVhcmKBnjJt9rZpyq4dv45cIDKHfeDUehIESQqSv2RWZjw4+
+FmcXvlDwZjhjAXDAGb84J2khaVhBRoGQZk0dAE9eFbi2tbPS9ZggigokosInoiG
M7/Solni3ji9LVFH76iQDQsw0UWoTpb96Zg2HcLInd4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 730       )
nUd/YsXufLSNoYLHHx6bJOaBf7lCW099q56HPd2FwlMnivJgGDR6z4zUJL6bnQ05
OlvN4imb3Lnub7YHZavNWH7hQsoBJThZlWWznwTz/YbzdWHAPoL3XSF1EYM685Gx
WfGabBJEOm6bnovR9xhddVJw1ohGRDp4NeuHE2dAdbNZwObJYeTrVUUxUI3wXek1
fSIgMa4nhO7NPYyt33K12xYKDd+admgcBbN0aLgPzM8s/Qm1nQ++14Jvy58nK9Ii
s3Wunrchmh+dSV+YhCEp4e0RzrVnFMLgJRbZb3ImG4HqDaa6aCPZWi0lla4yak9h
mY+94NrASQ2M4rVeXYn+UynBD7Mh+C9bcb5XoP0cBMoBh1zRvaNGTvyYJdRdinxk
GQ9/3io7ZylFOyTJy3itEkjF+zCklZyNhA8JjzGiCdyUGoZbc2V3RhLwsG03DuQ6
GWq9vuWMd7udTNdtc+SVUenZGnw24Wp2lWN1h+lw3/HsqKk8rXlbv832fx23mw1s
rZ/DXH84ZSgimgZxgpecreBDy+e88aNmCxP3cgAy3PqEUXfqmMptWYaaq7lWEwPg
a1LWRg9P/JVygCMYxeSAIjb/hK6XoVNoug6TKYwHmBcNhSKFRbNBMKTBOWcb9cM0
lMNzOReNGCKNMa2aSBh9uCxyU+nnMBl2HJtzdSe7h3vwZRFKXcSGhz1gKW9JU6Py
mBKRZ1lP49pNbSykz61DX7O06NGURUq7opfIS1vE8DvM5i6TSlvYSVbaJxjRQZ5Y
kp0tRzpK4qyr0md1vLioP8l3OYcJGBa/ox1Q9lLiL8OzwyJUdxWU/Lt9+fkvoi3u
KY/q7TqY2R2q71N2KKtFeFR1xlOAWdVcip0k0whoCetGcO6Xs/sfwiPh4j3IUY4V
6/OwzikS5KeLjnReKeBwBeJpqSu9Z1qVNenLiath6l8wLIM8YSNfTumbNg8Rc8bL
Cxf81jPwl88udw9i1JR6uA==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QKQzzXiLponV+NDy6dNDYuLaZLkZSKUKabBjUKTPoC1LhNXAqRMqyp7T5OVaUmYB
Lmk5Gzdj75GZDAS4gzwiBRUh7qlxXK72vr8AEHP6cheGcKRNl6TLcfKjzdb4Wdev
5qzun1lA6E3w1gkkfOYjbmi5VeD+LWopB9sJM4vsycA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 813       )
XyNEKfvcBIXBoo30y6Sq0e3dKTuq6b8+4VGQsf3j1MxdV7tlSVmbtwxrw4CNWRYe
pPPgpe63ubORcIUb4ICAwTteNzDLHMhPxadhy1fByV2rtqhUZETbgZq8+RGx7nIg
`pragma protect end_protected
