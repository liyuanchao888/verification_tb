
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
b+iLFpmi3h8/Uk1lPX1q6jT5EsWnekWwWpAVlb8dv5X1NnnoD2chmBs/VQvmf4zX
AUM7ZVTrcgZz17c9PmAXyVHAl1djqCVUbCplc3y7SPeyL5b5OdamuSsF9VDnnT+/
G0btcDQY5oO4IVmmlZHZaeXPTG2x1PaEuTKon7tJuOw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 489       )
mbDu7PL3w/FReRgCuDwJmqmVVPa597s08EdjLZkpt0cD+BMHOQO1ZEFtHIf0Qzw+
C6PgCB9NA7UL9jFlHA03M+Tf4roMVGLDLKB13tRxUTIBX6rzL0DEln7vZKFVuJkN
7TCg8vcBXgAG7pwQ+zQatkc9/x7+8gVlEdgstDpuf1R1wnPYRyQ5oezYbhYhKDlx
jCvkgBvlp7Lg8Dji/ry6CsRI3LsgzBR5OpykqmkeWcHTB5ZNoSyFxz+v8vVWW1vr
SbeQfs/acAwJSh/mEoiLfOQsoqF+bHEmscUW2qRcgF+s7ZaKFiCS81gnxjapFQTf
JcIYOvxpreoSHOAUuO2lw2J4za2Btka8LdQl6hjC+vbTieYW3F8znAUtFKeg/9NC
SvDCeGiZYlZxYcbkWLVbaJTUdhem1FAGmO9ZH9+ppjmvu5tgWV9prauijzlEzlxK
3pMCNNwVTlqGwBcYPIUpPiDmG6taxV5NdhwhYH/AGL+OFw7/w4TCnfn4E3FPOmBN
QwN7c5FqzFmi5C2szGAh8cXne/Pd9h2sBB3sDvJoRkC0Sp6yc8CWQnSIJkXuDuUv
HyWpqIP9nfZRvS3Ersgx8g5KqYfFeUFT8nLLNKEQ4lxaO6vStbK/NyUc9xCGLCX2
16U4mVSM8UENLmE7Pl2IXQ==
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Nz3k912hMnN+4V0RDLkRfKgSX1DO8BueLv0GGM5NFx92scrg4CGDOEassc8DbMZp
s2Boc9wdvspf15Z5vfdczyPeJ1p5WvBpmzjMExK6mHEiZlk7i+EQXBRkZqy/4qVX
8yapadTNyIJB0QQpi+JR/AZR55YPJWk57KNV/StB7QA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4160      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BwqQeQK0+2oHyYeS1qBvVofaenAgmatT+KQJs4SbHlVFdvc4Xu+eAG84MtNlqcO5
4bKZ1gqeFEJUcPV2XeTkbr29bMadgba+/9tYvrLhm5BijPCEFtf2AWN+ZSw6V7bq
ufc1AOc0vWkxyK7HwY4oItvGswNXRiTRPK8J+uKew20=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4243      )
OF/JheuaYLA5Jjb/vg6HctcSZYvquUIc2h7trppDdgMDFGnQQQbkMQnTxgUC10uz
sxhwiYNV4vj+sA9ZCTef2TQ8MfzXErSp7IHENrPrhML8vgcjzeZeontDUNhyRRDe
`pragma protect end_protected
