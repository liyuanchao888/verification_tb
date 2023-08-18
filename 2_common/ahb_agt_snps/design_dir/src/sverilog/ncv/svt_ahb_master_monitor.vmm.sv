
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_SV

typedef class svt_ahb_master_monitor_callback;
// =============================================================================
/**
 * This class is Master extention of the port monitor to add a response request
 * port.
 */
class svt_ahb_master_monitor extends svt_xactor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port that broadcasts response requests */
  vmm_tlm_analysis_port#(svt_ahb_master_monitor, svt_ahb_master_transaction) item_observed_port;

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_master_configuration cfg_snapshot;

  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_ahb_master_common  common;

  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;

/** @endcond */
  
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
   */
  extern function new(svt_ahb_master_configuration cfg, vmm_object parent = null);
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();
 
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /**
    * Stops performance monitoring
    */
  extern virtual protected task shutdown_ph();

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
/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when htrans changes during hready being low
   * 
   * This method issues the <i>htrans_changed_with_hready_low</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task htrans_changed_with_hready_low_cb_exec(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when htrans is changed with hready is driven low by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void htrans_changed_with_hready_low(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task observed_port_cov_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   * 
   * This method issues the <i>transaction_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave. 
   * 
   * This method issues the <i>beat_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction 
   * 
   * This method issues the <i>sampled_signals_during_wait_cycles</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_master_transaction xact);

  /** Method to set common */
  extern virtual function void set_common(svt_ahb_master_common common);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();
/** @endcond */
    
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZnRH4/WkorhYY4HR8JocorJr8ObXOzf9GkxBI4/7MoRkjW+XnT+2W54TnL4BNti+
osruWPRdQnmpDC9V7gzwqBB/5EAfgXIlxIqMHGxz11GRIqOn9dUZm8ETVsqcGBim
Ra38anxdGBxsxUkgt2uVX6Ip2vqNFfDX5h5s9xrFu32nPujzYfdKtQ==
//pragma protect end_key_block
//pragma protect digest_block
sQQSzf7IAfqhZNTQSYqP+LCVfWA=
//pragma protect end_digest_block
//pragma protect data_block
rzXyksFxOwccil9aVASIObsD5n63ecHsYZHxUBVLda6P3mszydhL1N8e2Fqrdz16
tr3WIStcEHIV/slfmbkeuX32zUTjK/wiHGCIdtToC9yIbAh8P2D25WaLAFedHnCu
OyQNeK2PDdHaoZhWZxq8waY7cKtU4F4u2sMvq85Bp2WNhq+HUCZhKuH6bT/JYTo8
VgAkI1v0EX0+vh22eRVtYTDe5dhBEvUMjCxxCNTxV+/ObPi7kK6Kj1MHWk3IubOG
Dt5w2A849ulolZdQijJnF2OeghWYrfdaT6bJZYnarkpBOiKDbF5K79aLC20AsnuB
UxFXLiSo6t3JmHOjJeYwEZgHk6xgx5LdtaMIroe0N8cZ+MukxHHzN+9XxfVdZsBJ
1ZrhE50s8IOqiifyU4CVxbnJRtTtPijVqzZV7NJW9pcLkN3DVn9glk8caCp/ZAEN
kLX5gux57ul+LHqQ3F3XtawVs7ZKDlQ5Rr82Hw7JOB1+yTA7G8US1IzCJG0aR73U
SAy0M2NKUO7GxGtBcowWe/6Y9Dh/9OvyjSr70WNH4ao4VGSFFM+7a/8stc6wfQch

//pragma protect end_data_block
//pragma protect digest_block
6PAtgC6Ho4iKi2IjQcwUsrr5s8o=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hQIUKMfq3V3LJCwbSjMB8t3aPVtGrr9ozyzKatZ/Yk3YsysPAsVleIxlC2BmIvxz
TQ1eqvPdksWw3BXSUiU+md5iOjfEqMLcw8cSwyS4R3gh4YqrX0KPt8XSa3S6FBzd
aLCBnVOdXO/e2sv7BkCtTl5iRXuH/tJZJPx/qT5Zo5/PNXPVHZicmg==
//pragma protect end_key_block
//pragma protect digest_block
mubKx3xfoVyANhkAbybC71z1zW8=
//pragma protect end_digest_block
//pragma protect data_block
D85UmXKMzSJ/u6lfVZ80a+OXZSVN1IWIJOSGReQSsipvfZbY+sgK6RYuuThlQDA6
WbViDgh8z7o24s3sZ1JVy2KTFKUb9qT9sj15jlSyDH8TG4av6ix2b/RqPjc/4Aqb
dhIsCZtn5YhqWb9eHUB+X0ziLEoj7ymXA+TMlRBlRwRfAa0WNbrFIeQ/EiSDy2KB
pyaJbp0zY0anmswL4cxk2F/tUE7R8If2fkRIjiD3CQ/izHB8RHNyb2smglho3giu
CdvFiLzlubQCwe8kIlG56s2RdQ0QTpXW792RFKJLi+hQIdmH1rG9BcyD6UnPvwi7
4MaB4pHcf4NjPAX+hVFNTWRdDF4X0SlI6X2MCBKLxL1ud6LcPWNZirQnmYGIUhZH
dg48STNJvg1fkaPIbNPmHRKU99xfpAjenDQywf3LOzxBTP03J7AA6eoctF9Rq7lM
WeH17a7Fsu0Lv9EED/Ax0zXot7pq3suUfC0X26wFXzVpinJqKZ/uc/ClD1k4XVAf
R6MLGaGZZS8B5LqsVPNIgs7v6bV99bPEk1sS/sfT1ov98Titsj25Iw2G7nU6rs3A
6r+Is4ACL3DiAe0Pf93Gm3fzSG4I4w4E+nBSUWTPTVWNUAMU7Sbn+UjKV6ICNmuN
aLXfz1E1Cbvwoo4KYNKwZTO10VKkQiD3i1BZ0urGoOUow81gJGRtk4YIO8/bL2dJ
VUgGbuOEjJZvSOuXvEVDDILmR7Xvh6/ZCXUycHxJj5091lhHUsYebhlEOuWF52cL
VwAYwPAEU81/a6Wno4nO6fiaH6AJeewA0By+Wu3TsevXe4NtkpTBAO+Yt9ZxhuZt
pOSfx40gWhMfM97sr58AQ/2rY+W9PfIE8bdPj2PnVA9i2QUYTvSosl8+YEvjQb0n
PFbYrc7AEequbgQq1PVQDyaqlT5NjyFqFPreBKZul8rofceNG6Bt+f209l+X3XkD
9X4ZSB9ioLfiDGfv5X4zg2KY8nghlsa/z669i2iWhm0BqhtLHZa3xvuPLa8VexzB
iDuOWNJ4C/MxB9ploFOM5HKxmIkDAL1Vsd2wAVPYAKeY08rJYsqNCnEEwWg1qbGC
9f0jeB0ZcJ1kFaWMXoMPeXMstl+XlOFn00BdEBQM9B8ZMeMrJwZQg9tokpH2YcPm
QBs3s30Kqe2pIvhrFBe6jLsdooSiQLBhFxUJXEk/RXBX4t/epCvkE5iXFot0dT3m
msfTbuhceTPtDr1DusICSuNxcEgM2F4eazjuBBfJyfSAesIwckwDbWVYq26a3cEZ
TOYSVqqoyH794Z6FzeZEDe0vnV1NLTWF3oLVFPQ9lyKwiESIN1xgqljmZV/brWai
fNT7oqiU6gnByBMmkpfE27t4kqHuh1i8JKPmo3a+rdhN/LdHQA00M1w0tNSwKLqz
uGsFovnPTyDMEOMWbmeERVM4ziUX37ocGksiIic+fjLqOd2np8Klp6Cqb+Eyqvy/
mVxwpvxNaFlZnJzeF1TnAWPu02rrmifHBD87xeDjLsmh/I4tn+lGmZ9Iamzm+skF
0Dx467taXvwokj2V7ONM/ZBhUVpLNDS7ORM+srv1K896kBXMFURhbqFtxArrH6nI
vY19FGfH+/nfLyqSMgPtAcD2dGdJymhps0kbPCZPadrIh9H0C0gK3YBnmNPs8cNf
rfa5ddcJpakC+fi5qVT1OfnKfFxqfvD6cauihvBFYt29Cj+4NsseB8+Q3hIccJYc
mFYwM6NrC/Vb8gEgWRvUw5IjOa2KEXuOzvM1pqupLcwnx2o2+JumOTCjscJL+VJU

//pragma protect end_data_block
//pragma protect digest_block
RJGwExUEiAL85wqLj1ofcvPVV+o=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
I4ap2SFNRAeUFpiGUat+ueesYXrUHcj0RkS61ttwdqg41BWdQW9w125cWurCkFOB
UWq2NRPj0d+WYlNGd6gvWem/ZDGvJBI2NVyEk0j2RixJIOcy8pZFmkSASRoT0oiU
ucmyqoBB9gDsanQKeEedntOPiQ7TDQZ5xO/JTyCMqUPcvxDZKpV+pQ==
//pragma protect end_key_block
//pragma protect digest_block
H+pS3PNWd486tqu10CQVAEjaVos=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
selh4Ar88MAYZ50jdQ6xHfQ3xwE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_SV
