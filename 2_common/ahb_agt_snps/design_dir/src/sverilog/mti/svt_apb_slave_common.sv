
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DD4/zVdbL8cpBIIsZSa30bGB1xkXMSmCrgnvVoN1DjGOPt3/s+2gPvP7fYOGVk5r
0LHhh8IQZD3667UYrTConYVGI0ZTOKyCqmnBodpKPSjsfjOkVQOLcIErgMtu2Zpw
jbAuvrTLblghUx8njWoLAJUk52C+N2xyrivYrrU/p/o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 932       )
c60LEfakIWozqSG1VqJ1yQozA3+wpZuqRXbQqrIAwdTcr6Oxpl9EOgFotTKfXZ02
RQ+insz6A93jRx9A3WEmeJB62ao6f6zT8TpxAdXRqcQMA/YX8v+QYTTGg/bp2Ars
ECeb0HVqd52ihVyB+rd1jHa4CGOqAFxTDYgsgrRBFTIGn2547ReuUn51yuwB+3Wn
S6vKqvPwvo1aIaQi1UEGxqZ9FvTOL5bDRoR5j0LQxHjRiRp0fKDwmkeXLy/p35XX
QfrQ5Y9t7LpNnlf7oNCu+O19Oga5ZpXQ20KOYNbGlGOaJPM1YyWiauUe+CNzLIJz
yFfPBXjj//Pz+BwZgPFWy72MP6DcveBsqYnDOVWZKFqUdBBz0pgxtLWkceVoJIpV
CU8rhBQ/Y+J/GOHUMcycCa1RJa5uwJDDECeU2ZDZWduisX16uCvnN8AlmhA4L5HK
7MEcVOHe+fbPtxgAfdM+zuV5bk68kCSvdEACJhPWqizNeLEDeEjrkAtQ0aeF/6cE
9YXY/fdKiFY5dNKYHaRsvpQij4sYVXHf8JATbZinF/vDBlpn87Y9+oGkULyBRPz1
lDg0gfdD0fabM9V79R1OD7/RlWGe/gCxrFsbKnpgKKGyRpK6c9eqxc4Tc9cmPhNG
sG1bK1waiC/PDdgeBmorIY0lQU/LC6YelPXLZpPbjZF6GmdvtN/xyTmKfxaUscGx
js4OYwu7/PorOy3KELsPPCXdr/n+LwLY7L/dI0nOCTX42PmLb6MY3sPYcYKFR10P
rIZogtM0swUgdifpJpKmjcYR3QhxNvDrF00/FsKZ3+t4BgCyelHVzterVTrlsf+t
2efbI3trEzieW7uRVoYo2DRpLFjduN5k+YZ1sImTlpk6qFv0yiomNTc9iQX6VtKb
vE7cKi6NvxyAfSPVBAvQKqU4FA92a7koMLbWO/Z0x/mga4qdi8JP5+Jzc4eQsXsB
+roG1fm6mBOh4i7Ly37qosh0JoXLGe+UUom0mkmlFaqAeRe1+ju9keqTQKHpNoSZ
9uECfZGLg3WnGhWoL6v6uS1rajROK6cgFz4M3/frn9UhFQUiH7GY07A9BeCE7tu8
Ux3yMzYalqDBZ0YUMuEQx+gP9cPYjT9QTzRK573j+vKgKezMj7uupdc5Cn2b2dmz
9arvv/frnFXKkw8f9LmpE+5nTrty3uFjJeMz2fKVgQP20xEu9YF3vyE/BauGSiPy
AUaerrnZby6trQH9ZkjpJejDuoGBj9JtQFwBx4PnsoE=
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VeHXuPDmWDZ6d5vG3CewxnUcR2qzUDPDYr2ycYk1p8uF5Y8teLneXQKEOKEw223T
eKTsQ//xjPXbnrp2GAa8Z80z1/L4NpLxc/xUNl0FZefMSX/Zp0SzI33mBDVthiQe
qW6GXhpxCEf5+tggWorTiZS4pz+K+ohM6lfc2chLUDY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2253      )
3qcf76SiqX1RWA8+PaXeWMke5XqCLA/em9CBcTY98G7AQdNQAYCM9NtZ2fj33Bn1
2zO1Qt4PY26EtbpmAHRYRjcssmbhDAUIDrMbA6L+w2hANPZ4X32yTc+rtTEWARqd
bR4JsUHfAzH4I3tUF8f6e0IDDjiPczIHmUbMB6vIpVWg8CYqn7qLShb81EMlOlnD
417aC265TRtqU25ydL1IjCEc5EpJLbqGIRUDfL6wvbPXWOMlRsJ0rOoA0BHn1VcM
RDL9ZEyYvnd/SngOtTauav7n6phGFmuIn6AhZyLwjKNiLl7BQSBC73oPqSEvq+8D
pD3wzzlV+Iyygxewi07EovCoaDBtaFfwbln1SfLa3gNZ+F+x1ZpHq7OmE+bK1vpI
2cSpgjxZXlmo7GwfoBJai7cQTFcRINf48/dEonOhMsv2LEJNqvcR0IBGlOjzYToV
fwod0twS4GDqX/viM2M2X/GgWtIgnEq2JGZbwLlOE8Mvvp8k5dKnKiWkEf0TX86b
441KpDTuRh6nrnHUHpWVKsl2bOTnbNYDw1NmBzRdieHlSXZwuQz9JsExGra7ikpS
pYmGZxBZLQfO8MN8EdXyjgK0lBH1rl4t+oQq/FeMVH2Hl9mookGbauz30xUCj5Ny
K7F6eT1lmvIU6ny0K4WDH38ZDQ9AkNrjJApvAhiHwunimJZYRQlk9qudjjgzpsBp
4lgFoP8WzOBl8SgLidzrIlJT9O1i8E5HD4is3H0fLq+fk2p3HacqM7a/HkNw4vjq
snxzF6g0c8y5mdCUdshR+9zxRil7Y6C+JfjGv6vbNvK5HsMPdpjlrAEzFYPfNuxq
OJx4F/e18PpHYRkCpyAu2WIehe6gxl4W4X4mCdD9N57vykszaNnEaOkaZpygd4Tx
uk7ba+GM6QXtOgzTBig/Q6KlYf0H2RQqcXVzmeh3UrIauNEVvTrwLEK9DiuxfIii
N7BzI0dk09O+36ZbHFHUWg5Fpke3cbSFipiynJzH8kJ4ePsqzwFSF5ir2S3hz3Y9
d5qJaYz2lo4fRWX/gvW3HC68J30eKDUwauWNmL0ZQ6GXzqQYGi+359XmoUZYK5rW
d69qXtRnVSXAiwEMFC3cOF0Ae+wa2cAjWnxcp0obpTSWgtohIXUq++KtTfYkT0Qq
bk8XeeERTepFHvfaAaYC+ISFeGQRSAdAwpFJzSAEzCXLd+eboOmFQtnE1/UTaNxr
yaYe9jw2aDGOg2fZEkCoCX/W3WyGGJA4+fA1UV+dyGAeqAX7sgNLQ/N7xpztpD3g
OwOrJV4ojLZ5MzdgxmgIdagVCE84jeMpSGqkGQZfh+J30nNDVBjbEeJKDf1SZT09
ajnGit0obmgmD1RZS9KPoeiH9N6EgnYZBIC8pvptj9dkuhd4dYdNsss0Dy1KP8KZ
5Lmfz6ft0Kc2whr7bANsjm4p1TgFBLaRdm24MkzIFD//qO6beX9Q0L+8lAF4080Q
cxHoKFW9lSMBKTyHhN0jYHXLAYqPN3F6iRT7hGC2OJ+r/9hqSFNbABMdJ4ilNm3E
QBsOX/WDdppSyUHgG8KpDK7PODhVVqf5ukYWZxxGxyML9/BNyKJDnDolLr/GhzM9
ASCKWvW6wk0+cpERA6HsYAZ4NbIueaQwHkUq3LoVMR9h0OrNGL/sRhkNEZkhACWR
hG8ySlipFFVNQHxbB+1nC7BMXhraucxgJxO/kjzoCxsvOOqQpIA1nSbxjWEdGjlI
7g56DGzoZjJlcCEzj4YMf5voaGxZ0CgMAvO1yz1vvPA=
`pragma protect end_protected      
`pragma protect begin_protected      
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fmuO3WrR4dQdM7C+qNP5aamERb09WR0SZKTNLx0W15ATbgG+gqfFh0YpWwkOjL3n
Nwo4MZGC3CiY/XcpK6bN0lEXD5Qd1wPKK//3fHWKC9H+RTxbdEVJAQswDahbd+8B
KC43HD+uzDjmnuhij/+wC74sA/xsYkNOrSdt8EnXe3U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2444      )
l94Cx1DeB2+4jY1wZNt/HG7Pq4LN0kz76LZNQpaabk5vg0OOFJjiN5XUpluv4gCI
WoDBUaTMAbxuGL5nFlMe7K0olms8T/wEj9N2mzmtQYZK7/qq02ADVTAEkxOYc8Ml
zerUUceCmCEckruL/Q6qcP9UE/x5oc8CfR1M5epPXSExALC+1hyvH3VJJ+Uxxak1
dNf/tvNl+v73FsRhJmaxWxluqVbm7Nd5XbQp/lXaPfy45vQO/ywp7b9eoBHV31lj
`pragma protect end_protected
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fN5qYhgQh3MvUBzxBkMOnOdJKolxkw3f2TOLHowmqVexB8R3gyOvNWD775LBJ9M1
Lqq0Aom4FOZ734nnypcMXWhw/clDd26QPAVslF2aaMdhrM5IsbOuCj6HQ4+vRNOz
iD4ABDJIuShPAiLE6GxbBsTGvBXG3JBOCet34tAquBk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25417     )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hq3gn8Po9WeUimq74MC/UIWWxIKL5nkApMwUat79HHgLLQ3HNwGlVAKp+4VNVENB
FgmyDOg4amdM3nIGOx0KXIUUcu3BFrwO2TZAvLbCJZyaO9aGvX9nPEsXYTlh1Pyx
wd1cuFyr6E68vtFWcKTSymYN2C2z1aeDsrReDc+xbtw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25500     )
UfIo2Jztpvyk1kFDNUtnb56H+5WtulbLce5cKyu8Ejs2ARKGebJDvYx482qG60mX
kIRCSsGsTb+Dh+D2M7gaXX9xsR0rzlyIxkw/i55FaWmyQXi5jK1vdvcvY+lZOYYh
`pragma protect end_protected
