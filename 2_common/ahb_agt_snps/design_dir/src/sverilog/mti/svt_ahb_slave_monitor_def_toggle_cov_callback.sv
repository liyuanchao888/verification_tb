
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

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
class svt_ahb_slave_monitor_def_toggle_cov_callback#(type MONITOR_MP=virtual svt_ahb_slave_if.svt_ahb_monitor_modport) extends svt_ahb_slave_monitor_def_toggle_cov_data_callbacks#(MONITOR_MP);

  /**
    * CONSTUCTOR: Create a new svt_ahb_slave_monitor_def_toggle_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_toggle_cov_callback");
`else
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp);
`endif

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NRu/XuOOb1bUp57sfjughc4EYHDOTjrQJJimEfZUyv3j6Q+2MMyyjzfYXOlkFojf
ZThE+twBPMqACmfAchCB+pQjVmNsJYLtrsb1NXKCh0hDFFdLOPNDwwLAJEH6E/Ll
95B+sWvivlhWXGd6UqEOjRaJYbIIK2L2FOWVDlSIm7I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2636      )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UNMSPuePePG0lVVGm7/rdfQSVZrbusrv7ymcnKr7FGrPw2hd9jLURGYVW0u6KYuw
jM/G1z1xSJ54slmnvlnsPCVItgs2i9tijyW2IW79ZEpVvSxUZvVvSGy+1kKg2WR/
K577yGBN0qeyZh3oG0j0vY6K94c4Na118/gH+xUWFXw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2719      )
5qMp4RsaKrGpgz8Witx5Y/gsx5+PiZSQvysM0/Yl4xP7vaNNK8sb1aiwr75eYr2j
d6Jty3HlNHWmzE8tQFPe6JJnQf3uU1SFk872fqpSm6vIaw3ZZfjy6bf6B8TovfEH
`pragma protect end_protected
