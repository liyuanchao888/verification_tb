
`ifndef GUARD_SVT_APB_SLAVE_COMMON_SV
`define GUARD_SVT_APB_SLAVE_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_slave_monitor;

class svt_apb_slave_common#(type MONITOR_MP = virtual svt_apb_slave_if.svt_apb_monitor_modport,
                            type DEBUG_MP = virtual svt_apb_slave_if.svt_apb_debug_modport)
  extends svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_apb_slave_monitor slave_monitor;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Slave VIP modport */
  protected MONITOR_MP monitor_mp;
  protected DEBUG_MP debug_mp;

  /** Reference to the system configuration */
  protected svt_apb_slave_configuration cfg;

  /** Reference to the active transaction */
  protected svt_apb_slave_transaction active_xact;

/** @cond PRIVATE */

  // Events/Notifications
  // ****************************************************************************
  /**
   * Event triggers when slave has driven the valid signal on the port interface.
   * The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when slave has completed transaction i.e. for WRITE 
   * transaction this events triggers once slave receives the write response and 
   * for READ transaction  this event triggers when slave has received all
   * data. The event can be used after the start of build phase. 
   */
  `SVT_APB_EVENT_DECL(XACT_ENDED)

/** @endcond */

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_apb_slave_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter used for messaging using the common report object
   */
  extern function new (svt_apb_slave_configuration cfg, `SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();
  
  /** Triggers an event when the clock edge is detected */
  extern virtual task synchronize_to_pclk();

  /** Monitor the signals which signify a new request */
  extern virtual task sample_setup_phase_signals();

  /** Returns a partially completed transaction with request information */
  extern virtual task wait_for_request(output svt_apb_transaction xact);

/** @cond PRIVATE */

  /** Executes the penable_after_psel check */
  extern protected task check_penable_after_psel();

  /** Executes the pstrb_low_for_read check */
  extern protected task check_pstrb_low_for_read();

  /** Executes the initial_bus_state_after_reset  check */
  extern protected task check_initial_bus_state_after_reset();

  /** Executes the bus_in_enable_state_for_one_clock check for APB2 */
  extern protected task check_bus_in_enable_state_for_one_clock();

  /** Executes the signal consistency during transfer checks */
  extern protected task check_signal_consistency( logic[`SVT_APB_MAX_NUM_SLAVES-1:0]       observed_psel,
                                                  logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]          observed_paddr,
                                                  logic                                    observed_pwrite,
                                                  logic                                    observed_penable,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_pwdata,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_prdata,
                                                  logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  observed_pstrb,
                                                  logic [2:0]                              observed_pprot
                                                );
  
   /** Creates the transaction inactivity timer */
   extern virtual function svt_timer create_xact_inactivity_timer();
 
   /** Tracks transaction inactivity */
   extern virtual task track_transaction_inactivity_timeout(svt_apb_transaction xact);

/** @endcond */

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CmAeAO1VwX2//wwW/T/cQ6or1+P50dKXFJCJoL7lmjXFo47GSXFhFgFqUJbrGnXj
KT8TZO3vfuKsorCNap1lZN9QTLXgVK8LNdjcRRirXAwVa0z8yOmjyh6pRM8YrTJG
tOQ67BpsqTp1+bXFFKj59vB7EfXhe2LcjsjyIVwb1o9OBO6MHy+jnA==
//pragma protect end_key_block
//pragma protect digest_block
rW6Op5ox8r3aRo+urES7zcxBS2M=
//pragma protect end_digest_block
//pragma protect data_block
uNANULmlGoKIC+pOP8xlaJU3nB1ZTPCAVA/bqEpAhgmm6OTvxQ2PVEekl1t8OTwE
7oMowwQ758BNiTOwwY85BYao5nTX72IcBTKtQthU9og2q6+bbHUO0WZ+jK49U+vd
fbpWolO0V7IbP0QU60r8crx72RfvzpTWSNtEew+s3Y9yUhmDvb0st30i1Xiu5nkN
cS0P7cyqD8y+foRBpcgHDRFslhHNbw4SpJvTX9N6V+493r3asup4OQWtQ8C/TQv8
ppJL97fX4xdoG2uqHdhAgd4ODk/L8bwROEF0DipZEi7LsLwlczGu1ePaDkKHIERH
aJ702nXEDZM6C/6T+xc/b7+ffp7uu+ROpThg0rHfItyc+P2L4A638lStMCDlVJpa
FGYPwpLJFs6VEk3LPqOSfQasTDDFxRdTDkwbA7b09wi0dZ9v3pX0eRytXWhGf7HR
QJd3BvWV8Atr596QWWAiARQVnv4Nk8Nl1PHVo00Tc1TAF9X+dL5y8LkkicmSAR5J
tlnHmyL1Wl/tI6jPth8Zt7isKPUzRyiKLt9hVeXUtohriHnht0sti5/JQf/Evdc3
AJhv2zFj/ALhOwoG2JV9Qla4dV7HD6w2PhsBu2lmwwM5okUOQheDOpP0O0cC8UCE
lFzyU94q7ljaUVqVIPS0/eyZycY6HRQaZVUbvaqgPExpzu9QPLut+4Xmn+esGGP9
4peotRoxtjBnv45q6F1Etw9VF6sWv3TDiYutBrnbf90C5hVzKNTtHfexGxd893j3
AFOaHtIdWxLBKPcbuS3RjnuRY55i4cHQy6NUhBC4enM++4iU4XHR6Kiq3cldOCQy
HlIY+AGImuFIEhdJWEUKyKr+dJMX6BfdkTH3j6Uio5NISQ4UyN4CRrYCVKXqdute
KW5AUyYDepMIpcLAa8ZY9fbqRIfqmuvjtkXmbwlhYnbcBhfOoNxH5O9cQRcD50F/
j5wP5nAO07tY3D6e+slMuPZSy/zKpQtC6pOR4bdJPeTI8zTvEPEP9l+RXVnMXx0Y
gW1IqIyF6FqxWgMd2IupCMrLSJ4AbHwbglDQZqPm6Iyw/LkLO8n7slqLD3/aGINA
hIBjeFZRffeqLMv3gP1DE6/rLPhJE+3xXAtLiW8xFb6kbQP0AU54wxPRm1nzqWw5
CiVDE6ixmjfR+S49ECJXUKbYV/anL4eIjLklUQb8O2RclhzXy1K4+XJcB4lJ7P39
30FnTovd822GeiXHFSr8DVZWkIKdx+Ct5UTXI/tl/Y8ZGxN8mOfwRWds30tHnLw9
h7PZQlmvqy5RpLEis75g8nr92K/Dxk/8g7w4INXgmDe0I4HoE930+ONQDB7P5oe3
W3NlRkugroHSlyo0/C8AlaTu0S9zVrsnnFgqaMdTRivJI2KTgS/c0U33LmmxKW/u
WdvJuRCv8xqZ4EEZRRuWDvIJERyrdiLppJpIcZ3/RckWMGbv04Sc8PXjV+gByBL9

//pragma protect end_data_block
//pragma protect digest_block
sGHaRlrS+V7fRnQ02HRPaXCxwog=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mlF3CB9Izs3NkkgOJowUXgDwI8kU1vcwu96G6i4DDr85I+AGjcsE0ezoLC3mqiYX
/1AvcstgYGNCn3A2BsmYg/ZLtRUCxE05J7CzjQ4pBCUgoPI8cAyYoqI76uuy46UG
ufe9eqnwNTUAyarnDlm6w/72tDzflEj72oDUyAABn3czOfmoal0BEg==
//pragma protect end_key_block
//pragma protect digest_block
b2rGMbhG1oJhLA23SQafNrRlY64=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Y8t/ygeQsAG+RppM0hhsyvlxP+M=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7QZlFJFUstKJhkZB7zjbTBk9n8+m2FXH7HuGwXIctLfq0r+p+L55en0pGhstfNLq
rrsuDfSXrO4aTPuLCMGiZaPzDiiW0aLPtGZfYnXGeZngZXY2tJLTq33hnFN36r7D
kZeIVhTgxSXR1RQQ8QGMB74nV+OZBfqPRrkeOoYoQGEg+TkF1FsFnA==
//pragma protect end_key_block
//pragma protect digest_block
yXpxJYmo46yW9oAKqF57+64Y5qI=
//pragma protect end_digest_block
//pragma protect data_block
PY3MmHqeKm3/WLRXyXQ/jxWGtvh8WIPCu1kky58YkpU+QB3ubvJgjOWPn8Fad2w5
glEIxSlgR3bZWStixW2AK/IjlH0Ww47SrIxzt7WXLMsDZIeFfq/PhtwiW/eaauop
quw09BnqkpJ9hlmuDMjfxkyULbauRDkzclwvvlnfxXgI9soL9xddCfkcvaUAE1Q3
4pmmE1CNNiUs5+GiNYURzsIxamARXr7X/gGxK6qdSoSzEofypar1DFyBqzSYAifn
kcKddAhQUg39igi+Gww646K6RbZ4b1t7+N0vzBG2pfnQR/HHF32O3I6D5tvohKY5
qsnMipeahfsboQhZ56JR/U5HR71ZMtIapaYfjqP84L/nDMdLIsF8Cj+pt+ki4tIe
sVGk8lZGTWW1V7hLla2fNap8Ipqt+9nfD9yHRTT27vX03BDi+NO+p7nCpfX63uoX
Zx2aqDGORRftrnTKtQUtlxKWWfPs24JuyEu3IRGn4zM=
//pragma protect end_data_block
//pragma protect digest_block
Km9/C6Jn9EyZAeRddxO8Up7bBT8=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
74/ndMJwB06NNq3NOnsMNAWIDYa9anNl+ZxJW0oXnEXCveDve+0/ZytgzPXCZy01
/y+jOxL0ojlioboiEvvgfVyuzlTju62yWuP3wSfrWUt6S9D+0cEDyr5TeXyG/gQK
n0EJ/zux88SkvwwkGaq2J0KP3QJRHWhsWD/oKcihpGGNmplk/cSysA==
//pragma protect end_key_block
//pragma protect digest_block
igBX+8vcFBGqDtSiP+kXudKlaY8=
//pragma protect end_digest_block
//pragma protect data_block
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
VapBn2H1f+ZeWUq4K0m9Ow==
//pragma protect end_data_block
//pragma protect digest_block
04yRhg1v/HHrVu+0H9NRT5IfFuk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
