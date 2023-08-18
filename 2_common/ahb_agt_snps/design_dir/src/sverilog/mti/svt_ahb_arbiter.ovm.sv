
`ifndef GUARD_SVT_AHB_ARBITER_UVM_SV

`define GUARD_SVT_AHB_ARBITER_UVM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
J4bNA9BUi748ZExvOsveN4IN5sq2dyLs9zwlDvJoPAakzr0Kx0yErzhhbqA0AGq6
x4slgzaZzwpLL/MNYBEmqFO/Dav6kw80E5qEnOa6kxgeI7h7cZkXTvmrEY/uV//I
EsaGFl/4xapt6ql/YMql5jUGB3y9Kj15TSxGf5TCKNc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 393       )
ccvC28vpFxs72jcW+sxIBbY1AVaOmrIYRQDR2P6+Jd2NoXKw42j8Lg8LoO9TqmGz
7YlodrLCYziP42NQ5mgk7YrBtkOIsCfm7Zdvb0tMeaqaQ+3ngcJjn8SpoMZxR0jQ
+aAO1i9H3bQC/pAvD72MCLM9RnrJZGi2Wtk45a8qyCMx9Sk1XP1X+FqUHPNmEYG6
zwv5tpeErYXPWTnHTcy+jEYtYY02Bhexwj7xrxZVqYfr0s76cIRzNJADs7V66yxb
81jMRuvSECJ5cLOOTVV2Jz6mYa0upZwr8lstyGi+uYjZoZ8u77XM6oag2Wd8nzM3
1SpL+4ahJ03tnRNY4PvhFpPiiaQxNSDlrXNhIDnlqSCzCS2+KCNve/4EFDmW/Z0J
oMO+ujYY2N+L4srxyXeDxBUTBNgSTSX/519US/Y3L/5dBjrMn8HH037RUKF0wql6
3vta1YnN592E5UiKR70+REx3B5FZjas78OScpS4ZAblyHWlHjw7RL6R3hd5CvbgF
fqR8A3r8bwE9GehEZRCrsA==
`pragma protect end_protected

// =============================================================================
/** This class implements an AHB ARBITER component */
class svt_ahb_arbiter extends svt_component;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ddvinWQqN9QEfbuzM/bwiGbubBOwksjA9G+tw4mRLJUpOLSN7XseZiGcMntf/LXK
b7XrY7Ru3d8KhK2dAmns255rFKxKYp6PJUkIS2hreTySoPbD7EPeyECFTnt2vFPS
3ph3x7rUrtLpVXtBRT9572dwChS2P5CN/oAKf/LNGp0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 600       )
kRBZXchV3nNacZMOQwZlPpv3a1sfykSc0n7QRcbJzNqhCzIgjTbmVYtm8/39TuFM
JQqI618QMzIJAaFWiWmwh4QE6BbC2g8zTqoSoWdySXhC5My/V6G8bP+xF2bh556x
Y4y4CfYxXIaGyApClwrxrZ3yFng5iMgXJiTl9HQxAcd1/P/AORC+1ULPNTIxP3U+
WOW2luoexkEMt/4hPT95Lt4+ZRbdnogAl6RoXUYeJk7i3ASSu9k7lLaFBfAWYZ3c
x+HXsQg5giSHwDIlmzNZLA==
`pragma protect end_protected

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /** Common features of ARBITER components */
  protected svt_ahb_arbiter_common common;

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
TyR0XBD0oqT2liq+it/V3ClUuJfP394ssBpJuA6Ebyhkaf4Khsr0REkQ0LrCIR4b
sIwSeqfLsLGMzcYPm866Ro20REyq1g++L+4McqeGwUsmFdQ4R8CJsEIWb1DlfsZq
g92rD9FDRpGN0iKfDy/SBDT7bvK1ArrSFmy6Qi/GnR8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 761       )
Y8cLbbvOToFjCjrxiG3gfadQqpSL0uLRyUtmimgY3x2MCgo4kgp0RtRRw+MmjVku
xGPjTdUT6ARVcDB3dctVKXsyVTNlazpd3/IbPPOn3FOo3KOp2YXJPKTuIhOfxnkc
V9y6t0cvDUpGdnYz5vyI8S1I5VyYBZ5kDqy5km0EcNCdRNgE1PchuTtxA3/DFUKu
F4XcR0Sgl2kyG0KZjSWCFKqWqEF4oJJhL3F3V/Via5I=
`pragma protect end_protected
  local int xact_count = 0;

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_arbiter)
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
  extern function void set_common(svt_ahb_arbiter_common common);

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IMfARZHvyL1IPIhew3JzwWId5jLoDQxKyHnfOyPgw3NZUdt8MG34HHv0O4eyOSaN
IW3DukdrDJY9T6ODVpFbBO1Zg8CYVncr909j2D6rdxFXIGoSNuw3ICE5Xl+P1okm
yI6XRKL9ErMl7DSpEuhtPqoeJi2XseM0S0fmRSU99AY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 871       )
wDE4ZTsqzQZLwDTGjbAyyXQBhl7yKF8TzDl/vwQ/FdyF5e8V/sSOGwvWMTem6Bvc
cpHZQNSLrSOvqneX3wiSO8JXnLc/AuaOzY2d9+GZlQ0qO0ST9CjPNgcYunlMmpWO
tY8G3YC3vMTf+q6PjG5Mpg==
`pragma protect end_protected  

/** @endcond */

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MBcK1qFeVOoHelH3yr5N0XB38rMgmP6BWre0FpbEBXeIfvzMRbyagwrFDd5LmCJK
uu76omp20oLKueIBCKwNJ/EKIHcWHU6sKdKtfYCZxWu24NPUtwf56s8oJIrwJJKT
9z0/DpwzL/I6oKKzvhqvwp2NS+Kl0hH1qYvI1sgPpys=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1341      )
bjPg0mwoLAE3H0sLZnMUSmb+9O+WA+ZmG1SZ2R2WxMmm0Rm/MawS9i7ApI+u49z0
ekHrH8bP4ioY6/JkXk1FGpNKhkV/Wwr7niXxp4NJHJ9pPwQHYbJCHJp/D5FFgDHf
EbjBiH0xksKszAg9t/cfdaiX9ZO339humpioTG9RW2R0rhyc0cITsWvWa32hYwmU
M7TwJiD/NtNZYYwBBjV2WXRj70Y3HCMsT+qQ0/rPl7TdprrzHtixuiw6O2SeQv3c
vdMz++91wa3ndwu6BSE/erBw6zTEBsI63o0y7V0rvNc77GbwIL8PbTUAWze52KAR
cAfi8TkBteNszXBvguzHR5YKAZJap088ddEZOjoY9JS4Em2m5qXZIGhUqunvme4L
5tYe1QmtxO5udGA2Sy1CwStmc0BwCpDQE0CefrMtxLlfuotwQaH/EEiUwXmMq2+H
LBc9o92PVDZgROHp39kTkrnK93E3WAl/BzzEKGBXXHy0BVbBFx6nuOUumswVd/Jf
0EUngKXPAvByPUUHXEzqPGG5Dqsuj6jKzssITEUiNGSiZBBDOfwBZbfF2nWvlMlm
0SjVu/mFvWm709Ii8lq22UvtguJIo+fCJxS544R7otPp15bYEYJk3h/Qc43sxZMA
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KJVRsWvXhjzLxGVyQCER8E9rS1NI8Q7zoGTNXGDwPaMqtzDa0lW0QT922DaO9tLD
VbTkG7EaaVelX+WKnkoSdMHwtNV4XT2+RzG/vf5rzfxxp9VUnEGXFSqZJUC/c/sN
19l9jH4FT8t32mvtCeEEDhot9pdwDypihOK3KmT5HGI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3328      )
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
`pragma protect end_protected  
  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
R6HSKxtESXsxiRhPx4Nn5VtGuGlX7fxbiuesZdfvlc7ba5PbElxNzPx8ZlWjlInX
QAVzqrY8rcb9k9ZwIKk9pciE5ybVBEAXeLpn9Fa7fgFWSIdWPdDRdYDkIImORbqH
MyO94hOO4wQZ9HuZDGkGaMGpg4BhArKyUgY4gv7K8vw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3462      )
+Nvt/JizjOCpFrbmw8dJ2gD8Yiw2INvMjLsTnEcaqdFnshPJlNdZc6pYkREF2O7Y
oFNGrO1Dj5tH8VV5OmMXfZLU+aOZ6Ooazk9PE0mjZq372NMzilwskkCp2dWLPQwJ
qKJ49YV7OLSId/LUazvcEJ7wo/EpDXNSbvJ6NV2IV6rdzMsa0ZjslYpS53TKdJN0
`pragma protect end_protected  
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
I+4/YPp976rQnAoDjHEZnw8C7VBXDUB+rJonC+1zt2GeEdGHgPtx6i+31ANRIsWI
/CkQbUeLIBBXk36Q8AYPZTQj70OXJNepXX5qCmd8hh+XhvNwrWZA/HtFZTCNkNZT
LQYX5MsyQ6uiL+t00xOqeyKa8iEJzRa/La5MTA6lzIM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5695      )
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
`pragma protect end_protected

// -----------------------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QeEt+olYUjJfqz/+g+8R5fQ5AORnyWTmQOZfK3qvSnPMm8t5J96DWaVtk6mkA1hY
VjZArcNWZJkFKVAcZQWQ5FPMw/ngXeK4ZsQc4bCpIzX93d8ym1qMWPtgkB27cPte
rWNlUbL3Shbqdidh3yl3t6u+AlIjCPyVnngPl+ECkFc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5826      )
3aTfcQM9aFijleu6ntzQoC9aFEyOW4818RonKDXkOE2s980M/DXL9GIWxbx2eACr
4OsJCeARtjWxWOlycZqo24YsHpbR61q7CTzStG4+XqaetIIH/QrDKkT/VK5uSGxa
8DpvaA0hpcGMoBOQQuzAZxv1Xanzegfl+GUO/NPz023gUsgb8SWpC7R1Gqirje2p
`pragma protect end_protected 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e+VisW0XiEuDRj5YNK4aGEXj05zYYjQuJESOlrFRSdam808ckySb9LBZ50XUC4hF
T+H46iO40pl0xxaWzi4RabxRzZo5omG3xBCr32Hv3FvPKaBjRW0p/Zanmrm2PM9Y
M1+BMWa1e9UmAzm3Efol0YG0WYjr91m4A0FUfVOsuYk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6048      )
vyivKBm4R1FPxT0qLbvgWPV8BoF7fgV7SJJXLVwMC8Q1EZta9+5Xm9SwHif2Zemm
dVMzkGyz1Pefwm4exOvREhd41Rc0zgvtggbpKfGFjDycaTHtQHej4G2ABNIKBoiS
GX1aEHw6dN7q2/BjlNZikyOWkzaAzXJd6XNZxBU5P7fKoq7jqd6ZQy5TySGd+LLb
eOT6RiN8hBqnufCNeeZHdnAA1IA7uqogWRbJR5FaGcABbxwHwGmKOZ7rNUrgB5AQ
sbkSwMK7cYy1EQyWwmEVtMm/uxbQudblvqXjMTY+iIw=
`pragma protect end_protected  

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C6swnALRBquCVDG3Us5ya9MUp57chFo79VzcCv9zaxYnmEy/jXSzt7MkcT8j6hvB
9L1AVAIkTIKuqsX5O6JxPdsxU+6H21BdSi/s9bpmlPkM6liPtihnUyTJiRmMe3lJ
cDg17nzIUjkwv0XC34F0MnRdjxFzg7RmDKb3+pPo2Ws=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6175      )
8EyPXQQ03eR0EPYHYc2b1ZvNq83rUgWhAsP/e2D+PcyMzgucyKAQ78V2dD3YF4ZW
xCjxYIUbJQ4eR69FPaAsy0mb8p5r4dRUSkfiMC/YJ/f4f0Q0XXwLtvgaLIOO5SHp
Tk3trpX0cWq6OgfMCz78LVJatMqPnOkg5QWQ1whYdkw=
`pragma protect end_protected  

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
l1V03m0TyUmB0+LpYRSFp48iRAMLiCfuRJYDobHZ8Z6nxWcqm0Se6Ab8ooYO63xh
9/R1ZSEyyWPYkRe0v02FbV6U2XRUB0hpciwM8X5WQrcjnlH2Swadkls9bjuVx1bf
FSyfEQIzrBb9/8J7C4bIGrGfgeDwzqPUhR3LzWzOItk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6311      )
1D/tVg8K3/Y/t0Ujfls+m43X2rWuwJS/6Jxv0qs7rRF2o3Ujzq6gSq2KcaMlXEW7
hpfAXgKPPW37C0rRayuQI039gDDF95d4JhiWJK/2VxnhyxdwKQRdS2yVOBtFMurY
4gMFJ6i6XvcTVBk6D8r9GmQ4VC2O/i1o5jdV0F09JiEEFXTQz89Yr96eQ8anmcsA
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jXjGb+ogCNc0K0xGDzd/HE36S2NTAUCEZ5RQgXUJZa3JxOdFNVhGlbbbw2VxD5Fy
3eD8szJWKHAbdFeQCOUmlkxOsYItPf3lFg1uRGlTfCKl3KKtT7BJsBZVHYb4rZhz
QjVht9fNkn5cIhrKMg/dHUiFL0npbot5sWJS9MUDKRI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6424      )
OAiFATioVQCBUNhon46r+mvVUP1ZjamcPy8+59xyt9eVeuDs+Jk5LFciQv32yDak
EFjZO7b5UuDs0/he+WasusLQiYfHMKxLh2m+np5lWNMfhop+DCgxgEZBYH81TNR6
8eA+Ghp7Wxj+YlqITUV3SY+vESTM3X+hXqYy5nNdo8M=
`pragma protect end_protected

`endif // GUARD_SVT_AHB_ARBITER_UVM_SV





`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WAOOdd7O5yiNrT0oUCf5Ai7vWLu63QI4u589Tl0eSn3cDLAJltSgt5Y1Gd+jfVhs
P1vCq8T+vxaDy8nF5jeyJvyGEFESVjMHHxHadNTpvlpMHm5Pr7EDYJllr+ZpO2Fd
SkRCOzccQHg72Wdv6gaGjC34lTKcShCAI/ltb1jCHBo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6507      )
0350TwTSqFrWJh6/s58pxmpoxfENcEZPtW69Jkd5VYk+dwKtE2SLIdItRmKrSMSg
e+VPE2ENsvixqJRCYPHl0NyhgOtCL739gowbAFHfwxppe+25I/uB/7pr2thRN14m
`pragma protect end_protected
