
`ifndef GUARD_SVT_APB_MASTER_COMMON_SV
`define GUARD_SVT_APB_MASTER_COMMON_SV

`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
`include "svt_apb_defines.svi"

/** @cond PRIVATE */
typedef class svt_apb_master_monitor;
`ifdef SVT_VMM_TECHNOLOGY
typedef class svt_apb_master_group;
`else
typedef class svt_apb_master_agent;
`endif

class svt_apb_master_common#(type MONITOR_MP = virtual svt_apb_if.svt_apb_monitor_modport,
                             type DEBUG_MP = virtual svt_apb_if.svt_apb_debug_modport)
  extends svt_apb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_apb_master_monitor master_monitor;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Monitor VIP modport */
  protected MONITOR_MP monitor_mp;

  /** Debug VIP modport */
  protected DEBUG_MP debug_mp;

  /** Reference to the system configuration */
  protected svt_apb_system_configuration cfg;

  /** Reference to the active transaction */
  protected svt_apb_master_transaction active_xact;
/** @cond PRIVATE */

  // Events/Notifications
  // ****************************************************************************
  /**
   * Event triggers when master has driven the valid signal on the port interface.
   * The event can be used after the start of build phase.  
   */
  `SVT_APB_EVENT_DECL(XACT_STARTED)

  /**
   * Event triggers when master has completed transaction i.e. for WRITE 
   * transaction this events triggers once master receives the write response and 
   * for READ transaction  this event triggers when master has received all
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
  extern function new (svt_apb_system_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter used for messaging using the common report object
   */
  extern function new (svt_apb_system_configuration cfg, `SVT_XVM(report_object) reporter);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();
 
  /** Triggers an event when the clock edge is detected */
  extern virtual task synchronize_to_pclk();

  /** Monitor the signals which the slave drives to complete a request */
  extern virtual task sample_access_phase_signals();

  /**
   * Creates the transaction inactivity timer
   */
  extern virtual function svt_timer create_xact_inactivity_timer();
 
 
  /** Tracks transaction inactivity */
  extern virtual task track_transaction_inactivity_timeout(svt_apb_transaction xact);


  /** Tracks pready timeout */
   extern virtual task  track_pready_timeout(svt_apb_master_transaction active_xact);

  /** Executes signal consistency during transfer checks */
  extern protected task check_signal_consistency( logic[`SVT_APB_MAX_NUM_SLAVES-1:0]       observed_psel,
                                                  logic[`SVT_APB_MAX_ADDR_WIDTH-1:0]          observed_paddr,
                                                  logic                                    observed_pwrite,
                                                  logic                                    observed_penable,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_pwdata,
                                                  logic[`SVT_APB_MAX_DATA_WIDTH-1:0]         observed_prdata,
                                                  logic [((`SVT_APB_MAX_DATA_WIDTH/8)-1):0]  observed_pstrb,
                                                  logic [2:0]                              observed_pprot,
                                                  int                                      slave_id  
                                                );
  
  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
duduZFKE5gKI3vA5aEPlY64VIFVV6y5GJOCSPs/v3uZjYZDYQW8POQ/x9xrq+vMU
oznVwWCofNL6FEKPvONSYrEJcVPhkDvH/7GxWwDHiAYMj+kPrRGymveI6+lizR7S
wnJMjEfKAvze0N/RkX76XvKjHsRyRBZtBw1DW8afyWs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 663       )
v/WfpjySl2NaJi9NMFN7YTpqMG9hH94+cTUrOePIJkVMIXTCwddtAtLMo1jwFUz5
h5V+7dTufQ2HKZ2CoFrU2w6/G/3QQ2plpOkFpijG/5ENGRZBlu9ZkhLuHH0A+Ujk
SsIcdYSLYmWXsLViMkZez/eSriETbBpXe4Txw345cIDkqNLUlvdNs+fjGAJid+Z5
28hNn79E9LkjHB22KNuvUcNL+8pm2oKph2/IXohzwxDMkuLly4TkQGpsaosGBlXm
VM+KRVAupJWGsG9y1zNlC07YcTc7xKAoeyG+k0Oa3UoSLxsVqqfO61bmHyjvFUBe
Px2GEvvhOZhl/osJ5Q5UwCg6cikl74LBL17ehPgMmRFvqvNUpKi7iq81dUrpKDvT
OYp5RC9WFJ3nMEg8/uCnJqdKNwxM1rNfQXbX3iFffPKJBhkwS38r8wsoIInKvjV/
qVFZcPYjz1CiCCMVLJE4bZdmdWP5Ckow0hM51Txr1lKzOpzbBzsyb0Mc59Z5+N16
TQIzs1/KXwi/fBzIzDF2MQ2hsODDpGazLIhgJYTQalSHi1i5eTi270NmwWfLW5lt
4OajPCGe6uUBcDWsvIkS+kyzFjMJx59uQ9OlnnNXGbB+ZyCLg9CQ/xhiqZWa82ri
MXaPMNwvS3ZpZaC+ZZk06An9HNXCYLl+y+67IFW5E9ft1c5FcvLAtv2MYlm+Jedm
dr7ARJyj6b53/PLwDIWm5x0x/Ua2L57+PAMOyh+LA5/bytxvRZexT/C1Dvaf3Ffs
HdkzVp/iDO+ym24HrFVKVJNqZTASsEXiktfi6w4YgwpP4vuk+OCmPUmomtUIEWWc
wRHF/gaYbT6i8lN9c+zlcN6lhfpLJnZJDW8d/zuKxYg677gq0QLzwF07v58P9hVL
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DgmGTTiMRYwwqAIEXwWgHsyZIpryyfGMHJOqzfjEKhuqvKGy4g0O5G+tL9fQlBtl
zZFDpODbgbjA+VBpMuOtkOFz1/zvdu/yDVj5PwLj/6k/UgV/ZGfDeqezTcAJXZ9P
HBwYQeZdOAPKRNVDXSrc0fiB5/i3HeWb19/SEiwrr14=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1913      )
C3QlwpZFV7VIsW7785AIh3jRLT6dcZwwWJ0944+7976aCEanlQkfAequkkODgiuX
A6vKav0iAjdYyuWWk2T5FUUOBUHA2+FHI80duds2VaGC7DLyH11/gB/nU84pCAB+
Q/g/v6NbPp8aHqCABGa+jIA/rORU99z1SPZBiM3hnjY0rH21Vg9nauPMgHEANngc
7yBP7A791awD+Nb7qeGftyWCEIeMhIIuJ8SiOTZKFYYpTzTgzuqLTp0RgbNZ7gsi
s6FT/REhqVlVs/b04rVQk8agLIYSaqgl2Vub7DdLM0TksXx2wfIeGZsd6ufEmBIF
jMriqkV3dQknN2eu4BveUE9nSUJc0tMrrg/FeDcIk4QxLeVtFJ5ydDSdKtZAgWVp
yZ7Z3DTDY6SmEKIL6tquV4z/GAdxO8JJvHHDS1HwQKCchBDFKZZ1Oo9SFa8zsaGf
0+VJj9lFiSxAfnet/dHSlrMD3tE9AYauwXRph5ylz9yF204GDSKzOEHAH9aj0R/7
VaN8VczoEQ26kqb2q5S7Nx6L3G+7uL0RyFqUYB2k93Gqgb2w0fOs4ZY2wTyvNHzl
9tTNdEl2FU5zY/L0AY7jpy0DmKaaDp8AC/OPLw1BHAav61jXM0b8HQu2fjlkkxt1
jieIUofRVe0Gu9rSMObnsA9qpnWLohgDt4erJzpROM8oGKMT4y7clQPgmCpz9w4g
Rd9xrWdKP7qbXto532cqBJ4+85J/G1AROGkxi7w8WXAJdqa1yJPqMo1LDJtTwK+G
aq+YmQ2uSfajfza3Gfn0wtQuMmBglJ94Mx0/EecpQ696z9QtH5EFjAzoPydGEgSn
VYKh5bWY3QBJMnes6R1ooEko0i04F+RqyAXpB1HZy+e91WhluisV9nX6WtV18HIA
ba7T/sBKpWL7UoQqTNW2A3gsGjaeXZFqIlS33yeKAvjlKQ449RstGqBpXmIwvQn2
4Rc2NooxGOsK42R8kl8F7dsxA0iKQk3JOpdnbR/l1JU0VHCVxQbmDKIoEPGR9tYP
9mjNxQ+jDfhtb8V3Y3gp12ymkOwfkz58AAfCctjQCkAWFNUCO0cOL/UsnXwaD60Q
KssYkePE9NnNjiCKL2+6p2kwQ14QD7anJNyIQCse907poAZyNDCR+pl4v0Ywr/7J
4/ooskFNh2o17ruSCSJvudtdPoB0zTJIEhO0MVTPHCEYIAF9bkTOZ65d+uH/IUG/
IOrU4ncpQAiCn9oSZvjNQ7BuHdAZdG3nCPn0ZHaF+WWADHtrn7gzpdbxe3VpRL8+
zO6QJhTuWibLH1SsIzFaUw8CS9XXp5/V0aRuEJuqYCzAB6a5I4RFUIKgyPHbqb3o
b0nuDJyYdx+4hOD5uq+gKbTEDxMVY9qjdTbaZRRioc8y78SNT0TEjHRLnejBx8zB
8J87zcBHWx/2cV/REwBY8AWmvk3Ll5QK1CM7gTLTFJLzZgEkhDLr07b8aX0cMgEH
xVHfo6IoaxGwkmLWcB7zHoo1Prrl6BbVuBFeb//mjAIGPJq/SIu30F3cUdrTrScl
Uh+a69GC2okSKJ5tmfUacGWJPQ3RH+Pv3TsExR2kDR31qnxlqIs3jcxQPXNsQU1L
MUGaxy/4FDjWZvOD/t2fCHYbjOI7vdYPLLJr+2K1EVjQ2rcJtg22G18gNY+bE4ip
vHZ92c+8Q2JOzNlpccmuDg==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EfXfw1oPADAM0cyDnAr5uWT+C9HNNaldjIp0emIno6nNtN0aLQM+WfiKLT2Hf4HF
2QwhOVwCvrEOM/yu9/ojRVX9vPqMK8MQPa5WbDMUx1aJJUS2l14CI94Q6snKQDZF
9o+ZYKRTUrfpBgAPCNlO1we+W0YFyaSSxmEbSYSyxA8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2104      )
3p/CicDusx+dtE8BoEYlOE6BzzSWzXiT5+ZmskqwUMR+91v3BINPcTSCEZv46Uwh
suyc5Lzb3+mdNTx4Ak5K6L+zy12E2zAaAn1A0uhwX9ZLXDnM6dmRTzuH3r5nEd6t
ZruHXP1/3DwPW8h8fOpVFeYb6yptnkneVplFIKlINmfQTdwj3mUCBsGTFs8eg3y4
oE/Rxbe2OphtHpCAE4irYPukDReT0FLiZO4NYw1V4VwsMVLrRjz/X1VMUrtvoz1l
`pragma protect end_protected
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QXqLyBVuXcfjf3c7RHeTPCVTKwcggpWnsjrrdihmoh3Lc+HmV4/cfIdoScGSYEj5
JOdmKGq/MqFFCaTu7liIuJdZPt2DmIcC+7CScCVG5sd1bwTjfIfcaoFx5H7VjH8V
55N+5DX2DVQ9mPZLSsdjOw3mFTNZa++eRTTJ3Cya92A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26373     )
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
`pragma protect end_protected

`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oO+isSyLCP7MYMCfYvK8Fpv93aGSeuloffswWT9WGqbYZfmVAEcCVQJFbgCCWryZ
Tr6ZXlQslqlhYjGfoixGA0/5HP65T8D4qsw9mqSf5oP2MeUERiZJkZkg7dp96G5a
AzWGl0UPSsusBXF2r7YZqf3CZXxBD/IZ+B/jpB33s6o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26456     )
PLzS/eGgZo4tvgtnjWt2KLR5fxRvQeG3z6sXOTsG4Rwd5CZ/C+jtaPAiZbNTJGdx
Amefufa+yg/L0GS4xdpqnTvgWybICAS+PhegXScut0mmtK1hNubjeHQ2Sf7IVRYm
`pragma protect end_protected
