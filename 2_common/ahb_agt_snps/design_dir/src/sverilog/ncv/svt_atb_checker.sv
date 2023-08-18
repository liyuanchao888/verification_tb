
`ifndef GUARD_SVT_ATB_CHECKER_SV
`define GUARD_SVT_ATB_CHECKER_SV


class svt_atb_checker extends svt_err_check;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3TJdTH3jZAW3mSxfCr8eONDeqDVR5R+SOhOuYTMhctxPhDB8jitw+GLIL6U5gy9n
715oDiI5ujSkrfaJfWj3wr/Z1PNl91p+RWD069TmahYDAiknUoV+FcmvyL/DC7Ne
Pr8M+5bCvwRgdtLumi7IAE+UL7iqQawqetQwvrMCGFrqr/nV3MkHzg==
//pragma protect end_key_block
//pragma protect digest_block
moRZ0TjObCQbBr0H98MqesrR4VI=
//pragma protect end_digest_block
//pragma protect data_block
bSx1m1uThQ9BUhO3qs+qDWhIRESeiidRmCVy75cREuQM9VuWH2nCN8K2kz1i4mf2
aeirdlLKZVKJKSWegQhk35prEKhTPPAzV5HtPWrYJFkxksQllSuFXJreBGDbp2uf
LaHQc28di9b9Z3z9FDn3qVcTbthgXPb7G80nRAvrgeTK/8Y3g9wKHyy1APEQbav+
HrR2dEXAmo2aH/mghl71ElJN3qjepeHFE9QpLhsyerOp+2K5SVKEVF8y/wPmteSo
3UkMUNXrun5kEAVbd7Agg4T/sq/ZezU5nv31EpVuv1lnR+GowpfYTaZEJ/1lrK8e
Dmzy0DZtve9Ogw4dAr7/7tFkhKxW3NSlTI/lAh2Mdif3HVohorwM0a2mkZKU/b0V

//pragma protect end_data_block
//pragma protect digest_block
WJ8oPXZ4kddHODeU0Ro0ll1s9dY=
//pragma protect end_digest_block
//pragma protect end_protected


  local svt_atb_port_configuration cfg;

/** @cond PRIVATE */
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
weAPRstPrA9z3VpYNpM84e1dFIaH5ytHCCLigvrrWhqoy7Tm7S3kla/rQF7G5QJ6
1bDb9DG2Ag5gJ5/o6L3ikCY06bPLEwJFJcFQFIvMOoTTgWDIu7yqGwejlBEw3ntf
lPVKrEL7FUQ/Hdk6FlYX1DfKDhmgWTNRQ/OIRVCvazHyUXhMa7I8nA==
//pragma protect end_key_block
//pragma protect digest_block
3G1Av+Lut2QIxVGvXJ88MNYiJjQ=
//pragma protect end_digest_block
//pragma protect data_block
rWcmmmg9ovDwhjxUc9J14mf1QPsUK+ek9+OkuYQxUYVzMV026wzMLIponTFwmnzI
y1pZCqkdrR4Mpuilb6pSW2LvWi5R/LodhIxFT0OMMGLG8MEUiPsxi73uhTwJ7ilM
jmpklfiUBoE4wvaEfNrJT/ZVhNG7IEHaM90at/+riJuxMe02M5tg8oJF795tc0f2
c22YHE0JTZ92/ftkyNoGsph2LWmPJewb419mYwNhoDKDlTsxtZxmSp03i97p6vvP
Xmv3o7dfvp+j+3WLK5UXw4M76g1BcLA56tPFzDmb7m9Vp6GtwxdXdGkeGWFY3Npa
nqX0Xpilh8qMxVrUGmjazZ+NkFclaVHkHxzWuRQlmQdBp43udxPXCsFPML7aYa97

//pragma protect end_data_block
//pragma protect digest_block
dQzeKufisoJndIZFjlTKlo/R5oQ=
//pragma protect end_digest_block
//pragma protect end_protected
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tpyF9FnYxD8gQYUb5B5PUTIl8qzqhXDXH8wMvwbKxK+AUxwkZFsnXArWRXqvODPE
ktp4/0P715ggMVmIAnByjeTv16Wa+TxV7OyyhOiwGBBrTek0W+VKgvqZcccVbXw+
r6FkH/UDPOZ5feoxTF2XFA8cU+ezKks1GotiXnwyEzTd9Z9y9LRsxA==
//pragma protect end_key_block
//pragma protect digest_block
qWpZcIK0qU9LtdtJ6Pca3d+U0vM=
//pragma protect end_digest_block
//pragma protect data_block
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
KdUbsNU8S5KpR/2pDxe8fQ==
//pragma protect end_data_block
//pragma protect digest_block
9T+l8lHQ+0mR2OM5h7AOTh+ca1g=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hjg6XwZHIj2I/Rs3f1LQJV7yoRmbdB0bIicQ6tgJuUA90ViHoMbdC9KRsoIzGe/f
oBJkaz/HS0kiIhQy673uuXR09luK+BGak4y2B7h0ylPW3lNPWToysERlZgJnGW+X
ibJyM8NYMuw7g9kC0Ubsmk0rdOs5YfrKK/VNqYD3c0ovDCUp8nKzYw==
//pragma protect end_key_block
//pragma protect digest_block
pvIQotXYg/+a3OiILOB9Iq8eFbs=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
bbpKlsAvwMC/ZetrEZfiF6pMYRc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif

