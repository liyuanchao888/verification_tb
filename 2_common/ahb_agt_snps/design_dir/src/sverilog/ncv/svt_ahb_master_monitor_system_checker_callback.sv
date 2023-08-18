`ifndef GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV


// =============================================================================
/**
 * The svt_ahb_master_monitor_system_checker_callback class is extended from the
 * #svt_ahb_master_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */
class svt_ahb_master_monitor_system_checker_callback extends svt_ahb_master_monitor_callback;

  svt_ahb_master_configuration cfg;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_master_transaction are put */ 
  uvm_tlm_fifo#(svt_ahb_master_transaction) ahb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_master_transaction are put - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_ahb_master_transaction) amba_ahb_master_transaction_fifo;

  `elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_master_transaction are put */ 
  tlm_fifo#(svt_ahb_master_transaction) ahb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_master_transaction are put - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_ahb_master_transaction) amba_ahb_master_transaction_fifo;

  `else
  vmm_log log;
  /** Channel through which checker gets transactions initiated from master to IC */
  svt_ahb_master_transaction_channel ahb_master_transaction_fifo;
  /** Channel through which checker gets transactions initiated from master to IC - Used by AMBA System Monitor */
  svt_ahb_master_transaction_channel amba_ahb_master_transaction_fifo;
  `endif

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8TPZ5AHRK1UDAvdbWLtSGomn1RMAeyYxMlEUq64iIhBn2qdhiCAkSY+WKnfiODSE
UA2RgNpjwoGEzN6RzIupY8JgaEuRFgzSVaQlXycMHFoTsyCVyaI8JYLyZG/NFTOR
T6rey2wu6sTf2Qg5Vt0OZg+JGsPLvRFKUeH3eWeExa49sMfh2Doy/w==
//pragma protect end_key_block
//pragma protect digest_block
cEbC+JAOIMv2V1yUCmASefvL7BE=
//pragma protect end_digest_block
//pragma protect data_block
qo9MX2jd88+keeHSDAnbffE85dRIXWMWASILrwo9A2fSROIqEmAtylJrNk0z6vpl
bLm3mtEqMSndubmWDgsVXWYpDRXE1NPnAo4JhN7i93uvDWCgBstikiKo5FTBYb0y
u/VeEF6+GwQniTgn8YwtqLrXu9QSzIw2vc+aEeJUKJVZhz5rrqZXpaYT1WjQ6sCC
tMRReY5t9Dkx1tiSC2Xp63BxmTqcYqGnTBy2ISaM6QBj0fVeGyN7o8veaWofoCVW
43Q7fzz+AKiSazZD27Z7EKGptDeR/gTr+/6lAG2ZTVHS2tutqcUdy7uDs1vNE55G
0aA7AlpaNMFpWjbOJh6/8fqX8OcDCjJN0A9AaxCzww8S3mnyIxyZg9No2h+B7Jw/
DmAHWBP5yVfk0cZMxUCbJQUSvc3Aex9nCp1QK4t9DeYZaGlo/qCSKiATKWsUwMUd
W16+Hb+sxtRdJ3k2nZKcj5i/o8PK5lRE0aq7pbsUdvPYRoiS1jCqdVvxf8L89NXx
WBrQs8zp5tuGGP3j96jlORk5T2pElbrulKFOaezFeWpWaPZcJGnNOwBa7OoJJV62
fiirX5y4DRbP2omKR6PEZvHZWxoJu/nGhNEY5l5eQt/YmZJIsTU1Diu5ILbYwkAy
PyoOAA06oOGOjY3yhsn89BmBs03QKTWzW6F2XJTvtP5hhVG0HQ7gW+/XDLAVJoUl
sitgsq1MxjcllXu+cpYWtU+hXAweThrKR6KcQHXXQp3YKyZGpp4vJeGBXJ/Cs1JI
cJ1cAp63rhag4Z/tCSEpeN5E8GGgwPUNqReSMVqs6NT2TWKmTEc3Tg0lBfkfcPS0
MwBTWiyI0mKs48Rd0Bq9IhS8YdxKkT/lIQFBWYZRb/L8xWLGuxmGYe5sIKzWc7lc
Qp3i7Tr1ZAgzpJWgIQIThDdzOBtaM0+QCrF0xei86C9Ab8FdzJNuYeOa7IFLxyW/
kEGXeRJDcPwdfvXOpRblZHqYUJyfYmH86bO6gLese5SOqrzCtwBe0Pddd3hFN7xM

//pragma protect end_data_block
//pragma protect digest_block
qgTE3zP8MAKVfa/NfwR6+taN68I=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GBBoycuOoRXIx8r12QQxkO3jdwyrzpZhna662rkYc6H9ppXEzcjn92RpiSK9Np4G
RqwYhYbf/Zgt8TFDGNQJDE/Kt+WFyjQ/tMPjg36g/NhcD6IhjcCxVOzZkD4sOKaU
VelqKyLbJSPiXM6P54rHDN/Da72rd4NLkXB+DSr09YQ9nh7D/nk6Lw==
//pragma protect end_key_block
//pragma protect digest_block
GsKWLV8eAUCXkFd2C7JElRuyLxc=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
2904vUT9ARJLZO3G8N3/H03TOWE=
//pragma protect end_digest_block
//pragma protect end_protected
endclass : svt_ahb_master_monitor_system_checker_callback

// =============================================================================
`endif // GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
