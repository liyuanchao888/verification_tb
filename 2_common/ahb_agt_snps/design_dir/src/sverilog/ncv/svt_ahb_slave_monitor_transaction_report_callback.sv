
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Mx9hsg4CqcL/4Y00WZj6LeWtJgBknQMVTqhIS/Q6T0HaJkuWjcEbusIK9DQxAn0E
yIInnn3fMAf/kmgdeJbjPCTATNv/Cdik0UaqPFbPW8PifUfjk6FV+WPlapBGAgYE
uXRzu6U/0QlannNoAnKzApkIeIlaelHm6dKhcqJWbhOXGj2zmB0y9g==
//pragma protect end_key_block
//pragma protect digest_block
La3uqpo4RRYB29gjEdwl7dm3QgI=
//pragma protect end_digest_block
//pragma protect data_block
9XM/QbY2csgeB/vRYSSt0qpoQDeF1gwsAMhxzxywjBOXdLKYYO/drnIjs1Oa7Xt1
8my1Cnf779amovWcEPxLpCZ/m2Ce1qNVEUHs4ZxQRTlQOXK/3yAYpUpy2zaREDCB
Jma/wJ4kbso6mJAqczlFBzFgsTv2uwe2CHYjGFGzffKARcYjFbaKjhGp4OgzOKcN
ucTTzR2mOdLpPQW64q2iy42obKSjx48WlMMOD2aqFu1a1A/VQYrwzxAJBz1bdSn5
pZ+BnePuLjV4hNWK6Erg1W5mCyKYBzGrl9w3y+Mb5ylI3xZUvSgiU0vT+Ugnnsv0
DHmT78kJi8+kCGlrSflcnelyhU0CY0nlbKmymo514KdiGUd7Fn4Uz1ySLGryR7Jn
GJ5hJNdKjfe0VBelP/NnwgvD8jpNXOXMLhjFEEOWeaYzLJmG7K+ZGeFcdpujGPbY
PCBCWG22i+rMndZIDSdlXbG1PYB1viEgFYkz21q2Z/uTDN+GWdbYH+Lfg8Dpgmos
lh+2cXYnAK/bDw0QAya7kLqmzQiYE2JGDFZDGkodKLw6eXDXah6toJXV70BQLElS
NuJRo9Jw5Z1jdXt7ZFtHTjKIXFXhp3nwCECubZXzNmvKdJ3OEh5T92U+U95LeNuu
RgbwxMwmUyinPokNCcfC3nDDNp7OLCiz4yfws50YNBhbegJ0Oyy9GnNgCpEUozTk
ZK2R4KKtbamnWRp3QxvDOiFaXLF33LAiIRpz9+U6iww063RMi5msP3LaSgNqHQ4w
vKmucR3P+KMQ9geSajrEV9S/pl83pQs7o5L/w9sWYjMIWJVTSNaN+zMVXg05QwKU
PUD6M93PitwzF2A7k1OZ8KBK/7sKV3pbdDI+8Y788NA=
//pragma protect end_data_block
//pragma protect digest_block
ae4pjMHP18RWOgStoJod90UfI1U=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/**
 * This callback class is used to generate AHB Transaction summary information
 * relative to the svt_ahb_slave_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_ahb_slave_monitor_transaction_report_callback extends svt_ahb_slave_monitor_callback;
    
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** The system AHB Transaction report object that we are contributing to. */
  `SVT_TRANSACTION_REPORT_TYPE sys_xact_report;

  /** The localized report object that we optionally contribute to. */
  `SVT_TRANSACTION_REPORT_TYPE local_xact_report;

  /** Indicates whether reporting to the log is enabled */
  local bit enable_log_report = 1;

  /** Indicates whether reporting to file is enabled */
  local bit enable_file_report = 1;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Creates a new instance of this class, with a reference to the AHB Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1);
`else
  /**
   * Creates a new instance of this class, with a reference to the AHB Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   * @param name Instance name.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1,
                      string name = "svt_ahb_slave_monitor_transaction_report_callback");
`endif
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on AHB Transaction activity */
  extern virtual function void transaction_ended(svt_ahb_slave_monitor monitor, svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of AHB Transaction. */
  extern virtual function void report_xact(svt_ahb_slave_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_ahb_transaction xact);

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uFTi8hcgi1KmFqFD/OT/AyJAuZYkax+4Z0Sio3NHz46gbe7WDiROdYnIXdql6R2K
JxSf1AEvraS56oiaFkM2OexvzlmMF9HtyN/gaa1CyDS6H2XtGXISLRxR4CH5p1Ia
4zBWbUWCtA/uEJqAxxaYyVnFEGkTuQ0cMt2hnFNMoPimGIo4EHY2BQ==
//pragma protect end_key_block
//pragma protect digest_block
Np5twpKh+/LmoRPcJ+GKg47M9wk=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
aIC4gnaqHQZxsuoeJl6hwIdDFec=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
