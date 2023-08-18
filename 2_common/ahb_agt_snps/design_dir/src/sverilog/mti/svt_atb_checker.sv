
`ifndef GUARD_SVT_ATB_CHECKER_SV
`define GUARD_SVT_ATB_CHECKER_SV


class svt_atb_checker extends svt_err_check;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Y/OMbIVHS/9zH6v6gmgEwInT5w1HwRhrssIleiWeER2Bp4+4wddkie5d0+4jqSTq
r68XN7jVWl2fAHX7Wdp7N8F62oy2rSSdSHJ4w7w6FH41kxgheH7MqH+Z0xeS0SHo
L2fCrAV0J/49PIH7quKJSupi+QWR95XRg0I7msxsVro=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 121       )
3N8f0mDqrM9GCgD/zS4UiSeWCRjKG4MoRKY2P4BBNVcv916ntjEyPxEju+Kn508X
tIJAx+lWIFfUvrzSKsQv4pMlSM2sRxFoXcK9Mfcl2AyUcIgORtOofuBKHMPQ10eA
Ykem8dbuEFipy4IyFY4l1pKXUj4g5SKjwBupeDAyvoM=
`pragma protect end_protected


  local svt_atb_port_configuration cfg;

/** @cond PRIVATE */
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Br/B5pjZOyU6wWiHhNbDA35U9xdQVXsPwvGkG8ItOeQXHB+Raj+9P5cGwvS4uG8e
KO4CEdjNgib2t6ekSvFdIt39m9+b34/b4wdg67ge6gtZkkCpfy5V9cbolP8o3ITJ
ZCbph7dEjk/TgoRzsHv73JQcPkq+z0+vTeL5cz2cGM8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 244       )
CFV5SYP2karhqostjvTPZOTitCLxB6ehn22+I3l99Z8RW08L4N7YCJmI7haQ6OwN
oP+GnVtTuRCBT+ZL1cwZvnbRUText357n/pp77drFef2fTX2rx+9ls/3tToxm0uU
itDgN4BJ1PcT/UeTB9JIvkA3ysbtHPt722HPYK3e+C0=
`pragma protect end_protected
  local string group_name = "";

  local string sub_group_name = "";

  /** Instance name */
  local string inst_name;

  /** String used in macros */
  local string macro_str = "";

  /** SVT Error Check Class passed in through the monitor */
  /** Last sampled value of reset */
  logic previous_reset = 1;

  local logic prev_atvalid = 0;
  local logic prev_afvalid = 0;
  local logic prev_afready = 0;
  local logic prev_atready = 0;
  local logic[`SVT_ATB_MAX_ID_WIDTH-1:0] prev_atid    = 0;
  local logic[`SVT_ATB_MAX_DATA_WIDTH-1:0] prev_atdata  = 0;
  local logic[`SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH-1:0] prev_atbytes = 0;
/** @endcond */


  //--------------------------------------------------------------
  /** Checks that ATID is not X or Z when ATVALID is high */
  svt_err_check_stats signal_valid_atid_when_atvalid_high_check;

  /** Checks that ATREADY is not X or Z */
  svt_err_check_stats signal_valid_atready_when_atvalid_high_check;

  /** Checks that ATDATA is not X or Z when ATVALID is high */
  svt_err_check_stats signal_valid_atdata_when_atvalid_high_check;

  /** Checks that ATBYTES is not X or Z when ATVALID is high */
  svt_err_check_stats signal_valid_atbytes_when_atvalid_high_check;

  /** Checks that AFREADY is not X or Z */
  svt_err_check_stats signal_valid_afready_when_afvalid_high_check;

  //--------------------------------------------------------------
  /** Checks that ATID is stable when ATVALID is high */
  svt_err_check_stats signal_stable_atid_when_atvalid_high_check;

  /** Checks that ATDATA is stable when ATVALID is high */
  svt_err_check_stats signal_stable_atdata_when_atvalid_high_check;

  /** Checks that ATBYTES is stable when ATVALID is high */
  svt_err_check_stats signal_stable_atbytes_when_atvalid_high_check;
  //--------------------------------------------------------------

  //--------------------------------------------------------------
  // Checks that need to be executed externally (by monitor).
  //--------------------------------------------------------------
  /** Checks that ATVALID is not X or Z */
  svt_err_check_stats signal_valid_atvalid_check;

  /** Checks that AFVALID is not X or Z */
  svt_err_check_stats signal_valid_afvalid_check;

  /** Checks that SYNCREQ is not X or Z */
  svt_err_check_stats signal_valid_syncreq_check;

  /** Checks if atvalid was interrupted before atready got asserted */
  svt_err_check_stats atvalid_interrupted_check;

  /** Checks if afvalid was interrupted before afready got asserted */
  svt_err_check_stats afvalid_interrupted_check;

  //--------------------------------------------------------------
  /** Checks if atvalid is low when reset is active */
  svt_err_check_stats atvalid_low_when_reset_is_active_check;

  /** Checks if afvalid is low when reset is active */
  svt_err_check_stats afvalid_low_when_reset_is_active_check;

  /** Checks if syncreq is low when reset is active */
  svt_err_check_stats syncreq_low_when_reset_is_active_check;
  //--------------------------------------------------------------

  /** Checks if atid driven on bus with reserved valud */
  svt_err_check_stats atid_reserved_val_check;

  /** Checks if atdata driven on bus is valid for corresponding atid */
  svt_err_check_stats atdata_valid_val_check;

  //* Checks if atbytes driven on bus is valid for corresponding atid */
  //svt_err_check_stats atbytes_valid_val_check;


/** @cond PRIVATE */
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM report server passed in through the constructor */
  uvm_report_object reporter;
`elsif SVT_OVM_TECHNOLOGY
  /** OVM report server passed in through the constructor */
  ovm_report_object reporter;
`else
  /** VMM message service passed in through the constructor*/
  vmm_log  log;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   *
   * @param reporter UVM report object used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   *
   */
  extern function new (string name, svt_atb_port_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new checker instance, passing the appropriate argument
   *
   * @param reporter OVM report object used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   *
   */
  extern function new (string name, svt_atb_port_configuration cfg, ovm_report_object reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   *
   * @param log VMM log instance used for messaging
   *
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new (string name, svt_atb_port_configuration cfg, vmm_log log = null);
`endif

  /**
    * checks valid ATB data signals and if those signals are stable when atvalid remains asserted
    */
  extern function void perform_atb_data_chan_signal_level_checks(
                logic observed_atvalid, logic [`SVT_ATB_MAX_ID_WIDTH-1:0] observed_atid,
                logic [`SVT_ATB_MAX_DATA_WIDTH-1:0] observed_atdata,
                logic [`SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH-1:0] observed_atbytes,
                logic observed_atready, output bit is_atid_valid,
                output bit is_atdata_valid, output bit is_atbytes_valid, output bit is_wready);

  /**
    * checks reset value of signals driven by slave i.e. afvalid and syncreq remain low during reset
    */
  extern function void perform_slave_reset_checks(logic observed_afvalid, logic observed_syncreq);

  /**
    * checks reset value of signals driven by master i.e. atvalid remains low during reset
    */
  extern function void perform_master_reset_checks( logic observed_atvalid);

  /** resets internal variables */
  extern function void reset_internal_variables();

  /**
    * checks if all valid and ready signals and syncreq signal have logic level either 0 or 1
    */
  extern function void valid_signal_check(logic observed_atvalid, logic observed_atready, logic observed_afvalid, logic observed_afready, logic observed_syncreq);

  extern virtual function void set_default_pass_effect(svt_err_check_stats::fail_effect_enum default_pass_effect);

  /** update delayed atb signals in atb_checker */
  extern function void update_delayed_atb_signals( logic observed_atvalid, logic [`SVT_ATB_MAX_ID_WIDTH-1:0] observed_atid, logic [`SVT_ATB_MAX_DATA_WIDTH-1:0] observed_atdata, logic [`SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH-1:0] observed_atbytes, logic observed_atready, logic observed_afvalid, logic observed_afready);

  //extern function void register_err_checks(bit en = 1'b1);

endclass
/** @endcond */

//----------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DNQI946MyGATIv0FwvEc+fKpWwHfh2MC7obIFztG2TLd+DHAE0Vl6hdD1pUXseqZ
rfqu28yP17eGSdOHgmPyvO+Feor0BzFhsSdSFe+pZyIcHdBsBzjzTSNdqa7dDQVn
DeZHC5ip29dmh6QoXJjOxdHv7jDP4kmcwsLK4Ovw1gw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7041      )
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
`pragma protect end_protected
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AEeJ4GUqv7uT5qSbSTcaP3nv9YA4bv0Vl5aB6WY74/fQemnPO2HlRHcvMNvTEPpd
DdGS9kW8YzvWtV6/S7seZQ0oWN7YE6hMQNQ+4JQfGZmce3crKigayrkg71V7Kesf
GURmsjbdXJhMxHzmvXQLGIhpj4C7B/hM6t0hxaqh7ec=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14633     )
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
9+I1/KUaGJUeEvTT3WT9vg==
`pragma protect end_protected

`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WsEsmj0Kz5anTV5mlk6E7tyCqzg9H0yabMTRLnd4FisipyZLyVtjrtuuPofr2+07
gp1TEVFphaLR1QeTz1zZmw+Nsh2pzqZYOjyohyIxdWOvQBrcvAQ6Z1Yaf7LfXPCw
zaTsfCZUNOEcL5NbFfWnlAlCF0RZZS3c7pEm0ZgUJqw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14716     )
Azrpjkz1Nlp/rEU/6poyH53FY7YNaWRWo5ftlAr2D4bhxcgWddiT8a4bPT5yJVdR
8XxYZgGvDnaTHD5zd9CphbxnINX3XfL2qZfC45A2cMqsXyVgg2OYZrKiIf9PzwKE
`pragma protect end_protected
