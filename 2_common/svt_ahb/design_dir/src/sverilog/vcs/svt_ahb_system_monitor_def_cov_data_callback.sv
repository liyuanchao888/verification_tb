
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

`protected
ZfB.^+F5,:;b33.-aQEW5+R9VO1O@O(^35C=(2K-&@FJH(=W8Fd]))[U@gD2aUF\
;,dQ@C)7@/aJ:-7Y=745\P@Db[&\OPHd0gAX\b7fbQLa2de-_LP#5BMb\eV?NUF_
eeP5QFTE#b&J[W04>UdK@,dCN<]_[IV[C(B,>?XIZP/Ad3?Z9&@?Y(7[419bZT-A
..S>bUg]bO+dZ_e;N_D+F_XKC,<7e9/W+S8dM[\S9608RJ3ac@;S>#KXJU94.Z_-
@N^[JQ(KfaAL/XPR&6Y(/C4/S_:[5B4BHV1[##VFeT8gEUW6O9/L3ZTa#FecFC/?
b38[SE.X]ScJ8C_-OT5DKG3NW@:T?80W,7@[)1+WgU//?=ZP_fSYgV#O/PXC=&_N
/NR=P7OFZTFL:-:&)IR-.@9JL[c3+a1Cc,LdD>^(Tbc,MJUWX_\;#f(N.\a2FGP8
VNULFeb9T0Y&#Kf\HKY.Q8S\a5@P2FEA(8b;RWKQ3P]^ID9IdJP[<,IY?2KV07DE
8P@S&P3.KT)bMc.K<3OGC^BY.HA#C\[<MW6_H4R55GGDT5=X5F[#8G>GGV<R?<>b
QeR,:NYFG\N^?2c3BN^:aV0=d.7Ma9CUdRcIPS4?UPV<c@@@+BGOVL@TJ+#IDTRW
Ce5(YDTK+60?;<bZgKR2\IY/^>2]0YMCWM2ZN_E]eLDJa[+bDGFOA48EWBV8c3J&
XR.AEcJVH209:JSK/U(edUdRPga\QPV98d3X1L#EU-AD]GaUKK]1R-ffNR7eX7E)
W<#,2R0DA4):F&^T;a<V&2/(]We5AR7&P<L34LACNI3WV.;RY^DI2)ffJ$
`endprotected


`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_DEF_COV_DATA_CALLBACK_SV
