
`ifndef GUARD_SVT_AHB_DECODER_COMMON_SV
`define GUARD_SVT_AHB_DECODER_COMMON_SV

`include "svt_ahb_defines.svi"

typedef class svt_ahb_decoder;
typedef class svt_ahb_system_env;

/** @cond PRIVATE */
  
class svt_ahb_decoder_common;

`ifndef __SVDOC__
  typedef virtual svt_ahb_if.svt_ahb_bus_modport AHB_IF_BUS_MP;
  typedef virtual svt_ahb_if.svt_ahb_debug_modport AHB_IF_BUS_DBG_MP;
  typedef virtual svt_ahb_if.svt_ahb_monitor_modport AHB_IF_BUS_MON_MP;
  typedef virtual svt_ahb_master_if.svt_ahb_bus_modport AHB_MASTER_IF_BUS_MP;
  typedef virtual svt_ahb_slave_if.svt_ahb_bus_modport AHB_SLAVE_IF_BUS_MP;
  protected AHB_IF_BUS_MP ahb_if_bus_mp;
  protected AHB_IF_BUS_DBG_MP ahb_if_bus_dbg_mp;
  protected AHB_IF_BUS_MON_MP ahb_if_bus_mon_mp;
  protected AHB_MASTER_IF_BUS_MP master_if_bus_mp[*];
  protected AHB_SLAVE_IF_BUS_MP slave_if_bus_mp[*];
`endif  
  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_ahb_decoder decoder;
  

  /** Report/log object */
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_log log;
`else
  protected `SVT_XVM(report_object) reporter; 
`endif

 /** Handle to the checker class */
//  svt_ahb_checker checks;

 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************

 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /**
   * Flag which indicats that the address phase is active.
   */
  protected bit address_phase_active = 0;

  /**
   * Flag which indicats that the data phase is active.
   */
  protected bit data_phase_active;

  /** Event that is triggered when the reset event is detected */
  protected event reset_asserted;

  /** Flag that indicates that a reset condition is currently asserted. */
  protected bit reset_active = 1;

  /** Flag that indicates that at least one reset event has been observed. */
  protected bit first_reset_observed = 0;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
l+8/mWp6ncEuL5aCd4XzJPujJT4LU3NTqoT+y2B4WJW9CDRtihlQl8eqDdDF7IwY
/qry9kRwWB6mPt2ly0jf7gpUW3pxThDz2/oixdYYtIjL0vfycfHZdcPSl/9PFySO
nYg8rfL+lE7WhDKYGBdg9i6l0ZSeNJkeRnE5lF3Zcd8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 121       )
IHS5h9SR8IDse4PxY1sT1alVxipo9sZhKpC9did8uPK7DCUNfkmMDvK9MW6ZtE3B
zq7CFrxj1UCsnK+rvLgBvTPwYVuX8ahXhcQ9FiKDy4Rxw+WqU0LJhh32kV6oe90E
BY3jTPEakbALAx6BjoZbQYj/eKx/kPLCfvDweoUAuAM=
`pragma protect end_protected  
  /** Flag that indicates that the dummy master is granted */
  protected bit default_slave_selected = 0;

  protected bit activate_default_slave = 0;
  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SnOcJJJXm0A+2HESqxdC5fciGegUJYcy2EKnGG8q6auppnGw+J7/3APdhcZk3Bs8
zGcqp3wIB84jxPvLIHY4jUhkXeUl9rxIiUTiUG6o6jUXA7Rct+tJ5gjFtOXk/tNw
WENpFbsliaKmDMGPJreOAHDXUN3JVWr4UwTuFEVB+7U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 244       )
bz5UAN5d2D0dLCIO7trOUQ+lXyS5MeE5mgjRbFoavzcFiru0IkjKYzehphEi0tXK
tSZM+KPypgn+Idi0r4dfs7jvukLANfKNBwzZWTkG1Rbn/KRLddSa2bngr7kBaUGv
I7sfcB5HFi8G/4DqEAM+QfWwmqDYlgWF0bDbe92HMYM=
`pragma protect end_protected  
  /** Get the address range index matched in the address range map */
  protected int addr_range_matched = -1;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Zz3Fqu3WSigKhkhS2ZwTOBtSESU+4pMXs7z2Krvc5PlBDr1TnAaqBGYhNKbETYnG
TrSox6BeuaNqO7GvsAokOrcWiMtIqLoCuKoGOj/f0YYDCX1joyDRbeKSqyN93LUX
XE002Ku/LYt/IGTiZh/6nCYIwSCnNDA2XsIomxy7Gr0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 367       )
JhsBux5d2zyCYlvap+qw1YX3byPZw4+OaA22wbuo6STVwH08JJtZY2907qBX6MO7
uWBM3aBIbn0VW5mbBuZnqfKmWtxOW6f4jtOZGv60S/8xGqm+QoROtmt2Gdp0+aMO
Iwyu0rIiFb5Ecge4E/uWFwtRhQNpxfeDoEDopr6dle4=
`pragma protect end_protected  
  /** Current address range is part of register space or not */
  protected bit register_address_space_selected = 0;
  
  /** Controls response muxing */
  protected bit continue_response_muxing = 0;

  /** Event for slave selection */
  protected event slave_selected;

 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************
  /** Configuration */
  local svt_ahb_bus_configuration bus_cfg;
  
  /** BUS info */
  local svt_ahb_bus_status bus_status;
  
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
  extern function new (svt_ahb_bus_configuration cfg, svt_ahb_decoder decoder, svt_ahb_bus_status bus_status);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param reporter report object used for messaging
   */
  extern function new (svt_ahb_bus_configuration cfg, `SVT_XVM(report_object) reporter, svt_ahb_decoder decoder, svt_ahb_bus_status bus_status);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Monitor the reset signal */
  extern virtual task sample_reset_signal();

  /** Monitor the reset signal */
  extern virtual task sample_common_phase_signals(); 
  
  /**
   * Method that is called when reset is detected to allow components to clean up
   * internal flags.
   */
  extern virtual task update_on_reset();

  /** Method that implements dummy master functionality */
  extern virtual task select_default_slave();

  /** Initializes signals to default values*/
  extern virtual task initialize_signals();

  /** Drive default values to control signals */
  extern virtual task drive_default_control_values();

  /** Drive default values to data signals */
  extern virtual task drive_default_data_values();

  /** Slave selection logic: address decoding*/
  extern virtual task select_slave();

  /** Check validity of address, control info */
  extern virtual task check_validity_of_addr_ctrl_info();

  /** Identify Response mux select line */
  extern virtual task identify_response_mux_slave_index();
  
  /** Pass on response from selected slave to all masters */
  extern virtual task multiplex_response_info_to_masters();

  /** Pass on read data from selected slave to all masters */
  extern virtual task multiplex_read_data_to_masters();
    
  /** Drive write data to all slaves */
  extern virtual task drive_read_data(logic [1023:0] read_data);  
endclass


//----------------------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QmUrnj7W+e1cVs4A2c73zH+hzitpFFyWYLzwnhNDpmSlaJTijzsW9Os3qZRZMxiR
Cm9ieOcWM0Cv/7LFmwP16oe2t5VQ1lMSJuqrUblEMUvu+ULMwmXUskZtnntUGFn6
ydz18i1ZrONoVFuLaZRlLYbQZEr+2Ryk3R3s1HKQCAA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 948       )
3gSmWuwFGf4IeHiTNDg+g1tLqoR6M46b5ZGYCb0Uq8UBFZETldz3dVIOa/9Qf9vP
X3sw+mWtgLKjCttdOpV4n9U/pmU7XI8fw0bATD7ENfoxR02uJ6jizMk7bpvE/uqY
r68qA0dMXzXZzyy0G3DlCyxYW8XTiECNYgv2qcsK+WAnJBkU8oS96TbQrnOp4moz
zfMWbE320u53+7zxPbd6JA+k542jW+HRgj2Vg9NHb/U+kCrtKgN9c06DY4AQjiek
efjegS+DY01GH3JrwxzWYymuy2zFX2ahbcuuytMzepuvQNCAaZ3C21N4xsAJQAsd
uFjDLcFEI0HItERBOP3t54vK+j+8lyQvonkqyjqrl+fwFSNbHcilZGbkw4LeQSR5
y/lDCsvR8qKSGV+j000VA4J2jbjhk94LHKHMoklPgwe3gpv6wJV0CIjSqIR7vqCJ
RZW0VjO9p4g0zcaEzurNBQhN5tixKbKz7Nyg1tqHcBNd+TLZmXsHYA2JefygVzul
a/OsdJ2GiKPudZposSM/1NjgkYb+T624K/tJDSQQD9blCLKhIKzhnVl7qTh0LvXn
b7a/fj7xLuACSdHOIWcK7Nqe6pH2Lg/Y0iQ3MGPWyvOzXbJ9jHK8k/pXjf/7zYZw
pra/fqqh4BYLa9QKLFL1cDbzwfsynweptTzu30Cc9iJQUu6FWGzIaDQVyvNamBBi
XWfV85DkIQsfstH2TOxcAlM9gtiaEuo7mTikFUdgs2xG93iHOsE7o2jD0YRvxEbd
UM8L6phftiphcEbRhITiCA==
`pragma protect end_protected  

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S5l8paL1ex2568PYjbO7Ex87iWc6Yu6Of3CXBkltaYzZIsUMrtMSUVFO4y5GM9RB
SObFjy1dkt2lMU4h57jGKrF0RBQFDfj+Ooqa+DEf6wdAsBS23YUspvKXY9xhmKuw
lDjxZ2EEQJUdgOpx+D69by7BvEL6HI4blacuOZHiArQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4595      )
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
`pragma protect end_protected    
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cDDqmkKkHqeQi9fjTMvKJRsVhPEHvy86lmB04/c32PvOQQHb2fhTqxXwXjT+ffNV
rnjLLxDEjmpOz7hJq2tOtPYfZQM8wpMPupOTq2Bn1mrLk0s2xykApbNBOz4bIPwW
emNsEk2fYjyyBBVzeLJIWmjh2u76qbJQuhPURkXnnM4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4765      )
qkB0Q1nYDf3ogreF9Bl/PmmZ+UzAc+k+lc0oGr64DNgJV2LBRCs0nKDvdch+sdvR
G3c2XYR1A5jW6FYowpMVe6lp2+mSVL4qy05dyPTTALbgTCDb4sALZ6H5ubbnW9cI
YyFmdDc9hpU1mo+7u4dTQXuFHHOYzEnc2+pIimV2baIMKW6DnFLn86Wh9/Mfgbiz
7GV3kgqxZG0fTnJTkAFDCKeFUuHEiRO05W8BKYDC378=
`pragma protect end_protected    
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TntaGZfxKxofCg4ZD6TTgiQyjm0ObQuYhOAnBlwgjjmbSKA8D3YqDfzfNIZ1ChM2
JywUKRHKhLfidDnspxQYUnddoCq18tE+fcI8qxU+tszzv/S+vpnjibjQ4l3k7gvI
mrRTpnIlV2G8OovFr2X7BeA3XkYfuWzUSx3L3II6/ro=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10365     )
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
`pragma protect end_protected    

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AG3eaNJXrSdp8m23lIrrMxCBsAy/F1F9Kp9t75nBhfno10Wr1uDZyuvuPexlIttG
eQdWgRjYb7BnUExYILg9IUwcCke4sfgbQtgAguW9xLSwluDlvVz9I1AMvK37dt8j
BxOaaSchU1nr+j49jjAN/qzEapGx+1nrLp5iQJJOTyU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10609     )
EbTNppJDe1JYynEqFJ4AQgJoi82DE/gJQKdPPz1/NGajcZjnDg4onf3kxEDo1esj
DI4NjaIYxCBdJHDLiPuteuFyzcpZIEh0O6PkUvriz+IT7MIQ+bENiR03ZvAZAvxl
7W6WWgPGlTYaA1zJekU6qSGplrRnBp0uhl/wCjQ7mI8pPl/iJuf+A0eZVyqotOif
AOxdchCLn1wYnZikXYxZ6uygiKvOIV+sImDoc9IX3HijY+W1HG43Ri0swtcexdXz
TeZGKoalCBgwZQJe3xEVb8Iq1CqHFeqRR7KG458zUAi6Te1qsNJMNRo6pTnirC83
su3RqLc1+p1p1yj6poy26w==
`pragma protect end_protected    
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UJswxBbX5EEC+Dlna7vvGl5CVKlA6Qudn3Yjqhy0csYnIhTqN7vLO5BC3RBOsXsG
NQTW7oVmPb07QP3BmyGTvXX5kWMPyGFn5OMdyNINV7+XAw2WE+lnLTSFnMVnUeEj
LUZ8HU838mhAaOXA6btkPzneRDJZpgB4YssZOo0WnIY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24161     )
U4QCpgpV+9od7KJ1lkKPRODPp8zCm205WaWdXEWAPilH7GI/vrHOMIDoYfgEXbvZ
S6BrEzIJhk64BEVWsPJA9sjAInKpMTVxeeQf6TYL5DL2xJ2fyqghpEOeSe3MEcD3
VL8XflAK0JdFZcWSCtrif1unMIvFBwE1eISr+DJ0nFRWdGjluanE57bPmNhbkDiX
w57xSwF+LDjTe+3PS+Ih2keS7mfs9nvLM9tbEXnlqlH6hM4s2hJZMie6PLqk65QC
eJK1F4foiiPzBJaawu/KjQXdD4sHc1VXGWnfsfrsFdHTnWabjEycnl4dMT/mAF65
W5HIwR+UpFbWqWEUoqgdR4dGGya9nOjzx4o57qxRXsSYSaXjoyyt6yWVexE4y9AF
oTlwjmwc8WWXDbSTrfUiDxlFdsWiXW8gZ06glLYICJpKi84gf8w+kHIHFdIXkV4W
1fYkHyBh7o7NG7jtVsJWfV/JsnqNv7Awh7MZDDwsIKF5xp5mUQO4PwqFUKxequCY
h3JUZOA27fU7Xx5+gd3R9iMaU1HMvzDfg+zjDUoDWol1tKkPCl/tDMOtGHVLw8o/
ZZK37HWkcSKL9jp52ejIc/2qV9g2S75cdbPrhHT0bDslI/+DSJiXBaK0tptLLrCw
WN3xFHSBSnyL1XImZBmNE5A+GbOw5Tqc/8m8ZDysY0YjPElxBit3G5RM/Y5MGvnL
lUBcDxwqSUMXVQhiWX8kMMW8L/rChrxiMzOARVFrNf2lSA5JkA4+YoawL5fD0WvL
I7BkbQOFakIci804Zap2XWcF9LcPb5IiDtsyDQjD018P1fFvJ2CFg1+xRvKQJe04
tboj3gQ4WF/0Mzg8kh71N2GPbwYWDbZCF3jueUMKLohDceqyjmqaoEAHdv+P1n30
fyDe1/gseLhxYg/OHJvKj53c37rmRZEG7tp18A+NIRZxta8wVrQv7K65mdQQkyKN
PLL9KPoIxyJdo6kLxtPcRTf310vwsuQ/oMqtdbflrvXf4tC0BEscUqfLndCt5Ac3
VaYN+rw3UmayN0bDFez75TZ1/bQjB4AWGaOtlFczC1H8adO9EpOFERcONXVtfW/9
BhCv/pFXPl3oWiRr5F0UF9oYPZa6bf/dT7VOxu346HFPcTnVXOsLigjHxbIgBGKi
SMeQTwW2IrvgDq0Sfrud483t8VKqopz+8NkwRU7CnQn6YIKf7oz9jHwUp/HCCK5b
ns3Tlv3QJwYVa5VHtTt/YuaighhWmO2NgFxBR7RG3VFUf0Zm/R1KxpEgEqmnKjcg
eF00qIpZ4ubbSj/+ytabG9wLuzJ03e/LcRi7N4E1tDfQzPaxI6QoZIPhZiM6hvNt
ysjoFOMT7y00t/Xf3FDWTP7UBITlWUEpqMqFVqCQaW5OlK2Ntwm0ZNjH7e/qQ9ge
tCVYjUkqRQbOkWmSJ0dJWXlKAu8yDXhEQyF46Taw70S5o+1YnCkN6l8BKeQe6yjJ
34AjuON8HiK8H+BR8ezgZ5H5eY/Rli2C9303l57NNLzBNR/L18jd3V5mTuiPwEFv
v2tcXpkg16llXsLYRfnLij7xfzpO+/EXl+lB4SQeLdmBxBLCVaKVsKy4mCCJePDU
LgtuhELjqgn8UhAagkEuGjZAaoKEbNCqBL0l0VLWLJbZuvgxLRy/kJAeucIPMASc
DX1OsoboUcJjb7DFpafEhyaiHyNQnXFCemnPltHd4yBcCwx3FnfaQrCE6CAXBMxs
KE+4ZTz4M481XoZkSCEDxNfs3snYWwEnWENPMjtXN3+zugKnA/qP6tURDPxrwY0v
cSWkR03FJqCgqAImQ/7wMBDPzXKK/qs07ie+YGaGlQD6Pnppy22BrQ/phj84L3uL
Zj4ipg2BWeSqze1R2WkBxXqLsN0+Qb+82+LkSZWi9IJ4qUevTQMxLs9qk281qtou
f1YFSrprXPhTFEOjnoQAJMn5I0dYP+ZkjKu3xR8Nmh3fZSF3D+clMmfO2XmRC5vb
PTfL65zkG+9OnW4wmalNra/swcQreqWYoyQmXTB3119ibShsjvkNPZzT0156+vLV
XZLklMtMHGRdVZGtqRSJn06uucM7EZKf9hjolXU8i0XyJOmnrg9hwxDluP9USxHx
fHHwk4NxSAgxkHznUEPQVqzil1Jct5TXd46V6t2LaUk6nechRG6FSL79i/yX9vN7
0kdbyV0BEqcwyXCbKYwdLMuv1re6V7mxaZSkLocNQVYXarQtN9qTkwWP7xkkq0az
9BFgsvv7hcarB+19LqE5vcb1qPxtfZxlfH2pTf3nPJc7CarXqQolmp2eiZRVYrwB
jm8YflRmnBxkMERxN7T8kx7GShHJ/5dIvVgSBxJFuaVH77ZChtewEfo7LAndJLbE
eSg4DQxaXSHUwkXBPbwWM86y7vBETYi4csY8oXRptpUNw+Du1hmhQUnTty/P+au/
ROn4XoAmE+NjYi2UcIDg7D0JvIhS9bNBEFb59txcbvRBoLlHCSGPpan3NgjQ6Zx+
fsrebUCUyygFewTphjEHaCebM6zfqjeTcnidbMVHN3jpz50WfNPHD2W6iC5wry2Q
3DdFAQzz5KfkZzeZpr7fgqGBDpQtR1y6Z9thcXNoplJFMRTQ4e6o+2MzbpcRzBMC
HqBgPSMm+PoSnP1+3/zcEjn4Sh58Pfh3Rq45oC6Mx/JsdBP3J4U4SMLEcxCooHyv
e4ZW2Dht7NfM18fFxa1gFNkoHIYSojztSAE24zZMFJz/adYjzxdg9UqX7F9Nxl21
nSGEj2cBrRfl9SWPgpXBOOePY+SL32XVbuQXkHaZYgOuSMpoPYt/Y0UC1QVNDcZ5
iYduyBe5P+3CcLo9gGz38XLDMhjYvxU/hOLPmIMmdkXFL/OfWpF0iYHPxYhX3u+E
W8mLXOl3y2D+BhhJNLTe77SoAcA1lWeoJyJqlbKR8zYh9+fG1zQlyVmsSwjsv8X2
1XQrr5DUelz8WgrSC0cNKL6aVgn0lZYSK5QISpNJX6qEtARP9YrYG96iqYKfWGLW
zh6L06ebqoTkqfHxVbj9lmz9hgnB/uVzta+jxGPe7/TICX9q/j8bM0IZtTSlTlcf
QGmPKaZUqjwUazTemGjzRY5xhscREUzW7IxkHV2yjU4tUnxMsduBp3U/fn7zVNlS
qSdM6R3FUeCf3v/vrNLsrW4Fqn/9xDd9Fhb+YHsgp64WVU97HP6AltEvwft3T36j
QuBr2aSt6BA9FizHZMoa8PGBOWS6bfVhswTLI2hwL0KUJ6WEAmkwWDVzi5nr1AZP
1JrAQc9wunYgDFxopgQfr1+AHvkdwOr3tMBtunl5qI14mZe2HkG2aNrq3ySM8BVY
W2tz2UaJiO9PMkd/AsSITPkHHc2+jcaHqdI7LxDoeM74AS3ywiqcV1VkuvFIVuWh
y3Zy2iQiXJ7HJ5GV0aie16ZDnhqeJVktQ18L62hVyWvpvPw8Qn/DCjzAlL1ubTBE
SdjaD9BXvJ3sR0GcGZbOxqwfBWBRov/vzDP7EeF0nlkERFGaIDnfm07R0c2l1gkq
UEs4sc7pxbMfolPvZxkJ3v+/lNRqEcV2FjguaIRkzp4cjNAiOpX3ozICSgQ5THCK
zB5xqHwGRcleTCswlHcuZrDrItOFVbCJ3IqzFKlYvM2QV8iwo4aVbuUHCHNlMjar
KK9rPDazAx52ROm1Ob3qhX30bkiKPkNiqZBqycOhutRwqqJ8PRI4Kau808S14WHe
xRSm/l7dIdmx2T5zs1rE2BuVTeXihhbSdYNI1b5ntoM6KPft7S4Sa2bR7sy0N41J
mVHUuUFL7hzGcwgEn06uWnDQXtDu7d+56Tkl/BQ2uGgT8j8uYE+5ONS+Kww724s6
/NnZwdh7YTcuerbizzjLet5mZy3iSQtQp1nVCwBoLbE0pL21ays3KYKBGbFMZ9Cr
2LRfeFnhByt3iVTQQqpHYQl0XK5RflyPFPrZPXnEvKk+cgAh/EDSjvphdvdT341e
C7YFoDlrWVPCv7viCVKXtUXSSlsLwwAX1DpPTf45ye1VXuMfdA5ESs1VzH+piPH/
C1vATdV7F3nBpn6e3nCPnEcDTBQPyg+kf/XEM18S83BQubbeuXjYwJ6QGJYrPKKW
Tk8iB8Ccu60dofGuqDpqc5QpKQgjwkVBIYErqy2OwDBpgq2V6wyy7fAEFeTaUXpX
sjHY5Msn9iIcQREA3ZJ3L0jZ8KU2mYMR/0q96gYyTqzt5Iv912ddxW/tAmWdoOD1
lxdiLF3Z+XP+ugIeAESyi5/geqPHGcDgMaSQpfkBw7QATu9Fb5OG7/08oeaFS0Lc
3M9cE4H14InhlLzq/qSWldHGk421A4d4D72jxj92MFDqtzjPRLKfxh9vnc+VzkGS
fJT+jj/htyvYSiG4TihgG+9QJkb7/1Sq40pNL+OqD3BJKr4S/deC99pjwSAsq90j
ZN7+Z5x8DpGS76paL09ek5sM2N3SHEB6Mqogxu3onQZPq99zWl+oG/3GH70398bt
RPD+wr1Bx6nE0qPv2CUceXBwU0VDv+14NVfmhnIxnSywvU3BhJB+zd3T9py3B6dw
H0Dyoni/knFuE2+BAco+3Bh7IhU73QLkaeSXHGl1S8OOk2S/zztdxgXVUL0Tfx0f
zyB5Ee7iP5Q5OceMeoH6yEmBmJmhskKZ8kUYMu/Nf1c3gasX7BkpQPsATqVHG2v0
JnI0mNal9K5TDvsrInYxREendf6a6oUoL4woENZIeArDfbruTwpYycOibO+ueSGK
4YBAGlYNW/fHYChHJA4xSSoC1fKVVQbvlGtH+RAnrZXv1z1L8WWKaRDM1zNmAWxl
cBajAjX9Xlch8gwIXB5yv3MVfNOxgpEjqJCcFQjpQOPgkXPmBoE6Cf1DzaZKmpVu
419RBPu8WkKHwAjc49ICN9/dG5BQM85dwJv2HM62USGyMWI7Fq4ur7Dfg0AMoX63
PpeTrKLZMIv0jPK7gHo9Y8pj6nEZe1Wp+8KGF74/v7LrSno5xoxGozpQR9GPsed4
sQH+BnNcissDShGhCR/R1e3nfN3j8HnNnhMlKardeTb/GH2usMZBDxBPTdTqODTN
07swjTia1+ri9BrqTNtpTazBp+Bh1CcDUt5AFNwDLs62YD2n20ujOk3lh38ljDDm
mwlaEVO/f6UqE0ITfr3Cb6oTWjEscu5SCMn3FnAouTDyjhGm81pmsxH1N7OntSsP
Dce/5z+NYI4rzbLZekL2tARZD2HVC/CImOXeLhEU1kXE0MfupHGMBLJ8hweY4a9V
tjTpEsMrMp/Zp5wKPT6+Nx7O5aGN1d2DPXioLrAp2hxf3nHgH0TKkoZbntgNJG+U
fGw2vLHHYmxuOLza3oYC8Cl2rKTxsTwgX0HwmmRbXNDesPWZ2VDLcgQX/4mfm48c
Ft7eBBhI8aN7KEF+KRfFgdLROFIW1uhvZG7AX5tswXefJq3P+Cz7YNlShK/3Y3zX
xjFL06+dTitVt2RVI/bvbTXqRKHtqpdXfxHYWbh7/KjXtQtJxtS22yLS2tk2Dwln
0IvWjDpUfNEmx9UP1rISDS1TsAZ5hVThA1exvSNk7h7je/BTuMAZ/tPb/ley24Y5
aE1PS8S7U3Zgu9ZVutASEgWJ0hFEcY3HoaHOGoQlfnUSnIDSKWcxuo9DtE62pUnT
zWe1zjXwESgHMRj62jGNcoVMSfVHTVHG+aSUFw9C0/KkZAds6ZtFm6HNne8qSNyD
wJaem8HdbmLly7MeDQI9QYREYeMxl/n6WWaA3gfrUtS5pQqlCrBOiGyq1/nJnaRZ
g849XEh3XHutq/nDJPWvLrZ47/Lhg3qOot01bCDeuwWlU1W1GNXkcr0W2DTP88Zz
06+D5LlwGwBtNjrrwHtE9TUbtrO1PnAKMdD8JbwhNm7Qxi+LnQ/j20QZeXA1kSL8
l2TWA1c9ruvi/Qp8NASM+4Mpab1uRgD4Mv1hXN3Dk91HRiw4ZOqdZ+r2nEgO/SMi
mSWgUf9LEkJVurf0J9CMSVr7xh3wPjArHD4UrqsvwYOc63g+36MLPvEljqnhuV6b
D9QmTPHHXslIT4nifxxzvl/n0sFF7R1axlzxnHw+GKRnXnzlaCTa6hbxcsyP1/xO
W5LnC8IgUcbMu0VlzMmPGJJtesoBOm7zcEw+m5mYTuvNZYmONvLoMZLhftixYcVo
T/TOIYHO6f2kZzYkMMxHC8ZWOiABm0G8tZKcqEJ9Sw4lFcuH4zYQ3Ic8Hs19+8RR
0cklNxQA18vKTRsG5Zgg5pUIanNxE63b8H+MuAOjlbWZjMo3CgFv0n5DF3lj4cZ8
PK+gAvx5Mt+K4aOzOlomVy2bkBHZmRkv3M+WbjsNttsuWyIsMDrsETCb+76HsEKf
SKwf/oWCp7G7guoZ5/vsu5CdTBfml9hiXwn+dwgf6ET/bqxlEZmS+F9LXlxi+sqD
ODf5avccOrk7Nd1J+QPAuWDreyoVveOORjYMNRuNbrKNnPeMxbgaWyRPfaLUVnyZ
Ixxy9uHtmo2PIBNyzHHXnJ7wtD+oM9/RyLHn9eM2Hsqwvp6p+ZXhd2GKkL+tlyks
6MyDFjhrOiJAi4EfrupZCqjmrR/A65XdE24B0DYmY9Dk6cc4oxF0GCx/MCB5D/IV
r293KyQVi0i+e9XDmdZnG3+kr4hx3cjJZk0HVgZrLdzg5fLrWfx5FoR1NidIKKjh
cljP7p11BoIZnvqGgU3h/WhzcK647IOEugZM/pG6FkEWpY0UzbgTmuqHy4WcnqFk
v/T6CDvbNS4xGK4DMZ+qXPdxzgj7U8X2ixWRtD2a8GuyjJhY59GTdIjQOnntkAd1
O5IiRHl2gpHQPVfn9u0sXkFX1b7g/KbmTFfpkz6Xg3igM6BKYhLNa3zTL6XWbxDJ
t99IczdOgAQnQ/GY7gJ23YnYB8CQmPSzSNP0t3VbfkUAArT2TLGN88jSuQffOvhR
7ff16Vap0GJwiKiLspDDp1gE6cLyLX2KXgrCBDEm4/XS+ZQTMIJg6DuGG5w2N3U5
FZeY/qH+AooaH2En+KM0m7GcZ1CExUsG7U1O+kj7sWaS2++fNr5Sblphnop4viLy
KTbT+xUGVd5GB3pAAB2TuqTrR3i4gxGNEe8oW/7bs/LfLrKsSzLJfqzaG7XMHxay
217Sd4GzKPcfC+92uFuptVtOp8eCStXq96jfF9tnREUIbKvGdqI/8Uh77kLyLZQt
EQXCQtB6QE9+wqOJvZR2q7beGUSRqiqbuC+Zv1paF0z3g58hWcANcidtBoqBdp3O
36sLaA+JO0G5rR1CSvebyeeZnrMdUtQHFEgMZjJ3CsvllDw44u/4LT+6vzkaCK/I
ibiL1sH5a3OcSJOCSSqOK3dFXfhwUrtDJS0RmlO0ORcRLZNjTQleDzd3VAxH56it
Gjr2CACANtOTUJrISblDEDX1rU3tPYxdMMVfxeHy+HYf4wArGMamxu6huxRAVjCi
tjzp4dx0WffTYw6eXUJ3aM1TwFkvNiqzEhw1pJZx+OMU/4/q+sHTfDCE89kFJnw6
Abx4cMl/Dj6nVhzUiPuyeNmHelSl4UfgiiYGwhHx0G3ctN4V/xKOJKD27hzQ1phx
y84wneeVwkBOLJPWrn37iwjai9u82E81fYn0S6zRjNmqHxDxG2RxvUik/kUav+fL
HtjMDRwqSiIEfyFhtYdA736XpiM6LcS3njquhG4mW5sD4A3sST3fIld3H1+CV1RP
LgfRfgLzWgf8qgJPmhgLQZz1xPqSLLYhqbO0uUgDx03IzXSk2aqQBSjrTmwM0WQm
3l99VL2IKgZVoM71zwACGaYClR+fsLE3isyyiammiIRTwMH2+b+HKCzePlAzmADD
idYoFMStjDebrff8fWzoc8ArDx2j1mykr+1/6XMN5022q1v5OapkYBjyukvhDeaY
Qt+eRYQpmOlmUfS9nSmL2Lo4OO6rlKm7dh1LJn8ucKCJAKpBlWib0NAghKPcrw8T
hWzLb1JebMMS77NSRpsnS/01IPTbRi0GRsNwtfaV6VbGDORK1gwlkE37mYvvkglI
J0IIJgFNps8L5SzaffxCl+7mXVsAUe0dD8t2UeN2zfdUJEIJonbzGXGuz84asrDb
cEnjOyn2uVpQuW14VSPMIH5m62T8v5paH7/gs1MOcxUNL4iKwKb960C45n++EaVr
XvQnn7UOGGURG5irBaM8UuCOJ7vzJTGACLR48gOD/NfjB1DuNse48u9DGNg7P5yW
t/XDv5AGmH2OtvWsHQQlgQi+154vbgqXUBzRyFhFv9W2dbyD7Lx11yZdA6V0zrgT
Dp4IdrQlv7e8XGe6aA4QyBeG76HWP7sQwqLCBJWpwJWGhixo0QY7kGGg+ShdJ/4T
gkglKCgwR30L9i6lp1pBKqXhvZTWdolR/nRqAfHU0D1bDnsqOMi2ylhSpcXyizgp
kWdtDNLihibI+LWz1ymeedGuSNtmqbG32B6nK374RU1VetByt0YT5N6HpVgz/LzS
ip+2YF+hwmQca4LKs1AUJogEE24OMis6EK724p7CNUNpvTIJJaXM7Jetpus5ivog
upcz50cUA6dE9Mxz1J44WR1wt5cBJ2lVl8ZSe24XEXZv4l3Pda9TSdqV8vaPZbKH
65ETJjHmNAh7uSN+AIYBDtx6vlQ5N/RF8xj0g0Lf+WZf75jzR3iPTxY/ehgDKneF
DvIjO9hUtOG1GEOBqiX/Ne9CimzV5ytfxz/3ZYuvpwKV8UVmlcXNuU7rmA/tLL+R
TnKuJVuxGILvJO1LxXbMv7GEp/aRqkaQi4RvlknYUcPDz0yC0eqX+yy/t0dB7zIL
flLUg5HYwDlP77mL3B/iNCW4N6QZqs+r5DyvsmqMNE5QMFbAkkh6QOzee7NS8xIX
8VSzBIYuhs/gagLYNGuRwCwRMkpoWX15ym77uf31XbVUdXchw6Erp9hRr9dAwQZp
qYcYVIFmxEudeudHBAl7nkWqMH6h+oeD34zIV4JFzq45kCo1aAKFVD3BFTkpBTYg
tNPgAWfAast/4kQZcnHR8LKB3yee4Csl8golF8mGjwp14e4zSfS0/mzNBwZAH9eQ
F4zp7rzryPOsIZ74WRiW49tbNzCQLM+PgvY+qeMkfLe3k4l78yL/Myfq11IczzU9
BInlGAdJ27s14XfrhhyrjQO5B5hBBbTvpf5Kt5/kwk2mtKWD0hxjRjZVSkdtxJLW
ESbr9d7FWsP944TGE/7puyekeZLIRGomdLkF9hNwLwIJcdyeR3Xwy2D0j+tWt4yj
KmQsSrN4iAZpilKCqxpKurChlC6L+Z2Jpv2ywbb7BNVSn3hn2vwide2ZUg1nQY6V
r+i4D9HeTo5uhwX9ys2jLCEM6AtqDXdnM3zw5yGGGv2zTUr1oQmucqP0Vesxelnm
tA4J4xrD4n6eyaTPDsfMS1zS1qkYBLzftc3nigC2fNzXwvM0666qdcsd8YuMIkSz
seZPUMdqtC3saphCzpIbczQJmjVeGY6U5Ci4VXB0XvjUiQPcImEOfUDYKtxXCJqI
LWVVh4IbxRFo4mkcrCYfe2yIBzpBDXSikKopf2/WkiZNylK7EKuLns//mhQuZN9D
jEctd/aHKuCnHX2UTaPSQD3BG9okeTcMvg+Ud+HHqvOJa78Yc6HuZ8b2l7/6JmVs
6SkMiZZNKzACRfe2IhKyzUDCvNXsJc6D2d0Brmyykvk31ZC+oG3fugnkYrrYPit6
FIBc5hfmc6qi/KgoCSPtTIsp4QNpg7oWFqVpppLPOR3TPQ3rOCDaS6jGGPvDzMve
17LhY3MUjYB3fkRdAZWhFrhOjxQ3VANSr6KlB38By0jifx5VY+HA/StI6hOX9AvN
9J44lBIBY5M1aebfavOQVNfCm+KtMrqLT8Uurrf/gfy6039vywlYGM4CwhGCG3rx
jsuh44Spe6A5yXAKRIlZTl3bWKoCzBFeBvPZpDR7cs3wjb5P5+5pIIA0D6Vta4l3
WtDI6sA9GGkn3InXHVIatSHqOL8OQKEedX3Qzps4qRd2gNzIyuOSbJ5TIYXHEcGI
xflNCv6ZKQy1YkOE7WxXWnvfAvjlucAsoDxeQKif5WC+znimKQRIdXwBYfXh8U44
z7vwdMAJuhGThkyDHUmhunzKdpCwoZ0KseKSdPUkLduIWdfd+Gj7Vu6HLGc8bx8c
sETv27Vzm24+mDLaiNy8W8pYvYT/00K+XtAzSrUA3d0zsb1NtwoQu/iFd1rbM98q
ttU38BmkR2Fp95S/TjYoj8fBXzoZJcu0JIsMazcGUq0LnUxRkffRqt7ZI7HBy4QI
yp3tEExsfi/HR6FUmSPR3mK9BBwQjLGpFTIIj6qWTkcwsC4lJ7A/D3dds7LxYK5o
xeTiBPYlSWUiGHqoxp7XjZ0YL73+00rgMBGnY6NuWVCs+it4KeF8+l6Uh3MJhRvx
BVCBVBZA1pql8VOz9nsP/6PIyFKujAe22HBr969uhYcqQnKZ50NDviZJsg5D7/eP
5dtcA5suZYa3bEtm7m6sh58/WEdCXUrEhmn0TjaJr8PTvMSk9K0ZYaMz60ia0hMp
mX/GhVx9Ifk+wWhdSaVGKQRi7CkMo5Xcp/N32+UZ426AsRlnxy82O6IYEi1jSq3f
hKVaQXCHe0Ri6rPJgzHYSyIEN8IWhF/j1tW+tOsvIji1MaNW7dJFJfKMCmFzk+so
RT1itt1REljVC6+/gXs9HaigOkXTWa3WkS9BLu6aFXnDJXwQTvQZrkuk4RR2Kqmh
J2TpxSNaODRjdp+DKkSOgMhx4s5bri/B+6JvkPZR8Aygj68GDNEyd1MAwVU6UwcI
xpb3GnC6Crm7Nk3N9hM8w9iN/Ps9Qwd4lNa/jcTf4Qj45qbkOOLkCb7o+zCQiGgW
cbA65BQmgYt/GgzZ58SDmJTrNcV7GQfNzBOn3rVUIDqXo1dDPEEYnEqxW6DO30Q+
MHclL6Lao9912yG9otYlvi9HKjedxBVD3Fgez92Wv7PNLMbJJ3t97kSR+o0hVOrY
rfGr6LoE9T1Zxbmoo9Z5uFdQE0syN6ybBoioCHdBD8jxfH0en4RxOqgxmI2ZZNCz
kENuSVYz7sbwKv+4jnAMaCJxWWZtHBXqSmguBZhvcNNRF6NEtu1mS2DDA+guham5
vGMHeoDfFrOxjdLWSmxPNb5TE+TCHrS8cTIrxEb+vMajSP6X7WmdMgRIQJafasRa
pC78pGSQIusgc+gSQddt3ccE5+4Pv43hVv66bludMdC9q+CE1OeYvQS9IbTvntLL
oeq7jKAM/Kzw3FGW0pA4VGLeKk0oh4kE4TyX3aaaS/rHlMRy3EG34Riiy8vGTMhy
qcOV4wCKwG7vBqX4pn2K6Us87QdXdCykRLKLnU4CzI+doQcten8O7a/HqcH8E+oL
szRxTUpWiHdStGrD7tDY1v09xiGcI94yq/LkifQBAtvkNDKz7nj6lARm0LHQMJ5Z
/FMYxPoAXy766x01QW+R3bX3FCcAWHhVVaECWfk4du17WZAbuppKb1BlO6nDl4ov
ZGVO81CtuM2YLwbqRzVREWAwWFbAkiHOFZ+xBtBAQi9m0uKf+6c5b+NdOYJBTsKq
XN8FshJkWFXGI4kUdUnW6J0G476Mf2QbeCJI/rU+TVIp8mtehkQmgRgw6/EpvEaF
DAstSQ8Ms7CpUuf8G9fRi4J4iXqeVYUV4bRrPBvYIFOtL7UYlx+CAu/vX6H9OTYZ
TJcC7tFAG/Bg2FU3oI5RW8W9N7js+9vDAVQUEve2rQh6kU/l8bDpCgGuR/fH8nXc
dRnOXJGk60qw4ioEnq5LArUnnI3ijoTlg8V9oF3yLwfnFuq1X3/dWKMm0LPFsjDZ
7+W0y3rvEDnZeVd5nEEXiXrflKA4ogTgwQZKETVy/KLoEu4cOwDHzRwQlKY0QDXF
Wh0to2vc+UjdavMn6p+KxdAYHHLXRqDHQkx5gYSph1Kswy/FKcIKL6OpUDOuu4tg
MnSedaH4No3P4243sYzviEvilx1UsveyXnjk1s3XBCU0q7qrMbWI81wh23mSKaZR
UygIoyT6NqUygOsRpJnRBeQ6wQhEBq5krK/m+Ft6p4DRxtfh38YyHbypJs+1ZVaq
hOYM0ll72VH8tzVMrgW67fjm6WbLDTkGJ1m60xa9V904F4OGgtPBhvy0GRMR0fxx
Ql+EH1fmVap6hGy4+Ifm/Tq4F/+xRbgYsHf6NKxUKlhztczyUzxKa6b6uo75uDDR
7SMJKOGed8BJQGa1hnXMcHGs15J9k4lejW4r/iBNRonA6+VA2km5IkbIfhzt6Jji
S3nyy07xpvzvyVQUixg6nViV2fJDwN5vhu8VIgYYJ1vsxIDa5IbB4NGekWmaTbSV
odGrDiJmuu6gNlm8TwhpSNwfA0nWr5PufkcBp4mmdBCM73xr1FgZUBJA3Kxz2RNy
42WNwfoFGSaNqP0pNaIu3DNb0NnIQeVw/07LPEgseLtF/yKLxSoUqVieyowNWJXF
izFXnpIHtBgcyA/raVbfaDRebE7HkH7rf4jmvbrnGWuiUl/p6GgvqiKvcYBjvkxY
SN7RmMPTPVXl9hxo+ghAHG6/7nihbQjVAAbrj8L4m/2VkkYL4EDpH/E4vYRfImoo
apT4BTdN9SeGXWeN9xM5Abv9A04QidZtGJTBOtmql3yOCTo8FEwGW2KFd1/6qUkQ
gf8TQOG8QP+TfmFtVmJHjSA1s6DHMKj5K7cBw0n2nbD3ZGzvr0zc5uv+IJwFch45
wm7w3ruXAEEeDKEJh5G5/Q1yf8OE3oijmQrF73fs6M9k9DQmTbBVKiigHyrPnbxQ
N0jHKcMVFJbNpBzZtJmOy8N3hrnUfnMpRc6GIahjegJMgiHLWjxe3peWsG/7ewmh
MsZO9kh4JgHsL1lojQxw5twLSnySSsmD/UFbjC2zUKOOy81WwEpB7c559AllGD2c
6xUeoguOUolar6gG1KGGk2QmMfQw2ycvairH9+PZFYIokIjUwyer25GxlakJMaot
yjr8JBo1MhnPYg8Yj7LQwb75VhI2f20IS1Nz8b14iXAaFWjieSwygy0hNHV+01Mz
2ew1W617DmpU0SeddBcUYHkziW65ldutk2HKKWBjKknQlhBp6IAn48kSg1yl4KZR
yK2JK6zGWldUI4qLC6ZxUOXoWxSe7ROXzx/6dfGB+37kYoQEgSosa/Sy7oyJelqL
8rqqNZxjzN/vPlirmulFeyXWdf1onW5R6KyxpMPChqhlZ5Mg1Pv9nZsw5TZYTDe9
8em5QS4fMcBP07tpx5gnHk96jP5vEXejioBi7yu4BtiY3o78NKeNOc0NMCMjdtnq
GhwX1tNasfp1Ov36G5REodYiAhcLi7r1uyEKQEsaSH6u59AW05CB2zFmS4WNK7P3
+XI1suRd8hwosM095qlXQiyN1j/UFrxi0I8hJx8i8QiS7YDJVUKBL/t+QkrBNfsx
U1csEtVBrZP2o+XYgWE7zohKMbvTe2XXCZK2wUjc4dWg+s+LgnKLM7IIsFhmS4w1
qUMT7PsYkqb1f68lAmlp9+sFpo+3HgzdvPcupp8xuuSiiEHOxWeQo/DmMul8JDx/
d09YdDDmThU/npSqgO4Z5bh+0VMBa4s211g8Yyz3LC9PPNHZJgHNeLQo40bUXB8m
2zfRW/pFTtBpw28gFIxKpu/86jrpftqcW9LFM4Z5n3yWhc8JCY2A4Dswpm/dZuIe
glIsiku0NXJNyeFrC/1qxLDDkTK2oBCLTmjdZr8C4wcPzNgn1Xx6C9hWI95A8trE
el1SRN+2/LlgdEnCSlGgZaYsbsqeJVGj3DNUEow74K4ySfgv3gx+pvJF+t41dEBb
F+W5984AI/2oV2V7fHygCGdZ5a6a6VhHaED5pSf0/FRjgsR1hjmTMDFYGs2E+tv3
BOiIwtSugXhO7P+Dx15VmNM7Prtic+uISXI38mtDhaiHDEgjEo8dctOXXfJ7D+iA
s0ks6j/6XBBZav7bNlavqlL4e92ZAk0cOW2SNfhr9DD5RxELW838QDZ1W23dcvdA
B3I8xmz0EMSMqgQZUjhR14kT5UdZpFiktF0WQ7wpAMn9y3CG9AxtNlajpTzi4PYB
xNquRbe3bM9da6+R29one3Yz+ua54Y4elP4P9NIUJnbCtVb2wlEqk6dptnV2Ca1S
dmdO+zyT0BWFvAPnA6Fww9SkNv7TztDUjoyuCFQh8E6sgOJ0tX37Iy469oipOx9C
IP3Jtn8jQ2eAwkbLIMStVYW3vajb0cZqdt4klrwyfVhKG9yOMRS3psgHzsaV0VjR
OEbgwfpAePtqyFUZHpOlpi/bR+wpQ8UwawTIftJ/2QGnXSEm0rmu7bZfC6vXEcUC
4kqgIMsWwJ9dIQyzP3LvMNeDUP0LMreYXlGZk6ZPvuYmnWf2RQPC9Ymx0vgyE2v4
+kNqr31/ZIEgylpo9PhX1FW3ROmCj48HX5peDgSUCTpbouF2APTfNC7mTRPrwhTj
ZVq1S1qXnI7CGxOFHldDkBrUPLGT9RyuYeU0qO5q+j3Hpmuc09Vx9juCcm8NzwD1
dPhwfiKpdjg7Y90kexIWmCOpkeRCKukaUbWZ+ipdrh6LxkOJqQqPG9jsDDlJZC7+
F7UO32ytF8F2uo1prHQPOEplhDrR9nFwLS10dRW4/kxiGuIAXIjkGLcLqGMgbcBU
WZ9dyugLpDG1iApovzKPNFYFWXF0C4ImiLOm8QnN7cKMA6G2ZrWm+n4vZkhPIyiK
hpatm77cwBB8hE7IqcJYJM9UO0OZCj5CIjCrorKL07fY63woyFoiLU1KLOTx8/kn
SgmsIUt/krTdAoJUpLr2CP7jmxtV1zDSDdFEVEtENsVtLS9wZg8v6VXkyeJIMLrE
HNRNcVi+/d3ktIUX40gJBq1h0k9j9zE3E4YhNQTGGED6RdbD7m6i36vsasWfEG/h
3iNR4v82A7A5rPTwuQhstIFXP9r3WB4ajWwYFqdsL9fgLjtHFnZ6fBho9lBmPjNj
APVOdZDjcm3gDazH7D+q2zC6VgC2hb4nUMAUkWa2y1Csv58kHsguh9VNesTrjlYF
YbG3R4dyoi45Knk+/Dy3S7jGoECx4QAKNGpGZDjOvOgdtJoor0LYgIL8nxcA/BI0
gimJloaAfGzc+PkogkgXDlBVQNTEd8EmzQ9FI1+52OmZ/x9rzOAZ+y1Cc5SZofpu
ItQOH555LEqkTtvwj+4+GEyaZX5r/IetR8lcpZwitrH3N6BDIKAwH/zx4obgfycd
rj5SOUafM2mjvsorruEcXnMUH/u5PlZSi0oZVNeZXCSvPDZArsR2EU7Z2AvzHCpa
fa5AYcyuG1k0Pq0dlX2t6kytNJSeotb8w2uHJcOVVImxVKIcSyaMObORa68djmgk
RqOWw3Xns6uix7NWtsUwl7x6dZVGboZm1mhrSBXjn1Mmp0vFyrfFCR3ktm8Fzdln
uyVRxMRiaAapjcJEnzNWS9QCimW9OO9Zl5qBZrwewhH/aJwNfhIYEdjwcxdsGuIL
ucAzhqnsRQ2utAW/olT3E8hd9RL4ugTQDJAAH729fF4T9zxmNpeWKBSnnl5KbDj/
EP1ro6DvX8J69Mm3RrXtLfYi3clfCqoGlpP5hD/VosRdoVC6pAdu7EWSYUvAmFhI
D8toc7gwP2ablvKrG/tPMfHpFbo7qzkZCjjEiIAQuHuHTCTIWUW8agxTIXxy1g0s
8Y7jnAunE+8KUxuv3For0SDyuzcQx2xAC7VbvawvX2TrCvADSEgX1Q8DTh/42ft8
mVhRfSTYhcRkLKZ2zIatXWmnS/u4va9VOJOSi5M7Z3vMcVxOvHbFUI6cVMSW/BKU
7pDvSjVcBYLtLP9EBFpg+cukJwBGmhl0GPSDKy23XUP+xO3aGWfthLkkondiZG4P
P4W1z4jo6/s/085WOYwcWzQ9zcUH6eg46jZ9LLAOs+C5YOMksEb9sl0SeVHPszVz
sKX1UJVo89K623DapEpazyxCLOMCfL+jhyW+xnflT/U049uzvnFOFPNcxeNnJlV/
9Sr2zMkuBXxjPi98jzNPoPXUruafr6n59MeSb5lRNLKAEUGs01apoi9xNYBFAbOQ
oGKDtO0iHSWqYt1h1upc7BoyTdASL4Cqd+6p0L6F4DiL0kIPrRkTo4DYsv3zDjvA
e4to11fFgWc0NebydmgiYylBbq3nmoMNd3MYM+0qUvRopRIV7jgEKCX6aBQavYp4
V9C+G3xu3289OQeAMuCBiBjvyK7EkEFXbtnUyVYc+xgYrKhsCCE2nD3mJQ0ZkjbZ
g2BZiQj6uKJ3MLZfVT9OP3vqb7Ho7DyO21c4Y9sdmo/8n8TyiXNpOSpcYulXoW9j
EQpTQFodexLYuxEOHlLygV1ZLd0zutALUO92w8gu64UALwnVFo+LSCWOrdxMW3H9
UmmbxgV9XkAu8qkTlomwS80EHQkn++Gy7qyE9UyeBfstQwLP/NYchPI8gS3xpZiG
T+4xXQxfHKGb0v0gx9tQnpKaG4ZV66GeazwC1E63jFYamK7fsP6hpiN/M/KSopMO
R557WsQEe8nyVBlqV7RSYxQF0m4CbwaBi6SMwP/W3kWfCYpZFc4YlcUkwupxbFbL
d2Y0Cl7skG9q4Hp9Q3djA1ejW5UYXk3+OKY+KzZFhIA+NOYEgQ/Efxb8BeSElgEw
bP/kaRGWM2e4fkAWOYIYc84ORhrgldroE3Xy70ZdQdZ6jVpurFkxdjaMPCOO5qSP
I4q7AOz63D0Ba7GnGBxYwhEu5EVNLYL7lK/ggChC8JxxqWMEYyMksgeXojae8d9G
HeoYYswYWfqu3YPUvTIG/weU+wi5Uv/a6f5dlO8MQ2i/oHdsrkzgnWrqDlLfziFc
uWc9xnSM2Ap+RPRQptOiXTFiVEggXWdhwY9pF3aVRAN6aIS9XsWRh84DkIFYwPCm
uYtisngs6skh6kvMV5xUqoOexa5aUlAfcd+T+uNd4Dd6beLadTEWu1yYMpbM9fXN
MJk/2C+fv/Yc9dFb5v1Cp4SyB9XpdQL4oxEFDoPt4/Cp06LN/6M+UA4ujYIfh2kQ
UNXn7OVbmYWJpDTCRouhEf2jHA6NzIC2wy+a+nrUvA4WAxpSN9x1KB0ZKrhlD9fU
bFruFqUT9jBPDv4BvCcllTSynH+9+rUJ2C3haAQh9VZ+XClx6hBi7e5f28Ra4HN7
/5liMgdLHwtUZIPApGelkjPNxKDj7gC/PwbUSygMhradwyEPhbj+EKdoeTymhsJV
x8FNaXJrXwQRqw70e+m3Du8I2+hCXioQR0rv8/xxR2APIa2nb/S+13Q/MM0vcr6v
rf0DxoTqZpxNnzrN0ngGEvfas675eR2w+k1ACmf+GA/NBP+IfoH+3rKJhsG62KlN
0tkrdqPznD94nP7Auz6pWhDxd0b3e88WbpouX84vmJYqsoQ0E4ixPdcae2m2o/Vb
sDl9XjU0pOJaBwZpZkiNtQCcVkS8iBalb+nv3OUYwUyqtVwDcE+dXTyiHvgl9+gL
dhfT87B9E0I5OR0TZZvFFpCJWR7GvClRZaJr2kj1JV4jQH2fnHec2gBU9pTPrfUk
d67m7g7wWCC0LFzXauaZwKs1KBB0sF1fMtt3yXYMmR52k1DMzjS9P8yubLzf6J4+
HSFN4demUb5jLaMymEfpviYD4B+M2TpQsQD/4+d/KRk6DeLFI7DU7v3EN78kM8SI
WCwAntvXSsCrAKQ+azNyldpPFXCZor8WxNOQKPqdevdGPI/4VgyT9k21HxAgTcqe
ovcKNvORZY7//cBkxlZy4mPmlrVsJcJVYsdP3Q0oL0rD9Jst0POO9JLlAbpyNvbO
1v7hhaFL6PsH1o0k3pZZVlYULGaHpB9dxuCraSSp0s6GPn7ET0esewVX0sX5nmNl
fG3zBc8Ju31v/lFKfFKsg+dedw33fMVS8OKxSnULuAndysKNz8Sedzj8MQYsHJlK
RGAElSOsmWo1CDV1EtsJ1swZ46OuBuU384y0G5MhZnfrjkU8dFty3AbdtyU+cRYx
eVolhSWeyQpegCoriYpxvMQLox+xpnB3zt82ahL8+PyBx4g3D7UAprGquEYlX5wr
GK6j69xBB3zKg8hh3O0yn8spblYjEUUIh1eCaTArEUFVg4SbgzCeECkyHZoAb4G1
PPQQHYEK0OHm2WYygvWEgC0JN1j3cY3u+/2UuuwSmNE=
`pragma protect end_protected
`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Zx45qmKLuQVDtxVQXqSeBzAhiLpIL3bgFP2J+CFVuiZja/4tP+XU16TDn1I1UoNi
hfRhw85fhE4sfRv0IHb53oZiZGLf/lLRFy/8Hg+snfq/wjI3/KndaHb5udwDgvx7
nv95axgsssTqOVL3VMrU1CzWsLOpRom9TRFGxsAOTFk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24244     )
oOEFgrb7TI0QsFF4QTgsknxg00RbcMmNsFfo2BIAL5qR/fDqlh2TclUsZB0d9Cu2
ND2LDjtvrHR/UtbyQXeSaWrgQVYCablGvg7wz4fjAlgNjsYu89nIWCt49avBxQke
`pragma protect end_protected
