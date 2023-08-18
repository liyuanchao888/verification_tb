
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WWBzqkItoByHD0RqAOrzwx2xN2ARFP9JjsQCu/q0SkXc6ApIyNJU3iQSPpkZuBXE
f1WoGKR+twM48ZdIvH9EmopY/W+7jsk9FbyJ3nRu3nOrpiQx6B1/DaUZfB4roQQm
t1m/gmHsN5bem9BdiFIDSHYwzs6RiV+zpvEyC+hcTrQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 492       )
mSQLFjcD17j4ZU9KEaGHrBRd/d74PGvTfAjx5O6tfWf2F+RjTtGS1LJL34bDUIMY
8nOUvRGfOEcXK7uKuulS8sicSlsjvEWADyiG11OdK99j/wUMXP3EZzjZdc2PztSh
3W2KD4J3+LBc6Z92Xm8gfqUNBVnO22hyvBAIxG+uWuIiNJQf4k36gEQ6GvuROvpl
jplqfEO8ojcuOAr5lt82ykSgsCGrCxC5I5/owY9LRmQld1NANGxlS51nn8DsQBrE
d6TFdPogE5OhbX8eD58qZbpZoXz+5aJZPiTHITb1mPGgQvuECEeNT8p4ICtgv/0T
8iB73v1LeZqJ6Wj3c+Yr+pLQIvusizbmh/52eeSlY/0AAJGtQeLFrTlwokKxP5RH
JN/HQJ4+r/DukbRrfRXfXZcOuhdy+lC3S/Wy7xg571LVZM8Jaqwy7fWjZ1t3sfXQ
g1AMkrQ/GsZ4ugSpzriOHl79HYIO6kkhzJqlyS5VBEgRvSi5IoKEZ0lftiyl27J4
fKmIUSGmGbLNSNIvv/9PN9bl0/pTjq/vk40gJt/OBZeVPaw6ElWJwJAOetIMVZ9g
L4XuPXSfQvwtTi062Ii4gN62PCYg1LokAjNL+nbViPcWCSx+/M/DTTnHFquwfbWa
1tlz2NOj8daaeFs+88entA==
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TH72qB4Wsh7mmAjN/h64OE/az7TGVJuQuNqWm6Fy2shTnqTVSTOIeQEUaSzhs2fy
0znB5BanuMT1ffKEsA/iptEUTYcfAnzM6uyER2xw2GHiXwJyFFRRtiHzEOgOwkiB
74ZE2ZslZuqC6u9P+PJA9hu/DRud2MsrOsU/M1xf5tE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4176      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XysJbUGE+kSQ0+Y/eDBtWZbWvJeCrHGaAYlx+A98xa719ubLLmSXvkzIAMGNJoXR
qY8F8bOYE2x1NUfdvTbEy1xrFW5afcbPMJV1/1cNtx3qaZvFf4WV517j+vkS7/XN
3lA47nviqngr13JcT+Q1WwwV93oX2SMsnEZfHVGq058=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4259      )
sXPaMBwA/0Z0b48EvJ5OVjAn3hrklRnAUyNLwb0Nc+JWbpo7prH+DztATsb9XILX
ka9Q/FNiti0/vOYYR3WkWIRjVxrPB0qNIxQQ/6SaNOOd7Ig0yrqXo/IgAbJcjRSj
`pragma protect end_protected
