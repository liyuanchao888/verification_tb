
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RaQ7USaimRA80p6dD3AMV7fQjlCJyTOgIxqceCDKP7vMTKK44yIU+yhxRVWaCVrw
xXTab9OStCUdAF+qkH09Sohi5x/rVlVSqx2fzRY71y1MvUQqCUEli21jiyTs8yht
uaYQdmzlkyS9kmrVsMZzzextR8+bDMHSJaUYHPK/ElI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11605     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_DEF_COV_DATA_CALLBACK_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JaVQjB0O0RRij6yvL/i7YQkaDjIe2vBgN3gM4mpXJRiDqK+dtPC3Hun3gTahxdd+
XxfIx7WbS1bj6XRpMOmF8Jt1sAVHEnFPaMDYzAHDcGxZ/E3gRPF2JVscY8SSUnbA
TFrh+SNZm6c1KJWPK5ga67bu6elj7sW7f/WZ+DwUcr8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11688     )
Wrr1V247WmhB4oedhqbtou2zS97p6kHmadaZ2tS1L8CkckxOXWLZ+5KDYfKP9dA9
k3PszyRZRGnYPvrHmiWd16giExcuuHjicreMzGalZW+ntKxOM6zviedmuFRDgRUi
`pragma protect end_protected
