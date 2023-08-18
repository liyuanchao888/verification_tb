
`ifndef GUARD_SVT_AHB_DECODER_UVM_SV
`define GUARD_SVT_AHB_DECODER_UVM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lhxh8kL81kBTw5WXsuF+trvt5i0GKe3dl8t7/chNoeKKadjwGM6o9BCj733uHJgT
BxzU+NeWBLuhP0oLy5vjjxoxYMxl/c7PzmIXe23feTSObd2pgS7LlbO8d9nvSmVY
zsiQsYzuMo7FS4OhAmgrjlxOtq2FxET77hZElWt5J1A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 393       )
Aurft5S4alhuemN8dWA3iubTAqOTSjlJ5/nvc729U4t5nsrDlcUbS6i06oVOyRlm
XqVnXR6MYl7TDiOzi4tjfl8P9MnnykrQbfODj3/JOPWrtNoAYTm+Sp3YjApUQ5y7
dKGYwj7SVyvewjOvUrNX09LR5ybwdHXKXUeXRk/+KiJGS+LuiPW6NCmSouoEZtHc
LgqaAJscz45D5If2cbg7ed/cHQcFEyFl21mta30PO+TuhEC1WkZRMW5A3bjepJ7l
ZKs+P++lc/0VWFwRS1Nt3zn2/MTUAi4ATm7zB6+tiMBmbZz13Q3R1ol+cieFdfto
qgAMy99zvwR4RRQsK4oEukIlBY+EY4Qqa4aN9GdzIXa0oSTktcEKuVftoBBVJl1X
GIhjnYyhqBVP/lKTO/yach55ov1aBELk4y/kJ+EO82FK8wD5wIeF+kan7crNR6Om
5ZkeILfy5il8dITwxge/q+SioKUaNW6oJv6RKZPKKMwTtDMdA0Ir0k1/sljr31q2
FFDlf+KDkwyI7CpwFfcHWw==
`pragma protect end_protected

// =============================================================================
/** This class implements an AHB DECODER component. */
class svt_ahb_decoder extends svt_component;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZZzNP69N9Na1aQrJHjdF+13gyt714t45t8zMJv78bw3OggU5n/NhdLqpQVYvVxfP
bemSRic2GW+buUITQgthQa95rKorl4ArH6GlLIwOsGLscLtEHzPxIqlivurRVCdt
DGd3SjUotnB7U/fM+qjd8KXhFQgZqWdn0dk/vhwSnL0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 600       )
U6TPYe3Unpy7WS3bIt4F3LXlt1/ArjbFbieverXZhvkKz7g+fGFcD/fI1U26MPYJ
f2P3Q0+OD/h3hRkjlaO7f5+/tOn/EL/6CPpGkIjuZmZzDhYODhMPS6mm1PwzSjPz
BpQdv7Q1LlgPS95wkb8iohMxuEJghhnDxJ+diO5igSFQpv2Pf1GMLsYS0tOfiT6H
NNUFTE+aMHQTdfA1tSjQ24AecfTrbI4F9RduvDI3d4qvLao4R4kYOQasS+BzwFyl
KKE3HxvJCfz3rFZhiZkb3w==
`pragma protect end_protected

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** Common features of DECODER components */
  protected svt_ahb_decoder_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_bus_configuration cfg_snapshot;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_bus_configuration cfg;

  /** Transaction counter */
`pragma protect begin_protected  
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
E26/Sf3mQfIhMFVvt+mBl6BUnCGS6qffxu23hWy7Kg2vw55Y0gm/TndkxULHvV0f
arwqKnOqPuxQ75fYbG/tuzDHFhN+mhtViViPrZp76WcwRRJUqumFXOvfiWWRgq79
BIfhvwXyw2FmjVNetIFishbIWebapFIMKj3+x/1a1vk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 761       )
OTfUlfnoXavyQvfSQjmKO7lScJjFRgzAU2MMdDgGctzHBpG7Jd+nki9G2woqevLX
4AUlFUBTUwUPeoGUZd+/8Z9h+EiZ9+DKY08RxmeFn37ajGZPlN3xnlKgAgvvDTU2
qKZu2F58KahQ8y4g6SxFbF8Qm1Z5SsNtF+u8ayT7/BvDcMkzLF/BZSeejm03SEPW
HBt6u1kv/9z682xKKeahzhyhJj7boQ3/M87quo9MH0M=
`pragma protect end_protected  
  local int xact_count = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_decoder)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------


  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_decoder_common common);

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U4++fZqzzaHdL9x3gjpZ83zA0uatsqdcqrfR+CCJw3arZtRdKbHxwrgdKCQskOh7
O8xS+/li/+ZBiFi1ChCtyrldry9QvfqEDIwnWIvrFhBDPu6WfvGERv1c8PmorV2c
5EOS+eFbSmAk2Z/4EPEUO8oZO0MF5WyLR8xWXpoVriI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 871       )
qRIvS8YqsO/84t6oXc2JMcLOP/YF3uI3urbMFP1dylt9pO4B7WzwS4oVENQLBed0
riyrLULMzPzBkGydKAwEcfLEJWH/hIslAMysqWkiLoL/OOOOA5cQClziDSdeGn/Z
bi71e5IdLq6a2cJDY/U5Fw==
`pragma protect end_protected  

/** @endcond */

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VYLd/72pKoCMDlahlJ9wgNBdXalDUGaG5kntB/QTSFCaZOrokLQlx3gTWOoktuWe
5mjvcSU3bcT59kVHEWICumOvD8k6txOFuFL187jk032pE7R29mOD1ZKhmuXoqPVc
h4AWFei54Uxbm4GcJGy9jN3QKxTab9Jdi1VtIhpqTig=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1341      )
JKKBT7ZDNotTjpvSR0bjy7yoQcRG2NZR95hyaW/jQw9VuOPpHO348hdft4f00ulW
UxklMo7NXMEY48XmPspgCyK3y4qQOuFp70/eu++94DiFplzVWpucJ4h6Zuz2xXHg
GaALA815PhScQnHC4NUTcQU8XewktIy995vnf/z5XXtHf5Uz0F0Z3jCgDj64AZuN
pJDMvgMSsNg/7kHDCfazELS+O3l5j0yo5APE4Oc5ygsoS6MXl1ax27oxHTPeZQrz
nFIULYeeIvGqwi3UvTrrQmtTwCOQyI2kdDpCMWV0w4XjU2NiFn3pLW8mzhHJRWT+
rBRMXv4mN3OUc2dAgOGio6pN8h5pls+oAnozRY7Ekc7J2dwy2fONNdMIRg/LBVlK
0QvPhZFjlr8l2wY2bmcr66rPdl4pXWab81yMAGa+DICO+kSh/GCz7902sLhqe9uy
nSzrwMkX/izhkWbS3y30jBUo6fK95X/D6qdMWZMjQr3DvvuYbStKTqPqp0IgEmod
Wrm0bMI82kIzwsGxeSvZmjTQzgHaaQ3HTZPxRxvZqNORUmbpT35BgEuw8Eikc4fh
oUBZRyRc+lkJ8U3Mgv4/3celKohYL9MNiQlEhyxkykB20mBkZOAVhqGAWLqp9tWb
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fR4f60LuFbrzYZX1qQ7L5RF8QN1LvTk7dBkcJtSKseahseEpXPOXKsM2N1r8EzwV
pXdKop2eN8bWL4ugcc9lfXTBAapCqFf0CWl8Ys8Azbj7cbWQA6quN25+z05O2Ft4
Q6ENkcPQWoDnE8v2fHJzBle+oTmRFFKvCGvdf+EUnKI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3267      )
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
RFCh2x22KJO3M8pB6GXZkQ==
`pragma protect end_protected  

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RHhRKesGqL1Ba03ThIjb4pFK/80Fj8Wg7eR8CyAmzYBgVFWTjTrn0fM68gd/p6p5
bxGrcwaT8CwOvwGa8A3ghNcF/vCk0BHY+5BLvYCcm00aiWYN+/2oNXIphs6F5ecP
hcXt1TqYvNUyVta8poAMpoLP38Bu5N3UAcAnh1EVCRg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3399      )
wBAW/1w8TgXBefPcBH/WTcZKPVv05DbJjLDruv1/ebJut2IZDdqTyuyTy04M7p9Y
/+ZTBITej6Y7ul+fp5zAVAI25C37xSX7jKaRciS6Hsd6zgFxvKdVxME0VuOwRMKx
MtJOhQqr+VSumH+bldAvQ3onbb8MxkOEdWrs+aFBo4w8j4AlPDMUmG9X2Ck7YZIk
`pragma protect end_protected 
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U2FO5PfE69oZQjnf+oy45J5nLXiH8YmPYBSkhWTYhGfzHsx+Y5ybLziNpDAk5+Cv
LcSgBwJEbX03iqB94uP0D0YnGruFwk/lWtnvHatXffFq7xa0ePagxCHbuK8rlkqh
r7wgtSbGvTDkX0FO75KJt4LBsfH+Y6SEB1XdcaHBFNo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5634      )
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
`pragma protect end_protected

// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KdDRVJ4kYwS3eTb0TEIho4CFgJBBTY63aZZNQPkqtEjRdOJqj4Pumek6stbJI0/s
VOh/L8xJcmRYggS9U/lVNN6A7pOvntAmirIUlnxBwEi9+bVjXzpM1EM1Z8OKM4fV
SPgUvdXefKZdLsrBYOQTQfS6KUZmGqT/YDxg6PYkjKA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5765      )
d/LXdIOrpXq9cqj4Xm8BA4yllXsJR71TEpuhr1/cynjSL+DdlDKCstJrvCcO2sSX
WQDx4XqzUHyNIBFzaO+IMOZ9QlhNmSxCWxtlLWpMjHZyviI5Bo6taxwuD8Jc4yKT
RdW2Xvjze12lBsDArgh3oCpzONdC9wLvgUrjNIx+ptr0GbdNDL2IW71eluC51yBN
`pragma protect end_protected 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
efTHJC/uKFroFsXsAi3pdSZjFW46bRbmpNudei/HUWEXM2Jg+RKrTC5icCvPeJ8C
liM135P99IIVkcb9QKgwtD22kXgfsIki9d3GB10N65EkGwGfr8cib2cypa2VvEwh
tO69QM7e0QtdqbDLMYuNkn+1mgkUqIxxyKyb0i5wqd0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5987      )
e4FabvCZZeOFvvCc9lWoC6IQRydIuUrXgSzapdvGqc8quQ8LfCFQ2nQ8ieg4/Dzm
vDdBZuozMrwQRUSYCVTAzBPHmi52bC47yjikMO7EfjNihLu8jhPBLZP78EBdMOzA
qPkArSblSV2r9+He9DoGAFuFaGVILbE99yKORO+ndzobdw9jX1Gdnn5A6wGplesv
nnW57VLp69uczZVOiRe9FLWdtN0OzTaNjRSocLlCa/FxKsK+iihn5hXRzeHGfgI1
7SDAVKSqxhoNycYysRa4GR/Kt2h3+PJgl0Br1t38voE=
`pragma protect end_protected  

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fnwgYXceb6vj1DRIpzIYPF0+1UEOvIEtlMyQkHQV9BNfqa2EvdCj2cluJDG8Hmfi
s9qX35UaAc0LIH+tYsRwgHXB3HNaRV44JRHdUhC7HklK4EkjoLPg8UO1X6AP2a9X
j+MzQvxwTlYDyoXn5fZ6QFnXNn45qNY34bGUL3hWSTU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6114      )
AgYNnreodb9/Kkc2SaKDleho4RV54CUWrwU5GJZRu541SmplcZbuQcK3Agfzok/t
NkQ+6rXlrD0FOcp3YxQpwDiUvtqB4sVF/GjRjWvQKOqsCwWa4bnnTksy0eJVuBOi
lHXDRAFaSyreyHna0R5atkTb1Ff4F025H6yG0mWXno0=
`pragma protect end_protected  

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UKrw9xK6zagq7pXfbaG0eu4EyHPc+iaCyTb3+6qvNZ42OvKkcm1vFz2+3pOuTfg6
0nKXtL5hSN5Fy2gmpgOivuG3wSh2Op9Nim2ypicpHNmpEI8MRs7xDNjTsK75GLeY
FxPGyIs+Y+L0wr1f2rTdlr/30OsRfYbdyhWc9Nhuzog=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6250      )
rOZ/FJ+cr4KFAqB2NppRNonTVv7giYEsJYSKNfqOmG+Z/VL3nUtH475rA1DZtJDg
b8UGnBaC4nod8ljDg+r+vhIftfNOy8QYmXnQ97nFZ6iL2Pp01U3EJTlbVqwwDBMX
7/zb8C3ph49yQcwuk5LjMpM/8dTBwVw0wz77eC8c8Ku8yKON6u14Bx+7j0wN8//V
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XMuCZBKfuoPepvUfaOM5D5jUZFykF8/qRXhtHMGY8l45badnxFxlmnpDubceZ2fW
0S5m0AfPiAFpo1IHqMuVM/6lEzNjG/+cDfRDmVMv4kz3Jy5IhtYzvUrPr1bEt/Wy
KRDfBlMYuFkEaU5wwbeFwc2gb0yr00efcj8DdWWgBeQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6363      )
Nu+sYeZ5Dqw8yNMSPIs5JzhzOaKV/Cdmectm88CB4GtHz2g54H99GPaKxV6/VVSa
n419odjpBgUV/Z8H5cRdq689wiaWhj0Ds9QfSwciZDIeCWopuN2nfyM2YuzS+542
nJ1MJBqkJrhlhgqTLzmf5l20ggsndFwm19l92BLipWI=
`pragma protect end_protected

`endif // GUARD_SVT_AHB_DECODER_UVM_SV





`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ae3H298g3SVgVbGwBuIEo+7uVAJdN6rSBbgn30jMtm2atznCtirb1GR2FRsP2Diy
pngrEqv1QcyQXBL7dUmB2mFBwZzjzonPXDQT/YJsQLQyrmPNL9Rz0bvev4C2nhpm
JHhI0gLfZdS/4HrdmZFyGOZGsO1YpDnJABzpt3JBMKQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6446      )
uTBH8pq6gLWn/kJbNuKHg7I70qp5oTkGJuAC+EjYuK6cNW5tiORxU/v9J+ioqj4t
PvA+h7EZWCoiJnWq/VZb94aYMtp3nj+byU2oKDeakAlRPpaRcP/4Q0u4lMo9jU3Z
`pragma protect end_protected
