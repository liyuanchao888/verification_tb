
`ifndef GUARD_SVT_AHB_ARBITER_UVM_SV

`define GUARD_SVT_AHB_ARBITER_UVM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
A5cK4WlkHLWKcivwXmx/Jn5Lo5fUNPs6X4fPZ8PXpC6z15w74Vkhc7U65pvKKFG7
6o+F+KhKvZhhBe63XI8vc01mYpFKRAQymoiCAOf4VyyHZe7duVfiEExDxCb481pZ
dOHkcfYcWprh4FJrSUOzoGfS/m+G9shwbbE7WZz6ENM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 393       )
8mhpHWY12JqsAuGegrXky6YiQaTyNuqcG3spyC+G/G/ftrfV5PPbXyRWbT+jCgkZ
zy72/A1iB/9EeiYzkDzw4LfSgIqcshLafgMC26deYVupajbFJ/39Ckf1nasqnl0a
aVbukrvdcf84g9pV1w2B1mh707Zmmi+kuNF0chkTw4Ppoj+1Lj6l26SZECXexpfr
z9rXfEM3wDFxN9yA4AIVBVM9qkpXjtnzlEmYG9HoZ038xgR/vWjbxcmTKgGdXC0A
vL+ANNyCWQNSxn4rvCv0sfTnX/e/him7JIsMuYkh4nmF9sP8futRbKci9pLMljLY
uzUzT1CmjOSkTa3bfHzB8+MhogVL/1cRq9GLZ63Y3D0mQA45pWCPMmjoEpmy1EqW
2748LloDoqaX2vrz1asOjutoXayqXalo7sOD7hJI6GEHQZ4oP65oL4JZGQY9bmzA
HlYgZQ8FZwuo9asRyliDxNViUDrSHCWTjbQZ5XenmiEe9AW60ROu5aIkgsVx5E3n
fCIiACQ4v6YVeL0CLwyKNQ==
`pragma protect end_protected

// =============================================================================
/** This class implements an AHB ARBITER component */
class svt_ahb_arbiter extends svt_component;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q1HRdYY9QkJxp+12JoJdjMBfRnTFMuzBgzu6tAMP51zV69zO4XJ/rs7DlQEg/gCn
qm/W0kPunRgs6voBuO+iCjixfzcd/k39wU8iMJ0SngTq0zCyQasbNjIYa7wqfK3U
oxRYQh43V+eRDH0p6Mnn+YPuX0Kx5wlZFIhVcs6NxOo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 600       )
MXnSKsdKQSKLG+nPJkTgYBbgaimKqtAJQ3PQxKczerUwEFA9uCtvtlXmOTzxGHbr
kUcEyBma6mHaIRL1d09PQW3uRXcjY4gvzn/vnL++UlKeLUHYvp1oC1G/Hsy30+tb
pZxxg9Vi9njCBrLC8eWnbyPWP3GVDwVGo1n5kLet1PldXBJwqaytJFrx/RDyxA0w
XdponrefqzAmR5le+eRM9lj75uN13uLxaeJW1yrE2bOa8c/Bfl96iK6CRTBEpi+K
CNjfmEJ/0z4g9naBg4KsWw==
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
FSIIF3ZN9jJyJT+cxOwlmfj/YSakmDPFutHC/mz/X5UHfu8B2wkfbOkLozCg5yxJ
eQ0ZDleFqld94p8uBmWtsQknVwElzWURfmzoPHAz2bA8qdHH3C3zM3os8Ij+zaDv
2xi4665Sdj1lQT1H9OJcUyZGIqFMXJUtjhrbB7pBlYc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 761       )
rGFPffUvL5bqB42t4L88VKQ07HeahpMw/hvZPDDPktivfwZjZ6YRwO1ScwonFHl/
PMBxaNx40vBbgN4mlg1FgCWSsnT5w5OkgO/JKSOkKcRl5TxzcYEtNw6lcq9qkMKI
RGvHThx56SIZ2f3T4IP0Dfq/X1C2cQKQWiJRJm9uJ/GYeG4b8X6fqbO3xbFU5rQC
uwQmHx0BbtfcED10BIC789C8jASuwMheOA/y3Rc53Pc=
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
XCzqCGzPwKcvrYlInC38gQp1Pxt/AvjRetuUjRvmMk7ySUEoDVYncVExZLPqsmnp
Q8UQr2l6CCwYMBMKbOB02Q4mSjtBlNqsI39LL+rH3cNdcU9qDeSKGnEvV+1mtKrj
taCH9YEUij9QuxILrHzWJp4Qk1Ft5l63cGa8gTi+iPI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 871       )
C3ksdheBhFxofLJ04VP1gohQxshIjBtpvTyKoEQoOFewT0mwfaw7HBojEALcjjqN
tW/mYsYXOG3QzEzylJHRS+QP8frbQ/dtoryuBgv9oBCtbj1NcvkogXAZWxtp1avw
Gz4c2uq5Kd0FFv0x+ToKpw==
`pragma protect end_protected  

/** @endcond */

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RV1OXf5Ha8bFsitv+5dTGuRyoGPLus+QjIDei94GXqukFoCZGwkpiLSpuC/LS55P
7NuX0jtlUgiXfpTuTpwQnbhqDZKgnan5SgNeu+/iMhMsZo082aeVA/VyMtup13g9
GkFqcewcUXg+wMc5UTXmTDmeoTnt+LSTbXmD7yf3K2I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1341      )
Ltscn9pwFGD9wvZZ3Dd3RywDsDB+bDsKLQ8qdEXVsD0iiL0DdELystsM/QM9vFIP
88yYnUQ5RSdh0Uq++W4sEijbvwH0EIRtEg5+2XnqLKVOGVXWfdoluqy6lUjzkGaA
0okJgV1HW4pWSxN37SAVqAC8VJhBlrhJMZDQOhyO+Lk8nchl+wwGLuTHxH30myod
loglIHQQHfSAoHcdm90N5lFCe4eKbD8zJGCIpXHu7QBZfmhjfZSkNOrX20xVsjnf
xaC9zylgXl9w9ob1VGZUCPvRG+bUCRWfnJVkHb607y4k9V1hq0eJDYd59bYgzulA
zW3KG7AWEP9PHcmrTAPRHo9USgYC/czGEREUgeOczSAXBLrNHCE56kBeBWJ30HWM
5bOzf1RFoOq4Hi5jyzsOAbvcDuFYgpMvxb/uGrLEbP3I3577MAw7wZlRgki7lZ7A
GggpZqEryeqLBW270yUsrS5QSNxtViUN3N5NXMKEiTOqsYyycu8JYxD1QEDfszws
yalxPy11rm/c3ZhuLZNWgqlbQPIgbXikXAmjY3fHuDYDm1fPTY3DzfHWQeuEGvpb
BAA8Wo8OtUsXd8LHcD4jJlJs2rJaOK3XK7JBFGwbtqLbeAhBF4PrtydTE8HYlsBh
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Idjvcy6b0BGr6RRF8aM3z/YNa7W4/O2FlLonVHsjU0yRnqS1zo3Q4fYLM8uYKDnc
Mpe8Ce5NKLn4W+xuthVGekumjpWrif5xBt5aa2/K7l28nbj/MNHIitNVNhKoYFPl
J7+xyOO2tirfrq8jg3evx+yzKxLpk6Yh/SdMiSOvo1Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3328      )
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
`pragma protect end_protected  
  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fvMVHqeFaOHCZ9NM63lkSC9E2csFZNtbtdvoVnkLvIWkj3ZxjJB4Qy0tLifRtWsB
CBqtd08FHVKRYFZvCA4qOkb5FX2BQqAgu2gVD7KkW+0FkWKn8sc144t2q+zYBN1K
2lED9naEBUvpqCTzfC4T+XxmKqvnTo59ltPbmYYgknY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3462      )
OT/aFuzIhfbXwJNx63eyqQW5HCWcc9Y4eM72m/0GTGLLBLgSJzllVM/CGmcpsws5
iKtEDH2Tr5udO0FWpIt5UYLPORub0iln15eJv7TMFFGdvldiRnoW99r6y3IJSIqR
L+Fynt4Tm3N6sMMx/OQV9fUOwZexpeUWgsGbY3z6BEWndxQKxI93v7mULMqaKKUJ
`pragma protect end_protected  
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oba3eu8enbEOxdC9LjMsf1I61iCGCPz46sQMYyQQUotarUIqFgUelI+i1EcKB6bn
6ZJtz3bPatZUnulKvxHSlNKpY2jkuAhCdh60hz8j4P1DH8VmiZQeI2tYcXbElcut
2G71cDZV1FkYJrKyE1IJLJS3bCjtNd6xS1vwmZWVpJU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5695      )
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
`pragma protect end_protected

// -----------------------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ajGlkboYOpAvxs1fiQmVt6qMg26ymgzdcsNYGeU1rFj1It8e85H+1Q78QIBcLNHU
G4KIo2ZgA1N5m1mQct7/NC/ZOTANSp5DL2/mtT43O5PkiTrqH5LiQTBmDDOlSsE0
9Z4iRx+ropize5uVzrZWWNFLEek6TANxLe1ANXIocGg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5826      )
1L3DoFnDJSHqMrhuDZnqe2gJiY/cD/unUkn4kUHUkNYAYw4vl8LxV41RzOaqXK0e
ucIDYXoRvyeMO7zZnIcBNsjltFnnImrNJHxos00b2dBnWV7LmatrFeRrIerHY3sS
2+PwhcL4tbRGr/EHsQS+Tzcu9r9YCe0tdaZqy7VibtwrZrzPWwWxPz6zOQRaeJWe
`pragma protect end_protected 



// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EKKdm31X+VAuzF4rl0Tw6djXge+JNiy4z8Bce/0xpJ7b5NOV2Dry6Yur0i+JoNOc
IWTv9FIcL5/VZsvdt2H22pQ5EGNTskAY+rtgbj5o6e8wUlwC4yPUsoqKE4ND8lcG
McZGmtaaXh1g6I0WbUbgMpj8oGpIDs4imVgKpWdt7Ao=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6048      )
2Qs7HLhXCdcgfC5qcyMA3DgFezSjhNHDgNz69/NDo4gKrkX5qOxY5XJOkK4cd4xU
nYtvViZDX6GwjTf6MCpL3/Wo0Flt0o6leqjbUTDHnp4o647fQGOMMaUq2x6cRl9e
evZoRxGj2xj1HZK8zPwMEsNMF8tRGwJcjRggbuQAbfYdtFnCXFf79ycH/GoYTnGy
456Fy9zAX4IV8PtKO329PD+b+iw8VhF8hrdK8xJmg47m+qntu4kuJr8YZngRg0ml
Y5LTxxs0q6JojpGVawuqYvxidhXD2hp5R27ieEU+/J4=
`pragma protect end_protected  

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FfKZH0jazivKxcg92B6pMRtFxGr9Im4UIA8YkWpoMbUYOhB5p38/r9ZloqjrgO1c
oTIpqD5O0u2pKvehmp/aM3LLuGFZk9j4xjTS7+oTdByioy5gDcaN5CpcFles0HK9
PQWP/QqyDf2nGe2xTropeG0aPdV1LGn+0l3oRagc77M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6175      )
ceLgQlN5DHK98eOkjkIQ2x0t2rQt7tXJjzyX27hq8+OpeS+PGUmZqAMkxlfe0vnE
zKZIl6DR+AV7fPccltU52mr6u0PukhVvhdiebsILIK40YwquYCSVICV8kz/tk8of
TAsyfWKGhTcwEuNMZgC4fkhsaag4Imp+ItGNVLyZDCg=
`pragma protect end_protected  

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IyFneo3RMCOoNcblU88NmpzYheJOnXx0mCACpFDZY8QEy2qlWK+V6fo5vDBBwnQY
yOcgMm31KgX1BPwy0ajcaSm6h6mC/6eXPYNbqtNp0L8ZNI1GviVjeIhUQM8fqvRt
0wMIt/rlrLtbIQhi9dfPCo41G0QmLOouKL7rzxah0o4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6311      )
LBGBv6lF+Kz0EZp+XZ0xfO0ewjCaDWpTP8IsrW/lkUkvbvFsf5EoRkWQMj3ZmucM
0zGvO6VtgDCYJRTzqzuYqLQ4+gs2VmCDl7wCUn9ImITT4DvxtYkqy7Bz3pDj2Gyv
e+4RdSEhByCSQs33SDsLJeDms9iscDAeDmTUrA3uzIIgdbLBE/rb5W/G4HH0TQbX
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FT0Nhw3iPF5rACTE9aHZogDltD9R0Gf6+wrsfiLzCv3LgnBXQBPweQmmtsCc5CJR
6tRACLgMxac0vAvh9NFM37+SnVwxwAp82T4Tl+Y0N6P6RDg6A0lTYGr0KUKCC3rb
jCzeqyocv7k0XMAo0EDM5KJC0NOv81PB0VIHYdCEJ/0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6424      )
J72fLWlcf8veC13DspU9ZpijCjyB++r+CpswlqxGWEcTSg0ky4tygVvENEtIuN72
V9wf8sV7YNxqhNphzAbt8FP+Uij1y8hjIN/EL0LD8wAhH1jt0C2/C7MinytDfVpN
kORY+2aHIcyFeWTQBHggNyB3V38lSjUlewCWwacZwvo=
`pragma protect end_protected

`endif // GUARD_SVT_AHB_ARBITER_UVM_SV





`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oie2wYXFspOLo3GnoSCLOmHtms+BBeOZsepRxHeBsrkoaN+HPJeXiTRlrBA3l4pA
S/DrnWBD7DQmJdoNNbYoD9/qQAD2J5692XJ84c2Ouu7vYN2EBPXdahYxNtbr6krY
z3A5NN1Ax4l6+QaSzgeFrXMh8lrOvyoWhV0/Pl672kE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6507      )
zP+LnlXy3VVxgjvY4hzQpkxL2TWIOSHRO1MXMUP8tRFBPVtTNddCt7fpvOeVphm3
7fjsh1IHVB44h0FqK4ov2WheBa8OqXLDIQTJT09n4NItbZ0TWEuhTr0aNf/NGyp+
`pragma protect end_protected
