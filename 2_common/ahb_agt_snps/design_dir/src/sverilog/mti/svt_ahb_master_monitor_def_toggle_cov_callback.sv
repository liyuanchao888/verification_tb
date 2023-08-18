
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)
 
/** Toggle coverage is a signal level coverage. Toggle coverage provides
 * baseline information that a system is connected properly, and that higher
 * level coverage or compliance failures are not simply the result of
 * connectivity issues. Toggle coverage answers the question: Did a bit change
 * from a value of 0 to 1 and back from 1 to 0? This type of coverage does not
 * indicate that every value of a multi-bit vector was seen but measures that
 * all the individual bits of a multi-bit vector did toggle. This Coverage
 * Callback class consists covergroup definition and declaration.
 */
class svt_ahb_master_monitor_def_toggle_cov_callback#(type MONITOR_MP=virtual svt_ahb_master_if.svt_ahb_monitor_modport) extends svt_ahb_master_monitor_def_toggle_cov_data_callbacks#(MONITOR_MP);

  /**
    * CONSTUCTOR: Create a new svt_ahb_master_monitor_def_toggle_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_toggle_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_master_monitor_def_toggle_cov_callback");
`else
  extern function new(svt_ahb_master_configuration cfg, MONITOR_MP monitor_mp);
`endif

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ur2vUot2+LjIZWkYYfW4wsax0SsEIMIBEYy0RaPfwwAjAp0bDyyNMEUvm9ujpuK6
HuZvYkJKAxaEsJr5SZQ3ApwAnzzZuQJOq+qvKJ21v/4mTh2nYjfqCkx0O1xI+ARV
pXYCy+hglMYxPxFU9bcPqF/SMiwVax9Gygq0MG/9K84=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2266      )
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
izNYOuzdFULxzMp+JPWtrg==
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RJG2VyOUX4ae4qpIemotFS/hL35dxbDnOsm8CvH/WOM8lbuuF8acEAgkp1z/VeSi
YF8uvQ3xJB81LDsD4FpbFftIpVastRCfnLNiI6bv3Cf2pPcxyGkWorqTOKBDqldF
RqR7ZD945KoWAeGWSquFuu8KpiazX49uSjZvceSpR3w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2349      )
4/NcBn+ER3GRVKyxzTjY4sTdPILaypsYGhMDBOcIC01Sdr/byJOIBjAmjmAR9wJl
0Y7KWYcXozNfKFcrXlfHOWdFGNHLsEQdUgrqxPV4zMOnw2edtIBcBvHOaZHR6T9/
`pragma protect end_protected
