
`ifndef GUARD_SVT_APB_COMMON_SV
`define GUARD_SVT_APB_COMMON_SV

`include "svt_apb_defines.svi"
typedef class svt_apb_checker;

class svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port makes observed tranactions available to the user */
`ifdef SVT_VMM_TECHNOLOGY
  vmm_tlm_analysis_port#(svt_apb_transaction) item_observed_port;
`else
  `SVT_XVM(analysis_port)#(svt_apb_transaction) item_observed_port;
  svt_event_pool event_pool;
`endif

  /** Report/log object */
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_log log;
`else
  protected `SVT_XVM(report_object) reporter; 
`endif

 /** Handle to the checker class */
 svt_apb_checker checks;

 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************

/** @cond PRIVATE */
 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /**
   * Indicates that the request was driven and the master is waiting for the
   * slave response;
   */
  protected event access_phase_started;

  /**
   * Indicates that the slave has responsed and the current transaction transfer
   * is complete;
   */
  protected event access_phase_ended;

  /** Event that is triggered when the posedge of pclk is detected */
  protected event clock_edge_detected;

  /**
   * Flag that indicates that a reset condition is currently asserted.
   */
  protected bit reset_active = 0;

  /**
   * Flag that indicates that at least one reset event has been observed.
   */
  protected bit first_reset_observed = 0;
  /**
   * This flag is set to 1'b1 at reset assertion.
   */
  protected bit is_reset = 1'b1;
/** @endcond */

 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter used for messaging using the common report object
   */
  extern function new (`SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();

  /** Monitor the signals which signify a new request */
  extern virtual task sample_setup_phase_signals();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /** Initializes master I/F output signals to 0 at 0 simulation time */
  extern virtual task async_init_signals();

  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Process the new transaction */
  extern virtual task drive_xact(svt_apb_transaction xact);

  /** Returns a partially completed transaction with request information */
  extern virtual task wait_for_request(output svt_apb_transaction xact);

  /** Process the state transitions */
  extern virtual task update_state( svt_apb_transaction xact, 
                                    svt_apb_transaction::xact_state_enum next_state, 
                                    bit protocol_checks_enable,
                                    bit apb3_enable
                                  );
endclass

//----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eyspzpQxqXxsN5Z/G4KSO0AkDncpjtTALyJn2mEnU3oyN5Yjex+EspxsJiwim8WK
FvTk94zpb3ayqGhzaueYvjVD1DCzh+9N8SjtMbo5CKM4zCoqGAh408MhslCy4wOX
Yc3BwBDYMHiqpa5NaO5cAkftt1sJfHPcIx9eyelr007wgAnb2jmziw==
//pragma protect end_key_block
//pragma protect digest_block
x/OcVXnCEn8laR2D8k5FfiXcRws=
//pragma protect end_digest_block
//pragma protect data_block
Zp9vxYzR91JMQGbDdO7s3qDWINh9/hl/IxV7YMQue0jKbLoJ2ILmRAmVqy7YYbVL
aKY2ONtp4NjabuKB9XioXdydv3BorEx5dQ6+/bUkTMqn9jkGUwlzCfIRC2ZcIkgH
3TfdodnF/SvDslJkUMQR4yHYbQBq5AcBZ7g+PJAC4tcln3rnErQ0EqcZXPqr2UBG
+d6SjdGMao5N/ZTxgDf0t8Sfq7tT5R1fPazSgKUsU3lPDxVNk/EdiEofqMNcalks
CnYclg8ybX7RmxpPM0PGo7Ib5CtN96MvwbXB6q5LuDrIFE77KYA4ZdNRMVHS8kLj
aqcEACfdkPqUVSIAi/oBqCXVZ+QXKFJhst2dVPkPRcj9N6A2yo/SG10XTXE5prKW
pDlS8xI/RpbtZSgV4sgvuoJ2R9cTUfEsnTN6I1iGZlYvawEBIrv9RwBLIOXlbrBj
DbkR2nckhm6zIOXJUUNBDuE0ec5JqD4dTS70KL3vZfuZaH8papHRYT5lOpEa/wei
n5lulZN5am33IhqaErRFiyZH3BBqqinm0e673AzWcn1nqMr6uHwAKOCQaElmK8xw
KAJvEXY1ZNzxhhfk6SeKzahgwTZA/f29T49Uu9rY2jeC6p6ocINyytgWA3154CSQ
tCxptyoIQAZVd0Itf3GrLl+OuNwlXax/esH2/gbduw8=
//pragma protect end_data_block
//pragma protect digest_block
P7o5fnAyQ5z26HEyADVNldR8C4M=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
UPDCInEFuNjmfAK+EhsGX816uxrm2v5/+n9VjSurtkB3VjI9pHIU4KqOilTDEbEW
TKWFNg/cfWdTuiOozfHz8g+RrFKbJgSLfEGz6tWj8P5dybRcDA63MyvVuTCBxhX4
mECambjt92p9hhOki18a02KsLq7T1V4eOoBuB+ipN+WtZPRIUs4ZsQ==
//pragma protect end_key_block
//pragma protect digest_block
lTUprzTVIrOmbM2F0KUdnRR8sPU=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
93AAvcq4ta9yStFxLmCsTHhGdA0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
