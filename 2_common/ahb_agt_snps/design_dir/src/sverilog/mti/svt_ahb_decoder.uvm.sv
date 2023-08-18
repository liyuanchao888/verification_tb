
`ifndef GUARD_SVT_AHB_DECODER_UVM_SV
`define GUARD_SVT_AHB_DECODER_UVM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gmbAywC6JDYJQ07MYcJo3u+AcyHbHdSwzy1hOzPm9NO8oB8dhVq7TbE0HGiZi4Dg
fox/44SAP3LXZgKCYsHini3eEKe/s31fqDu+IUh0l94JA9vi4N4Gy5WoQSF6QghR
xs6A8Au1t6ZU7Q2rtXqEkvBiKSURsiRvrjHpC/uyHy0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 393       )
OsewnpQwf1S9Mh3lIe9viNfPrFBMgoNXJJ0mUBk9b9hw4aBeZOasUiOJwHaYCA08
qHK9G5iP7Py/1lu1AJMur3lIXkkqmsrMmB0XqpMQRTjPuPFkWMuTY6E1AK2P0P40
Jsamafeco1+kJYwOcZyrltZciQHq5TV8tV1iOS+mCcYAOu2G5SvNlXx4ECZsXKHR
n3A20Ql9Afo9PzK1vHlq6ECr/uYwgLW9ZXfi++T5dZ6vWDhD1XbV8m6T6QEu4k9B
/QNqhAiVonSIjcHvkfYz8aV9/k6TVAnIuC8MAIWwRbp8PmTcjzJn8rkbxCSvcdCX
av0zW91xIugGPnb09uwtb1Yj2RkdXn2BAzZEa6AoNLAXiQRf3apfXhzU0GQCehdO
FS7FnYUs4Xa82ZHGc9OIvuqepJsfVp+dCvyFSZt74X03yKVrBi6Viq0QxFe71qyd
OjQ2ZuH39gWiZYwh5n1qS9d0Uurxe/4hIk40E0qFAySinIyZDrohOjyowfmixoFM
noof/uSkjg2/59yUF3/bkQ==
`pragma protect end_protected

// =============================================================================
/** This class implements an AHB DECODER component. */
class svt_ahb_decoder extends svt_component;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SmKgTt/QKVXEqUHaSLnbM+V8Gt2weIeQc1bMVrVbN1YxZ67CaqzedHNXJKK51uQf
D8/Zpuz+8UKsYtzI+50oRG05XxrjNmJot6FQiwhf1DLDvPz2ottI+z1sm4xYH1wH
FsiC11c64uVi5kT/83r5whOSoCvPkfobno6uw9f8r/g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 600       )
GyLMWEzN5W77I8T62VmasZnkTJNUUff5uy1N6hNBFN9NHM0LxAV+TqdlT1/ALMTT
GVJqqyj+EGoFKbVWmE50oac6ZtnpxbrdpQKG1yAuLJXKOeuXC7fWJg6gM1uCVguD
2hW8+nQznfSXF7OWPfdLqAbCJEVpTVWQsou9Scozio3t2V1ezD4qvt1A0j1n7RUx
4IJEuZXMxuCRwdkaMLPc46/hH6zbU4XQYZOMa1F/p/TgNK+mxLKfTgOIGTmDxQ3q
7o2nZbhu0Sr1obsLkYI9PA==
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
QY/UMI+2HVChXnO0dfvgW2OTsYFtlwuj6XwfTMlS2avjxPdmTty9Y5SPUskCkKhC
azwPMpdKTdbLvNXq3ZIRz6qpKUTGAzMxT6//5BczVFU7eVM/MfyUBqYTahQ0Znay
emtYO8rIJHyRbKoeVAb9G5B2camoCtCiCLYWuohLq04=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 761       )
BVo8ZRGD4dBvr85hBGPNjIPq/YqBMXJttjDc0z2L5duSW1Yo6vu19kpcfFQY2n/z
Gwi5cmZFqdbW2JEGHOgrLNA3klUWkKZLvU9OULkx17vi4kELjosg1mdHm0w6zzY1
x7NxN8b75f1B7hIr1sV7V5pnq/GrGpkuJOI+sZyDYUPjXJMyan9FLdSQpMI+2OfN
My60TuAb/G7Ebtfn75FFPtLunV0vzdGcPGlJbRYdtbE=
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
c7FaGHuJGoHJx53RMjNRpokH99ZQtrnMGgEDB+UIo8hfNyIIDGJjawtjktDAKzMQ
2hjx07EiFjBLy18MK2DcpOQqH4nnPtkmxiLWkoBpVY3Bg2Fek9Yj1f3ciq7JF1vH
tRC4OvVZVsiWM2yGXm49VNh/eqE1YlO6geYtpxx5QME=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 871       )
BRxEhFBxs6GkEsoFyIIYOAxuYdG/c2aCNuUMn82DL1uolbS8yzRW3qZBSpeCUxi5
c7Vq1F0ULQ2eHv9SajuRJ4qgcNLYiUZv56DFWteAozZFVIrtlNs8kOXXLam98RBN
I7a19woBIxp+RcVb/+KoNA==
`pragma protect end_protected  

/** @endcond */

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AzcypeRuBdny+7GaeM/CMp7MwgJSuDPryfBj3+CjcF1sTjwEqAm0GC04Q19oI8Pz
xKkchGZ4Jc/WxreqnWiSKH5Q0CleFX5zIXFnr3ltQPGXecEPehbnIlYz21cVQXuC
LddEKmjBnZ0cFa81zmUGoMejA4Xahw6l2TPt0aRfr3w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1341      )
d0MpBRyfTMmF/ln9R/qyWCozT8/XiJBoECFisgL4SxbhsVqjyxot64+mtKXE1vJT
e77n3qAPwo465oEIfX10s5tgOnpqBr+iVKL1vHF0cqhZnK+e+vdhvlRGIa8JQGoD
J4vP30M/tws1ujadQKZOQObOe7PK3d77JipMYd3u+Vc4bFwH20nVBgv4k9K8/a/Z
WwW/5N7y61LNOX7iB+xhj/y9aa5HIJ8JIBwl2osKI9v/WrgKYukke3oKpJOZ7RTw
FHLJBJOGtdZbnEjYoxcAJhhOBwGGbx3Y0vAqCAlm+It7lgT1rjj5MdkK9eo5DFUp
WoVmrwoHNF3ncoF67WBtgLC9YKh4clIiNrtjt6q63NZmGBCGFZPOxlxUpKVOotjm
HsMKQc/G5R4/w2BxMYBfJPwZ9ZUebM33CCTIAaoGAm6yg4xsXRPVC80uTFCI4jPq
eSaltxQIeTQEaqAv/2IclOY2d3RFTWLOQ1DTtfGOf9BzoHaloHc+yPvTrKnL55jV
EoANlSYdNYWdKeUyWIMl3AFMJ3gm7iLarVT5uQtjw4XO9UM8eu95fdg9CO4MXRA9
+OJkdXGJLeLkutJahu90OmiApGHfI9LFMPzDAVWsl9bUCtYszB1+44CmPxZ0mA0d
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OJXlHNTEykr5VSuEaUZXGFxTZ71eChjwo7PzzLn1WZhyAwl9Zv3RLi8ZedokGMIF
acqiNewxxsStmfzlSxclqE59DpL0rddPoCNMnllRzUwdhn84+mlwJqavtvlE972p
cZgGgaNrF8hnPE56NuHTi3qN4zIXiA21qDhbbsG7IhY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3267      )
GaPTY0oZdV6eez3YsBclAtc/SE4pFK/igR42CypEF/34V5ygW3RpGTWkFTZ4Zv2W
Fzb0G5KOIfsgcgtX2m3X68QZxpCqiz0cW6GJ1tIQlYebflrttZ0rmrHUtwQpPIB4
MCtZ8nS65Zm1cdfpb2/iOgiTwgVtS9r6bQrTjII+/F8c3rSWMGXLzq7bd4nzYXam
4O9jx41Jk++/C9TqN6ShJpdll0VsjoJaOCMr7MWNfc4irE5KEkOEw2PCEPd4J7lL
BFw7C2+04NPOwc4cRqWtjGEX0VarXjSkpwIp32e1Hex4ZvaP3fVirTxwL61G7UkE
tKJXUqxKLsnEWyLSuZi8NwuSDNbzPPuil2LUI5NdjZV7Zq8IjexJezPl8S40zGVL
ybOluA6IYRF/8plMoCME5oU4jY2RuE/aZ+MGw9JBCogsUK47NIOruUtEqtNuNlyz
Q8q7GCh0qqKyPm1Rs6bLrtFTjOpiee6Esc7+TRE/NIG6J3pJp+hicmFc2qAJ66tH
O3RuK1+TtEF+23b7B+gjVPiGGdhcPvzEqQBm+lY2o05tpBT7Ug8Yjk/hkv5bYR7C
LUx9bwRywHFDYHjkxchoN/+kdElZ9u45+gOtO40BncrZ33VA4yPzGFFjNLfwP1+1
LNI4Yc+5NqSD4pFbl5wFCU/g7x7Rc4c9C3o7Tm9BLlnHUoK54CygtkdQVKGfmnjP
NOimPbk077eiJaK/v9wgUZDM6oukziZgXkeJyb/TPwYs5U4AQhsYWzfKLXbTh+b/
nqmTtjU0EN+8xSIrwob30Uvn4lwEhyBKqqhRDsmHly7qfier/qHum2crMBc1wx46
I4jCJPabj2sk+zh1efNQT6mGu6cg4BBCXxqog+ew/rHlv1r8tob0vh6YNN2y5AHg
qLaopAnhYN+uPMhFjFhxgjOWdVHKEpS8uGEqdPORDve2dSJS8SHWneisgr4jVS2o
FEGJTsBfwKKSwVnrMQMLkfDTIvhQt9ohocWpWc2nRsJq8+hxTWwK1LeShOjym5ST
TjkcG8Rmq7xquXiR4mMcSErSefCwex5ZH1NR3y9UTQlPwcc4OnU2EsG8WfeyKqiE
tbiPtgvJ/ZWYXnbP2NY/0rmbu7Wjs21DAJapAd9NYEm79rMKtXmx4S6ZzrbLFPft
5LrbzjFAvEqvsfu/mPFfbQnf2MKmCnbTqtFkQ7diM8LiQDGsyJsnrqTn/qCzHMCn
AMlxijwzs9ATfOeK6WKcBqSiJIhGseDkuU3NdpJL4coMg7goJCx8QPLkpFhUV1GF
J0vBGY4AE852jyp7aUSa0YrtrY41yGiJEq1E2e3eepr0Puo8dtmXcNEWMNbR3G1A
9ICXMW2UYDaIUD7SzxRgHrveddU+INLIW4gfwOnq0s3aCFUOeOg+skBVvigbrYyc
rJUz7f4wz49Xye4AAW2SadsQ00w/C3mmzMZX0saMJIvU7erQanePG8shk/WLcUM9
MnL0FBvHcQvuex+gZV7j1m/omSd16biD1HVSc1FnqpMgXxw21TYtzgl/17ux2/xT
WZWAWyqFiVv8bLkFr4OErJbAAynXeGbteeVj3UKf4gs4SatxuJV+sOct3XQX8D89
YK3FR1SgvMweeevH2Yt8yFEtDyKAHpJRkCnbLE739CUS2EyODneoUCNIoC+7CBPF
bk9kWOJd7fpW1PBuks4ZQjVn3bgQnxgpimHcmVHwAyaPh5jgDcZRPzgLDCujVUrE
lB3pSJI/K56d/wVwu9JgcZj/uHkMdOwD1OaNE8rd+URRQGm4SUfrxv5UlYibmdRl
xQHjtxAp/aiyxgwd7cSXNdmkTM+0NJ4dDJ3l4iy00tPggT4gul1hOQD2Fv2wDgZ1
wo7OUX4oRN0ghAr0bXLyA03pMMT3VxKfi/i5c2RnoJHB+dhKX2sKl+AL2mXtGmGH
0yQ3ZfiWXwL/TNypmrROk07kVymJsxr04fGlsLysYfh3hRwhJQp0wC5tWcPVmCof
fjf32L6W0+Un3DLPq0KbLWSFLd/YKmV2iPzaDdn1dvQ3qmMID/B1MOOSdEuxdKGi
F2HktbwL77h2bnaDxkLDAE3kqBOCXxgWkdKCJsowlXWlkqiNEH10g1mcGranfGJQ
AQ6yRAVFJKAqmcqOoY/L4j5nvzHHkEbejxPqPueYbiKEdu7P0JC/JpxsdwkxtQMx
Gmy5EXaDNvJsDNkd99r+VvA9M5UZ6NEWlBOJj1v3rVfe5t69FIeVG65w3+cZGFh7
N1er7MdUkHn32PHaaBIrum9Ypg7RSljs8J/hMQbOXeXk/e8ct/XgBS0wGYV3kz2M
8G5twe9/UrPsbTMicWDgHjQZGQMr1wR6W9AYR+sENmepqfU7vu68Rumh+CHJTaGH
Gli5nw7jjPvD8FA23VT1pH+e3JbJroYQxSOAR1ir1z4eSyW4y5aB0C8zDWcMmXeV
a90Qb2KvL4DFjCOkJFeTO1Zuv8Az0jEbxbbk7bpx8JWbVY5Hsbq5SdWZvMDHJAko
Y5o1CpXLyigChD/6AiN6IQ0xNZsRjjnGkjFX5eBi9VD390uRvNAq1WIaCMSq1Opc
0iIoKDGWEjqUHziyQbjubw==
`pragma protect end_protected  

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TAY+2RSDftbJGP5lnVP/mY30p+mTpRvQMRcbdT9rU+wOUNa5rinxqZwElTccqHVQ
N4QYxiIp9fKVc/9M7z13Y0Rgylnh8MU2v2X2TJ7YFRTSnNjfQMKl1LBdpXtVMCVA
bVbpM+gi+0efq8eZ/fOLO2zm5xgkcQVcNRO6m9R74oQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3399      )
PNp9Eg6LlC7aaMXr0mq3syv600oD0IA8Y1tKJ8eVCteVY2v+RKWqpnjMsc1WoohB
vfk0Q5jaBV1NsUQUe/7QxcV1D3XHRKttyng+Gd92wQYc1raW3u6Rl2nSqF+Q1uVD
dNt+Ojmfn1okehu8K8dpH1U0oO9Edu1q2fAaS3rPCAJIe0+/OTKuVyW/VGyT4H2y
`pragma protect end_protected 
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Bt9S+KoNtr/fqib9S8JMtpLg7vDTGBrVjJrLFkOSHH/IiHfFHwwyPAndAgoX0YuF
4zGJa+CX+Whj6zf+hO2K7fnG2uX8xZYayq/pbiGUhbQLz6rWarBPRzJcddr5rWZS
zePffM3Bjhkca5oWSJnhZtYNKN4XYVaDpYAwLWvHB0c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5634      )
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
`pragma protect end_protected

// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EMI6PL0QVp4DdEDzT0a/vggQlEvCRFtVTYa65puPYVc/tfqE7YLHHYHpjeoCoMkt
bNbF5oyhUSqkAtu0BMy35oEtkyslgtPI50IuaC47dGX2FwZnwaeKXNsjI2/ZiFOf
u/a/MQP9yc9uMgpe4imuaQH1VvX5db+F81MHnk7HGcg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5765      )
Dfh1aIZquIkn5mfIOEqXqiWyaRtJHUcn1xVzaTzj0qWzH0+FqF/JmHIkKo7vGOsQ
B4dLjT35GOqvEN96e7citXzzbCizJoOHE1q9yinT8fj8KjHQkGW4hLWRQDzTUnxl
wxQPkl8c3H57OiAtvmaeKpWQHQUNoyo4B3y4u6Y93VNuNHbwK/243c29pze8w45u
`pragma protect end_protected 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
llWdsIRfP2WFly6f0qwh4k7KDILpBi1HvCi6r8LDNRJ2ukDy6VAPVWjqJDgGM6Em
EgFfIgk+kuLh/n6Uuv8p5296rPHNPVf10tSiIjxKc4hSVj8JtUA32D1oj8Ryfu+r
8XHjInkfsarwet0LvhqfD38Ich13Hqd/qJeVcNDYFGA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5987      )
zmfWiD2M3prYCMHG9VL258lHX8/vaL3Q+Tc5pk0FP9mvvC7IzODBgyjLKbZySqoE
ibteHtf5dio6oy/CZwf45kGzaYmKezsZsHM7v6ujxNiwGBb+HssSh2w4xsGJsm9K
MctE1WLRM7ZHsO0MhYEI9alBtiGE2XPdiPdijLFx7JpCU49q8IKd7NCgVinV4T7k
k0ooEM+vVlxaQkr6pTkorMj4aNFgYNlPvkOYsy6/1WJr3mU36oovW88ue1Txk6df
vlxq8k7wOdwCQ6qADWJX6UeyIOEgk+nTh2Q/xOIWtBQ=
`pragma protect end_protected  

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jLtykWNilIz8V9UNJyT3rxhZ1Xf8bF9HLRX+9dC5aYwix/w0Fy3TgIwE38Z6h+P5
b+XUIFWTFguiaUEhuVInjK5amjoQQ9bFZPg9sPNr2twfN1XvFmRhD8vP4nibrYfT
BPSao9NE9ukr6mZ+y974D01OkvShsqaabUvZWXiRFXE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6114      )
aO3VwGggwyohcR3EAWFxN+OohFzAXbiGj5H+RBa5l+V/UqsOldhqsKd/UPXUC2a3
+j5SWd+l2bNFlQ7BpkvyRCtCxC8EZ4f4/UJPtF/Y/2A428F1UPUSMn8vD5L7JCI3
Ctyr81l/rfwXQTgIxACcvH+wFDmp3TuBaDKxh0u05yA=
`pragma protect end_protected  

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jwYih1c5IgeplziWy+8aXHnwxi+bG/ZqoUKuPP8xZQkXQlZs+BrqqpuAiv+JrHnT
Nhfx8kb0ca+vExhAJUkGRYM17tV3nG7NNy6pbg+IsbuXCH16KrIOm3+FtqOrHtcf
928TZfXJc2jqu25Nk/7M17YwTt/YUUTkvCDF84WhEYo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6250      )
SRCQ84vyrSOiRRYulylAkpnB5irM2jtBvIiojkAqZtlqUYdvg+x7wdV4z5mZosT4
5zCw60Pl+SIn6I2sU9FjUHQlO7xMH5+3w0HgYLel3a1AYaP4PisF7feWTQ9+ihqg
ph7gZzqxTsy3em6bZzFqnbajixCrB78XTP4Onid1aFk8LU4M3lJDt9BumjCVr6Vr
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lK4YJTzjB32aLBBt4hKHvkiY6XTeh/57prv5tltufK5GQCN97FATlsZvIJfimjP/
DAZO8ic3eXoJMv0se4IIK0NjBFBOEEmDPhq6teK8J9GNVf+l1PZkY0zVN2Vvt8mA
+vrioSBWMROxzEgtKIlbYnpaEN1fhfEhhPUD3cUifYU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6363      )
p8ya2EPSUQFANQr3OQPtmmEsr2SgQUkrA9IcrtKsva+aBhF0B+rg3FeiRm2SKwih
Ha2/fvBgZfjlKJ0t39CMFv4xy5SFquHGCxlUOwNF8QVKu8GyYKZdIwfUCR3dISv5
H1W41/r7OH4RMIZmD5OOUI3DrpRfuWJKwuloi1auQFs=
`pragma protect end_protected

`endif // GUARD_SVT_AHB_DECODER_UVM_SV





`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
avYNinFM6aF5pvBaS9Pk5T/3bwLt9BorpKlzHMurkJzpFoIhv6aSfDlPOcBxFF+d
Peh8pPBGWnShcYKg3VGDKIsTMfoKuf0KIaz4865fV8Xn5sD3bZdH+KPv6wCD4rxs
wP1M475zNGCu+lJSd2R04UlqdRAkwA7GNI2Gvnm0Da8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6446      )
8WPID2cPEz2rRyQFQRXy3ZzzWcqf5wW/kNC2i7ZF63KW3E8FZhlxaHtAWmYbFw6n
Nousmehi/xsd6KtolSn3v83yTyAyVWb7to2Lja7XmYfZb5+8AEcoeF+EVqgwgWvR
`pragma protect end_protected
