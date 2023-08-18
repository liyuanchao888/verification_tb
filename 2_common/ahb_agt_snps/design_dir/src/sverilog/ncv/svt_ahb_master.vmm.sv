
`ifndef GUARD_SVT_AHB_MASTER_VMM_SV
`define GUARD_SVT_AHB_MASTER_VMM_SV

typedef class svt_ahb_master_callback;

// =============================================================================
/**
 * This class is VMM Transactor that implements an AHB Master component.
 */
class svt_ahb_master extends svt_xactor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** VMM channel instance for transactions to transmit */
  svt_ahb_master_transaction_channel xact_chan;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AHB Master components */
  protected svt_ahb_master_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_master_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;

  /** Transaction counter */
  local int xact_count = 0;

  /** Flag that indicated if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

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
  extern function new(svt_ahb_master_configuration cfg,
                      svt_ahb_master_transaction_channel xact_chan = null,
                      vmm_object parent = null);
  
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_master_active_common common);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  extern protected task consume_from_input_channel();

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual protected function void post_input_port_get(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * This method issues the <i>post_input_port_get</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual task post_input_port_get_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>input_port_cov</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_ahb_master_transaction xact);
  
 /** @endcond */

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/CFER3pJhIVaddSb2+/rc+Z6p4/ewOl/0yLKJGmMVEmkEGsPDe9ilxzyY73iTw/z
C8teNXW+E+QQUrX+bkmq5VljOIsn1g860+ymtv112xvGh3o1/FAs1Z9XkOK3aMoT
KsHlpv7qi9nxnSMee/cCFvGIRUso6GtSYxQt93OJVZgZTL/0KC3b6A==
//pragma protect end_key_block
//pragma protect digest_block
5oFmwx7hCv7GpuJkWdEnoPAeP/A=
//pragma protect end_digest_block
//pragma protect data_block
CNRgZwaecBawJguGFNHIHUP8YFKRmkfTUzsOyjMydoQew24XYogmFhBhaxFaMWqX
I0h0HrdnuxQl1hxRDDDV5h4Ppqrob+nH4fyXOEIAIsq7lOdEjS08AYCba/bHKZ4j
WnIqoDTys08FYha9hLSwC3sWGRZDNkxASdfJf9dCqz6fE9cua0QE8YCY4xQQLBw1
R6lD4sxeDCGn1/ocgcRMQxjowQ3TMFe8zziXRSfUaRQIctCBL+l35UEV+zgcVYnt
Yq8JI2Gr8OT2BjCF4d5h29l6lwSssxVAwOjrOL/3JfDjXO7xQW5kgrb534DNgGXo
hOwXVl3SH9FubuqYpz0rd4niF0iD+0DzblA2wWyMkZBPMUwIx4bjVx1FEFtKAyM6
LF7CTes3sNuxWqwf0IcPm65SUihleWLbK6TRwsgW3kIVdyCQFpUjf98k5aVQs5Yt
XZPe2WViNxVPOxY3hCbwQJQQRUUm89deFj7RE2dqT9oOAs0A4ZMP/RODZPcUIVph
CW2b+2FrCBfOT7eWpB6SXgnYCZ8tzWCWGrg6bl0r/og=
//pragma protect end_data_block
//pragma protect digest_block
cORwePPT1TSC7h7/4gv4bDFtCHI=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DH6F8NlYIa1o2sqBfNfBzUn91kq2R3yY2o1hnIVuNg7Y/vwbAfUwUkTiya5AJOSu
Z7mcJtAjafBuIrQkf1g4b0VlDPw938bdqXJgu3Jh+149r/lwbobpT1Hv8RtxGrvb
0zCGOJt+Ys+uBxuEP8J2dD3GQE4TUorgcFYq1hYv6BTGY057lTNsxg==
//pragma protect end_key_block
//pragma protect digest_block
oXExgJb+hdKaP9Z/3qkdabX/DNM=
//pragma protect end_digest_block
//pragma protect data_block
/R74wylVnTkCHT0qOp7KCisoMsQBMtifNBuB3J9xoaiqbBYhDE6I786NwAuojRwo
6lzD2v1Uq6lKM4Iv03p/4pg7M21d9qofFczYPESAzlwq6PP4ZbNm+EB1u/9Ss8ed
XIh5THUiYRW3JX7phUJyTH6K/56BjycqDM1fPR6NEnPEtShaY/oigUc0EfUnXn8f
zf/zXIi75jbvGatYQuWVuUF9xMBafZUXuaxjS6jzb55yumjL0JFv0Ogx3mADp8Pe
ozXOXoIn/9oTmMrB/iJQDliCuNfUf4HCwVy1nMDvDtF0JorHDt9V5+778Eyg1kor
CF8wcdibl3Z2YQMzMJ92hew5CPJSSuztfjaVashRJd05lQaiipV3ce9Zg1hIwqyX
sxE4+O/jtz0efHsowIRgCbuqIDqJN7JrFR7OxW8RUM4UYOYFTndEujrw3EluvSpp
eqmDVvfBuL5WfvA5LqRLye2N6ASTCfe74Y/zntzAT72mhOYLNyEq81CMD6tMCBiM
TKaX4jhqvSipmvUSiTrhFgzOKof7VvqIfN0wfgCMmhluT7/w9xpeZgQclZoBJaYz
ozAyLmZ+1VdnBcCxY93a7j2kg7f3lAtwg7djiAcw6ookkvYG0lLNZvaZ3jnfHaTB
pYeisYlbCTLHL9+Pr9CqUKInSqHSzG97mnCyDTFO+Syo8dLH0ur51egckHq23bnp
oDjFOsf6/15iG6NICBPc4qlIq68HB7mxtxlp9U+btpHgb10bFk6nwhmMb/hL0nMM
Hg2D1YAU2Cm3Xy6r8c1mUcLRn2eNhAM+qB5QGL35QCGns6SKqBlC0ENvqUfOMWbu
L2Vw/LNwy7y/Gqqecaz1GY8GspZTzmSOrGvULw8cRt91tdJhOS0uWkToTkrKQTh7
MTWOT17DkfAg3j0DGRJvdlOQc6ELhu+TrFMAADwVsGf0Gm6pNshavGa28/1U+7gY
m4pzIoej07WZvkU3Sx1oUcZol+Jgh469KNzLLapGdtc8DdsOfgR8zBHsGH5bMkfC
osk/vufyqp691BWrcBNxVm42nPAUyctFOfxYEEBuIFmG6Td+BIrsh3luezLLqEug
0KkXrPXzfmDjf5GP27z3FpbJ408RDuNUFo3se6mIEdlX+wp/El1ZkRiDahSBL6zu
yVu4hxOAwIR5vaRl6VoRDA8BxwLTSUeabMWTqyj6DQX5Roj4sahVJHHeEFjWrfOX
ajwBE/qRqfgWk6zzZKyAHxA7LqsUm8s2eEP3sTtfpoAT6UrIQL4VEeMdx7a9VMrM
3If4K0LMFjpBgy1dEgI6mA/9vIYljFN001pnZpn8Py5TaQBxO1sRxnKPrDJgis+D
J3z/pRAF+BDm6rEAK4WlbG8iX9hjG3YNJhHX/2tPkTcCcrWfDvRj5S7T4uH7N8vL
YIwnyrUU8qMcZf4/QAy35+S3bQID41JOUarzxch+EHOnK5YaHK1+ulbqNsAPLJMt
KlRD3OrZDHJVUgbozWuef+vFQ+UBYq9dx622OkwU7V+V7eyYGul6KfrY42bawF7z
nKW5gJTGXvtJVRCXGWbXJfnJ+J0jYhCZBf70dFksLfo6wkquHtImByRDUB4+biHV
pDmn0IKao89S0mHiqqKem8MXWivbib4iCAz2bNsNAUGoFAF+mSZxIS4NsJ4wO6MD
2cbmsZguZSUwPK625AbsnIxCNIITFI8CtRtdZXCYGFZnzta8mFxddDpM1pzKeu8Y
NTBSdrDFKsz+v0tEp+BqUh9lLP7y2/S/yJFszATnrlZLepV3cBEH7xATbUhMnzFs
sUmrXsKi+PHHh1du0QHTJT6NwEAjYyzmSXwLaPYtMwkU//nXXlC4beI9z1tfSy+J
yI667/sfAspwZZGazwwJQJoVu3gOfpJcd1EsiRAI/5B/S9BjQoh/vOu6onRjuzli
s1zLevjDQm8/9wYMzHSRT9zXClrmqn6m+L+R+uuGxm8=
//pragma protect end_data_block
//pragma protect digest_block
TErJJwRHJ5+l7w62x4LwItW7ch4=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Nm89AdkSWlYTjgUTNdkva9v1LAR/3c0odIPXr28HYnoXoSKy/xivJSFnvgpsR2XM
rHvphF8vmg/xzSZLLWlfdXJrUft0dd2kIW2wA+ycnyi6RSKXeD6PEoMZRWxNEpwN
zOfa/QycT/vE5vCHS5A625ATGxJr+YHLNvd3L35q/9NuqJt6ZGXk2g==
//pragma protect end_key_block
//pragma protect digest_block
ReWETgmBuwZXWpBz8flv12tCogw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
g2YVD6CmE1lHOP63Q6iNz0bAHow=
//pragma protect end_digest_block
//pragma protect end_protected

`endif //  `ifndef GUARD_SVT_AHB_MASTER_VMM_SV
  

  
