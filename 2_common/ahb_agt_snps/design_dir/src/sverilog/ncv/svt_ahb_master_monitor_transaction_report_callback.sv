
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sIejE/ETysXz+gtJ8hO74hlSnYIzAH9cgIfcc2d9nPZWMEgFYs7Tsa3XXzH8Cng4
DDt29iLFFc2JsdK8HUuVXhLAgRFxX5adVI+bSzpMT8TGPcfgH3OGqOgfQsI7h2Qt
dgIDpVusthwjXoq8Qva1tYWy64YXHnXJLrx44+kWJUtXn8Wgd6z0yw==
//pragma protect end_key_block
//pragma protect digest_block
ew2ZJcDMpecDumaA0dUUNtoewMc=
//pragma protect end_digest_block
//pragma protect data_block
BL5mwzv1YIwLHgjYWcY4u6cvgqMaTbK4TQZScTW+A6PaU3/mn672oGMMWN7GexuL
QMp6hDi52SBih+NwZ0I1oqChY2WVkPJaxCJ1WJYRnhBE3CWtY9nikB3zoazRXw3w
opjUTGLP6UPjDzqRaKSfSPPkb47bbuRz5vyb/baaTYO0zBh+SJNfwN/AzrCGUrbT
O23ySvGuUwxtN0Au9kK2IrD+zub1hMfhARVM34pqd6fvPA5J/eamjCvMoP3rs/OJ
/tLTlXnYy5f7NbQygzeaEU725pN+a/wJuZ9DKp7jw1zArXYDWk17CoXeZ4fDF3Ww
BXjVLsLHmFgGMF4eZEFBYfSA82r+uGxVjDI63S61979wJOsPGMV2U4SUFf5m2XCI
AvItWVW+b03ktm8sWXDzn2qQeQZ5aGtNg8KvzHpLrcxZ00FzafNOle7arW/OsJ7r
zMcywguInGvFyv4RWWsYDinRLv8pS+kxR/AsAmPGufbPjR5bfjD1/iLfXXBdtqut
FgRMq0pZYiLih05DYmBMbomuuBT4DzMqxPeZBdCxbPa8e7pe+LnBZNeaIYduof6R
NWxLvgBXtks3uDM8sGU6hvoRyGFNL7XjYMlHo1/qR/8Km/d4rwks/swiyUPMTyTn
g+ScKsRZTSpnEv99FjfUJVwbRxoSA+3NzBZ+/USdwvW7gkes7y20G86On5wY/Ded
6GjPwCj8M3uZsis66kcqdFSFYpWqT6gb6GNHxEEaIwEzaOwn+69vq8bjOjAjGFbO
L/ItEMVhnGMNucG8ye9118NwcyWz4cjH8QUrYoFWxUi8BRKyDCSHNV8S6dDdC7zD
89MdQC2yTs065mvc/c4LZbBslgHuZIUjt7+nIEf6C1ngM1d9RrDBLGE3cXjMNnXa

//pragma protect end_data_block
//pragma protect digest_block
Wdqdw9fZZ0geuNSt5ubH5unyD+Y=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/**
 * This callback class is used to generate AHB Transaction summary information
 * relative to the svt_ahb_master_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_ahb_master_monitor_transaction_report_callback extends svt_ahb_master_monitor_callback;
    
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
                      string name = "svt_ahb_master_monitor_transaction_report_callback");
`endif
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on AHB Transaction activity */
  extern virtual function void transaction_ended(svt_ahb_master_monitor monitor, svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of AHB Transaction. */
  extern virtual function void report_xact(svt_ahb_master_monitor mon, 
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
sxaz0LjduMsKtn0G3lEHa5XVteKBHGa6FZJh0pIIyHGrna7BHyVflrsB6feavrqo
bhmgZCZRASyAtayFrZxVo7L3axydflKPMqRMWQdXi1+GEG932BYpM6/k7duw5IDb
kqMiiqWEEJCDeSsdY11eWNHonQEyEQSJkoMjNvSIP1cWNe6CI6WARw==
//pragma protect end_key_block
//pragma protect digest_block
JzJC49mObpwMs4dPxQzWEx7Pypo=
//pragma protect end_digest_block
//pragma protect data_block
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
0E+qT8TOnE0CkNv6mgtvUg==
//pragma protect end_data_block
//pragma protect digest_block
EdVgqBiWvi+C0JRM6Lg25yK87W8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
