
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV

`include "svt_ahb_defines.svi"


// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_ahb_slave_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_ahb_slave_configuration handle as an argument, which is used
 * for shaping the coverage.
 */
class svt_ahb_slave_monitor_def_cov_data_callback extends svt_ahb_slave_monitor_callback;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Configuration object for shaping the coverage. */
  svt_ahb_slave_configuration cfg;

  /** Virtual interface to use */
  typedef virtual svt_ahb_slave_if.svt_ahb_monitor_modport AHB_SLAVE_IF_MP;
  protected AHB_SLAVE_IF_MP ahb_monitor_mp;

  /** Event used to trigger the covergroups for sampling. */
  event cov_sample_event;

  /** Event used to trigger covergroup trans_ahb_hready_in_when_hsel_high. */
  event cov_hready_in_sample_event;


  /** Event used to trigger response for the first beat of transaction. */
  event cov_first_beat_sample_response_event;

  /** Event used to sample response */
  event cov_hresp_sample_event;

  /** Event used to trigger response transistion between two different transactions. */
  event cov_diff_xact_ahb_full_event;

  /** Event used to trigger the trans_cross_ahb_num_busy_cycles covergroup. */
  event cov_num_busy_cycles_sample_event;

  /** Event used to trigger the trans_cross_ahb_num_wait_cycles covergroup. */
  event cov_num_wait_cycles_sample_event;

  /** Event used to trigger trans_cross_ahb_hburst_hresp covergroup. */
  event cov_sample_response_event;

  /** Event used to trigger trans_ahb_htrans_transition_write_xact covergroup. */
  event cov_htrans_transition_write_xact_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_write_xact_hready covergroup. */
  event cov_htrans_transition_write_xact_hready_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_read_xact covergroup. */
  event cov_htrans_transition_read_xact_sample_event;

  /** Event used to trigger trans_ahb_htrans_transition_read_xact_hready covergroup. */
  event cov_htrans_transition_read_xact_hready_sample_event;

  /** Event used to trigger trans_ahb_hburst_transition covergroup. */
  event cov_hburst_transition_sample_event;

  /** Event used to trigger trans_cross_ahb_htrans_xact covergroup. */
  event cov_cross_htrans_xact_sample_event;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Coverpoint variable used to hold the received transaction through observed_port_cov callback method. */
  protected svt_ahb_transaction cov_xact;

  /** Coverpoint variable used to hold number of busy cycles per beat of
   * a transaction. */
  protected int cov_num_busy_cycles_per_beat;

  /** Coverpoint variable used to hold number of wait cycles per beat of
   * a transaction. */
  protected int cov_num_wait_cycles_per_beat;

  /** Coverpoint variable used to hold response per beat of a transaction. */
  protected svt_ahb_transaction::response_type_enum cov_response_type;

  /** Coverpoint variable to sample hresp transistion type for beats proceeding. */
  protected svt_ahb_transaction :: response_type_enum cov_hresp_transistion_type;

  /** Temporary variable used to hold address pertaining to last beat of a transaction */
  protected bit[1023:0]  addr_last;
 
  /** Coverpoint variable used to hold htrans type of a write transaction.  */
  protected logic [2:0] cov_htrans_transition_write_xact = 3'bxxx;

  /** Coverpoint variable used to hold htrans type of a write transaction when hready is high.  */
  protected logic [2:0] cov_htrans_transition_write_xact_hready = 3'bxxx;

  /** Coverpoint variable used to hold htrans type of a read transaction.  */
  protected logic [2:0] cov_htrans_transition_read_xact = 3'bxxx;
  
  /** Coverpoint variable used to hold htrans type of a read transaction when hready is high.  */
  protected logic [2:0] cov_htrans_transition_read_xact_hready = 3'bxxx;

  /** Coverpoint variable used to hold burst type of a transaction.  */
  protected logic [3:0] cov_hburst_transition_type = 4'bxxxx;

  /** Coverpoint variable used to hold hmaster selectted for a transaction.  */
  protected int cov_hmaster;
 
  /** Coverpoint variable used to hold hready when a slave is selected.   */
  protected int cov_hready_in;

  /** Coverpoint variable used to hold trans_type per beat of a transaction. */
  protected svt_ahb_transaction::trans_type_enum cov_htrans_type;

  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new svt_ahb_slave_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the AHB Slave Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg);
`else
  extern function new(svt_ahb_slave_configuration cfg = null, string name = "svt_ahb_slave_monitor_def_cov_data_callback");
`endif

  //----------------------------------------------------------------------------
  /**
   * Callback issued when a Port Activity Transaction is ready at the monitor.
   * The coverage needs to extend this method as we want to get the details of
   * the transaction, at the end of the transaction.
   *
   * @param monitor A reference to the AHB Monitor instance that
   * issued this callback.
   *
   * @param xact A reference to the svt_ahb_slave_transaction.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void observed_port_cov(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.  
   * 
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------
  extern virtual function void beat_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is sent by the master.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void beat_started(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------

  /**
   * Called to sample hready_in signal when hsel is high.  
   * 
   * @param monitor A reference to the svt_ahb_master_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void hready_in_sampled(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction is ended.  
   * 
   * @param monitor A reference to the svt_ahb_slave_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  //----------------------------------------------------------------------------  
  extern virtual function void transaction_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);
  
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7V3IVMyNROcDNzEDMpL5YQne15yGivF2OzphPeSfIdCDrgOSphLTiFmb7mTJlsCm
SmT9FxtifayLQkhwckXglPOiZ1ypgKBLHGEiF8kosxV/9n0U/8dSvLYwSUcCqr/B
d7xSwyBQCcsqkpRDR3HMr5ekcjVkc3lROVGhjw2tjLC0Y3x1yKujSQ==
//pragma protect end_key_block
//pragma protect digest_block
Kvc4I/nE2iIqkjEgyo0CxnaC2dM=
//pragma protect end_digest_block
//pragma protect data_block
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
QilGWmTB8SypwB31HxyaBA==
//pragma protect end_data_block
//pragma protect digest_block
Y59SCWcX++NcZc2wHs1JdsQDesM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV

